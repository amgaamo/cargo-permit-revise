*** Setting ***
Resource       ../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test
...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               PageChangePwd.Generate Length Password Data test    31
...               AND               commonkeywords.Generate Random Values    3    3
...               AND               Set Suite Variable    ${username_new}     ${DS_USERPROFILE['firstloginuser'][${usrdata_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${firstname_new}    ${DS_USERPROFILE['firstloginuser'][${usrdata_col.firstname}]}${GLOBAL_RANDOMLETTER}
...               AND               Set Suite Variable    ${lastname_new}     ${DS_USERPROFILE['firstloginuser'][${usrdata_col.lastname}]}${GLOBAL_RANDOMLETTER}
...               AND               Set Suite Variable    ${phone_new}        ${DS_USERPROFILE['firstloginuser'][${usrdata_col.phone}]}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${email_new}        ${DS_USERPROFILE['firstloginuser'][${usrdata_col.email}]}_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com
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

Test Setup        Run Keywords      Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_PROFILE_FUNCTEST}.
...               AND               commonkeywords.Fill in Username Field     ${username_new}
...               AND               commonkeywords.Fill in Password Field     ${VAR_DEFAULTPASSWORD}
...               AND               commonkeywords.Click Login Button
...               AND               commonkeywords.Ignore warning Login

Test Template     Template Change Password With Invalid data test
Suite Teardown    Run Keywords      Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_PROFILE_FUNCTEST}.
...               AND               commonkeywords.Release user lock and close all browser


*** Test Cases ***
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------#
#                    Case                      | Old Password Field | New Password Field   | Confirm Password Field  |        Warning Message                     #
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------#

CASE1-Blank All Field                           ${EMPTY}               ${EMPTY}                 ${EMPTY}                      errmessage_old=${VAR_ERREMPTYOLDPWD}         errmessage_new=${VAR_ERREMPTYNEWPWD}         errmessage_cfpwd=${VAR_ERREMPTYCFPWD}
CASE2-Blank Old Password Field                  ${EMPTY}               ${VAR_NEWPASSWORD}       ${VAR_NEWPASSWORD}            errmessage_old=${VAR_ERREMPTYOLDPWD}
CASE3-Blank New Password Field                  ${VAR_OLDPASSWORD}     ${EMPTY}                 ${VAR_NEWPASSWORD}            errmessage_new=${VAR_ERREMPTYNEWPWD}
CASE4-Blank Confirm Password Field              ${VAR_OLDPASSWORD}     ${VAR_NEWPASSWORD}       ${EMPTY}                      errmessage_cfpwd=${VAR_ERREMPTYCFPWD}
CASE5-New Password < 8 letters                  ${VAR_OLDPASSWORD}     PWD                      ${VAR_NEWPASSWORD}            errmessage_new=${VAR_ERRNEWPWDCOND}
CASE6-New Password > 30 letters                 ${VAR_OLDPASSWORD}     ${GLOBAL_RDPWDDATA}      ${VAR_NEWPASSWORD}            errmessage_new=${VAR_ERRNEWPWDCOND}
CASE7-New Password x Lowercase letters          ${VAR_OLDPASSWORD}     ROBOT@123                ${VAR_NEWPASSWORD}            errmessage_new=${VAR_ERRNEWPWDCOND}
CASE8-New Password x Uppercase letters          ${VAR_OLDPASSWORD}     robot@123                ${VAR_NEWPASSWORD}            errmessage_new=${VAR_ERRNEWPWDCOND}
CASE9-New Password x Special characters         ${VAR_OLDPASSWORD}     Robot123                 ${VAR_NEWPASSWORD}            errmessage_new=${VAR_ERRNEWPWDCOND}
CASE10-Confirm Password Not Match               ${VAR_OLDPASSWORD}     ${VAR_NEWPASSWORD}       ${VAR_PASSWORDNOTMATCH}       errmessage_cfpwd=${VAR_ERRCFPWDNOTMATCH}
CASE11-Wrong Old Password                       ${VAR_OLDNOTMATCH}     ${VAR_NEWPASSWORD}       ${VAR_NEWPASSWORD}            errmessage_modal=${VAR_ERRINVALIDOLDPWD}
