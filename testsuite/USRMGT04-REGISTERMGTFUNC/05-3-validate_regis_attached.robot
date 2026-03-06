*** Settings ***
Resource        ../../resources/commonkeywords.resource

Suite setup      Run Keywords      dataSources.Import DataSource USER LOGIN
...              AND               commonkeywords.Set Data for Run Automated Test 
...              AND               Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}. 
...              AND               Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version
...              AND               commonkeywords.Initialize System and Go to Login Page
...              AND               commonkeywords.Login System     ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...              AND               commonkeywords.Go to MENU name                ${mainmenu}[registerMgt]
...              AND               commonkeywords.Verify Page Name is correct    ${menuname}[regMgt]

Test Setup       Run Keywords      Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version
...              AND               Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}. 
...              AND               commonkeywords.Wait Loading progress
...              AND               commonkeywords.Click button on list page    ${LOCATOR_ADDREGISTER_BTN}
...              AND               commonkeywords.Verify Field State           ${LOCATOR_VERIFYREGISTYPE_SEL}    visible

Test Template     Template Upload Attachment Information

Test Teardown     Run Keywords    Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version
...               AND             Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}. 
...               AND             commonkeywords.Click button on detail page      ${LOCATOR_REGISBACK_BTN}
...               AND             commonkeywords.Wait Loading progress
...               AND             commonkeywords.Click button on detail page      ${LOCATOR_REGISBACK_BTN}
...               AND             commonkeywords.Wait Loading progress

Suite Teardown    Run Keywords    Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.   
...               AND             commonkeywords.Release user lock and close all browser

*** Test Cases ***
#----------------------------------------------------------------------------#
#        CASE NAME          |     Register Type       |     Attatached File  #
#----------------------------------------------------------------------------#
Empty Attachment Company Type     ${REGISTYPE}[legal]       emptyattach=${REGISTER_REQUIREWARNMSG}[upload]
Empty Attachment Person Type      ${REGISTYPE}[person]      emptyattach=${REGISTER_REQUIREWARNMSG}[upload]

*** Keywords ***
Template Upload Attachment Information
    [Arguments]        ${registertype}       &{warnmsg}

      Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
      ...       \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}. 
      Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version

      commonkeywords.Verify Field State     ${LOCATOR_VERIFYREGISTYPE_SEL}              visible
      commonkeywords.Fill in data form      ${LOCATOR_VERIFYREGISTYPE_SEL}              ${registertype}
      commonkeywords.Fill in data form      ${LOCATOR_VERIFYREGISCOMTAXID_FIELD}        1000000100010
      commonkeywords.Click button on detail page    ${LOCATOR_REGISNEXT_BTN}
      commonkeywords.Wait Loading progress

      IF  '${registertype}'=='${REGISTYPE}[legal]'
            commonkeywords.Fill in data form    ${LOCATOR_REGISCOMPANYTYPE_SEL}            ${REGISCOMTYPE}[officer]
            commonkeywords.Fill in data form    ${LOCATOR_REGISCOMBRANCH_FIELD}            00000
      ELSE
          commonkeywords.Verify Field State     ${LOCATOR_REGISCOMPANYTYPE_SEL}            hidden
          commonkeywords.Verify Field State     ${LOCATOR_REGISCOMBRANCH_FIELD}            hidden
      END
      commonkeywords.Fill in data form      ${LOCATOR_REGISCOMNAME_FIELD}       Test Companay

      #Company Address Information data
      commonkeywords.Fill in data form    ${LOCATOR_REGISCOMHOUSENUM_FIELD}      11/11
      commonkeywords.Fill in data form    ${LOCATOR_REGISCOMSUBDISTRICT_FIELD}   หัวหมาก
      pageCompanyMgt.Choose subdictrict autocomplete for first row    หัวหมาก
      commonkeywords.Fill in data form    ${LOCATOR_REGISCOMPOSTCODE_FIELD}      13330
      commonkeywords.Fill in data form    ${LOCATOR_REGISCOMEMAIL_FIELD}         testmail@mail.com
      commonkeywords.Click button on detail page    ${LOCATOR_REGISNEXT_BTN}
      Sleep    1s
      commonkeywords.Wait Loading progress
      commonkeywords.Click button on detail page    ${LOCATOR_REGISNEXT_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Verify Warning message field    ${LOCATOR_WARN_UPLOADATTACH}     contains        ${warnmsg}[emptyattach]
      Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[emptyattach]

      commonkeywords.Click button on detail page      ${LOCATOR_REGISBACK_BTN}
      commonkeywords.Wait Loading progress
