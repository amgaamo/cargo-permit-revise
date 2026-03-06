*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource COMPANY INFO DATA
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               commonkeywords.Generate Random Values    lengthno=3    lenghtletter=3

...               AND               Set Suite Variable    ${defaultcompany_cust}       ${JS_DEFAULTDATA['companydata'][2]}[companyname]
...               AND               Set Suite Variable    ${defaultgroup_cust}         ${JS_DEFAULTDATA['groupdata'][3]}[groupname]
...               AND               Set Suite Variable    ${username_case1}            cs01${DS_USERPROFILE['adduserdata'][${usrdata_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${username_case2}            cs02${DS_USERPROFILE['adduserdata'][${usrdata_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Initialize System and Go to Login Page

...               AND               service-usermgt.Request Service Add New User Data Test
...                                    headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                    companyname=${defaultcompany_cust}
...                                    groupname=${defaultgroup_cust}
...                                    username=${username_case1}
...                                    password=${VAR_DEFAULTPASSWORD}    newpassword=${VAR_CHGPASSWORD}
...                                    firstname=${DS_USERPROFILE['adduserdata'][${usrdata_col.firstname}]}
...                                    lastname=${DS_USERPROFILE['adduserdata'][${usrdata_col.lastname}]}
...                                    telnumber=${DS_USERPROFILE['adduserdata'][${usrdata_col.phone}]}
...                                    email=cs01${DS_USERPROFILE['adduserdata'][${usrdata_col.email}]}_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

...               AND               service-usermgt.Request Service Add New User Data Test
...                                    headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                    companyname=${defaultcompany_cust}
...                                    groupname=${defaultgroup_cust}
...                                    username=${username_case2}
...                                    password=${VAR_DEFAULTPASSWORD}    newpassword=${VAR_CHGPASSWORD}
...                                    firstname=${DS_USERPROFILE['adduserdata'][${usrdata_col.firstname}]}
...                                    lastname=${DS_USERPROFILE['adduserdata'][${usrdata_col.lastname}]}
...                                    telnumber=${DS_USERPROFILE['adduserdata'][${usrdata_col.phone}]}
...                                    email=cs02${DS_USERPROFILE['adduserdata'][${usrdata_col.email}]}_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

...               AND               Log To Console    Add User Data Test Success !

Test Template     Template Repeat Password Function

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Release user lock and close all browser

*** Variables ***
${NEWPWD_ROUND1}       Robot@001
${NEWPWD_ROUND2}       Robot@002
${NEWPWD_ROUND3}       Robot@003

*** Test Cases ***
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
#                    Case Name                                       |               Username / Password Change            |                 Expected Message              #
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------#

CASE-Set Current Password same as Previous Password (ยังไม่ครบรอบที่ตั้งค่า)       ${username_case1}        ${NEWPWD_ROUND2}        Error         ${VAR_ERRSAMEPREVPWD}
CASE-Set Current Password same as Previous Password (ครบรอบที่ตั้งค่า)           ${username_case2}        ${VAR_CHGPASSWORD}      Success       ${VAR_SUCCESSCHNPWD}

*** Keywords ***
Template Repeat Password Function
   [Arguments]    ${username}    ${password_change}     ${exptitle}     ${expmsg}

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
    
      pageLogin.Fill in Login Field    ${username}    ${VAR_CHGPASSWORD}
      commonkeywords.Click Login Button
      commonkeywords.Ignore warning Login
      commonkeywords.Verify Welcome page

      IF   '${username}'=='${username_case1}'
            Change New Password     ${VAR_CHGPASSWORD}      ${NEWPWD_ROUND1}        Success           ${VAR_SUCCESSCHNPWD}
            Change New Password     ${NEWPWD_ROUND1}        ${NEWPWD_ROUND2}        Success           ${VAR_SUCCESSCHNPWD}
            Change New Password     ${NEWPWD_ROUND2}        ${VAR_CHGPASSWORD}      ${exptitle}       ${expmsg}
            pageChangePwd.Close Change Password Modal
            Log To Console    TEST CASE VERIFIED.

      ELSE IF   '${username}'=='${username_case2}'
            Change New Password     ${VAR_CHGPASSWORD}      ${NEWPWD_ROUND1}        Success           ${VAR_SUCCESSCHNPWD}
            Change New Password     ${NEWPWD_ROUND1}        ${NEWPWD_ROUND2}        Success           ${VAR_SUCCESSCHNPWD}
            Change New Password     ${NEWPWD_ROUND2}        ${NEWPWD_ROUND3}        Success           ${VAR_SUCCESSCHNPWD}
            Change New Password     ${NEWPWD_ROUND3}        ${VAR_CHGPASSWORD}       ${exptitle}       ${expmsg}
            Log To Console      TEST CASE VERIFIED.
      ELSE
        Fail    \nPlease Check condition username argument.
      END

      commonkeywords.Logout System
      pageLogin.Fill in Login Field       ${username}       ${password_change}
      commonkeywords.Click Login Button
      commonkeywords.Ignore warning Login
      commonkeywords.Verify Welcome page
      commonkeywords.Logout System

Change New Password
   [Arguments]    ${oldpwd}   ${newpwd}   ${titlemsg}    ${contentmsg}

      pageChangePwd.Click Change Password Menu
      pageChangePwd.Fill in Change Password Field
      ...       oldpwd=${oldpwd}
      ...       newpwd=${newpwd}
      ...       confirmpwd=${newpwd}
      pageChangePwd.Click Change Password Button
      commonkeywords.Verify Modal Title message      ${titlemsg}
      commonkeywords.Verify Modal Content message    ${contentmsg}
      commonkeywords.Click OK Button
      commonkeywords.Verify Welcome page
