table 1000900 "IBB Time Sheets Head"
{
    /*Master table contains information about the most important fields in this timeSheet, 
    the primary focus subjects of its functional area*/

    DataClassification = CustomerContent; // Global property.
    LookupPageId = 1000900;//Lookup ID record the 'Manage Timsheet' page.

    fields
    {
        //Fileds For Master page Called 'Manage Timsheet' and for The Header on the Card page .

        field(1; "Name"; Code[50])
        {

            TableRelation = User;
            Caption = 'Name';

            // Trigger extend The "User Name" From the User Table.
            trigger OnLookup()
            var

                Timesheet: Record User;
            begin
                Timesheet.FindSet();
                if Page.RunModal(9800, Timesheet) = Action::LookupOK then
                    Name := Timesheet."User Name";
            end;
        }
        field(2; "Creating Date"; Date)
        {
            Editable = false;
            Caption = 'Creating Date';
        }
        field(3; "Week No."; Integer)
        {

            Caption = 'Week No.';
        }

        //This Field in master page check if there is an existed open timesheet filtered by the name an week No.
        field(14; "Open"; Boolean)
        {
            CalcFormula = Exist("IBB Time Sheets Head" WHERE(Status = CONST(Open), Name = field(Name), "Week No." = field("Week No.")));
            Caption = 'Open';
            Editable = false;
            FieldClass = FlowField;
        }

        //This Field in master page check if there is an existed Closed timesheet filtered by the name an week No.
        field(16; "Closed"; Boolean)
        {
            CalcFormula = Exist("IBB Time Sheets Head" WHERE(Status = CONST(Closed), Name = field(Name), "Week No." = field("Week No.")));
            Caption = 'Closed';
            Editable = false;
            FieldClass = FlowField;
        }

        field(17; "Status"; Enum "IBB Timesheets Status")
        {
            Caption = 'Status';

        }



    }

    keys
    {
        //The primary keys used in this table to filter the data Insert by the name an week No.
        key(PK; "Name", "Week No.")
        {
            Clustered = true;
        }
    }



    trigger OnInsert()
    var
        line: Record "IBB TimeSheetsLine";

    // The time will be auto generated to Creation date.

    begin
        "Creating date" := Today();
        SetEnum();

        // line."Week No." := "Week No.";
        // line.Name := Name;
        // line.Modify();

    end;


    // The Status will be Open If you don't submit the timesheet.
    local procedure SetEnum()
    var
        statusEnum: Enum "IBB Timesheets Status";
    begin
        Status := statusEnum::Open
    end;






}
