*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               datasources.Import DataSource ROLE INFO DATA

...               AND               Set Suite Variable     ${default_mainmenu}          ${JS_DEFAULTDATA['menudata'][0]}[menuname]
...               AND               Set Suite Variable     ${default_submenu1}          ${JS_DEFAULTDATA['menudata'][1]}[menuname]
...               AND               Set Suite Variable     ${default_submenu2}          ${JS_DEFAULTDATA['menudata'][2]}[menuname]
...               AND               Set Suite Variable     ${default_submenu3}          ${JS_DEFAULTDATA['menudata'][3]}[menuname]

...               AND               Set Suite Variable     ${default_permission1}       ${JS_DEFAULTDATA['permdata'][0]}[permissioncode]
...               AND               Set Suite Variable     ${default_permission2}       ${JS_DEFAULTDATA['permdata'][1]}[permissioncode]
...               AND               Set Suite Variable     ${default_permission3}       ${JS_DEFAULTDATA['permdata'][2]}[permissioncode]

...               AND               Set Suite Variable     ${default_companyrole}       ${JS_DEFAULTDATA['companydata'][1]}[companyname]
...               AND               Set Suite Variable     ${role_adddata}              ${DS_ROLE['addnew'][${role_col.rolename}]}
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 

...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[roleMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[roleMgt]

Test Setup        Run Keywords      commonkeywords.Generate Random Values    lengthno=3    lenghtletter=2
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 

Test Template     Template Add new Role is success

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser


*** Test Cases ***
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
#              CASE NAME           |                                    Role Name                                 |           Main Menu               |           Sub Menu 1             |             Sub Menu 2             |                       Permission                               #
#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#

CASE-Add New Role Check Main Menu             ${role_adddata}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}          ${default_mainmenu}                ${default_submenu1}                       ${default_submenu2}           ${EMPTY}                          ${EMPTY}
CASE-Add New Role Check Sub Menu              ${role_adddata}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}          ${EMPTY}                           ${default_submenu1}                       ${default_submenu2}           ${default_permission1}            ${default_permission2}
CASE-Add New Role Fill in only role name      ${role_adddata}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}          ${EMPTY}                           ${EMPTY}                                  ${EMPTY}                      ${EMPTY}                          ${EMPTY}
CASE-Add New Role Check Permission            ${role_adddata}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}          ${EMPTY}                           ${EMPTY}                                  ${EMPTY}                      ${default_permission1}            ${default_permission3}
CASE-Add New Role Check Menu and Permission   ${role_adddata}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}          ${default_mainmenu}                ${default_submenu1}                       ${default_submenu2}           ${default_permission1}            ${default_permission2}

*** Keywords ***
Template Add new Role is success
   [Arguments]    ${rolename}    ${mainmenu_val}    ${submenu1}    ${submenu2}    ${permcode1}     ${permcode2}

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
    
      commonkeywords.Click button on list page      ${LOCATOR_ADDROLE_BTN}
      commonkeywords.Verify Page Name is correct    Add Role

      IF  '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
            Log To Console    \nTesting for USER MANAGEMENT STANDARD VERSION

      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
            Log To Console    \nTesting for USER MANAGEMENT IE5DEV VERSION
            commonkeywords.Fill in data form    ${LOCATOR_COMPANYROLE_SEL}       ${default_companyrole}
      ELSE
          Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'STANDARD' or 'IE5DEV'
      END

      commonkeywords.Fill in data form              ${LOCATOR_ROLENAME_FIELD}     ${rolename}

      IF   '${mainmenu_val}'!=''
          pageRoleMgt.Check checkbox role menu          ${mainmenu_val}
      END

      IF   '${mainmenu_val}'=='' and '${submenu1}'!=''
          pageRoleMgt.Check checkbox role menu          ${submenu1}
      END

      IF   '${mainmenu_val}'=='' and '${submenu2}'!=''
          pageRoleMgt.Check checkbox role menu          ${submenu2}
      END

      IF   '${permcode1}'!=''
          PageRoleMgt.Check checkbox role permission    ${permcode1}
      END

      IF   '${permcode2}'!=''
          PageRoleMgt.Check checkbox role permission    ${permcode2}
      END

      commonkeywords.Click button on detail page    ${LOCATOR_ROLEPSAVE_BTN}
      commonkeywords.Verify Modal Title message     Success
      commonkeywords.Click OK Button
      commonkeywords.Wait Loading progress

      # ASSERTION
      # verify record in Role list
      commonkeywords.Verify Page Name is correct    Role Management
      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYROLE_SEL}         ${ROLESEARCHBY}[rolename]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHROLE_KEYWORD}       ${rolename}
      commonkeywords.Click button on list page            ${LOCATOR_SEARCHROLE_BTN}
      commonkeywords.Wait Loading progress

      pageRoleMgt.Verify Role Result Datatable    1    rolename    contains    ${rolename}
      IF  '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
            Log To Console    \nTesting for USER MANAGEMENT STANDARD VERSION

      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
            Log To Console    \nTesting for USER MANAGEMENT IE5DEV VERSION
            pageRoleMgt.Verify Role Result Datatable    1    companyname    contains    ${default_companyrole}
      ELSE
          Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'STANDARD' or 'IE5DEV'
      END

      #verify role data info
      commonkeywords.Click button on list page      ${1ROW_ROLE_ACTION}[edit]
      commonkeywords.Verify Page Name is correct    Edit Role
      commonkeywords.Wait Loading progress

      IF  '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
            Log To Console    \nTesting for USER MANAGEMENT STANDARD VERSION

      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
            Log To Console    \nTesting for USER MANAGEMENT IE5DEV VERSION
            commonkeywords.Verify data form     ${LOCATOR_COMPANYROLE_SEL}    should be     ${default_companyrole}
      ELSE
          Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'STANDARD' or 'IE5DEV'
      END

      commonkeywords.Verify data form       ${LOCATOR_ROLENAME_FIELD}     should be    ${rolename}

      IF   '${mainmenu_val}'!=''
          PageRoleMgt.Verify checkbox role menu state       ${mainmenu_val}     True
          PageRoleMgt.Verify checkbox role menu state       ${submenu1}         True
          PageRoleMgt.Verify checkbox role menu state       ${submenu2}         True
      END

      IF   '${mainmenu_val}'=='' and '${submenu1}'!=''
          PageRoleMgt.Verify checkbox role menu state       ${submenu1}      True
      END

      IF   '${mainmenu_val}'=='' and '${submenu2}'!=''
          PageRoleMgt.Verify checkbox role menu state       ${submenu2}      True
      END

      IF   '${permcode1}'!=''
          pageRoleMgt.Verify checkbox role permission state    ${permcode1}     True
      END

      IF   '${permcode2}'!=''
          pageRoleMgt.Verify checkbox role permission state    ${permcode2}     True
      END

      commonkeywords.Click xClose button    ${LOCATOR_XCLOSEROLE_BTN}
      commonkeywords.Verify Page Name is correct    Role Management
      service-rolemgt.Request Service Verify Role of Group List is found
      ...           headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}      headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}     exprole=${rolename}


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
            commonkeywords.Fill in data form      ${LOCATOR_GROUPCOMPANY_SEL}      ${default_companyrole}

            pageGroupMgt.Verify checkbox role group state    ${rolename}    False
            pageGroupMgt.Check checkbox role group           ${rolename}

            IF   '${submenu1}'!=''
                  pageGroupMgt.Verify checkbox role menu group state    ${submenu1}             True
                  pageGroupMgt.Verify checkbox role menu group state    ${default_mainmenu}     True
            END
            IF   '${submenu2}'!=''
                  pageGroupMgt.Verify checkbox role menu group state    ${submenu2}             True
                  pageGroupMgt.Verify checkbox role menu group state    ${default_mainmenu}     True
            END
            IF   '${mainmenu_val}'!=''
                  pageGroupMgt.Verify checkbox role menu group state    ${mainmenu_val}         True
            END

            commonkeywords.Click xClose button    ${LOCATOR_XCLOSEGROUP_BTN}
            commonkeywords.Verify Page Name is correct    Group Management

            commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[roleMgt]
            commonkeywords.Verify Page Name is correct    Role Management

      ELSE
          Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'STANDARD' or 'IE5DEV'
      END

      Log To Console      TEST CASE VERIFIED.
