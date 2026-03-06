*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource COMPANY INFO DATA
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               commonkeywords.Generate Random Number    31
...               AND               Set Suite Variable    ${defaultadmin_username}       ${JS_DEFAULTDATA['userdata'][0]}[username]
...               AND               Set Suite Variable    ${defaultadmin_email}          ${JS_DEFAULTDATA['userdata'][0]}[email]
...               AND               Set Suite Variable    ${companycust}                 ${JS_DEFAULTDATA['companydata'][2]}[companyname]
...               AND               Set Suite Variable    ${groupcust}                   ${JS_DEFAULTDATA['groupdata'][3]}[groupname]
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Verify Login Page
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[usermgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[usermgt]

Test Setup        Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Click button on list page      ${LOCATOR_ADDUSER_BTN}
...               AND               commonkeywords.Verify Page Name is correct    pagename=Add User

Test Template     Template Validate User field exception case

Test Teardown     Run Keywords    Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND             commonkeywords.Click xClose button    ${LOCATOR_XCLOSEUSER_BTN}
...               AND             Sleep   500ms
...               AND             commonkeywords.Wait Loading progress
...               AND             commonkeywords.Verify Page Name is correct    pagename=${menuname}[usermgt]

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#                    CASE                       |              company            |     Group name     |     username    |     Password    |     Confirm Password     |   firstname  |     Lastname    |     Email    |       phone number   |                                                              Expected Warning                                                                                                                                                                           #
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

CASE-EMPTY ALL FIELD                     Please Select        Please Select        ${EMPTY}            ${EMPTY}           ${EMPTY}
...                                      ${EMPTY}           ${EMPTY}          ${EMPTY}          \
...                                      expcompany=${USER_REQWARNING}[emptyCom]            expgroup=${USER_REQWARNING}[emptyGroup]
...                                      expusername=${USER_REQWARNING}[emptyUsername]      exppwd=${USER_REQWARNING}[emptyPwd]             expcfpwd=${USER_REQWARNING}[emptyCFPwd]
...                                      expfirstname=${USER_REQWARNING}[emptyFirstname]    explastname=${USER_REQWARNING}[emptyLastname]   expemail=${USER_REQWARNING}[emptyEmail]

CASE-EMPTY Company name                  Please Select        Please Select         xautobotx         ${VAR_DEFAULTPASSWORD}   ${VAR_DEFAULTPASSWORD}
...                                      firstname        lastname        test@robot.com        \
...                                      expcompany=${USER_REQWARNING}[emptyCom]    expgroup=${USER_REQWARNING}[emptyGroup]

CASE-EMPTY Group name                    ${companycust}      Please Select                     xautobotx   ${VAR_DEFAULTPASSWORD}   ${VAR_DEFAULTPASSWORD}
...                                      firstname        lastname         test@robot.com       \
...                                      expgroup=${USER_REQWARNING}[emptyGroup]

CASE-EMPTY Username                      ${companycust}      ${groupcust}     ${EMPTY}    ${VAR_DEFAULTPASSWORD}   ${VAR_DEFAULTPASSWORD}
...                                      firstname   lastname    test@robot.com   \
...                                      expusername=${USER_REQWARNING}[emptyUsername]

CASE-EMPTY Password                      ${companycust}      ${groupcust}     xautobotx   ${EMPTY}                 ${VAR_DEFAULTPASSWORD}
...                                      firstname   lastname    test@robot.com   \
...                                      exppwd=${USER_REQWARNING}[emptyPwd]

CASE-EMPTY Confirm Password              ${companycust}      ${groupcust}     xautobotx   ${VAR_DEFAULTPASSWORD}   ${EMPTY}
...                                      firstname   lastname    test@robot.com   \
...                                      expcfpwd=${USER_REQWARNING}[emptyCFPwd]

CASE-EMPTY Firstname                     ${companycust}      ${groupcust}     xautobotx   ${VAR_DEFAULTPASSWORD}   ${VAR_DEFAULTPASSWORD}
...                                      ${EMPTY}    lastname    test@robot.com   \
...                                      expfirstname=${USER_REQWARNING}[emptyFirstname]

CASE-EMPTY Lastname                      ${companycust}      ${groupcust}     xautobotx   ${VAR_DEFAULTPASSWORD}   ${VAR_DEFAULTPASSWORD}
...                                      firstname   ${EMPTY}    test@robot.com   \
...                                      explastname=${USER_REQWARNING}[emptyLastname]

CASE-EMPTY Email                         ${companycust}      ${groupcust}     xautobotx   ${VAR_DEFAULTPASSWORD}   ${VAR_DEFAULTPASSWORD}
...                                      firstname   lastname    ${EMPTY}         \
...                                      expemail=${USER_REQWARNING}[emptyEmail]

CASE-USERNAME too short                  ${companycust}      ${groupcust}     usr         ${VAR_DEFAULTPASSWORD}     ${VAR_DEFAULTPASSWORD}
...                                      firstname   lastname    test@robot.com  \
...                                      expusername=${USER_OTHRWARNMSG}[condUsername]

CASE-USERNAME is duplicate               ${companycust}      ${groupcust}     ${defaultadmin_username}      ${VAR_DEFAULTPASSWORD}     ${VAR_DEFAULTPASSWORD}
...                                      firstname    lastname    test@robot.com     \
...                                      expusername=${USER_OTHRWARNMSG}[duplicate]

CASE-CONFIRM Password not match          ${companycust}      ${groupcust}     xautobotx    ${VAR_DEFAULTPASSWORD}   ${VAR_CHGPASSWORD}
...                                      firstname   lastname    test@robot.com    \
...                                      expcfpwd=${USER_OTHRWARNMSG}[CFPwdnotMatch]

CASE-PASSWORD less than 8                ${companycust}      ${groupcust}     xautobotx    Pwd      Pwd
...                                      firstname   lastname    test@robot.com    \
...                                      exppwd=${USER_OTHRWARNMSG}[condPWD]

CASE-PASSWORD more than 30               ${companycust}      ${groupcust}     xautobotx    ${GLOBAL_GENNUMBER}      ${GLOBAL_GENNUMBER}
...                                      firstname   lastname    test@robot.com    \
...                                      exppwd=${USER_OTHRWARNMSG}[condPWD]

CASE-PASSWORD not contain lowercase      ${companycust}      ${groupcust}     xautobotx    ROBOTXX@123              ROBOTXX@123
...                                      firstname   lastname    test@robot.com    \
...                                      exppwd=${USER_OTHRWARNMSG}[condPWD]

CASE-PASSWORD not contain uppercase      ${companycust}      ${groupcust}     xautobotx    robotxx@123              robotxx@123
...                                      firstname   lastname    test@robot.com    \
...                                      exppwd=${USER_OTHRWARNMSG}[condPWD]

CASE-PASSWORD not contain number         ${companycust}      ${groupcust}     xautobotx    Robotxx@xxt              Robotxx@xxt
...                                      firstname   lastname    test@robot.com    \
...                                      exppwd=${USER_OTHRWARNMSG}[condPWD]

CASE-PASSWORD not contain Special char   ${companycust}      ${groupcust}     xautobotx    Robotxx1234              Robotxx1234
...                                      firstname   lastname    test@robot.com    \
...                                      exppwd=${USER_OTHRWARNMSG}[condPWD]

CASE-EMAIL invalid pattern               ${companycust}      ${groupcust}     xautobotx    ${VAR_DEFAULTPASSWORD}   ${VAR_DEFAULTPASSWORD}
...                                      firstname   lastname    testmail@          \
...                                      expemail=${USER_OTHRWARNMSG}[emailInv]

CASE-Duplicate EMAIL                     ${companycust}      ${groupcust}     xautobotx    ${VAR_DEFAULTPASSWORD}   ${VAR_DEFAULTPASSWORD}
...                                      firstname   lastname    ${defaultadmin_email}   \
...                                      expemail=${USER_OTHRWARNMSG}[dupemail]

CASE-PHONE Number contain letter         ${companycust}      ${groupcust}     xautobotx    ${VAR_DEFAULTPASSWORD}   ${VAR_DEFAULTPASSWORD}
...                                      firstname   lastname    testmail@mail.com         0test112
...                                      expphonenum=${USER_OTHRWARNMSG}[phonenum]


*** Keywords ***
Template Validate User field exception case
   [Arguments]    ${usercompany}     ${usergroup}    ${username}      ${password}       ${cfpassword}
   ...            ${firstname}       ${lastname}     ${email}         ${phonenum}       &{warnmsg}

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
    
      commonkeywords.Wait Loading progress
      commonkeywords.Fill in data form              ${LOCATOR_USERCOMPANY_SEL}          ${usercompany}
      commonkeywords.Wait Loading progress
      commonkeywords.Fill in data form              ${LOCATOR_USERGROUP_SEL}            ${usergroup}
      commonkeywords.Fill in data form              ${LOCATOR_USERUSRNAME_FIELD}        ${username}
      commonkeywords.Fill in data form              ${LOCATOR_USERPWD_FIELD}            ${password}
      commonkeywords.Fill in data form              ${LOCATOR_USERCFPWD_FIELD}          ${cfpassword}

      pageUserMgt.Fill in user profile info
      ...     firstname=${firstname}
      ...     lastname=${lastname}
      ...     phone=${phonenum}
      ...     email=${email}
      commonkeywords.Click button on detail page    ${LOCATOR_USERSAVE_BTN}
      Log To Console     \n

      IF    '${usercompany}'=='Please Select'
            commonkeywords.Verify Warning message field      ${LOCATOR_WARN_USERCOMPANY_SEL}   contains     ${warnmsg}[expcompany]
            Log To Console      TEST CASE VERIFIED: ${warnmsg}[expcompany]
      END

      IF    '${usergroup}'=='Please Select'
            commonkeywords.Verify Warning message field      ${LOCATOR_WARN_USERGROUP_SEL}    contains     ${warnmsg}[expgroup]
            Log To Console      TEST CASE VERIFIED: ${warnmsg}[expgroup]
      END

      IF    '${username}'=='' or '${username}'=='usr' or '${username}'=='${defaultadmin_username}'
          IF    '${username}'=='' or '${username}'=='usr'
                    commonkeywords.Verify Warning message field     ${LOCATOR_WARN_USERNAME_FIELD}  contains    ${warnmsg}[expusername]
                    Log To Console      TEST CASE VERIFIED: ${warnmsg}[expusername]
          ELSE IF   '${username}'=='${defaultadmin_username}'
                    commonkeywords.Verify Modal Title message         Error
                    commonkeywords.Verify Modal Content message       ${warnmsg}[expusername]
                    commonkeywords.Click OK Button
                    Log To Console      TEST CASE VERIFIED: ${warnmsg}[expusername]
          END
      END

      IF    '${phonenum}'!=''
            commonkeywords.Verify Warning message field      ${LOCATOR_WARN_PHONENUM_FIELD}     contains    ${warnmsg}[expphonenum]
            Log To Console      TEST CASE VERIFIED: ${warnmsg}[expphonenum]
      END

      IF    '${password}'=='' or '${password}'!='${VAR_DEFAULTPASSWORD}'
            commonkeywords.Verify Warning message field     ${LOCATOR_WARN_USERPWD_FIELD}      contains    ${warnmsg}[exppwd]
            Log To Console      TEST CASE VERIFIED: ${warnmsg}[exppwd]
      END

      IF    '${cfpassword}'=='' or '${cfpassword}'=='${VAR_CHGPASSWORD}'
            commonkeywords.Verify Warning message field      ${LOCATOR_WARN_USERCFPWD_FIELD}    contains    ${warnmsg}[expcfpwd]
            Log To Console      TEST CASE VERIFIED: ${warnmsg}[expcfpwd]
      END

      IF    '${firstname}'==''
            commonkeywords.Verify Warning message field     ${LOCATOR_WARN_USERFIRSTNAME_FIELD}   contains    ${warnmsg}[expfirstname]
            Log To Console      TEST CASE VERIFIED: ${warnmsg}[expfirstname]
      END

      IF    '${lastname}'==''
            commonkeywords.Verify Warning message field      ${LOCATOR_WARN_USERLASTNAME_FIELD}    contains   ${warnmsg}[explastname]
            Log To Console      TEST CASE VERIFIED: ${warnmsg}[explastname]
      END

      IF    '${email}'=='' or '${email}'=='testmail@' or '${email}'=='${defaultadmin_email}'
        IF  '${email}'=='' or '${email}'=='testmail@'
                commonkeywords.Verify Warning message field      ${LOCATOR_WARN_USEREMAIL_FIELD}   contains    ${warnmsg}[expemail]
                Log To Console      TEST CASE VERIFIED: ${warnmsg}[expemail]
        ELSE IF  '${email}'=='${defaultadmin_email}'
                commonkeywords.Verify Modal Title message        Error
                commonkeywords.Verify Modal Content message      ${warnmsg}[expemail]
                commonkeywords.Click OK Button
                Log To Console      TEST CASE VERIFIED: ${warnmsg}[expemail]
        END
      END

      Log To Console     \n
