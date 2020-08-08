# Oracle Application Express Developer Notes

**Reference code for Apex Development.**
Virgil A. Aviles

## Interactive Report: Align Interactive Report Data to the Top

Inline CSS

````
#static-region-id .a-IRR-table td {  
  vertical-align: top;  
} 

````

## Interactive Report: Format Column Width

Inline CSS

````
#report_static_id td[headers=column_static_id]{ width:400px; }

````

## Interactive Report: Build URL 

Dynamically create a calling URL.

````sql
     APEX_UTIL.PREPARE_URL (
             'f?p='
          || V ('APP_ID')
          || ':NN:'
          || V ('SESSION')
          || ' ::::PNN_ID:'
          || <COLUMN_VALUE>
          || '')
          AS EDIT_LINK

````

**Where:**

- NN: Target Page

## Charts / Cards: Build URL and filter target dynamic report 

Dynamically create a calling URL and filter a dynamic report.

````sql
     APEX_UTIL.PREPARE_URL (
             'f?p='
          || v ('APP_ID')
          || ':NN:'
          || v ('SESSION')
          || ':::RIR,CIR:IR[MY_REPORT]IN_MY_COLUMN_NAME:'
          || NAME
          || '')

````

** Where :**

- NN: Target Page
- RIR,CIR : clear report filters
- IR Prefix mandatory
- [MY_REPORT] : Static Id of Interactive Report.
- IN interactive report filter IN operator ( see operator list below)
- MY_COLUMN_NAME:  interactive report column name.
- \value to serch\ value of filter.


 ### Operator List

- C = Contains
- EQ = Equals (this is the default)
- GTE = Greater than or equal to
- GT = Greater Than
- LIKE = SQL Like operator
- LT = Less than
- LTE = Less than or equal to
- N = Null
- NC = Not Contains
- NEQ = Not Equals
- NLIKE = Not Like
- NN = Not Null
- NIN = Not In (escape the comma separated values with a leading and trailing backslash, )
- IN = In (escape the comma separated values with a leading and trailing backslash, )
- ROWFILTER = Row Text Contains (this searches all columns displayed in the report with type STRING or NUMBER)

