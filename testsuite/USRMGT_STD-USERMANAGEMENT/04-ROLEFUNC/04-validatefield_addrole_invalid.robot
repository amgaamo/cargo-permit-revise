*** Settings ***
Resource          ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               Set Suite Variable     ${default_companyrole}       ${JS_DEFAULTDATA['companydata'][1]}[companyname]
...               AND               Set Suite Variable     ${default_role}          ${JS_DEFAULTDATA['roledata'][0]}[rolename]
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 

...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[roleMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[roleMgt]

Test Setup        Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               commonkeywords.Click button on list page      ${LOCATOR_ADDROLE_BTN}
...               AND               commonkeywords.Verify Page Name is correct    Add Role

Test template     Template Validate Role field exception case

Test Teardown     Run keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               commonkeywords.Click xClose button    ${LOCATOR_XCLOSEROLE_BTN}

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser


*** Test Cases ***
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#                    CASE                       |     Company Name      |     Role Name        |            Expected Warning           #
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

CASE-EMPTY Role field                                ${default_companyrole}      ${EMPTY}                 ${ROLE_REQUIREWARNMSG}[roleName]
CASE-Duplicate Role Name                             ${default_companyrole}      ${default_role}          ${ROLE_OTHRWARNMSG}[duplicate]
CASE-EMPTY Company Name (VERSION IE5DEV)             Please Select               Test Role                ${ROLE_REQUIREWARNMSG}[comName]

*** Keywords ***
Template Validate Role field exception case
   [Arguments]    ${comname}    ${rolename}     ${expwarn_rolename}
      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
      Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='STANDARD' and '${comname}'=='Please Select'      \nExecute Test only IE5DEV Version
      commonkeywords.Wait Loading progress   
      IF  '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
          commonkeywords.Fill in data form              ${LOCATOR_COMPANYROLE_SEL}     ${comname}
      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
          Log To Console    \nExecute Test For Standard Version
      ELSE
          Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'IE5DEV' or STANDARD
      END

      commonkeywords.Fill in data form              ${LOCATOR_ROLENAME_FIELD}     ${rolename}
      commonkeywords.Click button on detail page    ${LOCATOR_ROLEPSAVE_BTN}

      IF   '${rolename}'==''
          IF   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
              commonkeywords.Verify Warning message field     ${LOCATOR_WARN_IE5DEVROLENAME}    contains    ${expwarn_rolename}
          ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
              commonkeywords.Verify Warning message field     ${LOCATOR_WARN_ROLENAME}          contains    ${expwarn_rolename}
          ELSE
              Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'IE5DEV' or STANDARD
          END
          Log To Console      TEST CASE VERIFIED.

      ELSE IF   '${rolename}'=='${default_role}'
            commonkeywords.Verify Modal Title message       Error
            commonkeywords.Verify Modal Content message     ${expwarn_rolename}
            commonkeywords.Click OK Button
            Log To Console      TEST CASE VERIFIED.

      ELSE IF   '${comname}'=='Please Select'
            commonkeywords.Verify Warning message field     ${LOCATOR_WARN_COMROLENAME}    contains    ${expwarn_rolename}
            Log To Console      TEST CASE VERIFIED.
      END
