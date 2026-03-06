*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               datasources.Import DataSource PERMISSION INFO DATA
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               commonkeywords.Initialize System and Go to Login Page

...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[permMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[permMgt]

...               AND               service-permmgt.Request Service Delete by Permission Code
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   permcode=${DS_PERM['addnew'][${perm_col.permCode}]}

Test Setup        Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               service-permmgt.Request Service Create Permission
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   permcode=${DS_PERM['addnew'][${perm_col.permCode}]}
...               AND               commonkeywords.Click Expand Search Criteria
...               AND               commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYPERM_SEL}         ${PERMSEARCHBY}[permcode]
...               AND               commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHPERM_KEYWORD}       ${DS_PERM['addnew'][${perm_col.permCode}]}
...               AND               commonkeywords.Click button on list page    ${LOCATOR_SEARCHPERM_BTN}
...               AND               commonkeywords.Wait Loading progress
...               AND               commonkeywords.Click Hide Search Criteria
...               AND               pagePermMgt.Verify Permission Result Datatable    1    permissioncode    should be    ${DS_PERM['addnew'][${perm_col.permCode}]}

Test Template     Template Delete Permission data

Test Teardown     Run Keywords   Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...                AND    service-permmgt.Request Service Delete by Permission Code
...                    headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                    permcode=${DS_PERM['addnew'][${perm_col.permCode}]}

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser


*** Test Cases ***
#--------------------------------------------------------------------#
#                 CASE NAME                 |         Confirm?       #
#--------------------------------------------------------------------#

CASE-Click Yes to confirm delete data             Yes
CASE-Click No to cancel delete data               No


*** Keywords ***
Template Delete Permission data
      [Arguments]    ${isConfirm}

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
    
      commonkeywords.Click button on list page        ${1ROW_PERM_ACTION}[delete]
      commonkeywords.Verify Modal Title message       Warning
      commonkeywords.Verify Modal Content message     delete this item

      IF   '${isConfirm}'=='Yes'
            commonkeywords.Click Yes Button for confirm
            commonkeywords.Click OK Button
            commonkeywords.Wait Loading progress
            commonkeywords.Click Expand Search Criteria
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYPERM_SEL}         ${PERMSEARCHBY}[permcode]
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHPERM_KEYWORD}       ${DS_PERM['addnew'][${perm_col.permCode}]}
            commonkeywords.Click button on list page    ${LOCATOR_SEARCHPERM_BTN}
            commonkeywords.Wait Loading progress
            commonkeywords.Verify data table result is No Record Found     ${ROW_PERM_TBODY}
            Log To Console      \nTEST CASE 'Confirm Delete Permission' VERIFIED.

      ELSE IF   '${isConfirm}'=='No'
            commonkeywords.Click No Button for Cancel
            commonkeywords.Click Expand Search Criteria
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYPERM_SEL}         ${PERMSEARCHBY}[permcode]
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHPERM_KEYWORD}       ${DS_PERM['addnew'][${perm_col.permCode}]}
            commonkeywords.Click button on list page    ${LOCATOR_SEARCHPERM_BTN}
            commonkeywords.Wait Loading progress
            pagePermMgt.Verify Permission Result Datatable    1    permissioncode    should be    ${DS_PERM['addnew'][${perm_col.permCode}]}
            Log To Console      \nTEST CASE 'Cancel Delete Permission' VERIFIED.
      ELSE
          Fail    \nPlease Check 'isConfirm' should any Yes or No
      END
