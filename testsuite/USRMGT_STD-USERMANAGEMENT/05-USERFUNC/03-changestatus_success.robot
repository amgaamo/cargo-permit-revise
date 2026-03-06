*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource COMPANY INFO DATA
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               Set Suite Variable    ${defaultcompany_cust}       ${JS_DEFAULTDATA['companydata'][1]}[companyname]
...               AND               Set Suite Variable    ${defaultgroup_cust}         ${JS_DEFAULTDATA['groupdata'][1]}[groupname]
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Initialize System and Go to Login Page

Test Setup        Run Keywords      commonkeywords.Generate Random Values    3    3
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
            
Test Template     Template Change Status User

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
#                 CASE                  |                                                     User Name                                                      |  isActive Data    |     Confirm?     |     Expected Status  #
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
CASE1-Sysadmin Change status ACTIVE to INACTIVE         ${DS_USERPROFILE['changestatus'][${usrdata_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}        true                     Yes                 inactive
CASE2-Sysadmin Change status INACTIVE to ACTIVE         ${DS_USERPROFILE['changestatus'][${usrdata_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}        false                    Yes                 active
CASE3-Sysadmin Cancel to change status                  ${DS_USERPROFILE['changestatus'][${usrdata_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}        true                     No                  active


*** Keywords ***
Template Change Status User
   [Arguments]         ${username}       ${isActive}    ${isConfirm}      ${expectedstatus}

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
    
      commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}

      service-usermgt.Request Service Add New User Data Test
      ...             headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...             companyname=${defaultcompany_cust}
      ...             groupname=${defaultgroup_cust}
      ...             username=${username}     password=${VAR_DEFAULTPASSWORD}    newpassword=${VAR_CHGPASSWORD}
      ...             firstname=${DS_USERPROFILE['changestatus'][${usrdata_col.firstname}]}
      ...             lastname=${DS_USERPROFILE['changestatus'][${usrdata_col.lastname}]}
      ...             telnumber=${DS_USERPROFILE['changestatus'][${usrdata_col.phone}]}
      ...             email=${DS_USERPROFILE['changestatus'][${usrdata_col.email}]}_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

      service-usermgt.Request Service Update User Status
      ...             headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...             username=${username}      isActive=${isActive}

      commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[usermgt]
      commonkeywords.Verify Page Name is correct    pagename=${menuname}[usermgt]

      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYUSER_SEL}          ${USERSEARCHBY}[username]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHUSER_KEYWORD}        ${username}
      commonkeywords.Click button on list page      ${LOCATOR_SEARCHUSER_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Click Hide Search Criteria
      commonkeywords.Wait Loading progress
      pageUserMgt.Verify User Result Datatable    1    username    should be     ${username}


      IF   '${isActive}'=='true'
            pageUserMgt.Verify User Result Datatable    1    status    should be     ${USERSTATUS}[active]
      ELSE
            pageUserMgt.Verify User Result Datatable    1    status    should be     ${USERSTATUS}[inactive]
      END

      commonkeywords.Click button on list page    ${1ROW_USER_ACTION}[changeStatus]
      commonkeywords.Verify Modal Title message    Warning

      IF    '${isConfirm}'=='Yes'
            commonkeywords.Click Yes Button for confirm
            commonkeywords.Verify Modal Title message      Success
            commonkeywords.Verify Modal Content message    ${USERMGT_WARNMSG}[changestatus]
            commonkeywords.Click OK Button
      ELSE
            commonkeywords.Click No Button for Cancel
      END

      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYUSER_SEL}          ${USERSEARCHBY}[username]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHUSER_KEYWORD}        ${username}
      commonkeywords.Click button on list page      ${LOCATOR_SEARCHUSER_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Click Hide Search Criteria
      commonkeywords.Wait Loading progress
      pageUserMgt.Verify User Result Datatable    1    username    should be     ${username}
      pageUserMgt.Verify User Result Datatable    1    status      should be     ${USERSTATUS}[${expectedstatus}]

      commonkeywords.Logout System
      pageLogin.Fill in Login Field    ${username}    ${VAR_CHGPASSWORD}
      commonkeywords.Click Login Button
      commonkeywords.Login Waiting Loading

      IF    '${expectedstatus}'=='active'
            commonkeywords.Verify Welcome page
            commonkeywords.Logout System
            Log To Console      TEST CASE VERIFIED.
      ELSE
            commonkeywords.Verify Modal Title message        Login Failed
            commonkeywords.Verify Modal Content message      ${VAR_MSGLOGIN_INACTIVE}
            commonkeywords.Click Close Button
            commonkeywords.Verify Login Page
      END
