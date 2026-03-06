*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource COMPANY INFO DATA
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.     
...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[companyMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[companyMgt]

...               AND               commonkeywords.Click button on list page    ${LOCATOR_ADDCOMP_BTN}
...               AND               commonkeywords.Fill in data form    ${LOCATOR_COMREGISTYPE_SEL}      ${COMREGISTYPE}[legal]
...               AND               commonkeywords.Fill in data form    ${LOCATOR_COMTAXID_FIELD}        0100100010010
...               AND               commonkeywords.Click button on detail page    ${LOCATOR_COMNEXT_BTN}
...               AND               commonkeywords.Wait Loading progress

Test template     Template Verify Condition Field Company Data
     
Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Click xClose button     ${LOCATOR_XCLOSECOMPANY_BTN}
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
#                    CASE                       |     CASE Type   |      Register Type     | Unlimit User | Unlimit lock  |  unlimit repeat pwd | unlimit pwd expired  | Expected State branch   |    limit User Field |  Limit lock Field |  limit repeat pwd field |  limit pwd expired  field #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
CASE1-Type is Legal                                   condregis         ${COMREGISTYPE}[legal]       ${EMPTY}     ${EMPTY}          ${EMPTY}             ${EMPTY}            visible                 ${EMPTY}                ${EMPTY}          ${EMPTY}                   ${EMPTY}
CASE2-Type is Person                                  condregis         ${COMREGISTYPE}[person]      ${EMPTY}     ${EMPTY}          ${EMPTY}             ${EMPTY}            hidden                  ${EMPTY}                ${EMPTY}          ${EMPTY}                   ${EMPTY}

CASE3-Check Unlimit Users                             condcheckbox      ${EMPTY}                     check        uncheck           uncheck              uncheck             ${EMPTY}                 -1                     ${EMPTY}          ${EMPTY}                   ${EMPTY}
CASE4-Uncheck Unlimit Users                           condcheckbox      ${EMPTY}                     uncheck      uncheck           uncheck              uncheck             ${EMPTY}                ${EMPTY}                ${EMPTY}          ${EMPTY}                   ${EMPTY}
CASE5-Check Unlimited Login Attempts                  condcheckbox      ${EMPTY}                     uncheck      check             uncheck              uncheck             ${EMPTY}                ${EMPTY}                -1                ${EMPTY}                   ${EMPTY}
CASE6-Uncheck Unlimited Login Attempts                condcheckbox      ${EMPTY}                     uncheck      uncheck           uncheck              uncheck             ${EMPTY}                ${EMPTY}                ${EMPTY}          ${EMPTY}                   ${EMPTY}
CASE7-Check Unlimited Repeat Password                 condcheckbox      ${EMPTY}                     uncheck      uncheck           check                uncheck             ${EMPTY}                ${EMPTY}                ${EMPTY}          -1                         ${EMPTY}
CASE8-Uncheck Unlimited Repeat Password               condcheckbox      ${EMPTY}                     uncheck      uncheck           uncheck              uncheck             ${EMPTY}                ${EMPTY}                ${EMPTY}          ${EMPTY}                   ${EMPTY}
CASE9-Check Unlimited Password Expire Days            condcheckbox      ${EMPTY}                     uncheck      uncheck           uncheck              check               ${EMPTY}                ${EMPTY}                ${EMPTY}          ${EMPTY}                   -1
CASE10-Uncheck Unlimited Password Expire Days         condcheckbox      ${EMPTY}                     uncheck      uncheck           uncheck              uncheck             ${EMPTY}                ${EMPTY}                ${EMPTY}          ${EMPTY}                   ${EMPTY}

CASE11-Limit Users value equal -1                     condfield         ${EMPTY}                     check        uncheck           uncheck              uncheck             ${EMPTY}                -1                      ${EMPTY}          ${EMPTY}                   ${EMPTY}
CASE12-Limited Login Attempts equal -1                condfield         ${EMPTY}                     uncheck      check             uncheck              uncheck             ${EMPTY}                ${EMPTY}                -1                ${EMPTY}                   ${EMPTY}
CASE13-Limited Repeat Password value equal -1         condfield         ${EMPTY}                     uncheck      uncheck           check                uncheck             ${EMPTY}                ${EMPTY}                ${EMPTY}          -1                         ${EMPTY}
CASE14-Limited Password Expire Days value equal -1    condfield         ${EMPTY}                     uncheck      uncheck           uncheck              check               ${EMPTY}                ${EMPTY}                ${EMPTY}          ${EMPTY}                   -1
CASE15-Limit Users value inequal -1                   condfield         ${EMPTY}                     uncheck      uncheck           uncheck              uncheck             ${EMPTY}                30                      ${EMPTY}          ${EMPTY}                   ${EMPTY}
CASE16-Limited Login Attempts inequal -1              condfield         ${EMPTY}                     uncheck      uncheck           uncheck              uncheck             ${EMPTY}                ${EMPTY}                20                ${EMPTY}                   ${EMPTY}
CASE17-Limited Repeat Password value inequal -1       condfield         ${EMPTY}                     uncheck      uncheck           uncheck              uncheck             ${EMPTY}                ${EMPTY}                ${EMPTY}          50                         ${EMPTY}
CASE18-Limited Password Expire Days value inequal -1  condfield         ${EMPTY}                     uncheck      uncheck           uncheck              uncheck             ${EMPTY}                ${EMPTY}                ${EMPTY}          ${EMPTY}                   65


*** Keywords ***
Template Verify Condition Field Company Data
      [Arguments]    ${casetype}    ${regisType}     ${actionlimitusr}    ${actionlimitlock}    ${actionlimitpwd}       ${actionlimitpwdexpired}      ${expstatebranchfield}     ${vallimitusr}    ${vallimitlock}    ${vallimitpwd}     ${vallimitpwdexpired}
      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.

      IF  '${casetype}'=='condregis'
          commonkeywords.Clear field data form    ${LOCATOR_COMREGISTYPE_SEL}
          commonkeywords.Fill in data form        ${LOCATOR_COMREGISTYPE_SEL}              ${regisType}
          Sleep    500ms
          #Assertion
          commonkeywords.Wait Loading progress
          commonkeywords.Verify Field State   ${LOCATOR_COMBRANCH_FIELD}     ${expstatebranchfield}
          Log To Console      \nTEST CASE VERIFIED.
      ELSE IF   '${casetype}'=='condcheckbox'
          commonkeywords.Clear field data form    ${LOCATOR_COMUNLIMITUSR_CHK}
          commonkeywords.Clear field data form    ${LOCATOR_COMUNLIMITLOGINATTM_CHK}
          commonkeywords.Clear field data form    ${LOCATOR_COMUNLIMITREPEATPWD_CHK}
          commonkeywords.Clear field data form    ${LOCATOR_COMUNLIMITPWDEXPIRED_CHK}
          Hover  ${LOCATOR_COMSAVE_BTN}
          commonkeywords.Fill in data form        ${LOCATOR_COMUNLIMITUSR_CHK}              ${actionlimitusr}
          commonkeywords.Fill in data form        ${LOCATOR_COMUNLIMITLOGINATTM_CHK}        ${actionlimitlock}
          commonkeywords.Fill in data form        ${LOCATOR_COMUNLIMITREPEATPWD_CHK}        ${actionlimitpwd}
          commonkeywords.Fill in data form        ${LOCATOR_COMUNLIMITPWDEXPIRED_CHK}       ${actionlimitpwdexpired}

          #Assertion
          commonkeywords.Verify data form         ${LOCATOR_COMLIMITUSR_FIELD}            should be    ${vallimitusr}
          commonkeywords.Verify data form         ${LOCATOR_COMLIMITLOGINATTM_FIELD}      should be    ${vallimitlock}
          commonkeywords.Verify data form         ${LOCATOR_COMLIMITREPEATPWD_FIELD}      should be    ${vallimitpwd}
          commonkeywords.Verify data form         ${LOCATOR_COMPWDEXPIRED_FIELD}          should be    ${vallimitpwdexpired}
          Log To Console      \nTEST CASE VERIFIED.
      ELSE IF   '${casetype}'=='condfield'
          commonkeywords.Clear field data form    ${LOCATOR_COMUNLIMITUSR_CHK}
          commonkeywords.Clear field data form    ${LOCATOR_COMUNLIMITLOGINATTM_CHK}
          commonkeywords.Clear field data form    ${LOCATOR_COMUNLIMITREPEATPWD_CHK}
          commonkeywords.Clear field data form    ${LOCATOR_COMUNLIMITPWDEXPIRED_CHK}
          Hover  ${LOCATOR_COMSAVE_BTN}
          commonkeywords.Fill in data form        ${LOCATOR_COMLIMITUSR_FIELD}              ${vallimitusr}
          commonkeywords.Fill in data form        ${LOCATOR_COMLIMITLOGINATTM_FIELD}        ${vallimitlock}
          commonkeywords.Fill in data form        ${LOCATOR_COMLIMITREPEATPWD_FIELD}        ${vallimitpwd}
          commonkeywords.Fill in data form        ${LOCATOR_COMPWDEXPIRED_FIELD}            ${vallimitpwdexpired}
          Sleep  1s
          #Assertion
          commonkeywords.Verify data form         ${LOCATOR_COMUNLIMITUSR_CHK}              should be    ${actionlimitusr}
          Log     ${actionlimitlock}
          Log     ${actionlimitpwd}
          Log     ${actionlimitpwdexpired}
          commonkeywords.Verify data form         ${LOCATOR_COMUNLIMITLOGINATTM_CHK}        should be    ${actionlimitlock}
          commonkeywords.Verify data form         ${LOCATOR_COMUNLIMITREPEATPWD_CHK}        should be    ${actionlimitpwd}
          commonkeywords.Verify data form         ${LOCATOR_COMUNLIMITPWDEXPIRED_CHK}       should be    ${actionlimitpwdexpired}
          Log To Console      \nTEST CASE VERIFIED.
      END
