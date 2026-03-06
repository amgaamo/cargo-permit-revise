*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test
...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource DEFAULT DATA
 
...               AND               Set Suite Variable     ${default_mainmenu}          ${JS_DEFAULTDATA['menudata'][0]}[menuname]
...               AND               Set Suite Variable     ${default_submenu1}          ${JS_DEFAULTDATA['menudata'][1]}[menuname]
...               AND               Set Suite Variable     ${default_submenu2}          ${JS_DEFAULTDATA['menudata'][2]}[menuname]

...               AND               Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='STANDARD'          \nExecute Test Only IE5DEV Version

...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Login System     ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name               ${mainmenu}[configuration]      ${submenu}[ctypeMgt]
...               AND               commonkeywords.Verify Page Name is correct      Company Type Management
...               AND               commonkeywords.Wait Loading progress

...               AND               service-ctypemgt.Request Service Add Company Type Data
...                                   ${DS_LOGIN['robotapi'][${login_col.username}]}      ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   ${CTYPE_ID}[legal]
...                                   Botdupctype01
...                                   ${default_mainmenu}     ${default_submenu1}     ${default_submenu2}


Test Setup        Run Keywords      Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='STANDARD'          \nExecute Test Only IE5DEV Version

...               AND               commonkeywords.Click button on list page    ${LOCATOR_CTYPEMGT_ADD_BTN}
...               AND               commonkeywords.Wait Loading progress
...               AND               commonkeywords.Verify Page Name is correct     Add Company Type
...               AND               commonkeywords.Wait Loading progress

Test Template     Template Validate Company Type field exception case

*** Test Cases ***
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#               CASE             |       Company Type        |      Company Type Name        |        Checked Menu             |       Expeced Warning     #
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

CASE-EMPTY All field                    Please Select                 ${EMPTY}                     ${default_submenu1}      emptyCtype=${CTYPEMGT_REQUIREWARNING}[ctype]      emptyCtypename=${CTYPEMGT_REQUIREWARNING}[ctypename]
CASE-EMPTY Company Type                 Please Select                 Test Ctypex                  ${default_submenu1}      emptyCtype=${CTYPEMGT_REQUIREWARNING}[ctype]
CASE-EMPTY Company Type Name            ${CTYPETH}[legal]             ${EMPTY}                     ${default_submenu1}      emptyCtypename=${CTYPEMGT_REQUIREWARNING}[ctypename]
CASE-not selected menu                  ${CTYPETH}[legal]             Test Ctypex                  ${EMPTY}                 notcheckedmenu=${CTYPEMGT_REQUIREWARNING}[ctypemenu]
CASE-Duplicate Company Type             ${CTYPETH}[legal]             Botdupctype01                ${default_submenu1}      duplicate=${CTYPEMGT_DUPLICATEWARNING}

*** Keywords ***
Template Validate Company Type field exception case
    [Arguments]   ${ctype}      ${ctypename}     ${menuname}     &{expwarnmsg}
      Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='STANDARD'          \nExecute Test Only IE5DEV Version

      IF    '${menuname}'!=''
          pageComTypeMgt.Check checkbox company type menu    ${menuname}
      END

      commonkeywords.Fill in data form    ${LOCATOR_CTYPEMGT_COMTYPE_SEL}         ${ctype}
      commonkeywords.Fill in data form    ${LOCATOR_CTYPEMGT_CTYPENAME_FIELD}     ${ctypename}
      commonkeywords.Click button on detail page    ${LOCATOR_CTYPEMGT_SAVE_BTN}

      IF   '${ctypename}'=='Botdupctype01'
            commonkeywords.Verify Modal Title message      Error
            commonkeywords.Verify Modal Content message    ${expwarnmsg}[duplicate]
            commonkeywords.Click OK Button
            Log To Console    \nTEST CASE VERIFIED.
      END
      IF    '${ctype}'=='Please Select'
            commonkeywords.Verify Warning message field    ${LOCATOR_CTYPEMGT_CTYPE_WARNFIELD}           contains       ${expwarnmsg}[emptyCtype]
            Log To Console    \nTEST CASE VERIFIED.
      END
      IF    '${ctypename}'=='Please Select'
            commonkeywords.Verify Warning message field    ${LOCATOR_CTYPEMGT_CTYPENAME_WARNFIELD}       contains       ${expwarnmsg}[emptyCtypename]
            Log To Console    \nTEST CASE VERIFIED.
      END
      IF    '${menuname}'==''
            commonkeywords.Verify Modal Title message      Error
            commonkeywords.Verify Modal Content message    ${expwarnmsg}[notcheckedmenu]
            commonkeywords.Click OK Button
            Log To Console    \nTEST CASE VERIFIED.
      END

      commonkeywords.Click button on detail page    ${LOCATOR_XCLOSECTYPE_BTN}
      commonkeywords.Verify Page Name is correct    Company Type Management
