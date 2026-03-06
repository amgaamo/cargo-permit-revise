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
...                                   menuname=${DS_MENU['datasearch_1'][${menu_col.menuname}]}
...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['datasearch_2'][${menu_col.menuname}]}
...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['datasearch_3'][${menu_col.menuname}]}
...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['datasearch_0'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Add Parent Menu
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   icon=${DS_MENU['datasearch_0'][${menu_col.menuicon}]}
...                                   menuname=${DS_MENU['datasearch_0'][${menu_col.menuname}]}
...                                   ordermenu=${DS_MENU['datasearch_0'][${menu_col.menuorder}]}

...               AND               service-menumgt.Request Service Add Sub Menu
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   icon=${DS_MENU['datasearch_1'][${menu_col.menuicon}]}
...                                   mainmenuname=${DS_MENU['datasearch_0'][${menu_col.menuname}]}
...                                   submenuname=${DS_MENU['datasearch_1'][${menu_col.menuname}]}
...                                   urlmenu=${DS_MENU['datasearch_1'][${menu_col.menuurl}]}
...                                   ordermenu=${DS_MENU['datasearch_1'][${menu_col.menuorder}]}

...               AND               service-menumgt.Request Service Add Sub Menu
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   icon=${DS_MENU['datasearch_2'][${menu_col.menuicon}]}
...                                   mainmenuname=${DS_MENU['datasearch_0'][${menu_col.menuname}]}
...                                   submenuname=${DS_MENU['datasearch_2'][${menu_col.menuname}]}
...                                   urlmenu=${DS_MENU['datasearch_2'][${menu_col.menuurl}]}
...                                   ordermenu=${DS_MENU['datasearch_2'][${menu_col.menuorder}]}

...               AND               service-menumgt.Request Service Add Sub Menu
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   icon=${DS_MENU['datasearch_3'][${menu_col.menuicon}]}
...                                   mainmenuname=${DS_MENU['datasearch_0'][${menu_col.menuname}]}
...                                   submenuname=${DS_MENU['datasearch_3'][${menu_col.menuname}]}
...                                   urlmenu=${DS_MENU['datasearch_3'][${menu_col.menuurl}]}
...                                   ordermenu=${DS_MENU['datasearch_3'][${menu_col.menuorder}]}

...               AND               commonkeywords.Verify Page Name is correct    Menu Management
...               AND               commonkeywords.Click Expand Search Criteria

Test Template     Template Search Menu

Test Teardown     Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               commonkeywords.Click button on list page            ${LOCATOR_CLEARSEARCHMENU_BTN}

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['datasearch_1'][${menu_col.menuname}]}
...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['datasearch_2'][${menu_col.menuname}]}
...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['datasearch_3'][${menu_col.menuname}]}
...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['datasearch_0'][${menu_col.menuname}]}

...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
#-------------------------------------------------------------------------------------------------------------------------------------------#
#                             CASE NAME                       Case Type   |        Search By        |            Search Keyword             #
#-------------------------------------------------------------------------------------------------------------------------------------------#

CASE-Search by Menu Name > Full Search                          P       ${MENUSEARCHBY}[menuname]      ${DS_MENU['datasearch_1'][${menu_col.menuname}]}
CASE-Search by Menu Name > Partail Search (Start wording)       P       ${MENUSEARCHBY}[menuname]      TXMAINBOT
CASE-Search by Menu Name > Partail Search (Middle wording)      E       ${MENUSEARCHBY}[menuname]      botxix
CASE-Search by Menu Name > Partail Search (Last wording)        E       ${MENUSEARCHBY}[menuname]      Management

CASE-Search by Menu url > Full Search                           P       ${MENUSEARCHBY}[menuurl]        ${DS_MENU['datasearch_1'][${menu_col.menuurl}]}
CASE-Search by Menu url > Partail Search (Start wording)        P       ${MENUSEARCHBY}[menuurl]        /mainmenu
CASE-Search by Menu url > Partail Search (Middle wording)       E       ${MENUSEARCHBY}[menuurl]        mainmenu
CASE-Search by Menu url > Partail Search (Last wording)         E       ${MENUSEARCHBY}[menuurl]        cqybot

*** Keywords ***
Template Search Menu
   [Arguments]    ${casetype}     ${searchby}    ${searchkeyword}

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
    
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYMENU_SEL}         ${searchby}
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHMENU_KEYWORD}       ${searchkeyword}
      commonkeywords.Click button on list page            ${LOCATOR_SEARCHMENU_BTN}
      commonkeywords.Wait Loading progress

      pagemenumgt.Verify Menu Result Data Table for search function     ${casetype}     ${searchby}    ${searchkeyword}
