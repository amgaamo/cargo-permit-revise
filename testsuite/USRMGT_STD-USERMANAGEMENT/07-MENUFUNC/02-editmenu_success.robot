*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource MENU INFO DATA
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.  
...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}

...               AND               Log To Console    \nPrepare Data Test ...
...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['addsub'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['addmain'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['editsub'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['editmain'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['mainmenutest'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['mainmenutest2'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Add Parent Menu
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   icon=${DS_MENU['mainmenutest'][${menu_col.menuicon}]}
...                                   menuname=${DS_MENU['mainmenutest'][${menu_col.menuname}]}
...                                   ordermenu=${DS_MENU['mainmenutest'][${menu_col.menuorder}]}

...               AND               service-menumgt.Request Service Add Parent Menu
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   icon=${DS_MENU['mainmenutest2'][${menu_col.menuicon}]}
...                                   menuname=${DS_MENU['mainmenutest'][${menu_col.menuname}]}
...                                   ordermenu=${DS_MENU['mainmenutest'][${menu_col.menuorder}]}


Test Setup        Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['addsub'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['addmain'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['editsub'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['editmain'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Add Sub Menu
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   icon=${DS_MENU['addsub'][${menu_col.menuicon}]}
...                                   mainmenuname=${DS_MENU['mainmenutest'][${menu_col.menuname}]}
...                                   submenuname=${DS_MENU['addsub'][${menu_col.menuname}]}
...                                   urlmenu=${DS_MENU['addsub'][${menu_col.menuurl}]}
...                                   ordermenu=${DS_MENU['addsub'][${menu_col.menuorder}]}

...               AND               service-menumgt.Request Service Add Parent Menu
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   icon=${DS_MENU['addmain'][${menu_col.menuicon}]}
...                                   menuname=${DS_MENU['addmain'][${menu_col.menuname}]}
...                                   ordermenu=${DS_MENU['addmain'][${menu_col.menuorder}]}

...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[menuMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[menuMgt]

Test Template     Template Edit Menu Success

Test Teardown     Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.  
...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['addsub'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['addmain'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['editsub'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['editmain'][${menu_col.menuname}]}

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.  
...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['mainmenutest'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['mainmenutest2'][${menu_col.menuname}]}

...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
#---------------------------------------------------------------------------------------------------------------#
# CASE Name | Menu name | Edit Menu Name  | Menu url  | Menu Icon | Menu Order  | Menu Type | Main Menu Select  #
#---------------------------------------------------------------------------------------------------------------#

CASE-Edit Main Menu success
...     menuname=${DS_MENU['addmain'][${menu_col.menuname}]}
...     editmenuname=${DS_MENU['editmain'][${menu_col.menuname}]}
...     menuurl=${DS_MENU['editmain'][${menu_col.menuurl}]}
...     menuicon=${DS_MENU['editmain'][${menu_col.menuicon}]}
...     menuorder=${DS_MENU['editmain'][${menu_col.menuorder}]}
...     menuType=mainmenu
...     mainmenuname=${EMPTY}

CASE-Edit Sub Menu success
...     menuname=${DS_MENU['addsub'][${menu_col.menuname}]}
...     editmenuname=${DS_MENU['editsub'][${menu_col.menuname}]}
...     menuurl=${DS_MENU['editsub'][${menu_col.menuurl}]}
...     menuicon=${DS_MENU['editsub'][${menu_col.menuicon}]}
...     menuorder=${DS_MENU['editsub'][${menu_col.menuorder}]}
...     menuType=submenu
...     mainmenuname=${DS_MENU['mainmenutest2'][${menu_col.menuname}]}

CASE-Change Sub Menu to Parent Menu
...     menuname=${DS_MENU['addmain'][${menu_col.menuname}]}
...     editmenuname=${EMPTY}
...     menuurl=${DS_MENU['editmain'][${menu_col.menuurl}]}
...     menuicon=${DS_MENU['editmain'][${menu_col.menuicon}]}
...     menuorder=${DS_MENU['editmain'][${menu_col.menuorder}]}
...     menuType=changetomain
...     mainmenuname=${EMPTY}

CASE-Chage Parent Menu to Sub Menu
...     menuname=${DS_MENU['addsub'][${menu_col.menuname}]}
...     editmenuname=${EMPTY}
...     menuurl=${DS_MENU['editsub'][${menu_col.menuurl}]}
...     menuicon=${DS_MENU['editsub'][${menu_col.menuicon}]}
...     menuorder=${DS_MENU['editsub'][${menu_col.menuorder}]}
...     menuType=changetosub
...     mainmenuname=${DS_MENU['mainmenutest'][${menu_col.menuname}]}


*** Keywords ***
Template Edit Menu Success
   [Arguments]    ${menuname}    ${editmenuname}     ${menuurl}    ${menuicon}    ${menuorder}   ${menuType}      ${mainmenuname}

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
    
      commonkeywords.Wait Loading progress
      commonkeywords.Verify Page Name is correct    Menu Management
      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYMENU_SEL}         ${MENUSEARCHBY}[menuname]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHMENU_KEYWORD}       ${menuname}
      commonkeywords.Click button on list page            ${LOCATOR_SEARCHMENU_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Click Hide Search Criteria

      pageMenuMgt.Verify Menu Result Datatable    1    menuname    should be    ${menuname}

      #edit menu data info
      commonkeywords.Click button on list page        ${1ROW_MENU_ACTION}[edit]
      commonkeywords.Verify Page Name is correct      Edit Menu
      commonkeywords.Wait Loading progress

      IF   '${editmenuname}'!=''
          commonkeywords.Fill in data form        ${LOCATOR_MENUNAME_FIELD}       ${editmenuname}
      END

      commonkeywords.Fill in data form        ${LOCATOR_MENUURL_FIELD}        ${menuurl}
      commonkeywords.Fill in data form        ${LOCATOR_MENUICON_FIELD}       ${menuicon}
      commonkeywords.Fill in data form        ${LOCATOR_MENUORDER_FIELD}      ${menuorder}

      IF   '${menuType}'=='changetosub'
          pageMenuMgt.Check Switch to Sub Menu
          commonkeywords.Verify data form     ${LOCATOR_MENUSWITCH_CHK}       should be   True
          commonkeywords.Verify Field State   ${LOCATOR_MENUPARENT_SEL}       visible
          commonkeywords.Fill in data form    ${LOCATOR_MENUPARENT_SEL}       ${mainmenuname}
      ELSE IF   '${menuType}'=='changetomain'
          PageMenuMgt.Uncheck Switch to Sub Menu
          commonkeywords.Verify data form     ${LOCATOR_MENUSWITCH_CHK}       should be   False
          commonkeywords.Verify Field State   ${LOCATOR_MENUPARENT_SEL}       hidden
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

      IF  '${editmenuname}'==''
          commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHMENU_KEYWORD}       ${menuname}
          commonkeywords.Click button on list page            ${LOCATOR_SEARCHMENU_BTN}
          commonkeywords.Wait Loading progress
          commonkeywords.Click Hide Search Criteria
          pageMenuMgt.Verify Menu Result Datatable    1    menuname    should be    ${menuname}

      ELSE IF   '${editmenuname}'!=''
          commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHMENU_KEYWORD}       ${menuname}
          commonkeywords.Click button on list page            ${LOCATOR_SEARCHMENU_BTN}
          commonkeywords.Wait Loading progress
          commonkeywords.Verify data table result is No Record Found    ${ROW_MENU_TBODY}
          commonkeywords.Click button on list page    ${LOCATOR_CLEARSEARCHMENU_BTN}
          commonkeywords.Wait Loading progress

          commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHMENU_KEYWORD}       ${editmenuname}
          commonkeywords.Click button on list page            ${LOCATOR_SEARCHMENU_BTN}
          commonkeywords.Wait Loading progress
          commonkeywords.Click Hide Search Criteria
          pageMenuMgt.Verify Menu Result Datatable    1    menuname    should be    ${editmenuname}
      END

      pageMenuMgt.Verify Menu Result Datatable        1    menuurl     should be    ${menuurl}

      #verify menu data info
      commonkeywords.Click button on list page        ${1ROW_MENU_ACTION}[edit]
      commonkeywords.Verify Page Name is correct      Edit Menu
      commonkeywords.Wait Loading progress

      IF   '${editmenuname}'==''
            commonkeywords.Verify data form     ${LOCATOR_MENUNAME_FIELD}    should be      ${menuname}
      ELSE IF  '${editmenuname}'!=''
            commonkeywords.Verify data form     ${LOCATOR_MENUNAME_FIELD}    should be      ${editmenuname}
      END

      commonkeywords.Verify data form       ${LOCATOR_MENUURL_FIELD}         should be       ${menuurl}
      commonkeywords.Verify data form       ${LOCATOR_MENUICON_FIELD}        should be       ${menuicon}
      commonkeywords.Verify data form       ${LOCATOR_MENUORDER_FIELD}       should be       ${menuorder}

      IF   '${menuType}'=='changetosub'
            commonkeywords.Verify data form    ${LOCATOR_MENUSWITCH_CHK}     should be       True
            commonkeywords.Verify data form    ${LOCATOR_MENUPARENT_SEL}     should be       ${mainmenuname}
            Log To Console      TEST CASE VERIFIED.
      ELSE IF   '${menuType}'=='changetomain'
            commonkeywords.Verify data form    ${LOCATOR_MENUSWITCH_CHK}     should be       False
            Log To Console      TEST CASE VERIFIED.
      END

      commonkeywords.Click xClose button    ${LOCATOR_XCLOSEMENU_BTN}
      commonkeywords.Verify Page Name is correct    Menu Management

      IF  '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
          Log To Console    \nTest User Management Standard Version
          commonkeywords.Go to SUBMENU name               ${mainmenu}[configuration]      ${submenu}[roleMgt]
          commonkeywords.Verify Page Name is correct      Role Management
          commonkeywords.Click button on list page        ${LOCATOR_ADDROLE_BTN}
          commonkeywords.Verify Page Name is correct      Add Role

          IF   '${editmenuname}'==''
                pageRoleMgt.Verify checkbox role menu state     ${menuname}         False
          ELSE IF  '${editmenuname}'!=''
                pageRoleMgt.Verify checkbox role menu state     ${editmenuname}     False
          END

     ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
          Log To Console    \nTest User Management IE5DEV Version
          commonkeywords.Go to SUBMENU name                         ${mainmenu}[configuration]      ${submenu}[ctypeMgt]
          commonkeywords.Verify Page Name is correct                Company Type Management
          commonkeywords.Click button on list page                  ${LOCATOR_CTYPEMGT_ADD_BTN}
          commonkeywords.Verify Page Name is correct                Add Company Type

          IF   '${editmenuname}'==''
                pageComTypeMgt.Verify checkbox company type menu state     ${menuname}         False
          ELSE IF  '${editmenuname}'!=''
                pageComTypeMgt.Verify checkbox company type menu state     ${editmenuname}     False
          END
     ELSE
          Fail    \nPlease Check 'GLOBAL_STANDARD_VERSION' should any 'STANDARD' or 'IE5DEV'
     END
