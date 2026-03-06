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
...               AND               pageProfile.Click Edit Profile Button

Test Template     pageProfile.Template Edit Profile Validation Field

Test Teardown     Run Keywords      Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_PROFILE_FUNCTEST}.
...               AND               commonkeywords.Fill in data form      ${LOCATOR_FIRSTNAME_USRPF_TXT}    ${firstname_new}
...               AND               commonkeywords.Fill in data form      ${LOCATOR_LASTNAME_USRPF_TXT}     ${lastname_new}
...               AND               commonkeywords.Fill in data form      ${LOCATOR_PHONENUM_USRPF_TXT}     ${phone_new}
...               AND               commonkeywords.Fill in data form      ${LOCATOR_EMAIL_USRPF_TXT}        ${email_new}
...               AND               commonkeywords.Verify Button State    ${LOCATOR_SAVEPF_BTN}             enabled

Suite Teardown    Run Keywords      Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_PROFILE_FUNCTEST}.
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser


*** Test Cases ***
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#                    CASE            |    Firstname   |   Lastname    |       Email      |  Phone Number    |     Expected Warning               #
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
CASE-EMPTY ALL FIELD                   ${EMPTY}           ${EMPTY}      ${EMPTY}              ${EMPTY}        expwarnfirstname=${WARNMSG_PROFILE}[emptyfirstname]    expwarnlastname=${WARNMSG_PROFILE}[emptylastname]     expwarnemail=${WARNMSG_PROFILE}[emptyEmail]
CASE-EMPTY FIRSTNAME                   ${EMPTY}           testlast      testmail@mail.com     ${EMPTY}        expwarnfirstname=${WARNMSG_PROFILE}[emptyfirstname]
CASE-EMPTY LASTNAME                    testfirst          ${EMPTY}      testmail@mail.com     ${EMPTY}        expwarnlastname=${WARNMSG_PROFILE}[emptylastname]
CASE-EMPTY EMAIL                       testfirst          testlast      ${EMPTY}              ${EMPTY}        expwarnemail=${WARNMSG_PROFILE}[emptyEmail]
CASE-Email not contain @               testfirst          testlast      testmail              ${EMPTY}        expwarnemail=${WARNMSG_PROFILE}[invemail]
CASE-Email not contain domain          testfirst          testlast      testmail@             ${EMPTY}        expwarnemail=${WARNMSG_PROFILE}[invemail]
CASE-Phone Number Contain letter       testfirst          testlast      testmail@mail.com     02112xx00       expwarnphone=${WARNMSG_PROFILE}[invphone]
