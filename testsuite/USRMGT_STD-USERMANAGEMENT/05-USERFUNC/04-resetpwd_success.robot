*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource COMPANY INFO DATA
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               Set Suite Variable    ${defaultcompany_cust}       ${JS_DEFAULTDATA['companydata'][1]}[companyname]
...               AND               Set Suite Variable    ${defaultgroup_cust}         ${JS_DEFAULTDATA['groupdata'][2]}[groupname]
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Initialize System and Go to Login Page

Test Setup        Run Keywords    commonkeywords.Generate Random Values    3    3
...               AND             Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.

Test Template     Template reset password user function

Test teardown     Run Keywords    Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND             commonkeywords.Logout System
...               AND             commonkeywords.Verify Login Page
   
Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
#---------------------------------------------------------------------------------#
#             CASE NAME                       |   User Type   |    is Confirm?    #
#---------------------------------------------------------------------------------#
CASE-Confirm Reset Password User by sysadmin      sysadmin        confirm
CASE-Confirm Reset Password User by custadmin     custadmin       confirm
CASE-Cancel Reset Password User by sysadmin       sysadmin        cancel
CASE-Cancel Reset Password User by custadmin      custadmin       cancel

*** Keywords ***
Template reset password user function
    [Arguments]   ${usertype}     ${is_confirm}

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
    
      Set Suite Variable    ${username_reset}    ${DS_USERPROFILE['resetpwd'][${usrdata_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}

      service-usermgt.Request Service Add New User Data Test
      ...             headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...             companyname=${defaultcompany_cust}
      ...             groupname=${defaultgroup_cust}
      ...             username=${username_reset}     password=${VAR_DEFAULTPASSWORD}    newpassword=${VAR_CHGPASSWORD}
      ...             firstname=${DS_USERPROFILE['resetpwd'][${usrdata_col.firstname}]}
      ...             lastname=${DS_USERPROFILE['resetpwd'][${usrdata_col.lastname}]}
      ...             telnumber=${DS_USERPROFILE['resetpwd'][${usrdata_col.phone}]}
      ...             email=${DS_USERPROFILE['resetpwd'][${usrdata_col.email}]}_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

      service-usermgt.Request Service Update User Status
      ...             headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...             username=${username_reset}      isActive=true

      IF  '${usertype}'=='sysadmin'
          commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
          Log To Console    Login to SysAdmin Success
      ELSE IF   '${usertype}'=='custadmin'
          commonkeywords.Login System          ${DS_LOGIN['robotcustomer'][${login_col.username}]}   ${DS_LOGIN['robotcustomer'][${login_col.password}]}
          Log To Console    Login to Customer Admin Success
      END

      commonkeywords.Go to SUBMENU name             ${mainmenu}[configuration]      ${submenu}[usermgt]
      commonkeywords.Verify Page Name is correct    pagename=${menuname}[usermgt]

      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYUSER_SEL}          ${USERSEARCHBY}[username]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHUSER_KEYWORD}        ${username_reset}
      commonkeywords.Click button on list page      ${LOCATOR_SEARCHUSER_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Click Hide Search Criteria
      commonkeywords.Wait Loading progress

      # Assert User Status is Active and reset password User
      pageUserMgt.Verify User Result Datatable    1    username    should be     ${username_reset}
      pageUserMgt.Verify User Result Datatable    1    status      should be     ${USERSTATUS}[active]

      commonkeywords.Click button on list page           ${1ROW_USER_ACTION}[resetPWD]
      commonkeywords.Verify Modal Title message   Warning

      IF    '${is_confirm}'=='confirm'
            commonkeywords.Click Yes Button for confirm
            commonkeywords.Verify Modal Title message     Success
            commonkeywords.Verify Modal Content message   ${USERMGT_WARNMSG}[resetpwd]
            commonkeywords.Click OK Button
            Log To Console      TEST CASE Confirm to Reset User(${username_reset}) VERIFIED.
      ELSE
            commonkeywords.Click No Button for Cancel
            Log To Console      TEST CASE Cancel to Reset User(${username_reset}) VERIFIED.
      END
