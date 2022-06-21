page 1000902 "IBB TimeSheetsLine"
{
    //List Part page contains information about the line fields in this timeSheet*/
    Caption = 'Timesheet Line';
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "IBB TimeSheetsLine";
    AutoSplitKey = true;


    layout
    {
8t34456
        area(Content)
        {

            repeater(IBB)
            {
                 //Fileds used as factbox.
                field("Week No"; rec."Week No.")
                {
                    Style = Strong;
                    ToolTip = 'Timesheet Week Number';
                    ApplicationArea = All;
                }

                field("Name"; rec."Name")
                {
                    ToolTip = 'User Name';
                    ApplicationArea = All;
                }
                field("Type"; rec.Type)
                {

                    ToolTip = 'Task Type';
                    ApplicationArea = All;
                }
                field("Date"; rec.WorkDate)
                {
                    ToolTip = 'Specify Timesheet Date';
                    ApplicationArea = All;
                }
                field("Day"; rec.Day)
                {

                    ToolTip = 'weekday';
                    ApplicationArea = All;
                }
                field("Time in"; rec."Time in")
                {
                    Style = Favorable;
                    ToolTip = 'Time in';
                    ApplicationArea = All;
                }
                field("Time out"; rec."Time out")
                {
                    Style = Unfavorable;
                    ToolTip = 'Time out';
                    ApplicationArea = All;
                }

                field("Tasks"; rec."Tasks")
                {
                    ToolTip = 'Tasks Description';
                    ApplicationArea = All;
                }

                field("Working Hours"; rec."Working Hours")
                {

                    ToolTip = 'Amount of Time';
                    ApplicationArea = All;
                }
            }
        }
    }


    actions
    {
        area(Processing)
        {
            group(IBBImportExport)
            {
                Caption = 'Import/Export';
                Image = ImportExport;
                ToolTip = 'Import or Export Excel File';

                action("IBBImport")
                {
                    ApplicationArea = All;
                    Caption = 'Import From Excel';
                    ToolTip = 'Import From Excel';

                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Image = ImportChartOfAccounts;



                    trigger OnAction()
                    var
                        ImportFile: Codeunit "IBB Manage Timesheet";
                    begin

                        ImportFile.Run();


                    end;
                }
                action(IBBExportToExcel)
                {
                    Caption = 'Export to Excel';
                    ToolTip = 'Export to Excel';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Export;

                    trigger OnAction()
                    var
                        ExportFile: Codeunit "IBB Manage Timesheet";
                    begin
                        ;
                        ExportFile.ExportGenLine(Rec);
                    end;
                }
            }
        }
    }

}
