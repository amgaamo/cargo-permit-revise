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
...               AND               service-permmgt.Request Service Create Permission
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   permcode=${DS_PERM['addnew'][${perm_col.permCode}]}


Test Setup        Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Click button on list page      ${LOCATOR_ADDPERM_BTN}
...               AND               commonkeywords.Verify Page Name is correct    Add Permission
...               AND               commonkeywords.Wait Loading progress

Test Template     Template Validate Permission field exception case

Test Teardown     Run Keywords    Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND             commonkeywords.Click xClose button            ${LOCATOR_XCLOSEPERM_BTN}

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               service-permmgt.Request Service Delete by Permission Code
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   permcode=${DS_PERM['addnew'][${perm_col.permCode}]}
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#                    CASE                       |        Permission Name        |      Expected Warning           #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

CASE-EMPTY Permission field                        ${EMPTY}                          ${PERM_REQUIREWARNMSG}[permcode]
CASE-Duplicate Permission Code                     ${DS_PERM['addnew'][0]}           ${PERM_OTHRWARNMSG}[duplicate]

*** Keywords ***
Template Validate Permission field exception case
   [Arguments]    ${permcode}     ${expwarn_permcode}

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
    
      commonkeywords.Fill in data form    ${LOCATOR_PERMCODE_FIELD}     ${permcode}
      commonkeywords.Click button on detail page    ${LOCATOR_PERMSAVE_BTN}

      IF   '${permcode}'==''
            commonkeywords.Verify Warning message field    ${LOCATOR_WARN_PERMCODE}       contains       ${expwarn_permcode}
            Log To Console    \TEST CASE VERIFIED.
      ELSE
            commonkeywords.Verify Modal Title message      Error
            commonkeywords.Verify Modal Content message    ${expwarn_permcode}
            commonkeywords.Click OK Button
            Log To Console    \TEST CASE VERIFIED.
      END
