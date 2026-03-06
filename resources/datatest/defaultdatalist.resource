*** Setting ***
Resource     ../commonkeywords.resource

*** Variables ***

${VAR_MENUNAME_USERMGT}       User Management
${VAR_MENUNAME_COMPANYMGT}    Company Management
${VAR_MENUNAME_GROUPMGT}      Group Management
${VAR_MENUNAME_MAINCONF}      Configuration

@{VAR_PERM_COMPANYMGT}        COMPANY_CREATE    COMPANY_EDIT      COMPANY_VIEW
@{VAR_PERM_USERMGT}           USER_CREATE       USER_VIEW         USER_EDIT      USER_CHANGE_STATUS        USER_RESET_PASSWORD       USER_UNLOCK
@{VAR_PERM_GROUPMGT}          GROUP_CREATE      GROUP_VIEW        GROUP_EDIT

*** Keywords ***
Create List Data Test Default Role Value
      datasources.Import DataSource DEFAULT DATA
      Set Local Variable    ${default_adminrole01}          ${JS_DEFAULTDATA['roledata'][0]}[rolename]
      Set Local Variable    ${default_adminrole02}          ${JS_DEFAULTDATA['roledata'][1]}[rolename]
      Set Local Variable    ${default_supportrole}          ${JS_DEFAULTDATA['roledata'][2]}[rolename]
      Set Local Variable    ${default_custrole}             ${JS_DEFAULTDATA['roledata'][3]}[rolename]
      Set Local Variable    ${super_robotrole}              ${JS_DEFAULTDATA['roledata'][4]}[rolename]
      Set Local Variable    ${custadmin_robotrole}          ${JS_DEFAULTDATA['roledata'][5]}[rolename]

      ${GLOBAL_DEFAULTROLE_LIST}=       Create List       ${default_adminrole01}    ${default_adminrole02}    ${default_supportrole}    ${default_custrole}   ${super_robotrole}    ${custadmin_robotrole}

      Set Global Variable          ${GLOBAL_DEFAULTROLE_LIST}

Create List Data Test Default Menu Value
      datasources.Import DataSource DEFAULT DATA
      Set Local Variable    ${defaultmainmenu}           ${JS_DEFAULTDATA['menudata'][0]}[menuname]
      Set Local Variable    ${defaultsubmenu01}          ${JS_DEFAULTDATA['menudata'][1]}[menuname]
      Set Local Variable    ${defaultsubmenu02}          ${JS_DEFAULTDATA['menudata'][2]}[menuname]
      Set Local Variable    ${defaultsubmenu03}          ${JS_DEFAULTDATA['menudata'][3]}[menuname]

      ${GLOBAL_DEFAULTMENU_LIST}=       Create List       ${defaultsubmenu01}    ${defaultsubmenu02}   ${defaultsubmenu03}    ${defaultmainmenu}
      Set Global Variable          ${GLOBAL_DEFAULTMENU_LIST}

Create List Data Test Default Permission Value
      datasources.Import DataSource DEFAULT DATA
      Set Local Variable    ${defaultperm01}          ${JS_DEFAULTDATA['permdata'][0]}[permissioncode]
      Set Local Variable    ${defaultperm02}          ${JS_DEFAULTDATA['permdata'][1]}[permissioncode]
      Set Local Variable    ${defaultperm03}          ${JS_DEFAULTDATA['permdata'][2]}[permissioncode]

      ${GLOBAL_DEFAULTPERM_LIST}=       Create List       ${defaultperm01}    ${defaultperm02}   ${defaultperm03}
      Set Global Variable          ${GLOBAL_DEFAULTPERM_LIST}
