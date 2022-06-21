page 1000905 IBBTimeSheetStatusFactBox
{
    //Part page contains information about the FactBox fields in this timeSheet*/
    Caption = 'Timesheet Status';
    PageType = CardPart;
    SourceTable = "IBB TimeSheetsline";

    layout
    {
        area(content)
        {
            field(Sun; rec.Sun)
            {
                ApplicationArea = All;
                Caption = 'Sun';
                Editable = false;
                ToolTip = 'Specifies the sum of timesheet hours for timesheets.';
            }
            field("Mon"; rec."Mon")
            {
                ApplicationArea = All;
                Caption = 'Mon';
                Editable = false;
                ToolTip = 'Specifies the sum of timesheet hours for timesheets.';
            }
            field(Tue; rec.Tue)
            {
                ApplicationArea = All;
                Caption = 'Tue';
                Editable = false;
                ToolTip = 'Specifies the sum of timesheet hours for timesheets.';
            }
            field("Wed"; rec."Wed")
            {
                ApplicationArea = All;
                Caption = 'Wed';
                Editable = false;
                ToolTip = 'Specifies the sum of timesheet hours for timesheets.';
            }
            field("Thu"; rec."Thu")
            {
                ApplicationArea = All;
                Caption = 'Thu';
                Editable = false;
                ToolTip = 'Specifies the sum of timesheet hours for timesheets.';
            }
            field("Fri"; rec."Fri")
            {
                ApplicationArea = All;
                Caption = 'Fri';
                Editable = false;
                ToolTip = 'Specifies the sum of timesheet hours for timesheets.';
            }
            field("Sat"; rec."Sat")
            {
                ApplicationArea = All;
                Caption = 'Sat';
                Editable = false;
                ToolTip = 'Specifies the sum of timesheet hours for timesheets.';
            }

            field("Total Hours"; rec."Total Hours")
            {
                Style = Favorable;
                ToolTip = 'Total Hours';
                ApplicationArea = All;
            }


        }
    }

    //Update the data entered by the Timesheet line.
    procedure UpdateData(TimeSheetHeader: Record "IBB Time Sheets Head")
    begin
        CurrPage.Update();
    end;
}