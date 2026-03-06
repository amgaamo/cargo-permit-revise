*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource COMPANY INFO DATA
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               commonkeywords.Generate Random Values    3    3
...               AND               Set Suite Variable    ${defaultcompany_cust1}       ${JS_DEFAULTDATA['companydata'][1]}[companyname]
...               AND               Set Suite Variable    ${defaultgroup1_cust1}        ${JS_DEFAULTDATA['groupdata'][1]}[groupname]
...               AND               Set Suite Variable    ${defaultgroup2_cust1}        ${JS_DEFAULTDATA['groupdata'][2]}[groupname]
...               AND               Set Suite Variable    ${user_cust1}                 ${DS_USERPROFILE['adduserdata'][${usrdata_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}

...               AND               Set Suite Variable    ${defaultcompany_cust2}       ${JS_DEFAULTDATA['companydata'][2]}[companyname]
...               AND               Set Suite Variable    ${defaultgroup1_cust2}        ${JS_DEFAULTDATA['groupdata'][3]}[groupname]
...               AND               Set Suite Variable    ${user_cust2}                 ${DS_USERPROFILE['adduserdata'][${usrdata_col.username}]}${GLOBAL_RANDOMNO}${GLOBAL_RANDOMLETTER}
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Verify Login Page
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[usermgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[usermgt]
...               AND               service-usermgt.Request Service Add New User Data Test
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     companyname=${defaultcompany_cust1}
...                                     groupname=${defaultgroup1_cust1}
...                                     username=${user_cust1}     password=${VAR_DEFAULTPASSWORD}    newpassword=${VAR_CHGPASSWORD}
...                                     firstname=${DS_USERPROFILE['adduserdata'][${usrdata_col.firstname}]}
...                                     lastname=${DS_USERPROFILE['adduserdata'][${usrdata_col.lastname}]}
...                                     telnumber=${DS_USERPROFILE['adduserdata'][${usrdata_col.phone}]}
...                                     email=${DS_USERPROFILE['adduserdata'][${usrdata_col.email}]}_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

...               AND               service-usermgt.Request Service Add New User Data Test
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     companyname=${defaultcompany_cust2}
...                                     groupname=${defaultgroup1_cust2}
...                                     username=${user_cust2}     password=${VAR_DEFAULTPASSWORD}    newpassword=${VAR_CHGPASSWORD}
...                                     firstname=${DS_USERPROFILE['adduserdata'][${usrdata_col.firstname}]}
...                                     lastname=${DS_USERPROFILE['adduserdata'][${usrdata_col.lastname}]}
...                                     telnumber=${DS_USERPROFILE['adduserdata'][${usrdata_col.phone}]}
...                                     email=${DS_USERPROFILE['adduserdata'][${usrdata_col.email}]}_${GLOBAL_RANDOMNO}${GLOBAL_RANDOMLETTER}@mail.com

...               AND               Log To Console    Create User Data Test: ${user_cust1} ,${user_cust2})  Success!


Test Template     Template Edit User Success

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
#             CASE Name                  |           username         |     company name        |           Group Name          |                         Firstname                   |                            Lastname                               |                              phone                           |                           email                             #
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#

CASE-Edit Company Data                          ${user_cust1}              ${EMPTY}                     ${EMPTY}                     ${DS_USERPROFILE['edituser1'][${usrdata_col.firstname}]}       ${DS_USERPROFILE['edituser1'][${usrdata_col.lastname}]}         ${DS_USERPROFILE['edituser1'][${usrdata_col.phone}]}    ${DS_USERPROFILE['edituser1'][${usrdata_col.email}]}_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com
CASE-Edit New Company and New Group             ${user_cust2}              ${defaultcompany_cust1}      ${defaultgroup2_cust1}       ${DS_USERPROFILE['edituser2'][${usrdata_col.firstname}]}       ${DS_USERPROFILE['edituser2'][${usrdata_col.lastname}]}         ${DS_USERPROFILE['edituser2'][${usrdata_col.phone}]}    ${DS_USERPROFILE['edituser2'][${usrdata_col.email}]}_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com
CASE-Edit Old Company New Group                 ${user_cust1}              ${EMPTY}                     ${defaultgroup2_cust1}       ${DS_USERPROFILE['edituser1'][${usrdata_col.firstname}]}       ${DS_USERPROFILE['edituser1'][${usrdata_col.lastname}]}         ${DS_USERPROFILE['edituser1'][${usrdata_col.phone}]}    ${DS_USERPROFILE['edituser1'][${usrdata_col.email}]}_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

*** Keywords ***
Template Edit User Success
      [Arguments]    ${username}    ${companyname}    ${groupname}      ${firstname}   ${lastname}       ${phone}    ${email}

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
    
      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYUSER_SEL}          ${USERSEARCHBY}[username]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHUSER_KEYWORD}        ${username}
      commonkeywords.Click button on list page      ${LOCATOR_SEARCHUSER_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Click Hide Search Criteria
      commonkeywords.Wait Loading progress
      pageUserMgt.Verify User Result Datatable    1     username     should be      ${username}
      commonkeywords.Click button on list page      ${1ROW_USER_ACTION}[edit]
      commonkeywords.Verify Page Name is correct    Edit User
      commonkeywords.Wait Loading progress

      #Edit data

      commonkeywords.Verify Field State     ${LOCATOR_USERUSRNAME_FIELD}    disabled    timeout=30s
      commonkeywords.Verify Field State     ${LOCATOR_USERPWD_FIELD}        disabled

      IF   '${companyname}'!=''
          commonkeywords.Fill in data form    ${LOCATOR_USERCOMPANY_SEL}          ${companyname}
          commonkeywords.Wait Loading progress
      END
      IF   '${groupname}'!=''
          commonkeywords.Fill in data form    ${LOCATOR_USERGROUP_SEL}            ${groupname}
          commonkeywords.Wait Loading progress
      END

      pageUserMgt.Fill in user profile info
      ...     firstname=${firstname}
      ...     lastname=${lastname}
      ...     phone=${phone}
      ...     email=${email}

      commonkeywords.Click button on detail page    ${LOCATOR_USERSAVE_BTN}
      commonkeywords.Verify Modal Title message     Success
      commonkeywords.Click OK Button

      # ASSERTION
      # verify record in user list
      commonkeywords.Verify Page Name is correct    User Management
      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYUSER_SEL}          ${USERSEARCHBY}[username]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHUSER_KEYWORD}        ${username}
      commonkeywords.Click button on list page      ${LOCATOR_SEARCHUSER_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Click Hide Search Criteria
      commonkeywords.Wait Loading progress

      pageUserMgt.Verify User Result Datatable    1    name         contains        ${firstname}
      pageUserMgt.Verify User Result Datatable    1    name         contains        ${lastname}
      pageUserMgt.Verify User Result Datatable    1    username     should be       ${username}

      IF   '${companyname}'!=''
            pageUserMgt.Verify User Result Datatable    1    companyname    contains      ${companyname}
      END
      IF   '${groupname}'!=''
            pageUserMgt.Verify User Result Datatable    1    group    should be      ${groupname}   ignore_case=true
      END

      pageUserMgt.Verify User Result Datatable    1    email            should be     ${email}
      pageUserMgt.Verify User Result Datatable    1    approve          should be     Y
      pageUserMgt.Verify User Result Datatable    1    status           should be     ${USERSTATUS}[active]

      #verify use data info
      commonkeywords.Click button on list page      ${1ROW_USER_ACTION}[edit]
      commonkeywords.Verify Page Name is correct    Edit User
      commonkeywords.Wait Loading progress

      IF   '${companyname}'!=''
            commonkeywords.Verify data form         ${LOCATOR_USERCOMPANY_SEL}    should be        ${companyname}
            commonkeywords.Wait Loading progress
      END
      IF   '${groupname}'!=''
            commonkeywords.Verify data form         ${LOCATOR_USERGROUP_SEL}      should be        ${groupname}
            commonkeywords.Wait Loading progress
      END

      commonkeywords.Verify Field State     ${LOCATOR_USERUSRNAME_FIELD}    disabled
      commonkeywords.Verify Field State     ${LOCATOR_USERPWD_FIELD}        disabled

      pageUserMgt.Verify user profile Info
      ...     username=${username}
      ...     firstname=${firstname}
      ...     lastname=${lastname}
      ...     phone=${phone}
      ...     email=${email}

      commonkeywords.Click xClose button    ${LOCATOR_XCLOSEUSER_BTN}
      commonkeywords.Verify Page Name is correct    User Management

      service-profile.Request Service Login System      ${username}      ${VAR_CHGPASSWORD}
      service-profile.Request Service Logout System     ${username}      ${VAR_CHGPASSWORD}
      Log To Console      \nTEST CASE VERIFIED.
