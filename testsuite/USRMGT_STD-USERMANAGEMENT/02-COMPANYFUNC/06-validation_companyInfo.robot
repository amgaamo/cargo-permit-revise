*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource COMPANY INFO DATA
...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[companyMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[companyMgt]

Test Setup        Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               commonkeywords.Click button on list page    ${LOCATOR_ADDCOMP_BTN}
...               AND               commonkeywords.Verify Page Name is correct    Add Company

Test template     Template Add information for company register type invalid

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#                 CASE              |           Register Type              |        TAX ID         |        Expected Warning Popup       |                               Expected Warning Message                               #
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
CASE1-All Field Empty                      ${EMPTY}                               ${EMPTY}                   Please select type                       ${LOCATOR_WARN_COMREGISTYPE_INFOPAGE}    Type is required.
CASE2-Deselect Register Type               ${EMPTY}                               0100000110010              Please select type                       ${LOCATOR_WARN_COMREGISTYPE_INFOPAGE}    Type is required.
CASE3-Empty Tax ID Field                   ${COMREGISTYPE}[legal]                 ${EMPTY}                   Please input tax id                      ${LOCATOR_WARN_COMTAXID_INFOPAGE}        Tax ID is required
CASE4-TaxID least 13 minlength             ${COMREGISTYPE}[legal]                 123456              Please input tax id at least 13 minlength       ${LOCATOR_WARN_COMTAXID_INFOPAGE}        Please input at least 13 minlength
CASE5-TaxID contains alphabet              ${COMREGISTYPE}[legal]                 12345A              Please input tax id at least 13 minlength       ${LOCATOR_WARN_COMTAXID_INFOPAGE}        Tax ID is invalid.
CASE6-TaxID contains alphabet length 13    ${COMREGISTYPE}[legal]                 abbasxxcc90on       Please input tax id number only                 ${LOCATOR_WARN_COMTAXID_INFOPAGE}        Tax ID is invalid

*** Keywords ***
Template Add information for company register type invalid
   [Arguments]    ${registerType}      ${taxid}       ${expwarningpopup}      ${locatorfield}     ${expwarningmsg}
      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.      
      
      Click   ${LOCATOR_COMREGISTYPE_SEL}
      Click   ${LOCATOR_COMTAXID_FIELD}
      commonkeywords.Fill in data form    ${LOCATOR_COMREGISTYPE_SEL}      ${registerType}
      commonkeywords.Fill in data form    ${LOCATOR_COMTAXID_FIELD}        ${taxid}
      Click   ${LOCATOR_CURRENT_PAGENAME}
      commonkeywords.Click button on detail page    ${LOCATOR_COMNEXT_BTN}
      commonkeywords.Verify Modal Title message     Error
      commonkeywords.Verify Modal Content message   ${expwarningpopup}
      commonkeywords.Click OK Button
      Click   ${LOCATOR_CURRENT_PAGENAME}
      commonkeywords.Verify Warning message field    ${locatorfield}    contains    ${expwarningmsg}
      Log To Console      \nTEST CASE VERIFIED.
      commonkeywords.Click xClose button     ${LOCATOR_XCLOSECOMPANY_BTN}
