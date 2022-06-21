page 1000900 "IBB Manage Timesheet"
{
    /*Master page contains information about the most important fields in this timeSheet*/
    Caption = 'IBB Innovations Timesheet';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "IBB Time Sheets Head";
    CardPageId = 1000901;//Card Page ID for the 'ManageUsersTimesheet'.
    Editable = false;// This page is Unditable.

    layout
    {

        area(Content)
        {
            repeater(GroupName)
            {

                field("Name"; rec."Name")
                {
                    ToolTip = 'User Name';
                    ApplicationArea = All;
                    Width = 50;
                }
                field("Creating Date"; rec."Creating Date")
                {
                    ToolTip = 'Specify Timesheet Creation Date';
                    ApplicationArea = All;
                    Width = 50;
                }

                field("Week No"; rec."Week No.")
                {
                    ToolTip = 'Specify Timesheet Week Number';
                    ApplicationArea = All;
                    Width = 50;
                }

                field("Open"; rec."Open")
                {
                    Width = 50;
                    Style = Favorable;
                    DrillDown = false;
                    ToolTip = 'Specifies if there are timesheets with the status Open.';
                    ApplicationArea = All;

                }

                field("Closed"; rec."Closed")
                {
                    Width = 50;
                    Style = Unfavorable;
                    DrillDown = false;
                    ToolTip = 'Specifies if there are timesheets with the status Closed.';
                    ApplicationArea = All;

                }



            }
        }
    }
    actions
    {
        area(Processing)
        {

        }
    }
}
