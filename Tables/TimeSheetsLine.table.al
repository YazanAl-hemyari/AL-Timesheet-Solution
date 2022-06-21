table 1000901 "IBB TimeSheetsLine"
{
    /*Line table contains information about fields in this timeSheet.*/

    DataClassification = CustomerContent; // Global property.

    fields
    {
        field(1; "Name"; Code[20])
        {
            Caption = 'Name';

        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Week No."; Integer)
        {

            Caption = 'Week no.';

        }
        field(4; "WorkDate"; Date)
        {

            Caption = 'Date';

        }
        field(5; "Day"; Text[25])
        {
            Editable = false;
            Caption = 'Day';
        }
        field(6; "Time in"; Time)
        {
            Caption = 'Time in';
        }
        field(7; "Time out"; Time)
        {
            Caption = 'Time out';
        }

        field(8; Type; Enum "IBB Type of Tasks")
        {
            Caption = 'Type';

        }
        field(9; "Tasks"; Text[100])
        {
            Caption = 'Tasks Done';
        }
        field(10; "Working Hours"; Duration)
        {
            Editable = false;
            Caption = 'Amount of time';


        }

        //Fields 11 to 17 specify the sum of Working Hours on the timesheet.

        field(11; "Sat"; Duration)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("IBB TimeSheetsLine"."Working Hours" where(Day = const('Saturday'), Name = field(Name), "Week No." = field("Week No.")));
        }

        field(12; "Sun"; Duration)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("IBB TimeSheetsLine"."Working Hours" where(Day = const('Sunday'), Name = field(Name), "Week No." = field("Week No.")));
        }
        field(13; "Mon"; Duration)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("IBB TimeSheetsLine"."Working Hours" where(Day = const('Monday'), Name = field(Name), "Week No." = field("Week No.")));
        }
        field(14; "Tue"; Duration)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("IBB TimeSheetsLine"."Working Hours" where(Day = const('Tuesday'), Name = field(Name), "Week No." = field("Week No.")));
        }
        field(15; "Wed"; Duration)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("IBB TimeSheetsLine"."Working Hours" where(Day = const('Wednesday'), Name = field(Name), "Week No." = field("Week No.")));
        }
        field(16; "Thu"; Duration)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("IBB TimeSheetsLine"."Working Hours" where(Day = const('Thursday'), Name = field(Name), "Week No." = field("Week No.")));
        }
        field(17; "Fri"; Duration)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("IBB TimeSheetsLine"."Working Hours" where(Day = const('Friday'), Name = field(Name), "Week No." = field("Week No.")));
        }

        //specify the sum of Working Hours for the entire week.
        field(18; "Total Hours"; Duration)
        {
            FieldClass = FlowField;
            Caption = 'Total Hours';
            CalcFormula = Sum("IBB TimeSheetsLine"."Working Hours" where(Name = field(Name), "Week No." = field("Week No.")));
        }

    }

    //specify the sum of Working Hours on the timesheet
    keys
    {
        key(PK; "Name", "Week No.", "Line No.")
        {
            Clustered = true;
        }
    }

    // Trigger OnModify used to get the duration and the Period time.
    trigger OnModify()
    var
        DateForWeek: Record Date;
        Head: Record "IBB Time Sheets Head";
    begin

        if DateForWeek.Get(DateForWeek."Period Type"::Date, WorkDate) then day := DateForWeek."Period Name";

        //calculate the amount time used to get tasks done.
        "Working Hours" := "Time out" - "Time in";

        // "Week No." := Head."Week No.";
    end;
}