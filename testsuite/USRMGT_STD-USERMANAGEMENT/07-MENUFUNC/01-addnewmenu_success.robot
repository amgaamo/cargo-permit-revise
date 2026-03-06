*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               datasources.Import DataSource MENU INFO DATA
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.  
...               AND               commonkeywords.Initialize System and Go to Login Page

...               AND               commonkeywords.Login System     ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}

...               AND               Log To Console    \nPrepare Data Test ...
...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['addsub'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['mainmenutest'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['addmain'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Add Parent Menu
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   icon=${DS_MENU['mainmenutest'][${menu_col.menuicon}]}
...                                   menuname=${DS_MENU['mainmenutest'][${menu_col.menuname}]}
...                                   ordermenu=${DS_MENU['mainmenutest'][${menu_col.menuorder}]}

Test Setup        Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.  
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[menuMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[menuMgt]

Test Template     Template Add new menu is success

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['addsub'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['mainmenutest'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['addmain'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Add Parent Menu
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   icon=${DS_MENU['mainmenutest'][${menu_col.menuicon}]}
...                                   menuname=${DS_MENU['mainmenutest'][${menu_col.menuname}]}
...                                   ordermenu=${DS_MENU['mainmenutest'][${menu_col.menuorder}]}

...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser


*** Test Cases ***
#---------------------------------------------------------------------------------------------#
# CASE Name | Menu Name | Menu url  | Menu Icon | Menu Order  | Menu Type | Main Menu Select  #
#---------------------------------------------------------------------------------------------#

CASE-Add New Main Menu Type
...       menuname=${DS_MENU['addmain'][${menu_col.menuname}]}
...       menuurl=${DS_MENU['addmain'][${menu_col.menuurl}]}
...       menuicon=${DS_MENU['addmain'][${menu_col.menuicon}]}
...       menuorder=${DS_MENU['addmain'][${menu_col.menuorder}]}
...       menuType=mainmenu
...       mainmenuname=${EMPTY}

CASE-Add New Sub Menu Type
...       menuname=${DS_MENU['addsub'][${menu_col.menuname}]}
...       menuurl=${DS_MENU['addsub'][${menu_col.menuurl}]}
...       menuicon=${DS_MENU['addsub'][${menu_col.menuicon}]}
...       menuorder=${DS_MENU['addsub'][${menu_col.menuorder}]}
...       menuType=submenu
...       mainmenuname=${DS_MENU['mainmenutest'][${menu_col.menuname}]}


*** Keywords ***
Template Add new menu is success
   [Arguments]    ${menuname}     ${menuurl}    ${menuicon}    ${menuorder}   ${menuType}      ${mainmenuname}

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
    
      commonkeywords.Click button on list page      ${LOCATOR_ADDMENU_BTN}
      commonkeywords.Verify Page Name is correct    Add Menu
      commonkeywords.Wait Loading progress
      pageMenuMgt.Fill in menu data info    ${menuname}    ${menuurl}    ${menuicon}    ${menuorder}

      IF   '${menuType}'=='submenu'
          pageMenuMgt.Check Switch to Sub Menu
          commonkeywords.Verify Field State       ${LOCATOR_MENUPARENT_SEL}       visible
          commonkeywords.Fill in data form        ${LOCATOR_MENUPARENT_SEL}       ${mainmenuname}
      ELSE IF  '${menuType}'=='mainmenu'
          commonkeywords.Verify data form       ${LOCATOR_MENUSWITCH_CHK}       should be     uncheck
      ELSE
          Fail    \nPlease check 'menuType' argument should any 'submenu' or 'mainmenu'!
      END

      commonkeywords.Click button on detail page    ${LOCATOR_MENUSAVE_BTN}
      commonkeywords.Verify Modal Title message     Success
      commonkeywords.Click OK Button


      # ASSERTION
      # verify record in menu list
      commonkeywords.Wait Loading progress
      commonkeywords.Verify Page Name is correct    Menu Management
      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYMENU_SEL}         ${MENUSEARCHBY}[menuname]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHMENU_KEYWORD}       ${menuname}
      commonkeywords.Click button on list page            ${LOCATOR_SEARCHMENU_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Click Hide Search Criteria

      pageMenuMgt.Verify Menu Result Datatable    1    menuname    should be    ${menuname}
      pageMenuMgt.Verify Menu Result Datatable    1    menuurl     should be    ${menuurl}

      #verify menu data info
      commonkeywords.Click button on list page        ${1ROW_MENU_ACTION}[edit]
      commonkeywords.Verify Page Name is correct      Edit Menu
      commonkeywords.Wait Loading progress

      pageMenuMgt.Verify menu data info    ${menuname}    ${menuurl}    ${menuicon}    ${menuorder}

      IF   '${menuType}'=='submenu'
            commonkeywords.Verify data form    ${LOCATOR_MENUSWITCH_CHK}    should be     True
            commonkeywords.Verify data form    ${LOCATOR_MENUPARENT_SEL}    should be     ${mainmenuname}
            Log To Console     \nTEST CASE Add new submenu VERIFIED.
      ELSE IF  '${menuType}'=='mainmenu'
            commonkeywords.Verify data form    ${LOCATOR_MENUSWITCH_CHK}    should be     uncheck
            Log To Console     \nTEST CASE Add new mainmenu VERIFIED.
      ELSE
          Fail    \nPlease check 'menuType' argument should any 'submenu' or 'mainmenu'!
      END

      commonkeywords.Click xClose button    ${LOCATOR_XCLOSEMENU_BTN}
      commonkeywords.Verify Page Name is correct    Menu Management

      IF  '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
            Log To Console    \nTest User Management Standard Version
            commonkeywords.Go to SUBMENU name               ${mainmenu}[configuration]      ${submenu}[roleMgt]
            commonkeywords.Verify Page Name is correct      Role Management
            commonkeywords.Click button on list page        ${LOCATOR_ADDROLE_BTN}
            commonkeywords.Verify Page Name is correct      Add Role
            pageRoleMgt.Verify checkbox role menu state     ${menuname}     False

      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
          Log To Console    \nTest User Management IE5DEV Version
          commonkeywords.Go to SUBMENU name                         ${mainmenu}[configuration]      ${submenu}[ctypeMgt]
          commonkeywords.Verify Page Name is correct                Company Type Management
          commonkeywords.Click button on list page                  ${LOCATOR_CTYPEMGT_ADD_BTN}
          commonkeywords.Verify Page Name is correct                Add Company Type
          pageComTypeMgt.Verify checkbox company type menu state    ${menuname}    False
      ELSE
          Fail    \nPlease Check 'GLOBAL_STANDARD_VERSION' should any 'STANDARD' or 'IE5DEV'
      END
