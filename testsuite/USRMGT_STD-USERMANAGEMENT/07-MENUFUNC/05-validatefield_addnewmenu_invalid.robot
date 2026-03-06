*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource MENU INFO DATA
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[menuMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[menuMgt]

...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['mainmenutest'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Add Parent Menu
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   icon=${DS_MENU['mainmenutest'][${menu_col.menuicon}]}
...                                   menuname=${DS_MENU['mainmenutest'][${menu_col.menuname}]}
...                                   ordermenu=${DS_MENU['mainmenutest'][${menu_col.menuorder}]}

Test Setup        Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               commonkeywords.Click button on list page      ${LOCATOR_ADDMENU_BTN}
...               AND               commonkeywords.Verify Page Name is correct    Add Menu
...               AND               commonkeywords.Wait Loading progress

Test Template     Template Validate Menu field exception case

Test Teardown     Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               commonkeywords.Click xClose button    ${LOCATOR_XCLOSEMENU_BTN}
...               AND               commonkeywords.Verify Page Name is correct    Menu Management

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['mainmenutest'][${menu_col.menuname}]}
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
#                    CASE Name               |       Menu Type         |        Menu Name        |        Menu Url            |       Menu Order          |           Main Menu Select          |         Expected Warning Message     #
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#

CASE-Add Main Menu Empty all field                 mainmenu                ${EMPTY}                      ${EMPTY}                      ${EMPTY}                ${EMPTY}                                               expwarn_menuname=${MENU_REQUIREWARNMSG}[menuname]           expwarn_menuurl=${MENU_REQUIREWARNMSG}[menuurl]   expwarn_menuorder=${MENU_REQUIREWARNMSG}[menuorder]
CASE-Add Main Menu Empty Menu name                 mainmenu                ${EMPTY}                      main/test                     99                      ${EMPTY}                                               expwarn_menuname=${MENU_REQUIREWARNMSG}[menuname]
CASE-Add Main Menu Empty Menu order                mainmenu                Robotxx Menu                  ${EMPTY}                      ${EMPTY}                ${EMPTY}                                               expwarn_menuorder=${MENU_REQUIREWARNMSG}[menuorder]
CASE-Add Sub Menu Empty all field                  submenu                 ${EMPTY}                      ${EMPTY}                      ${EMPTY}                Please Select                                          expwarn_menuname=${MENU_REQUIREWARNMSG}[menuname]           expwarn_menuurl=${MENU_REQUIREWARNMSG}[menuurl]    expwarn_menuorder=${MENU_REQUIREWARNMSG}[menuorder]        expwarn_mainmenuname=${MENU_REQUIREWARNMSG}[menuparent]
CASE-Add Sub Menu Empty Menu name                  submenu                 ${EMPTY}                      main/test                     99                      ${DS_MENU['mainmenutest'][${menu_col.menuname}]}       expwarn_menuname=${MENU_REQUIREWARNMSG}[menuname]
CASE-Add Sub Menu Empty Menu url                   submenu                 Robotxx Menu                  ${EMPTY}                      99                      ${DS_MENU['mainmenutest'][${menu_col.menuname}]}       expwarn_menuurl=${MENU_REQUIREWARNMSG}[menuurl]
CASE-Add Sub Menu Empty Menu order                 submenu                 Robotxx Menu                  sub/test                      ${EMPTY}                ${DS_MENU['mainmenutest'][${menu_col.menuname}]}       expwarn_menuorder=${MENU_REQUIREWARNMSG}[menuorder]
CASE-Add Sub Menu not choose Main menu             submenu                 Robotxx Menu                  sub/test                      99                      Please Select                                          expwarn_mainmenuname=${MENU_REQUIREWARNMSG}[menuparent]

*** Keywords ***
Template Validate Menu field exception case
    [Arguments]    ${menuType}     ${menuname}     ${menuurl}     ${menuorder}   ${mainmenuname}    &{expwarning}

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
    
      commonkeywords.Fill in data form    ${LOCATOR_MENUNAME_FIELD}             ${menuname}
      commonkeywords.Fill in data form    ${LOCATOR_MENUURL_FIELD}              ${menuurl}

      IF   '${menuType}'=='submenu'
            pagemenumgt.Check Switch to Sub Menu
            commonkeywords.Verify Field State       ${LOCATOR_MENUPARENT_SEL}         visible
            commonkeywords.Fill in data form        ${LOCATOR_MENUPARENT_SEL}         ${mainmenuname}

      ELSE IF   '${menuType}'=='mainmenu'
            commonkeywords.Verify data form         ${LOCATOR_MENUSWITCH_CHK}    should be     False
      END
      commonkeywords.Fill in data form    ${LOCATOR_MENUORDER_FIELD}          ${menuorder}
      commonkeywords.Click button on detail page    ${LOCATOR_MENUSAVE_BTN}

      IF    '${menuname}'==''
            commonkeywords.Verify Warning message field     ${LOCATOR_WARN_MENUNAME}     contains       ${expwarning}[expwarn_menuname]
            Log To Console    \nTEST CASE 'Empty Menu Name' VERIFIED.
      END

      IF    '${menuorder}'==''
            commonkeywords.Verify Warning message field     ${LOCATOR_WARN_MENUORDER}    contains       ${expwarning}[expwarn_menuorder]
            Log To Console    \nTEST CASE 'Empty Menu Order' VERIFIED.
      END

      IF    '${menuType}'=='submenu'
          IF   '${menuurl}'==''
              commonkeywords.Verify Warning message field    ${LOCATOR_WARN_MENUURL}          contains      ${expwarning}[expwarn_menuurl]
          END
          IF   '${mainmenuname}'=='Please Select'
              commonkeywords.Verify Warning message field    ${LOCATOR_WARN_MENUPARENT}       contains      ${expwarning}[expwarn_mainmenuname]
          END
            Log To Console    \nTEST CASE 'Sub Menu' VERIFIED.
      END
