*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test
...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               datasources.Import DataSource COMPANY TYPE INFO DATA


...               AND               Set Suite Variable     ${default_mainmenu}          ${JS_DEFAULTDATA['menudata'][0]}[menuname]
...               AND               Set Suite Variable     ${default_submenu1}          ${JS_DEFAULTDATA['menudata'][1]}[menuname]
...               AND               Set Suite Variable     ${default_submenu2}          ${JS_DEFAULTDATA['menudata'][2]}[menuname]
...               AND               Set Suite Variable     ${default_submenu3}          ${JS_DEFAULTDATA['menudata'][3]}[menuname]
...               AND               Set Suite Variable     ${default_submenu4}          ${JS_DEFAULTDATA['menudata'][4]}[menuname]
...               AND               Set Suite Variable     ${companyname_ctype}         Ctypeedit Botfunc Company Limited

...               AND               Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='STANDARD'          \nExecute Test Only IE5DEV Version

...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Login System     ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}

Test Setup        Run Keywords      commonkeywords.Generate Random Values    lengthno=3    lenghtletter=2
...               AND               Set Suite Variable     ${companytypename}       ${DS_CTYPE['addnewlegal'][${ctype_col.ctypename}]}${GLOBAL_RANDOMLETTER}${SPACE}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable     ${companytypeedit}       ${DS_CTYPE['editlegal'][${ctype_col.ctypename}]}${GLOBAL_RANDOMLETTER}${SPACE}${GLOBAL_RANDOMNO}
...               AND               Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='STANDARD'          \nExecute Test Only IE5DEV Version

...               AND               service-ctypemgt.Request Service Create Company Type
...                                   ${DS_LOGIN['robotapi'][${login_col.username}]}            ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   ${CTYPE_ID}[legal]
...                                   ${companytypename}
...                                   ${default_mainmenu}     ${default_submenu1}     ${default_submenu2}     ${default_submenu3}

...               AND               commonkeywords.Go to SUBMENU name               ${mainmenu}[configuration]      ${submenu}[ctypeMgt]
...               AND               commonkeywords.Verify Page Name is correct      Company Type Management
...               AND               commonkeywords.Wait Loading progress

Test Template     Template Add Company Type

Suite Teardown    commonkeywords.Release user lock and close all browser


*** Test Cases ***
#----------------------------------------------------------------------------------------------------------------------------------------------------------#
#      CASE NAME       |        Case Type     |     Company Type Data     |            Company Type Name Data             |         Menu Name              #
#----------------------------------------------------------------------------------------------------------------------------------------------------------#

CASE-Edit Field Data             caseField          legal     person        ${companytypename}      ${companytypeedit}           ${EMPTY}
CASE-Checked more menu           caseChecked        legal    ${EMPTY}       ${companytypename}      ${EMPTY}                     ${default_submenu4}
CASE-Unchecked menu              caseUnchecked      legal    ${EMPTY}       ${companytypename}      ${EMPTY}                     ${default_submenu3}

*** Keywords ***
Template Add Company Type
      [Arguments]     ${casetype}      ${ctype_old}     ${ctype_edit}    ${ctypename_old}     ${ctypename_edit}      ${menu_edit}

      Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='STANDARD'     \nExecute Test Only IE5DEV Version
      service-ctypemgt.Request Service Get Company Type Info    ${DS_LOGIN['robotapi'][${login_col.username}]}    ${DS_LOGIN['robotapi'][${login_col.password}]}    ${ctypename_old}
      service-companymgt.Request Service Add Default Company data test
      ...       headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...       registype=${CTYPE_ID}[${ctype_old}]
      ...       ctypeid=${GLOBAL_CTYPEID_DATA}
      ...       cname=${companyname_ctype}    ctaxid=0881001990910    cbranch=00000    cemail=ctypeedcom01@robot.com
      ...       limittrypwd=-1    limitusr=-1    pwdexpire=-1    limitrepeatpwd=-1   idlesession=60    limitsession=60

      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_CTYPEMGT_SEARCHBY_SEL}              ${COMTYPESEARCHBY}[ctypename]
      commonkeywords.Fill in search field on list page    ${LOCATOR_CTYPEMGT_SEARCHKEYWORD_SEL}         ${ctypename_old}
      commonkeywords.Click button on list page            ${LOCATOR_CTYPEMGT_SEARCH_BTN}
      commonkeywords.Click Hide Search Criteria
      commonkeywords.Wait Loading progress
      pageComTypeMgt.Verify Company Type Result Datatable    1    companytypename    contains     ${ctypename_old}
      pageComTypeMgt.Verify Company Type Result Datatable    1    companytype        should be    ${CTYPETH}[${ctype_old}]

      commonkeywords.Click button on list page    ${CTYPE_ROW1EDIT}
      commonkeywords.Wait Loading progress
      commonkeywords.Verify data form             ${LOCATOR_CTYPEMGT_COMTYPE_SEL}         should be       ${CTYPETH}[${ctype_old}]
      commonkeywords.Verify data form             ${LOCATOR_CTYPEMGT_CTYPENAME_FIELD}     contains        ${ctypename_old}
      pageComTypeMgt.Verify checkbox company type menu state    ${default_mainmenu}       true
      pageComTypeMgt.Verify checkbox company type menu state    ${default_submenu1}       true
      pageComTypeMgt.Verify checkbox company type menu state    ${default_submenu2}       true
      pageComTypeMgt.Verify checkbox company type menu state    ${default_submenu3}       true

      IF   '${casetype}'=='caseField'
          commonkeywords.Fill in data form    ${LOCATOR_CTYPEMGT_COMTYPE_SEL}         ${CTYPETH}[${ctype_edit}]
          commonkeywords.Fill in data form    ${LOCATOR_CTYPEMGT_CTYPENAME_FIELD}     ${ctypename_edit}
      ELSE IF  '${casetype}'=='caseChecked'
          pageComTypeMgt.Check checkbox company type menu      ${menu_edit}
      ELSE IF  '${casetype}'=='caseUnchecked'
          pageComTypeMgt.Uncheck checkbox company type menu    ${menu_edit}
      ELSE
          Fail    \nPlease Check $casetype arg. should any 'caseField', 'caseChecked' or 'caseUnchecked'
      END

      commonkeywords.Click button on detail page    ${LOCATOR_CTYPEMGT_SAVE_BTN}
      commonkeywords.Verify Modal Title message     Success
      commonkeywords.Click OK Button
      commonkeywords.Wait Loading progress
      commonkeywords.Verify Page Name is correct      Company Type Management

      #Assertion
      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_CTYPEMGT_SEARCHBY_SEL}              ${COMTYPESEARCHBY}[ctypename]
      commonkeywords.Fill in search field on list page    ${LOCATOR_CTYPEMGT_SEARCHKEYWORD_SEL}         ${ctypename_old}
      commonkeywords.Click button on list page            ${LOCATOR_CTYPEMGT_SEARCH_BTN}
      commonkeywords.Click Hide Search Criteria
      commonkeywords.Wait Loading progress

      IF   '${casetype}'=='caseField'
          commonkeywords.Verify data table result is No Record Found    ${CTYPEMGT_TBODY}
          commonkeywords.Click Expand Search Criteria
          commonkeywords.Fill in search field on list page    ${LOCATOR_CTYPEMGT_SEARCHBY_SEL}              ${COMTYPESEARCHBY}[ctypename]
          commonkeywords.Fill in search field on list page    ${LOCATOR_CTYPEMGT_SEARCHKEYWORD_SEL}         ${ctypename_edit}
          commonkeywords.Click button on list page            ${LOCATOR_CTYPEMGT_SEARCH_BTN}
          commonkeywords.Click Hide Search Criteria
          commonkeywords.Wait Loading progress
          pageComTypeMgt.Verify Company Type Result Datatable    1    companytypename    contains     ${ctypename_edit}
          pageComTypeMgt.Verify Company Type Result Datatable    1    companytype        should be    ${CTYPETH}[${ctype_edit}]

      ELSE
          pageComTypeMgt.Verify Company Type Result Datatable    1    companytypename    contains     ${ctypename_old}
          pageComTypeMgt.Verify Company Type Result Datatable    1    companytype        should be    ${CTYPETH}[${ctype_old}]
      END

      commonkeywords.Click button on list page    ${CTYPE_ROW1EDIT}
      commonkeywords.Wait Loading progress

      IF   '${casetype}'=='caseField'
          commonkeywords.Verify data form             ${LOCATOR_CTYPEMGT_COMTYPE_SEL}         should be       ${CTYPETH}[${ctype_edit}]
          commonkeywords.Verify data form             ${LOCATOR_CTYPEMGT_CTYPENAME_FIELD}     contains        ${ctypename_edit}
          pageComTypeMgt.Verify checkbox company type menu state    ${default_mainmenu}       true
          pageComTypeMgt.Verify checkbox company type menu state    ${default_submenu1}       true
          pageComTypeMgt.Verify checkbox company type menu state    ${default_submenu2}       true
          pageComTypeMgt.Verify checkbox company type menu state    ${default_submenu3}       true

      ELSE IF   '${casetype}'=='caseChecked' or '${casetype}'=='caseUnchecked'
          commonkeywords.Verify data form             ${LOCATOR_CTYPEMGT_COMTYPE_SEL}           should be       ${CTYPETH}[${ctype_old}]
          commonkeywords.Verify data form             ${LOCATOR_CTYPEMGT_CTYPENAME_FIELD}       contains        ${ctypename_old}
          pageComTypeMgt.Verify checkbox company type menu state    ${default_mainmenu}         true
          pageComTypeMgt.Verify checkbox company type menu state    ${default_submenu1}         true
          pageComTypeMgt.Verify checkbox company type menu state    ${default_submenu2}         true

          IF    '${casetype}'=='caseChecked'
              pageComTypeMgt.Verify checkbox company type menu state    ${default_submenu3}     true
              pageComTypeMgt.Verify checkbox company type menu state    ${default_submenu4}     true
          ELSE IF   '${casetype}'=='caseUnchecked'
              pageComTypeMgt.Verify checkbox company type menu state    ${default_submenu3}     false
          ELSE
              Fail    \nPlease Check $casetype arg. should any 'caseChecked' or 'caseUnchecked'
          END

      ELSE
          Fail    \nPlease Check $casetype arg. should any 'caseField', 'caseChecked' or 'caseUnchecked'
      END

      commonkeywords.Click button on detail page    ${LOCATOR_XCLOSECTYPE_BTN}
      commonkeywords.Verify Page Name is correct    Company Type Management

      #assertion role management
      commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[roleMgt]
      commonkeywords.Verify Page Name is correct    Role Management
      commonkeywords.Click button on list page      ${LOCATOR_ADDROLE_BTN}
      commonkeywords.Verify Page Name is correct    Add Role
      commonkeywords.Fill in data form    ${LOCATOR_COMPANYROLE_SEL}       ${companyname_ctype}

      IF  '${casetype}'=='caseField'
            PageRoleMgt.Verify checkbox role menu state       ${default_mainmenu}      False
            PageRoleMgt.Verify checkbox role menu state       ${default_submenu1}      False
            PageRoleMgt.Verify checkbox role menu state       ${default_submenu2}      False
            PageRoleMgt.Verify checkbox role menu state       ${default_submenu3}      False

      ELSE IF   '${casetype}'=='caseChecked'
            PageRoleMgt.Verify checkbox role menu state       ${default_mainmenu}      False
            PageRoleMgt.Verify checkbox role menu state       ${default_submenu1}      False
            PageRoleMgt.Verify checkbox role menu state       ${default_submenu2}      False
            PageRoleMgt.Verify checkbox role menu state       ${default_submenu3}      False
            PageRoleMgt.Verify checkbox role menu state       ${menu_edit}             False

      ELSE IF   '${casetype}'=='caseUnchecked'
            PageRoleMgt.Verify checkbox role menu state         ${default_mainmenu}      False
            PageRoleMgt.Verify checkbox role menu state         ${default_submenu1}      False
            PageRoleMgt.Verify checkbox role menu state         ${default_submenu2}      False
            pageRoleMgt.Verify checkbox role menu not found     ${menu_edit}

      ELSE
          Fail    \nPlease Check $casetype arg. should any 'caseField', 'caseChecked' or 'caseUnchecked'
      END

      commonkeywords.Click xClose button              ${LOCATOR_XCLOSEROLE_BTN}
      commonkeywords.Verify Page Name is correct      Role Management
      commonkeywords.Go to SUBMENU name               ${mainmenu}[configuration]      ${submenu}[ctypeMgt]
      commonkeywords.Verify Page Name is correct      Company Type Management
