*** Settings ***
Resource          ../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test
...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_PROFILE_FUNCTEST}.

Test Setup        Run Keywords      Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_PROFILE_FUNCTEST}.
...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Get MAIN pageids for switch page

Suite Teardown    Run Keywords      Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_PROFILE_FUNCTEST}.
...               AND               commonkeywords.Release user lock and close all browser

*** Variables ***
${ERRMSG_DUPLICATE}           Not Found Username or Password

*** Test Cases ***
CASE1-User Login Success
      Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
      pageLogin.Fill in Login Field
      ...     username=${DS_LOGIN['robotadmin1'][${login_col.username}]}
      ...     password=${DS_LOGIN['robotadmin1'][${login_col.password}]}
      commonkeywords.Click Login Button
      commonkeywords.Ignore warning Login
      commonkeywords.Verify Welcome page
      Log To Console      \nTEST CASE VERIFIED.
      commonkeywords.Logout System

CASE2-Duplicate User Login
      Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
      pageLogin.Fill in Login Field
      ...     username=${DS_LOGIN['robotadmin1'][${login_col.username}]}
      ...     password=${DS_LOGIN['robotadmin1'][${login_col.password}]}
      commonkeywords.Click Login Button
      commonkeywords.Ignore warning Login
      commonkeywords.Verify Welcome page

      commonkeywords.Initialize System and Go to Login Page   is_newpage=True
      pageLogin.Fill in Login Field
      ...     username=${DS_LOGIN['robotadmin1'][${login_col.username}]}
      ...     password=${DS_LOGIN['robotadmin1'][${login_col.password}]}
      commonkeywords.Click Login Button
      commonkeywords.Ignore warning Login

      #Asertion: second user can login system
      commonkeywords.Verify Welcome page

      #Asertion: first user login should show message Duplicate user
      Switch Page      ${GLOBAL_MAINPAGE}     context=ALL
      # Switch Context    ${GLOBAL_MAINCONTEXT}
      commonkeywords.Logout System
      pageLogin.Check Duplicate Message         ${ERRMSG_DUPLICATE}
      Log To Console      \nTEST CASE VERIFIED.
      commonkeywords.Click Close Button
      service-profile.Request Service Logout System      ${DS_LOGIN['robotadmin1'][${login_col.username}]}             ${DS_LOGIN['robotadmin1'][${login_col.password}]}