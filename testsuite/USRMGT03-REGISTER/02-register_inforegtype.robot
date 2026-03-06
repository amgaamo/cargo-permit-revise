*** Settings ***
Resource        ../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Generate Random Number    lengthno=13
...               AND               commonkeywords.Set Data for Run Automated Test 
...               AND               Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.    
...               AND               Pass Execution If   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'    \nTest Cases for User Management Version Standard Version
...               AND               commonkeywords.Initialize System and Go to Login Page

Test Setup        Run Keywords      Pass Execution If   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version
...               AND               Pass Execution If   '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.
...               AND               pageRegister.Click Register Link

Test Template     Template Add information for register type

Test Teardown     Run Keywords    Pass Execution If   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version
...               AND             Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.
...               AND             commonkeywords.Click button on detail page      ${LOCATOR_REGISBACK_BTN}
...               AND             commonkeywords.Click button on detail page      ${LOCATOR_REGISBACK_BTN}

Suite Teardown    Run Keywords      Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.
...               AND               commonkeywords.Release user lock and close all browser


*** Test Cases ***
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
#                 CASE              |         Register Type     |  State Company Type Field  |    State Company Branch Field        #
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
CASE-Register Legal Type Success                legal                   visible                       visible
CASE-Register Person Type Success               person                  hidden                        hidden

*** Keywords ***
Template Add information for register type
    [Arguments]   ${registertype}       ${exp_ctypestate}     ${exp_branchstate}

      Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
      ...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.
      Pass Execution If   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version
      commonkeywords.Fill in data form    ${LOCATOR_VERIFYREGISTYPE_SEL}              ${REGISTYPE}[${registertype}]
      commonkeywords.Fill in data form    ${LOCATOR_VERIFYREGISCOMTAXID_FIELD}        ${GLOBAL_GENNUMBER}
      commonkeywords.Click button on detail page    ${LOCATOR_REGISNEXT_BTN}
      Sleep   500ms
      service-register.Request Service Register verify         taxid=${GLOBAL_GENNUMBER}     registype=${REGISTYPE}[${registertype}]
      commonkeywords.Verify data form       ${LOCATOR_REGISTYPE_SEL}           should be     ${REGISTYPE}[${registertype}]
      commonkeywords.Verify Field State     ${LOCATOR_REGISCOMPANYTYPE_SEL}    ${exp_ctypestate}
      commonkeywords.Verify Field State     ${LOCATOR_REGISCOMBRANCH_FIELD}    ${exp_branchstate}
