*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               defaultdatalist.Create List Data Test Default Role Value
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[groupMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[groupMgt]
...               AND               commonkeywords.Click button on list page      ${LOCATOR_ADDGROUP_BTN}
...               AND               commonkeywords.Wait Loading progress

Test template     Template Verify Condition Field Group Data

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Click xClose button    ${LOCATOR_XCLOSEGROUP_BTN}
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser


*** Test Cases ***
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#                    CASE                       |     CASE Type   |      Checkbox State     |  Limit User Value    #
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

CASE-Limit Users value equal -1                    condfield               check                -1
CASE-Limit Users value inequal -1                  condfield               uncheck               99
CASE-Limit Users value equal 0                     condfield               uncheck               0
CASE-Limit Users value equal EMPTY                 condfield               uncheck               ${EMPTY}
CASE-Check Unlimit Users                           condcheckbox            check                -1
CASE-Uncheck Unlimit Users                         condcheckbox            uncheck               ${EMPTY}

*** Keywords ***
Template Verify Condition Field Group Data
      [Arguments]    ${casetype}       ${checkboxstate}     ${limitusr_value}

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
    
      IF   '${casetype}'=='condcheckbox'
              commonkeywords.Clear field data form    ${LOCATOR_GROUPUNLIMITUSER_CHK}
              commonkeywords.Clear field data form    ${LOCATOR_GROUPLIMITUSER_FIELD}
              commonkeywords.Fill in data form        ${LOCATOR_GROUPUNLIMITUSER_CHK}    ${checkboxstate}
              commonkeywords.Verify data form         ${LOCATOR_GROUPLIMITUSER_FIELD}    should be    ${limitusr_value}
              Log To Console      TEST CASE 'Condition Group field Checkbox' VERIFIED.
      ELSE IF   '${casetype}'=='condfield'
              commonkeywords.Clear field data form    ${LOCATOR_GROUPUNLIMITUSER_CHK}
              commonkeywords.Clear field data form    ${LOCATOR_GROUPLIMITUSER_FIELD}
              commonkeywords.Fill in data form        ${LOCATOR_GROUPLIMITUSER_FIELD}    ${limitusr_value}
              commonkeywords.Verify data form         ${LOCATOR_GROUPUNLIMITUSER_CHK}    should be    ${checkboxstate}
              Log To Console      TEST CASE 'Condition Group field Checkbox' VERIFIED.
      ELSE
            Fail    \nPlease Check 'casetype' argument
     END
