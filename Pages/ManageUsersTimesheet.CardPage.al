page 1000901 "IBB Manage Users Timesheet"
{
    //Card page used The Header and Line for the timesheet.
    Caption = 'IBB Innovations Users TimeSheet';
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "IBB Time Sheets head";

    layout
    {

        area(Content)
        {
            //Fileds used in the Header section on the Card page .
            group("Timesheet")
            {

                field("Name"; rec."Name")
                {

                    ToolTip = 'User Name.';
                    ApplicationArea = All;
                }
                field("Creating Date"; rec."Creating Date")
                {

                    ToolTip = 'Specify Timesheet Creation Date.';
                    ApplicationArea = All;
                }

                field("Week No"; rec."Week No.")
                {
                    Style = Strong;
                    ToolTip = 'Specify Timesheet Week Number.';
                    ApplicationArea = All;
                }
                field("Status"; rec."Status")
                {

                    ToolTip = 'Specify Timesheet Status.';
                    ApplicationArea = All;
                    Style = Subordinate;
                    Editable = false;
                }

            }
            //Part page used in the line section on the Card page.

            part(Lines; "IBB TimeSheetsLine")
            {
                SubPageLink = "Name" = field("Name"), "Week No." = field("Week No.");
                ApplicationArea = all;
                UpdatePropagation = Both;
            }
        }

        area(factboxes)
        {
            part(TimeSheetStatusFactBox; "IBBTimesheetStatusFactBox")
            {
                SubPageLink = "Name" = field("Name"), "Week No." = field("Week No.");
                ApplicationArea = Jobs;
                Caption = 'Timesheet Details';

            }

        }
    }


    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                //After clicking this action, the timesheet will be uneditable
                action(Submit)
                {
                    ApplicationArea = Jobs;
                    Caption = '&Submit';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Submit timesheet.';

                    trigger OnAction()
                    var
                        statusEnum: Enum "IBB Timesheets Status";
                        card: Page "IBB Manage Users Timesheet";

                    // The Status will be Closed If you submit the timesheet, also you can't edit your timesheet.
                    begin
                        Status := statusEnum::Closed;
                        card.SetRecord(Rec);
                        CurrPage.Update();
                        CurrPage.Close();
                        card.Editable := false;
                        card.Run();
                    end;
                }
                action(Emails)
                {
                    ApplicationArea = All;
                    Caption = 'Send Email';
                    Image = Email;
                    ToolTip = 'Send an email to this customer.';

                    trigger OnAction()
                    var
                        EmailMgt: Codeunit "Mail Management";
                    begin
                        EmailMgt.AddSource(Database::Customer, Rec.SystemId);
                        EmailMgt.Run();
                    end;
                }
                action(SentEmail)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sent Emails';
                    Image = ShowList;
                    Promoted = true;
                    PromotedCategory = Category7;
                    ToolTip = 'View a list of emails that you have sent to this customer.';
                    Visible = EmailImprovementFeatureEnabled;

                    trigger OnAction()
                    var
                        Email: Codeunit Email;
                    begin
                        Email.OpenSentEmails(Database::Customer, Rec.SystemId);
                    end;
                }



            }
        }
    }


    trigger OnOpenPage()
    var
        statusEnum: Enum "IBB Timesheets Status";
    begin
        if (Status = statusEnum::Closed) then
            CurrPage.Editable(false);
    end;

}
