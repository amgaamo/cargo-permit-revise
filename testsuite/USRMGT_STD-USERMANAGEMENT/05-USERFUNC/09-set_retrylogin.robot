*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource COMPANY INFO DATA
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               commonkeywords.Generate Random Values    3    3
...               AND               Set Suite Variable    ${defaultcompany_cust}       ${JS_DEFAULTDATA['companydata'][2]}[companyname]
...               AND               Set Suite Variable    ${defaultgroup_cust}         ${JS_DEFAULTDATA['groupdata'][3]}[groupname]
...               AND               Set Suite Variable    ${username_lock}             ${DS_USERPROFILE['lockuser'][${usrdata_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Initialize System and Go to Login Page

...               AND               service-usermgt.Request Service Add New User Data Test
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   companyname=${defaultcompany_cust}
...                                   groupname=${defaultgroup_cust}
...                                   username=${username_lock}     password=${VAR_DEFAULTPASSWORD}    newpassword=${VAR_CHGPASSWORD}
...                                   firstname=${DS_USERPROFILE['lockuser'][${usrdata_col.firstname}]}
...                                   lastname=${DS_USERPROFILE['lockuser'][${usrdata_col.lastname}]}
...                                   telnumber=${DS_USERPROFILE['lockuser'][${usrdata_col.phone}]}
...                                   email=${DS_USERPROFILE['lockuser'][${usrdata_col.email}]}_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
CASE-Retry Password Max User is Locked

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
    
      service-profile.Request Service Login System    ${username_lock}     ErrPwd@123    fail
      Should Contain      ${GLOBAL_LOGIN_WARNMSG}   (1)
      service-profile.Request Service Login System    ${username_lock}     ErrPwd@456    fail
      Should Contain      ${GLOBAL_LOGIN_WARNMSG}   (2)
      service-profile.Request Service Login System    ${username_lock}     ErrPwd@789    fail
      Should Contain      ${GLOBAL_LOGIN_WARNMSG}   ${VAR_MSGLOGIN_USERLOCK}

      commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
      commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[usermgt]
      commonkeywords.Verify Page Name is correct    pagename=${menuname}[usermgt]

      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYUSER_SEL}          ${USERSEARCHBY}[username]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHUSER_KEYWORD}        ${username_lock}
      commonkeywords.Click button on list page            ${LOCATOR_SEARCHUSER_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Click Hide Search Criteria
      commonkeywords.Wait Loading progress

      # Assert User Status is Inactive and Unlock User
      pageUserMgt.Verify User Result Datatable    1    username    contains      ${username_lock}
      pageUserMgt.Verify User Result Datatable    1    status      should be     ${USERSTATUS}[active]
      commonkeywords.Verify Field State           ${LOCATOR_USERLOCK_ICON}       visible

      Log To Console      TEST CASE VERIFIED.
