*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource COMPANY INFO DATA
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[companyMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[companyMgt]

Test Setup        Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               commonkeywords.Click button on list page    ${LOCATOR_ADDCOMP_BTN}
...               AND               commonkeywords.Verify Page Name is correct    Add Company

Test template     Template Add information for company register type

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser


*** Test Cases ***
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#                 CASE              |                    Register Type and id             |        TAX ID         |  State Company Branch Field   #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
CASE1-Add Register Type is Legal     ${COMREGISTYPE}[legal]    ${COMREGISTYPE_ID}[legal]         0100000110010                     visible
CASE2-Add Register Type is Person    ${COMREGISTYPE}[person]   ${COMREGISTYPE_ID}[person]        0100000110010                     hidden

*** Keywords ***
Template Add information for company register type
   [Arguments]    ${registerType}   ${registerTypeid}     ${taxid}       ${state}
      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.      
      
      commonkeywords.Wait Loading progress
      commonkeywords.Fill in data form    ${LOCATOR_COMREGISTYPE_SEL}      ${registerType}
      commonkeywords.Fill in data form    ${LOCATOR_COMTAXID_FIELD}        ${taxid}
      commonkeywords.Click button on detail page    ${LOCATOR_COMNEXT_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Verify data form     ${LOCATOR_COMTAXID_FIELD}       should be     ${taxid}
      commonkeywords.Verify Field State   ${LOCATOR_COMBRANCH_FIELD}      ${state}
      commonkeywords.Verify Field State   ${LOCATOR_COMDISTRICT_FIELD}    disabled
      commonkeywords.Verify Field State   ${LOCATOR_COMPROVINCE_FIELD}    disabled
      Log To Console      \nTEST CASE VERIFIED.
      commonkeywords.Click button on detail page    ${LOCATOR_COMCANCEL_BTN}
