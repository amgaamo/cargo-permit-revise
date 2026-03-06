*** Setting ***
Resource       ../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test
...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               commonkeywords.Generate Random Values    3    3
...               AND               Set Suite Variable    ${username_new}     ${DS_USERPROFILE['loginuserdata'][${usrdata_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${firstname_new}    ${DS_USERPROFILE['loginuserdata'][${usrdata_col.firstname}]}${GLOBAL_RANDOMLETTER}
...               AND               Set Suite Variable    ${lastname_new}     ${DS_USERPROFILE['loginuserdata'][${usrdata_col.lastname}]}${GLOBAL_RANDOMLETTER}
...               AND               Set Suite Variable    ${phone_new}        ${DS_USERPROFILE['loginuserdata'][${usrdata_col.phone}]}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${email_new}        ${DS_USERPROFILE['loginuserdata'][${usrdata_col.email}]}_${GLOBAL_RANDOMNO}@mail.com
...               AND               Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_PROFILE_FUNCTEST}.
...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               service-usermgt.Request Service Get list User
...                                         headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                         username=${DS_LOGIN['robotcustomer'][${login_col.username}]}      firstName=${EMPTY}    lastname=${EMPTY}    email=${EMPTY}

...               AND               service-usermgt.Request Service Add New User Data Test
...                                         headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                         companyname=${GLOBAL_USERCOMPANY}
...                                         groupname=${GLOBAL_USERGROUPNAME}
...                                         username=${username_new}
...                                         password=${VAR_DEFAULTPASSWORD}
...                                         newpassword=${VAR_NEWPASSWORD}
...                                         firstname=${firstname_new}
...                                         lastname=${lastname_new}
...                                         telnumber=${phone_new}
...                                         email=${email_new}

...               AND               commonkeywords.Login System    ${username_new}    ${VAR_NEWPASSWORD}
...               AND               commonkeywords.Verify Profile Detail data     ${LOCATOR_USRNAME_WELCOME_BAR}      ${username_new}
...               AND               pageProfile.Click View Profile Menu
...               AND               commonkeywords.Verify data form     ${LOCATOR_FIRSTNAME_USRPF_TXT}    should be    ${firstname_new}
...               AND               commonkeywords.Verify data form     ${LOCATOR_LASTNAME_USRPF_TXT}     should be    ${lastname_new}
...               AND               commonkeywords.Verify data form     ${LOCATOR_PHONENUM_USRPF_TXT}     should be    ${phone_new}
...               AND               commonkeywords.Verify data form     ${LOCATOR_EMAIL_USRPF_TXT}        should be    ${email_new}

...               AND               commonkeywords.Verify Field State    ${LOCATOR_FIRSTNAME_USRPF_TXT}   disabled
...               AND               commonkeywords.Verify Field State    ${LOCATOR_LASTNAME_USRPF_TXT}    disabled
...               AND               commonkeywords.Verify Field State    ${LOCATOR_PHONENUM_USRPF_TXT}    disabled
...               AND               commonkeywords.Verify Field State    ${LOCATOR_EMAIL_USRPF_TXT}       disabled
...               AND               commonkeywords.Verify Button State   ${LOCATOR_EDITPF_BTN}            visible


Suite Teardown    Run Keywords      Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_PROFILE_FUNCTEST}. 
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
CASE1-Edit Profile Info
      Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
      Set Local Variable    ${firstname_edit}    XXX${DS_USERPROFILE['loginuserdata'][${usrdata_col.firstname}]}${GLOBAL_RANDOMLETTER}
      Set Local Variable    ${lastname_edit}     XXX${DS_USERPROFILE['loginuserdata'][${usrdata_col.lastname}]}${GLOBAL_RANDOMLETTER}
      Set Local Variable    ${phone_edit}        0${DS_USERPROFILE['loginuserdata'][${usrdata_col.phone}]}${GLOBAL_RANDOMNO}
      Set Local Variable    ${email_edit}        xxx${DS_USERPROFILE['loginuserdata'][${usrdata_col.email}]}_${GLOBAL_RANDOMNO}@mail.com

      pageProfile.Click Edit Profile Button
      commonkeywords.Verify Field State    ${LOCATOR_FIRSTNAME_USRPF_TXT}   enabled
      commonkeywords.Verify Field State    ${LOCATOR_LASTNAME_USRPF_TXT}    enabled
      commonkeywords.Verify Field State    ${LOCATOR_PHONENUM_USRPF_TXT}    enabled
      commonkeywords.Verify Field State    ${LOCATOR_EMAIL_USRPF_TXT}       enabled

      commonkeywords.Fill in data form    ${LOCATOR_FIRSTNAME_USRPF_TXT}    ${firstname_edit}
      commonkeywords.Fill in data form    ${LOCATOR_LASTNAME_USRPF_TXT}     ${lastname_edit}
      commonkeywords.Fill in data form    ${LOCATOR_PHONENUM_USRPF_TXT}     ${phone_edit}
      commonkeywords.Fill in data form    ${LOCATOR_EMAIL_USRPF_TXT}        ${email_edit}

      pageProfile.Click Save Profile Button
      commonkeywords.Verify Modal Title message    Warning
      commonkeywords.Click Yes Button for confirm
      commonkeywords.Verify Modal Title message    Success
      commonkeywords.Click OK Button

      #Assertion
      commonkeywords.Verify data form     ${LOCATOR_FIRSTNAME_USRPF_TXT}    should be    ${firstname_edit}
      commonkeywords.Verify data form     ${LOCATOR_LASTNAME_USRPF_TXT}     should be    ${lastname_edit}
      commonkeywords.Verify data form     ${LOCATOR_PHONENUM_USRPF_TXT}     should be    ${phone_edit}
      commonkeywords.Verify data form     ${LOCATOR_EMAIL_USRPF_TXT}        should be    ${email_edit}

      commonkeywords.Verify Field State    ${LOCATOR_FIRSTNAME_USRPF_TXT}   disabled
      commonkeywords.Verify Field State    ${LOCATOR_LASTNAME_USRPF_TXT}    disabled
      commonkeywords.Verify Field State    ${LOCATOR_PHONENUM_USRPF_TXT}    disabled
      commonkeywords.Verify Field State    ${LOCATOR_EMAIL_USRPF_TXT}       disabled
      commonkeywords.Verify Button State   ${LOCATOR_EDITPF_BTN}            visible

      commonkeywords.Logout System
      commonkeywords.Login System    ${username_new}    ${VAR_NEWPASSWORD}

      pageProfile.Click View Profile Menu
      commonkeywords.Verify data form       ${LOCATOR_FIRSTNAME_USRPF_TXT}    should be    ${firstname_edit}
      commonkeywords.Verify data form       ${LOCATOR_LASTNAME_USRPF_TXT}     should be    ${lastname_edit}
      commonkeywords.Verify data form       ${LOCATOR_PHONENUM_USRPF_TXT}     should be    ${phone_edit}
      commonkeywords.Verify data form       ${LOCATOR_EMAIL_USRPF_TXT}        should be    ${email_edit}

      commonkeywords.Verify Field State     ${LOCATOR_FIRSTNAME_USRPF_TXT}   disabled
      commonkeywords.Verify Field State     ${LOCATOR_LASTNAME_USRPF_TXT}    disabled
      commonkeywords.Verify Field State     ${LOCATOR_PHONENUM_USRPF_TXT}    disabled
      commonkeywords.Verify Field State     ${LOCATOR_EMAIL_USRPF_TXT}       disabled
      commonkeywords.Verify Button State    ${LOCATOR_EDITPF_BTN}            visible

      Log To Console      TEST CASE VERIFIED.
