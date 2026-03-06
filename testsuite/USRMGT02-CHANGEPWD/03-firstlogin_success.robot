*** Setting ***
Resource       ../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test
...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               commonkeywords.Generate Random Values    3    3
...               AND               Set Suite Variable    ${username_new}     ${DS_USERPROFILE['firstloginuser'][${usrdata_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${firstname_new}    ${DS_USERPROFILE['firstloginuser'][${usrdata_col.firstname}]}${GLOBAL_RANDOMLETTER}
...               AND               Set Suite Variable    ${lastname_new}     ${DS_USERPROFILE['firstloginuser'][${usrdata_col.lastname}]}${GLOBAL_RANDOMLETTER}
...               AND               Set Suite Variable    ${phone_new}        ${DS_USERPROFILE['firstloginuser'][${usrdata_col.phone}]}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${email_new}        ${DS_USERPROFILE['firstloginuser'][${usrdata_col.email}]}_${GLOBAL_RANDOMNO}${GLOBAL_RANDOMLETTER}@mail.com
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_PROFILE_FUNCTEST}.
...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               service-usermgt.Request Service Get list User
...                                         headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                         username=${DS_LOGIN['robotcustomer'][${login_col.username}]}      firstName=${EMPTY}    lastname=${EMPTY}    email=${EMPTY}

...               AND               service-usermgt.Request Service Create New User
...                                         headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                         companyname=${GLOBAL_USERCOMPANY}
...                                         groupname=${GLOBAL_USERGROUPNAME}
...                                         username=${username_new}
...                                         password=${VAR_DEFAULTPASSWORD}
...                                         firstname=${firstname_new}
...                                         lastname=${lastname_new}
...                                         telnumber=${phone_new}
...                                         email=${email_new}

...               AND               commonkeywords.Fill in Username Field     ${username_new}
...               AND               commonkeywords.Fill in Password Field     ${VAR_DEFAULTPASSWORD}
...               AND               commonkeywords.Click Login Button
...               AND               commonkeywords.Ignore warning Login

Suite Teardown    Run Keywords      Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_PROFILE_FUNCTEST}.
...               AND               commonkeywords.Release user lock and close all browser

*** Variables ***
${WARNERR_USERNOTFOUND}            Login Failed

*** Test Cases ***
CASE1-Login First Force Change Password is success
      Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
      pageChangePwd.Fill in Change Password Field
      ...       oldpwd=${VAR_DEFAULTPASSWORD}
      ...       newpwd=${VAR_NEWPASSWORD}
      ...       confirmpwd=${VAR_NEWPASSWORD}
      pageChangePwd.Click Change Password Button
      commonkeywords.Verify Modal Title message    Success
      commonkeywords.Click OK Button
      commonkeywords.Logout System

      ## Assertion Login old password should fail
      commonkeywords.Verify Login Page
      pageLogin.Fill in Login Field               username=${username_new}    password=${VAR_DEFAULTPASSWORD}
      commonkeywords.Click Login Button
      pageLogin.Check Login Message Alert         ${LOCATOR_TITLEMODAL}        ${WARNERR_USERNOTFOUND}

      ## Assertion Login new password should success
      pageLogin.Fill in Login Field               username=${username_new}    password=${VAR_NEWPASSWORD}
      commonkeywords.Click Login Button
      commonkeywords.Ignore warning Login
      commonkeywords.Verify Welcome page
      commonkeywords.Verify Profile Detail data     ${LOCATOR_USRNAME_WELCOME_BAR}      ${username_new}
      Log To Console      \nTEST CASE VERIFIED.
