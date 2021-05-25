# Oracle Application Express Developer Notes

**Reference code for Apex Development.**
Virgil A. Aviles

## PL/SQL Code for DML Process

CREATE,SAVE,DELETE
\

````sql

begin
   case :APEX$ROW_STATUS
   when 'C' then 

      insert into TABLE_NAME ( col1, col2, col3 ..)
      values ( :PNN_A, :PNN_B, :PNN_C ...) ;

      /*
         insert into TABLE_NAME ( col1, col2, col3 ..)
         values ( :PNN_A, :PNN_B, :PNN_C ...) 
         returning rowid into :ROWID l
      */

      if :PNN_ZZZ is not null then 
         insert into TABLE_NAME_ZZZ ( col1, col2 ..)
         values ( :PNN_ID, :PNN_ZZZ ...) ;
      end if;

   when 'U' then
      update TABLE_NAME
         set col1 = :PNN_A,
             col2 = :PNN_B,
             col3 = :PNN_C
      where 
         col_id = :PNN_ID ;

      /*
         update TABLE_NAME
            set col1 = :PNN_A,
                col2 = :PNN_B,
                col3 = :PNN_C
         where 
            rowid = :ROWID ;
      */ 


      merge into TABLE_NAME_ZZZ dst
            using (select :PNN_ID as ID, :PNN_ZZZ AS ZZZ FROM SYS.DUAL ) src
            on ( src.id = dst.id )
            when matched then update set dst.zzz = src.zzz
                 delete where src.ZZZ is null
            when not matched then insert ( dst.no, dst.zzz ) values ( src.no, src.zzz )
                 where src.zzz is not null ;   
      
   when 'D' then
      delete TABLE_NAME
      where id = :PNN_ID ;

      /*
         delete TABLE_NAME
         where rowid = :ROWID ;
      */

      delete from TABLE_NAME_ZZZ
      where id = :PNN_ID ;
   
   end case ;

end ;


````


## Login Page Background


````
.t-PageBody--login .t-Login-container {
    background-color: -moz-linear-gradient(top, #45484d 0%, #000000 100%);  
    background-color: -webkit-linear-gradient(top, #45484d 0%,#000000 100%);  
    background-color: linear-gradient(to bottom, #45484d 0%,#000000 100%);  
}


.t-PageBody--login {
     background-image: url("#APP_IMAGES#texture-11.png");
     background-size: 360px 360px;
     background-repeat:repeat;
}


````

## Context Sessions

````sql

SELECT SYS_CONTEXT('APEX$SESSION','APP_USER') AS X FROM DUAL ;
SELECT SYS_CONTEXT('APEX$SESSION','APP_SESSION') AS X FROM DUAL ;
SELECT SYS_CONTEXT('APEX$SESSION','WORKSPACE_ID') AS X FROM DUAL ;

CREATE OR REPLACE FUNCTION MY_AUTH(
    p_username IN VARCHAR2, 
    p_password IN VARCHAR2)
RETURN BOOLEAN
IS
BEGIN
    APEX_UTIL.SET_CUSTOM_AUTH_STATUS(p_status=>'User:'||p_username||' is back.');
    IF UPPER(p_username) = 'GOOD' THEN
        APEX_UTIL.SET_AUTHENTICATION_RESULT(24567);
        RETURN TRUE;
    ELSE
        APEX_UTIL.SET_AUTHENTICATION_RESULT(-666);
        RETURN FALSE;
    END IF;
END;
7 - Docu


````

## Execute PL/SQL Procedure from JS with Confirmation 

````
apex.message.confirm("Are you sure to do this?", function(okPressed) {
    if (okPressed) {
        //
        apex.server.process(
            "TRUNCATE_A10000_ERRORS", {}, {
                dataType: 'text',
                success: function(pData) {
                    var region = apex.region( "paneErrorLog" );
                    region.refresh();
                    return;
                }
            }
        );
        //
    }
});

Other Examples:

apex.server.process(
    "TRUNCATE_A10000_ERRORS", {
        x01: '',
        x02: '',
        x03: ''
    }, {
        dataType: 'text',
        success: function(pData) {
            // alert(pData)
            console.log( 'Message to console');
        }
    }
);







````

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
          || '::::PNN_ID:'
          || <COLUMN_VALUE>
          || '')
          AS EDIT_LINK

````

**Where:**

- NN: Target Page

## Reports / Charts / Cards: Build URL and filter target dynamic report 

Dynamically create a calling URL and filter a dynamic report.

````sql
     APEX_UTIL.PREPARE_URL (
             'f?p='
          || v ('APP_ID')
          || ':NN:'
          || v ('SESSION')
          || ':::RIR,CIR:IR[MY_REPORT]IN_MY_COLUMN_NAME:'
          || TARGET_VALUE_TO_SEARCH
          || '')

````

** Where :**

- NN: Target Page
- RIR,CIR : Clear Report filters
- IR : Prefix Mandatory
- [MY_REPORT] : Static Id of Interactive Report.
- IN : Report filter IN operator ( see operator list below)
- MY_COLUMN_NAME: Interactive report column name.
- TARGET_VALUE_TO_SEARCH: Value of filter.


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



## Custom Confirm Dialog Button Labels

Change the labels of the confirm dialog buttons from “Cancel/Ok” to “No/Yes”.

Reference : https://askmax.blog/2018/01/17/custom-confirm-dialog-button-labels/

````
customConfirm( "Are you sure?", function( okPressed ) {
    console.log(okPressed ? 'Ok' : 'Cancel');
}, "Yes", "No");

````


````
function customConfirm( pMessage, pCallback, pOkLabel, pCancelLabel ){
    var l_original_messages = {"APEX.DIALOG.OK":     apex.lang.getMessage("APEX.DIALOG.OK"),
                               "APEX.DIALOG.CANCEL": apex.lang.getMessage("APEX.DIALOG.CANCEL")};

    //change the button labels messages
    apex.lang.addMessages({"APEX.DIALOG.OK":     pOkLabel});
    apex.lang.addMessages({"APEX.DIALOG.CANCEL": pCancelLabel});

    //show the confirm dialog
    apex.message.confirm(pMessage, pCallback);
    
    //the timeout is required since APEX 19.2 due to a change in the apex.message.confirm
    setTimeout(function () {
    //changes the button labels messages back to their original values
    apex.lang.addMessages({"APEX.DIALOG.OK":     l_original_messages["APEX.DIALOG.OK"]});
    apex.lang.addMessages({"APEX.DIALOG.CANCEL": l_original_messages["APEX.DIALOG.CANCEL"]});
    }, 0);
}

````


## Calling PLSQL from Javascript

Call a database procedure passing a parameter which returns a result without submitting the page.
For the example, I have a procedure called process_order, which returns an error message and an error code. If the return is successful, then the error code will be 0, if not it will return an error code.

1. AJAX Callback: Let’s start with the ajax process responsible for calling the PL/SQL procedure.

On the APEX page go to the Processing tab, right click on Ajax Callback and click on Create Process.

#### In the PL/SQL Code window, add the code below to call the database procedure.

````

Declare
   ln_error_code         Number;
   lv_error_msg          varchar2(4000);   

Begin
FOR i IN 1..apex_application.g_f01.COUNT
LOOP
PROCESS_ORDER (p_order_num => apex_application.g_f01(i),
               p_return_code => ln_error_code ,
               p_return_message => lv_error_msg);
END LOOP;

/* below, the function return a JSON formatted string with the two returned values */
apex_json.open_object;
  apex_json.open_array('output');
    apex_json.open_object;
      apex_json.write('lv_error_code', ln_error_code);
       apex_json.write('lv_error_msg', lv_error_msg);
  apex_json.close_object; 
   apex_json.close_array;
apex_json.close_object;

End;

````

#### JavaScript function to call the AJAX Process
In the page properties level go to Function and Global Variable Declaration to create the JavaScript function.

2. JavaScript function to call the AJAX Process
In the page properties level go to Function and Global Variable Declaration to create the JavaScript function.

````

function processOrder(id) {
    /* to avoid the user to click on some other order while a order is being processed,
        we show the apex spinner, you need to set a ID on the report. in this case the ID is ORDER_REPORT */
    var lSpinner$ = apex.util.showSpinner( $( "#ORDER_REPORT" ) );
    /* ajax to call the database procedure */
    apex.server.process("PROCESS_ORDER", { // the ajax callback process name
        f01 : id, /* The order id passed from the report link */
        pageItems: "#P1_ORDER_ID" // The page item that we want to submit before calling the process.
    }, {
        success: function(pData) {
            /* now we can remove the spinner */
            lSpinner$.remove();
            
            /* The Ajax process will return lv_error_msg and lv_error_code, if lv_error_code = 0 
            show the successful message, if not show the error */ 
            var errorMsg = pData.output[0].lv_error_msg; 
            if (pData.output[0].lv_error_code == '0') {
                apex.message.clearErrors();
                apex.message.alert( 'Order processed successfully' );
            } else {
                apex.message.clearErrors();
                apex.message.showErrors([{
                    type: "error",
                    location: ["page"],
                    message: errorMsg,
                    unsafe: false
                }]);
            }
        }
    });
}

````

3. Create the order report to call the JavaScript function. I am using the DEMO_ORDERS table from the sample database package application, but you can use your own.

3.1 Edit the order id column to call the JavaScript function.
Type: Link
Target: Type: URL / Target: javascript:processOrder(#ORDER_ID#);
Link Text: #ORDER_ID#
Link Attributes: class=”t-Button t-Button–simple t-Button–hot t-Button–stretch”

Run the report to show the results. In this example the order #2 returns a successful message, #3 returns an error.