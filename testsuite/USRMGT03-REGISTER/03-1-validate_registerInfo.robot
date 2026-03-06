*** Settings ***
Resource        ../../resources/commonkeywords.resource

Suite setup       Run Keywords      datasources.Import DataSource DEFAULT DATA
...               AND               commonkeywords.Set Data for Run Automated Test 
...               AND               Set Suite Variable    ${VAR_DEFAULTTAX_SYSTEM}      ${JS_DEFAULTDATA['companydata'][0]}[taxid]
...               AND               Set Suite Variable    ${VAR_DEFAULTCOMNAME_SYS}     ${JS_DEFAULTDATA['companydata'][0]}[companyname]
...               AND               Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.
...               AND               Pass Execution If   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'    \nTest Cases for User Management Version Standard Version
...               AND               commonkeywords.Initialize System and Go to Login Page

Test Setup        Run Keywords      commonkeywords.Generate Random Number    lengthno=13
...               AND               Set Test Variable    ${RANDOM_TAX}      ${GLOBAL_GENNUMBER}
...               AND               commonkeywords.Generate Random Number    lengthno=31
...               AND               Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.
...               AND               Pass Execution If   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'    \nTest Cases for User Management Version Standard Version
...               AND               pageRegister.Click Register Link
...               AND               commonkeywords.Verify Field State    ${LOCATOR_VERIFYREGISTYPE_SEL}    visible

Test Template     Template Admin Add Verify Register Data

Test Teardown     Run Keywords    Pass Execution If   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'    \nTest Cases for User Management Version Standard Version
...               AND             Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.
...               AND             commonkeywords.Click button on detail page      ${LOCATOR_REGISBACK_BTN}
...               AND             commonkeywords.Wait Loading progress

Suite Teardown    Run Keywords      Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.
...               AND               commonkeywords.Release user lock and close all browser


*** Test Cases ***
#----------------------------------------------------------------------------------------------------------------------#
#         CASE NAME               |    Register Type      |       TaxID           |              Warning Message       #
#----------------------------------------------------------------------------------------------------------------------#
All Empty Field                      Please Select            ${EMPTY}                    emptyRegistype=${REGISTER_REQUIREWARNMSG}[registerType]     emptyTax=${REGISTER_REQUIREWARNMSG}[taxid]
Empty Register Type                  Please Select            1909990991870               emptyRegistype=${REGISTER_REQUIREWARNMSG}[registerType]
Empty Company TaxID                  ${REGISTYPE}[legal]      ${EMPTY}                    emptyTax=${REGISTER_REQUIREWARNMSG}[companyTax]
Empty Person TaxID                   ${REGISTYPE}[person]     ${EMPTY}                    emptyTax=${REGISTER_REQUIREWARNMSG}[personTax]
Duplicate TaxID                      ${REGISTYPE}[legal]      ${VAR_DEFAULTTAX_SYSTEM}    duptax=${REGISTER_OTHERWARNMSG}[taxduplicate]
Invalid TaxID-Legal                  ${REGISTYPE}[legal]      xx9909990009xx0             invalidTax=${REGISTER_OTHERWARNMSG}[taxInvalid]
Invalid TaxID-Person                 ${REGISTYPE}[person]     xx9909990009xx0             invalidTax=${REGISTER_OTHERWARNMSG}[taxInvalid]
TaxID less than 13-Legal             ${REGISTYPE}[legal]      010990190                   13Tax=${REGISTER_OTHERWARNMSG}[tax13]
TaxID less than 13-Person            ${REGISTYPE}[person]     010990190                   13Tax=${REGISTER_OTHERWARNMSG}[tax13]
TaxID less than 13 and mix letter    ${REGISTYPE}[legal]      xx099                       invalidTax=${REGISTER_OTHERWARNMSG}[taxInvalid]      13Tax=${REGISTER_OTHERWARNMSG}[tax13]

*** Keywords ***
Template Admin Add Verify Register Data
    [Arguments]       ${registertype}     ${taxid}    &{warnmsg}

      Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
      ...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.
      Pass Execution If   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'    \nTest Cases for User Management Version Standard Version
      commonkeywords.Verify Field State     ${LOCATOR_VERIFYREGISTYPE_SEL}            visible
      commonkeywords.Fill in data form      ${LOCATOR_VERIFYREGISTYPE_SEL}            ${registertype}
      commonkeywords.Fill in data form      ${LOCATOR_VERIFYREGISCOMTAXID_FIELD}      ${taxid}
      commonkeywords.Click button on detail page    ${LOCATOR_REGISNEXT_BTN}
      commonkeywords.Wait Loading progress

      ${taxdata}=           Get Text        ${LOCATOR_VERIFYREGISCOMTAXID_FIELD}
      ${taxdata_lenght}=    Get Length      ${taxdata}

      IF   '${taxid}'=='${VAR_DEFAULTTAX_SYSTEM}'
            commonkeywords.Verify Warning message modal     ${warnmsg}[duptax]
            Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[duptax]

      ELSE IF   '${registertype}'=='${REGISTYPE}[legal]' and '${taxid}'==''
                commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGISTAXID_REGISPAGE}   contains      ${warnmsg}[emptyTax]
                Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[emptyTax]

      ELSE IF   '${registertype}'=='${REGISTYPE}[person]' and '${taxid}'==''
                commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGISTAXID_REGISPAGE}   contains      ${warnmsg}[emptyTax]
                Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[emptyTax]

      ELSE IF   '${registertype}'=='Please Select' and '${taxid}'!=''
                commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGISTYPE_REGISPAGE}   contains      ${warnmsg}[emptyRegistype]
                Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[emptyRegistype]

      ELSE IF   '${registertype}'=='Please Select' and '${taxid}'==''
                commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGISTYPE_REGISPAGE}   contains       ${warnmsg}[emptyRegistype]
                commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGISTAXID_REGISPAGE}   contains      ${warnmsg}[emptyTax]
                Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[emptyRegistype] and ${warnmsg}[emptyTax]

      ELSE IF   '${taxid}'!='' and '${taxdata_lenght}'!='13' and '${taxid}'!='xx099'
                commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGISTAXID_REGISPAGE}   contains      ${warnmsg}[13Tax]
                Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[13Tax]

      ELSE IF   '${taxid}'=='xx9909990009xx0'
                commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGISTAXID_REGISPAGE}   contains      ${warnmsg}[invalidTax]
                Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[invalidTax]

      ELSE IF   '${taxid}'=='xx099'
                commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGISTAXID_REGISPAGE}   contains       ${warnmsg}[invalidTax]
                commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGISTAXID_REGISPAGE2}   contains      ${warnmsg}[13Tax]
                Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[invalidTax] and ${warnmsg}[13Tax]

      ELSE
          Fail    Check Case Condition
      END
