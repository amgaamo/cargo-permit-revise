*** Settings ***
Resource          ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               datasources.Import DataSource ROLE INFO DATA
...               AND               datasources.Import DataSource DEFAULT DATA

...               AND               Set Suite Variable     ${default_mainmenu}          ${JS_DEFAULTDATA['menudata'][0]}[menuname]
...               AND               Set Suite Variable     ${default_submenu1}          ${JS_DEFAULTDATA['menudata'][1]}[menuname]
...               AND               Set Suite Variable     ${default_submenu2}          ${JS_DEFAULTDATA['menudata'][2]}[menuname]

...               AND               Set Suite Variable     ${default_permission1}       ${JS_DEFAULTDATA['permdata'][0]}[permissioncode]
...               AND               Set Suite Variable     ${default_permission2}       ${JS_DEFAULTDATA['permdata'][1]}[permissioncode]

...               AND               Set Suite Variable     ${default_companyrole}     ${JS_DEFAULTDATA['companydata'][3]}[companyname]
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 

...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[roleMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[roleMgt]

...               AND               service-menumgt.Create Data List of Menu
...                                     ${DS_LOGIN['robotapi'][${login_col.username}]}            ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     ${default_mainmenu}     ${default_submenu1}     ${default_submenu2}
...               AND               service-permmgt.Create Data List of Permission
...                                     ${DS_LOGIN['robotapi'][${login_col.username}]}           ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     ${default_permission1}    ${default_permission2}

...               AND               Run Keyword If   '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
...                                      service-rolemgt.Request Service Add Default Role data test
...                                       ${DS_LOGIN['robotapi'][${login_col.username}]}      ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                       ${DS_ROLE['data_1'][${role_col.rolename}]}
...                                       ${GLOBAL_MENUDATALIST}    ${GLOBAL_PERMDATALIST}

...               AND               Run Keyword If   '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
...                                      service-rolemgt.Request Service Add Default Role data test
...                                       ${DS_LOGIN['robotapi'][${login_col.username}]}      ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                       ${DS_ROLE['data_2'][${role_col.rolename}]}
...                                       ${GLOBAL_MENUDATALIST}    ${GLOBAL_PERMDATALIST}

...               AND               Run Keyword If   '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
...                                     service-rolemgt.Request Service Add Default Role data test
...                                       ${DS_LOGIN['robotapi'][${login_col.username}]}      ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                       ${DS_ROLE['data_3'][${role_col.rolename}]}
...                                       ${GLOBAL_MENUDATALIST}    ${GLOBAL_PERMDATALIST}

...               AND                 Run Keyword If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
...                                     service-rolemgt.Request Service Add Default Role data test
...                                       ${DS_LOGIN['robotapi'][${login_col.username}]}      ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                       ${DS_ROLE['data_1'][${role_col.rolename}]}
...                                       ${GLOBAL_MENUDATALIST}    ${GLOBAL_PERMDATALIST}    ${default_companyrole}
...               AND                 Run Keyword If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
...                                     service-rolemgt.Request Service Add Default Role data test
...                                       ${DS_LOGIN['robotapi'][${login_col.username}]}      ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                       ${DS_ROLE['data_2'][${role_col.rolename}]}
...                                       ${GLOBAL_MENUDATALIST}    ${GLOBAL_PERMDATALIST}    ${default_companyrole}
...               AND                 Run Keyword If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
...                                     service-rolemgt.Request Service Add Default Role data test
...                                       ${DS_LOGIN['robotapi'][${login_col.username}]}      ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                       ${DS_ROLE['data_3'][${role_col.rolename}]}
...                                       ${GLOBAL_MENUDATALIST}    ${GLOBAL_PERMDATALIST}    ${default_companyrole}

...               AND               commonkeywords.Click Expand Search Criteria


Test Template     Template Role Search Function


Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
#----------------------------------------------------------------------------------------------------------------------------------------#
#                             CASE NAME                    |   Type    |        Search By        |            Search Keyword             #
#----------------------------------------------------------------------------------------------------------------------------------------#
CASE-Search by Role name > Full Search                          P       ${ROLESEARCHBY}[rolename]       ${DS_ROLE['data_2'][${role_col.rolename}]}
CASE-Search by Role name > Partail Search (Start wording)       P       ${ROLESEARCHBY}[rolename]       AUTOBOTXXT
CASE-Search by Role name > Partail Search (Middle wording)      E       ${ROLESEARCHBY}[rolename]       AUTOZ
CASE-Search by Role name > Partail Search (Last wording)        E       ${ROLESEARCHBY}[rolename]       AUTOZ USER
Case-Search by Company Name (VERSION IE5DEV)                    X       ${ROLESEARCHBY}[companyname]    ${default_companyrole}

*** Keywords ***
Template Role Search Function
      [Arguments]    ${casetype}    ${searchby}    ${searchkeyword}

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
    
        IF  '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYROLE_SEL}         ${searchby}
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHROLE_KEYWORD}       ${searchkeyword}
        ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='STANDARD' and '${casetype}'!='X'
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYROLE_SEL}         ${searchby}
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHROLE_KEYWORD}       ${searchkeyword}
        ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='STANDARD' and '${casetype}'=='X'
            Pass Execution    \nExecute Test only IE5DEV Version
        ELSE
            Fail    \nPlease Check Condition Search Test Cases
        END

        commonkeywords.Click button on list page            ${LOCATOR_SEARCHROLE_BTN}
        commonkeywords.Wait Loading progress
        pageRoleMgt.Verify Role Result Data Table for search function    ${casetype}   ${searchby}      ${searchkeyword}
