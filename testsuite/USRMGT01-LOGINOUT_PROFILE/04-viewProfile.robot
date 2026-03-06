*** Setting ***
Resource       ../../resources/commonkeywords.resource
Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test
...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               commonkeywords.Generate Random Values    3    3
...               AND               Set Suite Variable    ${username_random}     ${DS_USERPROFILE['loginuserdata'][${usrdata_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${firstname_random}    ${DS_USERPROFILE['loginuserdata'][${usrdata_col.firstname}]}${GLOBAL_RANDOMLETTER}
...               AND               Set Suite Variable    ${lastname_random}     ${DS_USERPROFILE['loginuserdata'][${usrdata_col.lastname}]}${GLOBAL_RANDOMLETTER}
...               AND               Set Suite Variable    ${phone_random}        ${DS_USERPROFILE['loginuserdata'][${usrdata_col.phone}]}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${email_random}        ${DS_USERPROFILE['loginuserdata'][${usrdata_col.email}]}_${GLOBAL_RANDOMNO}@mail.com
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
...                                         username=${username_random}
...                                         password=${VAR_DEFAULTPASSWORD}
...                                         newpassword=${VAR_NEWPASSWORD}
...                                         firstname=${firstname_random}
...                                         lastname=${lastname_random}
...                                         telnumber=${phone_random}
...                                         email=${email_random}

...               AND               commonkeywords.Login System    ${username_random}    ${VAR_NEWPASSWORD}
...               AND               commonkeywords.Verify Profile Detail data     ${LOCATOR_USRNAME_WELCOME_BAR}      ${username_random}

Suite Teardown    Run Keywords      Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_PROFILE_FUNCTEST}. 
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
CASE1-View Profile Detail
      Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
      pageProfile.Click View Profile Menu
      commonkeywords.Verify data form     ${LOCATOR_FIRSTNAME_USRPF_TXT}    should be    ${firstname_random}
      commonkeywords.Verify data form     ${LOCATOR_LASTNAME_USRPF_TXT}     should be    ${lastname_random}
      commonkeywords.Verify data form     ${LOCATOR_PHONENUM_USRPF_TXT}     should be    ${phone_random}
      commonkeywords.Verify data form     ${LOCATOR_EMAIL_USRPF_TXT}        should be    ${email_random}

      commonkeywords.Verify Field State    ${LOCATOR_FIRSTNAME_USRPF_TXT}   disabled
      commonkeywords.Verify Field State    ${LOCATOR_LASTNAME_USRPF_TXT}    disabled
      commonkeywords.Verify Field State    ${LOCATOR_PHONENUM_USRPF_TXT}    disabled
      commonkeywords.Verify Field State    ${LOCATOR_EMAIL_USRPF_TXT}       disabled
      commonkeywords.Verify Button State   ${LOCATOR_EDITPF_BTN}            visible
      Log To Console      TEST CASE VERIFIED.
