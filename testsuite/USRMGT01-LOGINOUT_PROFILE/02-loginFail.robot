*** Settings ***
Resource       ../../pages/pageLogin.robot

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test
...               AND               datasources.Import DataSource USER LOGIN
...               AND               Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_PROFILE_FUNCTEST}.
...               AND               commonkeywords.Initialize System and Go to Login Page

Test Template     Template Login With Invalid Credentials should fail
Suite Teardown    Run Keywords      Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_PROFILE_FUNCTEST}.
...               AND               commonkeywords.Release user lock and close all browser



*** Test Cases ***
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
#            Case                      |                   User ID                     |                        Password                         |              LOCATORMSG          |          VerifyMessage       #
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#

#Check Error Message Username Field
CASE1.1-Blank Username and Password       ${EMPTY}                                            ${EMPTY}                                                     ${LOCATOR_INVALIDMSGUSRNAME}           ${VAR_MSGEMPTYUSERNAME}
#Check Error Message Password Field
CASE1.2-Blank Username and Password       ${EMPTY}                                            ${EMPTY}                                                     ${LOCATOR_INVALIDMSGPASSWORD}          ${VAR_MSGEMPTYPASSWORD}
CASE2-Blank Username                      ${EMPTY}                                            ${DS_LOGIN['robotadmin1'][${login_col.password}]}             ${LOCATOR_INVALIDMSGUSRNAME}           ${VAR_MSGEMPTYUSERNAME}
CASE3-Blank Password                      ${DS_LOGIN['robotadmin1'][${login_col.username}]}    ${EMPTY}                                                     ${LOCATOR_INVALIDMSGPASSWORD}          ${VAR_MSGEMPTYPASSWORD}
CASE4-Invalid Username                    Invalid                                             ${DS_LOGIN['robotadmin1'][${login_col.password}]}             ${LOCATOR_CONTENTMODAL}                ${VAR_MSGLOGINFAIL}
CASE5-Invalid Password                    ${DS_LOGIN['robotadmin1'][${login_col.username}]}    Invalid                                                      ${LOCATOR_CONTENTMODAL}                ${VAR_MSGLOGINFAIL}
CASE6-Invalid Username and Password       Invalid                                              Invalid                                                      ${LOCATOR_CONTENTMODAL}                ${VAR_MSGLOGINFAIL}

*** Keywords ***
Template Login With Invalid Credentials should fail
      [Arguments]       ${userid}         ${password}          ${LOCATOR}          ${verifyMSG}
      Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
      pageLogin.Fill in Login Field          username=${userid}    password=${password}
      commonkeywords.Click Login Button
      pageLogin.Check Login Message Alert    ${LOCATOR}        ${verifyMSG}
