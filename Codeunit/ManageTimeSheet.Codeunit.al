codeunit 1000900 "IBB Manage Timesheet"
{
    trigger OnRun()
    begin

        ReadExcelFile();
        ImportExcelData();

    end;

    var


        TempExcelBuffer: Record "Excel Buffer" temporary;
        Timesheet: Record "IBB TimeSheetsLine";
        FileManagement: Codeunit "File Management";
        FileName: Text;
        SheetName: Text;
        Instream: InStream;
        FromFile: Text;
        RowNo: Integer;
        LineNo: Integer;
        MaxRowNo: Integer;

        UploadExcelMsg: Label 'Please Choose a File to Import';
        NoFileFoundMsg: Label 'No Excel File Was Detected ?';
        ImpSucessedMsg: Label 'Excel File is Imported Successfully';


    procedure ReadExcelFile()
    begin

        UploadIntoStream(UploadExcelMsg, '', '', FromFile, Instream);

        if FromFile <> '' then begin
            FileName := FileManagement.GetFileName(FromFile);
            SheetName := TempExcelBuffer.SelectSheetsNameStream(Instream);
        end else
            Error(NoFileFoundMsg);

        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.OpenBookStream(Instream, SheetName);
        TempExcelBuffer.ReadSheet();
        Message('Total Count %1', TempExcelBuffer.Count);

    end;

    procedure ImportExcelData()
    var


    begin
        RowNo := 0;
        MaxRowNo := 0;
        LineNo := 0;
        Timesheet.Reset();
        if Timesheet.FindLast() then
            LineNo := Timesheet."Line No.";
        TempExcelBuffer.Reset();

        if TempExcelBuffer.FindLast() then begin

            MaxRowNo := TempExcelBuffer."Row No.";

        end;

        for RowNo := 2 to MaxRowNo do begin
            LineNo := LineNo + 10000;
            Timesheet.Init();
            Timesheet."Line No." := LineNo;
            Evaluate(Timesheet."Week No.", GetValueAtCell(RowNo, 1));
            Evaluate(Timesheet."Type", GetValueAtCell(RowNo, 2));
            Evaluate(Timesheet."WorkDate", GetValueAtCell(RowNo, 3));
            Timesheet.Validate(Timesheet."WorkDate");
            Evaluate(Timesheet."Day", GetValueAtCell(RowNo, 4));
            Evaluate(Timesheet."Time in", GetValueAtCell(RowNo, 5));
            Evaluate(Timesheet."Time Out", GetValueAtCell(RowNo, 6));
            Evaluate(Timesheet.Tasks, GetValueAtCell(RowNo, 7));
            Evaluate(Timesheet."Working Hours", GetValueAtCell(RowNo, 8));


            Timesheet.Insert();

        end;
        Message(ImpSucessedMsg);
    end;

    procedure ExportGenLine(var Timesheet: Record "IBB TimeSheetsLine")
    var
        CustLedgerEntriesLbl: Label 'Timesheet';
        ExcelFileNameLbl: Label 'Timesheet_%1_%2', Comment = '%1 = XML node name ; %2 = Parent XML node name';
    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(Timesheet.FieldCaption("Week No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        // TempExcelBuffer.AddColumn(Timesheet.FieldCaption("Name"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Timesheet.FieldCaption("Type"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Timesheet.FieldCaption("WorkDate"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Timesheet.FieldCaption("day"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Timesheet.FieldCaption("Time in"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Timesheet.FieldCaption("Time out"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Timesheet.FieldCaption(Tasks), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(Timesheet.FieldCaption("Working hours"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


        if Timesheet.FindSet() then
            repeat
                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn(Timesheet."Week no.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                // TempExcelBuffer.AddColumn(Timesheet."name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                TempExcelBuffer.AddColumn(Timesheet."Type", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Timesheet."Workdate", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Timesheet."Day", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Timesheet."Time in", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Timesheet."Time Out", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Timesheet.Tasks, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Timesheet."Working hours", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            until Timesheet.Next() = 0;
        TempExcelBuffer.CreateNewBook(CustLedgerEntriesLbl);
        TempExcelBuffer.WriteSheet(CustLedgerEntriesLbl, CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileNameLbl, CurrentDateTime, UserId));
        TempExcelBuffer.OpenExcel();
    end;


    procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    begin

        TempExcelBuffer.Reset();
        If TempExcelBuffer.Get(RowNo, ColNo) then
            exit(TempExcelBuffer."Cell Value as Text")
        else
            exit('');
    end;

}