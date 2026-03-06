*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test
...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               datasources.Import DataSource COMPANY TYPE INFO DATA
...               AND               commonkeywords.Generate Random Values    lengthno=3    lenghtletter=3

...               AND               Set Suite Variable     ${default_mainmenu}          ${JS_DEFAULTDATA['menudata'][0]}[menuname]
...               AND               Set Suite Variable     ${default_submenu1}          ${JS_DEFAULTDATA['menudata'][1]}[menuname]
...               AND               Set Suite Variable     ${default_submenu2}          ${JS_DEFAULTDATA['menudata'][2]}[menuname]
...               AND               Set Suite Variable     ${default_submenu3}          ${JS_DEFAULTDATA['menudata'][3]}[menuname]
...               AND               Set Suite Variable     ${default_submenu4}          ${JS_DEFAULTDATA['menudata'][4]}[menuname]

...               AND               Set Suite Variable     ${companytypelegal}          ${DS_CTYPE['addnewlegal'][${ctype_col.ctypename}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable     ${companytypeperson}         ${DS_CTYPE['addnewperson'][${ctype_col.ctypename}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}

...               AND               Set Suite Variable     ${companyname_ctype}         Ctypeadd Botfunc Company Limited

...               AND               Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='STANDARD'          \nExecute Test Only IE5DEV Version
...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Login System     ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name               ${mainmenu}[configuration]      ${submenu}[ctypeMgt]
...               AND               commonkeywords.Verify Page Name is correct      Company Type Management
...               AND               commonkeywords.Wait Loading progress

Test Template     Template Add Company Type

Suite Teardown    commonkeywords.Release user lock and close all browser


*** Test Cases ***
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
#               CASE NAME             |                     Company type                          |         Company Type Name         |                       Menu Name                          #
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#

CASE-Add New Type Legal                      ${DS_CTYPE['addnewlegal'][${ctype_col.ctype}]}             ${companytypelegal}           mainmenu    ${default_mainmenu}
CAESE-Add New Type Person                    ${DS_CTYPE['addnewperson'][${ctype_col.ctype}]}            ${companytypeperson}          submenu     ${default_submenu1}       ${default_submenu2}


*** Keywords ***
Template Add Company Type
      [Arguments]     ${ctype}      ${ctypename}     ${typemenu}      @{menuname}

      Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='STANDARD'      \nExecute Test Only IE5DEV Version
      commonkeywords.Click button on list page    ${LOCATOR_CTYPEMGT_ADD_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Verify Page Name is correct                Add Company Type
      commonkeywords.Fill in data form    ${LOCATOR_CTYPEMGT_COMTYPE_SEL}         ${CTYPETH}[${ctype}]
      commonkeywords.Fill in data form    ${LOCATOR_CTYPEMGT_CTYPENAME_FIELD}     ${ctypename}

      ${menu_lenght}=       Get Length        ${menuname}
      FOR  ${index}   IN RANGE   ${menu_lenght}
          pageComTypeMgt.Check checkbox company type menu     ${menuname}[${index}]
      END

      commonkeywords.Click button on detail page    ${LOCATOR_CTYPEMGT_SAVE_BTN}
      commonkeywords.Verify Modal Title message     Success
      commonkeywords.Click OK Button
      commonkeywords.Wait Loading progress
      commonkeywords.Verify Page Name is correct      Company Type Management

      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_CTYPEMGT_SEARCHBY_SEL}              ${COMTYPESEARCHBY}[ctypename]
      commonkeywords.Fill in search field on list page    ${LOCATOR_CTYPEMGT_SEARCHKEYWORD_SEL}         ${ctypename}
      commonkeywords.Click button on list page            ${LOCATOR_CTYPEMGT_SEARCH_BTN}
      commonkeywords.Click Hide Search Criteria
      commonkeywords.Wait Loading progress
      pageComTypeMgt.Verify Company Type Result Datatable    1    companytypename    contains     ${ctypename}
      pageComTypeMgt.Verify Company Type Result Datatable    1    companytype        should be    ${CTYPETH}[${ctype}]

      commonkeywords.Click button on list page    ${CTYPE_ROW1EDIT}
      commonkeywords.Wait Loading progress
      commonkeywords.Verify data form             ${LOCATOR_CTYPEMGT_COMTYPE_SEL}         should be       ${CTYPETH}[${ctype}]
      commonkeywords.Verify data form             ${LOCATOR_CTYPEMGT_CTYPENAME_FIELD}     contains        ${ctypename}

      FOR  ${index}   IN RANGE   ${menu_lenght}
            IF  '${typemenu}'=='mainmenu'
                pageComTypeMgt.Verify checkbox company type menu state    ${default_mainmenu}       true
                pageComTypeMgt.Verify checkbox company type menu state    ${default_submenu1}       true
                pageComTypeMgt.Verify checkbox company type menu state    ${default_submenu2}       true
                pageComTypeMgt.Verify checkbox company type menu state    ${default_submenu3}       true
                pageComTypeMgt.Verify checkbox company type menu state    ${default_submenu4}       true
            ELSE
                pageComTypeMgt.Verify checkbox company type menu state    ${menuname}[${index}]     true
                pageComTypeMgt.Verify checkbox company type menu state    ${default_mainmenu}       true
            END
      END

      commonkeywords.Click button on detail page    ${LOCATOR_XCLOSECTYPE_BTN}
      commonkeywords.Verify Page Name is correct    Company Type Management

      service-ctypemgt.Request Service Get Company Type Info    ${DS_LOGIN['robotapi'][${login_col.username}]}    ${DS_LOGIN['robotapi'][${login_col.password}]}    ${ctypename}
      service-companymgt.Request Service Add Default Company data test
      ...       headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...       registype=${CTYPE_ID}[${ctype}]
      ...       ctypeid=${GLOBAL_CTYPEID_DATA}
      ...       cname=${companyname_ctype}    ctaxid=0980001900910    cbranch=00000    cemail=ctypecom01@robot.com
      ...       limittrypwd=-1    limitusr=-1    pwdexpire=-1    limitrepeatpwd=-1   idlesession=60    limitsession=60

      #assertion role management
      commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[roleMgt]
      commonkeywords.Verify Page Name is correct    Role Management
      commonkeywords.Click button on list page      ${LOCATOR_ADDROLE_BTN}
      commonkeywords.Verify Page Name is correct    Add Role
      commonkeywords.Fill in data form    ${LOCATOR_COMPANYROLE_SEL}       ${companyname_ctype}

      IF  '${typemenu}'=='mainmenu'
            PageRoleMgt.Verify checkbox role menu state       ${default_mainmenu}      False
            PageRoleMgt.Verify checkbox role menu state       ${default_submenu1}      False
            PageRoleMgt.Verify checkbox role menu state       ${default_submenu2}      False
            PageRoleMgt.Verify checkbox role menu state       ${default_submenu3}      False
            PageRoleMgt.Verify checkbox role menu state       ${default_submenu4}      False
      ELSE
            PageRoleMgt.Verify checkbox role menu state       ${menuname}[${index}]    False
            PageRoleMgt.Verify checkbox role menu state       ${default_mainmenu}      False
      END
      commonkeywords.Click xClose button              ${LOCATOR_XCLOSEROLE_BTN}
      commonkeywords.Verify Page Name is correct      Role Management
      commonkeywords.Go to SUBMENU name               ${mainmenu}[configuration]      ${submenu}[ctypeMgt]
      commonkeywords.Verify Page Name is correct      Company Type Management
