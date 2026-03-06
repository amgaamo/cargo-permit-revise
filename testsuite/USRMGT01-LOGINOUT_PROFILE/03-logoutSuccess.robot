*** Settings ***
Resource          ../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test
...               AND               datasources.Import DataSource USER LOGIN
...               AND               Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_PROFILE_FUNCTEST}.    

Test Setup        Run Keywords    Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'   
...                                       \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_PROFILE_FUNCTEST}.   
...               AND             commonkeywords.Initialize System and Go to Login Page
...               AND             commonkeywords.Get MAIN pageids for switch page

Suite Teardown    Run Keywords      Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_PROFILE_FUNCTEST}.
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
CASE1-User Logout Success
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
      commonkeywords.Verify Login Page

CASE2-User Logout (Duplicate User Login)
      Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
      commonkeywords.Login System         ${DS_LOGIN['robotadmin1'][${login_col.username}]}            ${DS_LOGIN['robotadmin1'][1]}
      commonkeywords.Initialize System and Go to Login Page       is_newpage=True
      pageLogin.Fill in Login Field
      ...     username=${DS_LOGIN['robotadmin1'][${login_col.username}]}
      ...     password=${DS_LOGIN['robotadmin1'][${login_col.password}]}
      commonkeywords.Click Login Button
      commonkeywords.Ignore warning Login
      commonkeywords.Verify Welcome page
      Log To Console      \nTEST CASE VERIFIED.
      commonkeywords.Logout System
      commonkeywords.Verify Login Page
      Switch Page  ${GLOBAL_MAINPAGE}    context=ALL    
      commonkeywords.Logout System
      commonkeywords.Verify Login Page
      commonkeywords.Click Close Button
     