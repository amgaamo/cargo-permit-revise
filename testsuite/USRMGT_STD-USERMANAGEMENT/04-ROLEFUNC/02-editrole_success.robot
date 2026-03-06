*** Settings ***
Resource          ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               datasources.Import DataSource ROLE INFO DATA
...               AND               Set Suite Variable     ${role_adddata}              ${DS_ROLE['addnew'][${role_col.rolename}]}
...               AND               Set Suite Variable     ${role_editdata}             ${DS_ROLE['update'][${role_col.rolename}]}

...               AND               Set Suite Variable     ${default_submenu1}          ${JS_DEFAULTDATA['menudata'][1]}[menuname]
...               AND               Set Suite Variable     ${default_submenu2}          ${JS_DEFAULTDATA['menudata'][2]}[menuname]
...               AND               Set Suite Variable     ${default_submenu3}          ${JS_DEFAULTDATA['menudata'][3]}[menuname]
...               AND               Set Suite Variable     ${default_submenu4}          ${JS_DEFAULTDATA['menudata'][4]}[menuname]
...               AND               Set Suite Variable     ${default_mainmenu}          ${JS_DEFAULTDATA['menudata'][0]}[menuname]

...               AND               Set Suite Variable     ${default_permission1}       ${JS_DEFAULTDATA['permdata'][0]}[permissioncode]
...               AND               Set Suite Variable     ${default_permission2}       ${JS_DEFAULTDATA['permdata'][1]}[permissioncode]
...               AND               Set Suite Variable     ${default_permission3}       ${JS_DEFAULTDATA['permdata'][2]}[permissioncode]

...               AND               Set Suite Variable     ${default_company01role}     ${JS_DEFAULTDATA['companydata'][4]}[companyname]
...               AND               Set Suite Variable     ${default_company02role}     ${JS_DEFAULTDATA['companydata'][1]}[companyname]
...               AND               Set Suite Variable     ${default_company03role}     ${JS_DEFAULTDATA['companydata'][2]}[companyname]
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[roleMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[roleMgt]
    
Test Setup        Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               commonkeywords.Generate Random Values    lengthno=3    lenghtletter=2
...               AND               service-menumgt.Create Data List of Menu
...                                     ${DS_LOGIN['robotapi'][${login_col.username}]}            ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     ${default_mainmenu}       ${default_submenu1}       ${default_submenu2}

...               AND               service-permmgt.Create Data List of Permission
...                                     ${DS_LOGIN['robotapi'][${login_col.username}]}           ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     ${default_permission1}    ${default_permission2}

...               AND               Run Keyword If   '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
...                                             service-rolemgt.Request Service Create Role Data Test
...                                             ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                             ${role_adddata}${GLOBAL_RANDOMLETTER}${SPACE}${GLOBAL_RANDOMNO}
...                                             ${GLOBAL_MENUDATALIST}    ${GLOBAL_PERMDATALIST}

...               AND               Run Keyword If   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
...                                             service-rolemgt.Request Service Create Role Data Test
...                                             ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                             ${role_adddata}${GLOBAL_RANDOMLETTER}${SPACE}${GLOBAL_RANDOMNO}
...                                             ${GLOBAL_MENUDATALIST}    ${GLOBAL_PERMDATALIST}      ${default_company01role}


Test Template     Template Edit Role is success

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser


*** Test Cases ***
CASE-Edit Role Name Field
...      caseType=caseField
...      companyname=${EMPTY}
...      oldrolename=${role_adddata}${GLOBAL_RANDOMLETTER}${SPACE}${GLOBAL_RANDOMNO}
...      rolename_edit=${role_editdata}${GLOBAL_RANDOMLETTER}${SPACE}${GLOBAL_RANDOMNO}
...      edit_menuname=${EMPTY}
...      edit_permcode=${EMPTY}

CASE-Check more Menu and Permission
...      caseType=caseChecked
...      companyname=${EMPTY}
...      oldrolename=${role_adddata}${GLOBAL_RANDOMLETTER}${SPACE}${GLOBAL_RANDOMNO}
...      rolename_edit=${EMPTY}
...      edit_menuname=${default_submenu3}
...      edit_permcode=${default_permission3}

CASE-Uncheck Menu and Permission
...      caseType=caseUnchecked
...      companyname=${EMPTY}
...      oldrolename=${role_adddata}${GLOBAL_RANDOMLETTER}${SPACE}${GLOBAL_RANDOMNO}
...      rolename_edit=${EMPTY}
...      edit_menuname=${default_submenu2}
...      edit_permcode=${default_permission2}

CASE-Change Company Role - บริษัทที่เปลี่ยนมีเมนูเก่าก่อนหน้าที่เลือกไว้ (Version-IE5DEV)
...      caseType=caseCompany
...      companyname=${default_company02role}
...      oldrolename=${role_adddata}${GLOBAL_RANDOMLETTER}${SPACE}${GLOBAL_RANDOMNO}
...      rolename_edit=${EMPTY}
...      edit_menuname=${VAR_MENUNAME_GROUPMGT}
...      edit_permcode=${EMPTY}

CASE-Change Company Role - บริษัทที่เปลี่ยนไม่มีเมนูเก่าก่อนหน้าที่เลือกไว้ (Version-IE5DEV)
...      caseType=caseCompany
...      companyname=${default_company03role}
...      oldrolename=${role_adddata}${GLOBAL_RANDOMLETTER}${SPACE}${GLOBAL_RANDOMNO}
...      rolename_edit=${EMPTY}
...      edit_menuname=${VAR_MENUNAME_GROUPMGT}
...      edit_permcode=${EMPTY}

*** Keywords ***
Template Edit Role is success
   [Arguments]    ${caseType}    ${companyname}    ${oldrolename}     ${rolename_edit}    ${edit_menuname}    ${edit_permcode}

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
    
      IF  '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
            IF   '${caseType}'=='caseCompany'
                Pass Execution    \nTest Cases for User Standard Version IE5DEV Version
            END
      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
            Log To Console    \nTesting for USER MANAGEMENT IE5DEV VERSION
      ELSE
            Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'STANDARD' or 'IE5DEV'
      END

      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYROLE_SEL}         ${ROLESEARCHBY}[rolename]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHROLE_KEYWORD}       ${oldrolename}
      commonkeywords.Click button on list page            ${LOCATOR_SEARCHROLE_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Click Hide Search Criteria

      pageRoleMgt.Verify Role Result Datatable    1    rolename    contains    ${oldrolename}

      #verify role data info
      commonkeywords.Click button on list page      ${1ROW_ROLE_ACTION}[edit]
      commonkeywords.Verify Page Name is correct    Edit Role
      commonkeywords.Wait Loading progress


      IF   '${caseType}'=='caseChecked'
            pageRoleMgt.Verify checkbox role menu state           ${default_submenu1}         True
            pageRoleMgt.Verify checkbox role menu state           ${default_submenu2}         True
            pageRoleMgt.Verify checkbox role permission state     ${default_permission1}      True
            pageRoleMgt.Verify checkbox role permission state     ${default_permission2}      True
            pageRoleMgt.Check checkbox role menu                  ${edit_menuname}
            pageRoleMgt.Check checkbox role permission            ${edit_permcode}

      ELSE IF   '${caseType}'=='caseUnchecked'
            pageRoleMgt.Verify checkbox role menu state           ${default_submenu1}         True
            pageRoleMgt.Verify checkbox role menu state           ${default_submenu2}         True
            pageRoleMgt.Verify checkbox role permission state     ${default_permission1}      True
            pageRoleMgt.Verify checkbox role permission state     ${default_permission2}      True
            pageRoleMgt.Uncheck checkbox role menu                ${edit_menuname}
            pageRoleMgt.Uncheck checkbox role permission          ${edit_permcode}

      ELSE IF   '${caseType}'=='caseField'
            commonkeywords.Fill in data form       ${LOCATOR_ROLENAME_FIELD}       ${rolename_edit}

      ELSE IF   '${caseType}'=='caseCompany'
            IF  '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
                  Log To Console    \nTesting for USER MANAGEMENT STANDARD VERSION

            ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
                  Log To Console    \nTesting for USER MANAGEMENT IE5DEV VERSION
              IF    '${companyname}'=='${default_company02role}'
                    pageRoleMgt.Verify checkbox role menu state    ${default_mainmenu}    True
                    pageRoleMgt.Verify checkbox role menu state    ${default_submenu1}    True
                    pageRoleMgt.Verify checkbox role menu state    ${default_submenu2}    True
                    pageRoleMgt.Verify checkbox role menu state    ${default_submenu3}    False
                    pageRoleMgt.Verify checkbox role menu state    ${default_submenu4}    False

                    commonkeywords.Fill in data form     ${LOCATOR_COMPANYROLE_SEL}       ${default_company02role}
                    pageRoleMgt.Verify checkbox role menu state    ${default_mainmenu}    True
                    pageRoleMgt.Verify checkbox role menu state    ${default_submenu1}    True
                    pageRoleMgt.Verify checkbox role menu state    ${default_submenu2}    True
                    pageRoleMgt.Verify checkbox role menu state    ${default_submenu3}    False
                    pageRoleMgt.Verify checkbox role menu state    ${default_submenu4}    False

                    pageRoleMgt.Verify checkbox role menu state    ${VAR_MENUNAME_MAINCONF}       False
                    pageRoleMgt.Verify checkbox role menu state    ${VAR_MENUNAME_USERMGT}        False
                    pageRoleMgt.Verify checkbox role menu state    ${VAR_MENUNAME_GROUPMGT}       False
                    pageRoleMgt.Verify checkbox role menu state    ${VAR_MENUNAME_COMPANYMGT}     False
                    pageRoleMgt.Check checkbox role menu     ${edit_menuname}

              ELSE IF   '${companyname}'=='${default_company03role}'

                    pageRoleMgt.Verify checkbox role menu state    ${default_mainmenu}    True
                    pageRoleMgt.Verify checkbox role menu state    ${default_submenu1}    True
                    pageRoleMgt.Verify checkbox role menu state    ${default_submenu2}    True
                    pageRoleMgt.Verify checkbox role menu state    ${default_submenu3}    False
                    pageRoleMgt.Verify checkbox role menu state    ${default_submenu4}    False

                    commonkeywords.Fill in data form     ${LOCATOR_COMPANYROLE_SEL}       ${default_company03role}
                    pageRoleMgt.Verify checkbox role menu not found    ${default_mainmenu}
                    pageRoleMgt.Verify checkbox role menu not found    ${default_submenu1}
                    pageRoleMgt.Verify checkbox role menu not found    ${default_submenu2}
                    pageRoleMgt.Verify checkbox role menu not found    ${default_submenu3}
                    pageRoleMgt.Verify checkbox role menu not found    ${default_submenu4}
                    pageRoleMgt.Verify checkbox role menu state        ${VAR_MENUNAME_MAINCONF}       False
                    pageRoleMgt.Verify checkbox role menu state        ${VAR_MENUNAME_USERMGT}        False
                    pageRoleMgt.Verify checkbox role menu state        ${VAR_MENUNAME_GROUPMGT}       False
                    pageRoleMgt.Verify checkbox role menu state        ${VAR_MENUNAME_COMPANYMGT}     False
                    pageRoleMgt.Check checkbox role menu     ${edit_menuname}
              ELSE
                  Fail    \nPlease Check Company Name Val. should be '$default_company02role' or $default_company01role
              END
            ELSE
                Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'STANDARD' or 'IE5DEV'
            END

      ELSE
              Fail    \nPlease check 'caseType' Argument!
      END

      commonkeywords.Click button on detail page    ${LOCATOR_ROLEPSAVE_BTN}
      commonkeywords.Verify Modal Title message     Success
      commonkeywords.Click OK Button
      commonkeywords.Wait Loading progress

      # ASSERTION
      # verify record in group list
      commonkeywords.Verify Page Name is correct          Role Management
      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYROLE_SEL}         ${ROLESEARCHBY}[rolename]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHROLE_KEYWORD}       ${oldrolename}
      commonkeywords.Click button on list page            ${LOCATOR_SEARCHROLE_BTN}
      commonkeywords.Wait Loading progress

      IF   '${caseType}'=='caseField'
            commonkeywords.Verify data table result is No Record Found    ${ROW_ROLE_TBODY}
            commonkeywords.Click button on list page    ${LOCATOR_CLEARSEARCHROLE_BTN}
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYROLE_SEL}         ${ROLESEARCHBY}[rolename]
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHROLE_KEYWORD}       ${rolename_edit}
            commonkeywords.Click button on list page            ${LOCATOR_SEARCHROLE_BTN}
            commonkeywords.Wait Loading progress
            pageRoleMgt.Verify Role Result Datatable    1    rolename    contains    ${rolename_edit}

      ELSE IF   '${caseType}'=='caseCompany'
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYROLE_SEL}         ${ROLESEARCHBY}[rolename]
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHROLE_KEYWORD}       ${oldrolename}
            commonkeywords.Click button on list page            ${LOCATOR_SEARCHROLE_BTN}
            commonkeywords.Wait Loading progress
            pageRoleMgt.Verify Role Result Datatable    1    rolename       contains    ${oldrolename}
            pageRoleMgt.Verify Role Result Datatable    1    companyname    contains    ${companyname}
      ELSE
            pageRoleMgt.Verify Role Result Datatable    1    rolename    contains    ${oldrolename}
      END
      commonkeywords.Click Hide Search Criteria

      #verify role data info
      commonkeywords.Click button on list page      ${1ROW_ROLE_ACTION}[edit]
      commonkeywords.Verify Page Name is correct    Edit Role
      commonkeywords.Wait Loading progress

      IF   '${caseType}'=='caseChecked'
            pageRoleMgt.Verify checkbox role menu state           ${default_submenu1}         True
            pageRoleMgt.Verify checkbox role menu state           ${default_submenu2}         True
            pageRoleMgt.Verify checkbox role permission state     ${default_permission1}      True
            pageRoleMgt.Verify checkbox role permission state     ${default_permission2}      True

            pageRoleMgt.Verify checkbox role menu state           ${edit_menuname}        True
            pageRoleMgt.Verify checkbox role permission state     ${edit_permcode}        True
            commonkeywords.Verify data form    ${LOCATOR_ROLENAME_FIELD}    should be     ${oldrolename}
            Log To Console    TEST CASE VERIFIED.

      ELSE IF  '${caseType}'=='caseUnchecked'
            pageRoleMgt.Verify checkbox role menu state           ${default_submenu1}         True
            pageRoleMgt.Verify checkbox role menu state           ${default_submenu2}         False
            pageRoleMgt.Verify checkbox role permission state     ${default_permission1}      True
            pageRoleMgt.Verify checkbox role permission state     ${default_permission2}      False

            pageRoleMgt.Verify checkbox role menu state           ${edit_menuname}            False
            pageRoleMgt.Verify checkbox role permission state     ${edit_permcode}            False

            commonkeywords.Verify data form    ${LOCATOR_ROLENAME_FIELD}    should be     ${oldrolename}
            Log To Console    TEST CASE VERIFIED.

      ELSE IF   '${caseType}'=='caseField'
            commonkeywords.Verify data form    ${LOCATOR_ROLENAME_FIELD}    should be         ${rolename_edit}
            pageRoleMgt.Verify checkbox role menu state           ${default_submenu1}         True
            pageRoleMgt.Verify checkbox role menu state           ${default_submenu2}         True
            pageRoleMgt.Verify checkbox role permission state     ${default_permission1}      True
            pageRoleMgt.Verify checkbox role permission state     ${default_permission2}      True
            Log To Console    TEST CASE VERIFIED.

      ELSE IF   '${caseType}'=='caseCompany'
            IF  '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
                  Log To Console    \nTesting for USER MANAGEMENT STANDARD VERSION

            ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
                  Log To Console    \nTesting for USER MANAGEMENT IE5DEV VERSION
              IF  '${companyname}'=='${default_company02role}'
                  pageRoleMgt.Verify checkbox role menu state    ${default_mainmenu}             True
                  pageRoleMgt.Verify checkbox role menu state    ${default_submenu1}             True
                  pageRoleMgt.Verify checkbox role menu state    ${default_submenu2}             True
                  pageRoleMgt.Verify checkbox role menu state    ${default_submenu3}             False
                  pageRoleMgt.Verify checkbox role menu state    ${default_submenu4}             False
                  pageRoleMgt.Verify checkbox role menu state    ${VAR_MENUNAME_MAINCONF}        True
                  pageRoleMgt.Verify checkbox role menu state    ${VAR_MENUNAME_USERMGT}         False
                  pageRoleMgt.Verify checkbox role menu state    ${VAR_MENUNAME_GROUPMGT}        True
                  pageRoleMgt.Verify checkbox role menu state    ${VAR_MENUNAME_COMPANYMGT}      False

              ELSE IF   '${companyname}'=='${default_company03role}'
                  pageRoleMgt.Verify checkbox role menu not found    ${default_mainmenu}
                  pageRoleMgt.Verify checkbox role menu not found    ${default_submenu1}
                  pageRoleMgt.Verify checkbox role menu not found    ${default_submenu2}
                  pageRoleMgt.Verify checkbox role menu not found    ${default_submenu3}
                  pageRoleMgt.Verify checkbox role menu not found    ${default_submenu4}
                  pageRoleMgt.Verify checkbox role menu state        ${VAR_MENUNAME_MAINCONF}        True
                  pageRoleMgt.Verify checkbox role menu state        ${VAR_MENUNAME_USERMGT}         False
                  pageRoleMgt.Verify checkbox role menu state        ${VAR_MENUNAME_GROUPMGT}        True
                  pageRoleMgt.Verify checkbox role menu state        ${VAR_MENUNAME_COMPANYMGT}      False
              ELSE
                  Fail    \nPlease Check Company Name Val. should be '$default_company02role' or $default_company01role
              END
                  commonkeywords.Verify data form    ${LOCATOR_ROLENAME_FIELD}      should be    ${oldrolename}
                  commonkeywords.Verify data form    ${LOCATOR_COMPANYROLE_SEL}     should be    ${companyname}
                  Log To Console    TEST CASE VERIFIED.
            END
      END

      commonkeywords.Click xClose button    ${LOCATOR_XCLOSEROLE_BTN}
      commonkeywords.Verify Page Name is correct    Role Management

      #Assertion Group Management
      IF  '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
            Log To Console    \nTesting for USER MANAGEMENT STANDARD VERSION

      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
            Log To Console    \nTesting for USER MANAGEMENT IE5DEV VERSION
            commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[groupMgt]
            commonkeywords.Verify Page Name is correct    Group Management
            commonkeywords.Click button on list page      ${LOCATOR_ADDGROUP_BTN}
            commonkeywords.Verify Page Name is correct    Add Group
            commonkeywords.Wait Loading progress

        IF  '${caseType}'=='caseField'
              commonkeywords.Fill in data form      ${LOCATOR_GROUPCOMPANY_SEL}      ${default_company01role}
              pageGroupMgt.Verify checkbox role group state         ${rolename_edit}        False
              pageGroupMgt.Check checkbox role group                ${rolename_edit}
              pageGroupMgt.Verify checkbox role menu group state    ${default_mainmenu}     True
              pageGroupMgt.Verify checkbox role menu group state    ${default_submenu1}     True
              pageGroupMgt.Verify checkbox role menu group state    ${default_submenu2}     True

        ELSE IF  '${caseType}'=='caseChecked'
              commonkeywords.Fill in data form      ${LOCATOR_GROUPCOMPANY_SEL}      ${default_company01role}
              pageGroupMgt.Verify checkbox role group state         ${oldrolename}          False
              pageGroupMgt.Check checkbox role group                ${oldrolename}
              pageGroupMgt.Verify checkbox role menu group state    ${default_mainmenu}     True
              pageGroupMgt.Verify checkbox role menu group state    ${default_submenu1}     True
              pageGroupMgt.Verify checkbox role menu group state    ${default_submenu2}     True
              pageGroupMgt.Verify checkbox role menu group state    ${edit_menuname}        True


        ELSE IF  '${caseType}'=='caseUnchecked'
              commonkeywords.Fill in data form      ${LOCATOR_GROUPCOMPANY_SEL}      ${default_company01role}
              pageGroupMgt.Verify checkbox role group state             ${oldrolename}          False
              pageGroupMgt.Check checkbox role group                    ${oldrolename}
              pageGroupMgt.Verify checkbox role menu group state        ${default_mainmenu}     True
              pageGroupMgt.Verify checkbox role menu group state        ${default_submenu1}     True
              pageGroupMgt.Verify checkbox role menu group not found    ${edit_menuname}

        ELSE IF  '${caseType}'=='caseCompany'
              IF  '${companyname}'=='${default_company02role}'
                  commonkeywords.Fill in data form      ${LOCATOR_GROUPCOMPANY_SEL}      ${default_company02role}
                  pageGroupMgt.Verify checkbox role group state         ${oldrolename}               False
                  pageGroupMgt.Check checkbox role group                ${oldrolename}
                  pageGroupMgt.Verify checkbox role menu group state    ${default_mainmenu}          True
                  pageGroupMgt.Verify checkbox role menu group state    ${default_submenu1}          True
                  pageGroupMgt.Verify checkbox role menu group state    ${default_submenu2}          True
                  pageGroupMgt.Verify checkbox role menu group state    ${edit_menuname}             True
                  pageGroupMgt.Verify checkbox role menu group state    ${VAR_MENUNAME_MAINCONF}     True

              ELSE IF   '${companyname}'=='${default_company03role}'
                  commonkeywords.Fill in data form      ${LOCATOR_GROUPCOMPANY_SEL}      ${default_company03role}
                  pageGroupMgt.Verify checkbox role group state         ${oldrolename}               False
                  pageGroupMgt.Check checkbox role group                ${oldrolename}
                  pageGroupMgt.Verify checkbox role menu group not found    ${default_mainmenu}
                  pageGroupMgt.Verify checkbox role menu group not found    ${default_submenu1}
                  pageGroupMgt.Verify checkbox role menu group not found    ${default_submenu2}
                  pageGroupMgt.Verify checkbox role menu group state        ${edit_menuname}             True
                  pageGroupMgt.Verify checkbox role menu group state        ${VAR_MENUNAME_MAINCONF}     True
              ELSE
                  Fail    \nPlease Check Company Name Val. should be '$default_company02role' or $default_company01role
              END

        ELSE
              Fail    \nPlease Check Case Type should any 'caseField', 'caseChecked', 'caseUnchecked', 'caseCompany'
        END

            commonkeywords.Click xClose button    ${LOCATOR_XCLOSEGROUP_BTN}
            commonkeywords.Verify Page Name is correct    Group Management

            commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[roleMgt]
            commonkeywords.Verify Page Name is correct    Role Management

      ELSE
          Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'STANDARD' or 'IE5DEV'
      END
