*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource COMPANY INFO DATA
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               commonkeywords.Initialize System and Go to Login Page

Test Setup        Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               commonkeywords.Verify Login Page
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[usermgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[usermgt]
...               AND               commonkeywords.Generate Random Values    3    3

Test Teardown     Run Keywords    Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND             commonkeywords.Logout System
Suite teardown    Run Keywords    Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND             commonkeywords.Release user lock and close all browser


*** Test Cases ***
CASE-Add New Customer User Success

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
    
      Set Local Variable     ${customer_company}          ${JS_DEFAULTDATA['companydata'][1]}[companyname]
      Set Local Variable     ${customer_group}            ${JS_DEFAULTDATA['groupdata'][2]}[groupname]

      Set Local Variable     ${customer_username}         ${DS_USERPROFILE['adduserdata'][${usrdata_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
      Set Local Variable     ${customer_useremail}        ${DS_USERPROFILE['adduserdata'][${usrdata_col.email}]}_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

      commonkeywords.Click button on list page      ${LOCATOR_ADDUSER_BTN}
      commonkeywords.Verify Page Name is correct    Add User
      commonkeywords.Wait Loading progress
      commonkeywords.Fill in data form              ${LOCATOR_USERCOMPANY_SEL}          ${customer_company}
      commonkeywords.Wait Loading progress
      commonkeywords.Fill in data form              ${LOCATOR_USERGROUP_SEL}            ${customer_group}
      commonkeywords.Fill in data form              ${LOCATOR_USERUSRNAME_FIELD}        ${customer_username}
      commonkeywords.Fill in data form              ${LOCATOR_USERPWD_FIELD}            ${VAR_DEFAULTPASSWORD}
      commonkeywords.Fill in data form              ${LOCATOR_USERCFPWD_FIELD}          ${VAR_DEFAULTPASSWORD}

      pageUserMgt.Fill in user profile info
      ...     firstname=${DS_USERPROFILE['adduserdata'][${usrdata_col.firstname}]}
      ...     lastname=${DS_USERPROFILE['adduserdata'][${usrdata_col.lastname}]}
      ...     phone=${DS_USERPROFILE['adduserdata'][${usrdata_col.phone}]}
      ...     email=${customer_useremail}


      commonkeywords.Click button on detail page    ${LOCATOR_USERSAVE_BTN}
      commonkeywords.Verify Modal Title message     Success
      commonkeywords.Click OK Button

      # ASSERTION
      # verify record in user list
      commonkeywords.Verify Page Name is correct    User Management
      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYUSER_SEL}          ${USERSEARCHBY}[username]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHUSER_KEYWORD}        ${customer_username}
      commonkeywords.Click button on list page      ${LOCATOR_SEARCHUSER_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Click Hide Search Criteria
      commonkeywords.Wait Loading progress

      pageUserMgt.Verify User Result Datatable    1    name             contains      ${DS_USERPROFILE['adduserdata'][${usrdata_col.firstname}]}
      pageUserMgt.Verify User Result Datatable    1    name             contains      ${DS_USERPROFILE['adduserdata'][${usrdata_col.lastname}]}
      pageUserMgt.Verify User Result Datatable    1    username         should be     ${customer_username}
      pageUserMgt.Verify User Result Datatable    1    companyname      contains      ${customer_company}
      pageUserMgt.Verify User Result Datatable    1    group            should be     ${customer_group}       ignore_case=true
      pageUserMgt.Verify User Result Datatable    1    email            should be     ${customer_useremail}
      pageUserMgt.Verify User Result Datatable    1    approve          should be     Y
      pageUserMgt.Verify User Result Datatable    1    status           should be     ${USERSTATUS}[active]

      #verify use data info
      commonkeywords.Click button on list page      ${1ROW_USER_ACTION}[edit]
      commonkeywords.Verify Page Name is correct    Edit User
      commonkeywords.Wait Loading progress

      commonkeywords.Verify data form       ${LOCATOR_USERCOMPANY_SEL}      should be    ${customer_company}
      commonkeywords.Verify data form       ${LOCATOR_USERGROUP_SEL}        should be    ${customer_group}
      commonkeywords.Verify Field State     ${LOCATOR_USERUSRNAME_FIELD}    disabled
      commonkeywords.Verify Field State     ${LOCATOR_USERPWD_FIELD}        disabled

      pageUserMgt.Verify user profile Info
      ...     username=${customer_username}
      ...     firstname=${DS_USERPROFILE['adduserdata'][${usrdata_col.firstname}]}
      ...     lastname=${DS_USERPROFILE['adduserdata'][${usrdata_col.lastname}]}
      ...     phone=${DS_USERPROFILE['adduserdata'][${usrdata_col.phone}]}
      ...     email=${customer_useremail}

      commonkeywords.Click xClose button    ${LOCATOR_XCLOSEUSER_BTN}
      commonkeywords.Verify Page Name is correct    User Management

      commonkeywords.Logout System
      commonkeywords.Verify Login Page
      pageLogin.Fill in Login Field
      ...     username=${customer_username}
      ...     password=${VAR_DEFAULTPASSWORD}
      commonkeywords.Click Login Button
      commonkeywords.Login Waiting Loading

      pageChangePwd.Fill in Change Password Field
      ...     oldpwd=${VAR_DEFAULTPASSWORD}
      ...     newpwd=${VAR_NEWPASSWORD}
      ...     confirmpwd=${VAR_NEWPASSWORD}
      pageChangePwd.Click Change Password Button
      commonkeywords.Verify Modal Title message    Success
      commonkeywords.Click OK Button
      commonkeywords.Verify Modal should Hidden

      commonkeywords.Verify Welcome page
      commonkeywords.Verify Profile Detail data     ${LOCATOR_USRNAME_WELCOME_BAR}      ${customer_username}

      #logout and login again
      commonkeywords.Logout System
      commonkeywords.Verify Login Page
      pageLogin.Fill in Login Field
      ...     username=${customer_username}
      ...     password=${VAR_NEWPASSWORD}
      commonkeywords.Click Login Button
      commonkeywords.Login Waiting Loading
      commonkeywords.Ignore warning Login
      commonkeywords.Verify Welcome page
      commonkeywords.Verify Profile Detail data     ${LOCATOR_USRNAME_WELCOME_BAR}      ${customer_username}


CASE-Add New Officer User Success

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
    
      Set Local Variable     ${customer_company}          ${JS_DEFAULTDATA['companydata'][0]}[companyname]
      Set Local Variable     ${customer_group}            ${JS_DEFAULTDATA['groupdata'][0]}[groupname]
      Set Local Variable     ${customer_username}         ${DS_USERPROFILE['addofficeruser'][${usrdata_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
      Set Local Variable     ${customer_useremail}        ${DS_USERPROFILE['addofficeruser'][${usrdata_col.email}]}_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

      commonkeywords.Click button on list page      ${LOCATOR_ADDUSER_BTN}
      commonkeywords.Verify Page Name is correct    Add User
      commonkeywords.Wait Loading progress
      commonkeywords.Fill in data form              ${LOCATOR_USERCOMPANY_SEL}          ${customer_company}
      commonkeywords.Wait Loading progress
      commonkeywords.Fill in data form              ${LOCATOR_USERGROUP_SEL}            ${customer_group}
      commonkeywords.Fill in data form              ${LOCATOR_USERUSRNAME_FIELD}        ${customer_username}
      commonkeywords.Fill in data form              ${LOCATOR_USERPWD_FIELD}            ${VAR_DEFAULTPASSWORD}
      commonkeywords.Fill in data form              ${LOCATOR_USERCFPWD_FIELD}          ${VAR_DEFAULTPASSWORD}

      pageUserMgt.Fill in user profile info
      ...     firstname=${DS_USERPROFILE['addofficeruser'][${usrdata_col.firstname}]}
      ...     lastname=${DS_USERPROFILE['addofficeruser'][${usrdata_col.lastname}]}
      ...     phone=${DS_USERPROFILE['addofficeruser'][${usrdata_col.phone}]}
      ...     email=${customer_useremail}

      commonkeywords.Click button on detail page    ${LOCATOR_USERSAVE_BTN}
      commonkeywords.Verify Modal Title message     Success
      commonkeywords.Click OK Button

      # ASSERTION
      # verify record in user list
      commonkeywords.Verify Page Name is correct    User Management
      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYUSER_SEL}          ${USERSEARCHBY}[username]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHUSER_KEYWORD}        ${customer_username}
      commonkeywords.Click button on list page      ${LOCATOR_SEARCHUSER_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Click Hide Search Criteria
      commonkeywords.Wait Loading progress

      pageUserMgt.Verify User Result Datatable    1    name             contains      ${DS_USERPROFILE['addofficeruser'][${usrdata_col.firstname}]}
      pageUserMgt.Verify User Result Datatable    1    name             contains      ${DS_USERPROFILE['addofficeruser'][${usrdata_col.lastname}]}
      pageUserMgt.Verify User Result Datatable    1    username         should be     ${customer_username}
      pageUserMgt.Verify User Result Datatable    1    companyname      contains      ${customer_company}
      pageUserMgt.Verify User Result Datatable    1    group            should be     ${customer_group}         ignore_case=true
      pageUserMgt.Verify User Result Datatable    1    email            should be     ${customer_useremail}
      pageUserMgt.Verify User Result Datatable    1    approve          should be     Y
      pageUserMgt.Verify User Result Datatable    1    status           should be     ${USERSTATUS}[active]

      #verify use data info
      commonkeywords.Click button on list page      ${1ROW_USER_ACTION}[edit]
      commonkeywords.Verify Page Name is correct    Edit User
      commonkeywords.Wait Loading progress

      commonkeywords.Verify data form       ${LOCATOR_USERCOMPANY_SEL}      should be    ${customer_company}
      commonkeywords.Verify data form       ${LOCATOR_USERGROUP_SEL}        should be    ${customer_group}
      commonkeywords.Verify Field State     ${LOCATOR_USERUSRNAME_FIELD}    disabled
      commonkeywords.Verify Field State     ${LOCATOR_USERPWD_FIELD}        disabled

      pageUserMgt.Verify user profile Info
      ...     username=${customer_username}
      ...     firstname=${DS_USERPROFILE['addofficeruser'][${usrdata_col.firstname}]}
      ...     lastname=${DS_USERPROFILE['addofficeruser'][${usrdata_col.lastname}]}
      ...     phone=${DS_USERPROFILE['addofficeruser'][${usrdata_col.phone}]}
      ...     email=${customer_useremail}

      commonkeywords.Click xClose button    ${LOCATOR_XCLOSEUSER_BTN}
      commonkeywords.Verify Page Name is correct    User Management

      commonkeywords.Logout System
      commonkeywords.Verify Login Page
      pageLogin.Fill in Login Field
      ...     username=${customer_username}
      ...     password=${VAR_DEFAULTPASSWORD}
      commonkeywords.Click Login Button
      commonkeywords.Login Waiting Loading

      pageChangePwd.Fill in Change Password Field
      ...     oldpwd=${VAR_DEFAULTPASSWORD}
      ...     newpwd=${VAR_NEWPASSWORD}
      ...     confirmpwd=${VAR_NEWPASSWORD}
      pageChangePwd.Click Change Password Button
      commonkeywords.Verify Modal Title message    Success
      commonkeywords.Click OK Button
      commonkeywords.Verify Modal should Hidden

      commonkeywords.Verify Welcome page
      commonkeywords.Verify Profile Detail data     ${LOCATOR_USRNAME_WELCOME_BAR}      ${customer_username}

      #logout and login again
      commonkeywords.Logout System
      commonkeywords.Verify Login Page
      pageLogin.Fill in Login Field
      ...     username=${customer_username}
      ...     password=${VAR_NEWPASSWORD}
      commonkeywords.Click Login Button
      commonkeywords.Login Waiting Loading
      commonkeywords.Ignore warning Login
      commonkeywords.Verify Welcome page
      commonkeywords.Verify Profile Detail data     ${LOCATOR_USRNAME_WELCOME_BAR}      ${customer_username}
