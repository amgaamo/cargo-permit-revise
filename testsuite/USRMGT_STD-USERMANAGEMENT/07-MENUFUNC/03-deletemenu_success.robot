*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource MENU INFO DATA
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.  
...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}

Test Setup        Run Keywords     Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.  
...               AND              service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['delsub'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['delsub2'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['delmain'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['delmain2'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Add Parent Menu
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   icon=${DS_MENU['delmain'][${menu_col.menuicon}]}
...                                   menuname=${DS_MENU['delmain'][${menu_col.menuname}]}
...                                   ordermenu=${DS_MENU['delmain'][${menu_col.menuorder}]}

...               AND               service-menumgt.Request Service Add Parent Menu
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   icon=${DS_MENU['delmain2'][${menu_col.menuicon}]}
...                                   menuname=${DS_MENU['delmain2'][${menu_col.menuname}]}
...                                   ordermenu=${DS_MENU['delmain2'][${menu_col.menuorder}]}

...               AND               service-menumgt.Request Service Add Sub Menu
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   icon=${DS_MENU['delsub'][${menu_col.menuicon}]}
...                                   mainmenuname=${DS_MENU['delmain2'][${menu_col.menuname}]}
...                                   submenuname=${DS_MENU['delsub'][${menu_col.menuname}]}
...                                   urlmenu=${DS_MENU['delsub'][${menu_col.menuurl}]}
...                                   ordermenu=${DS_MENU['delsub'][${menu_col.menuorder}]}

...               AND               service-menumgt.Request Service Add Sub Menu
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   icon=${DS_MENU['delsub2'][${menu_col.menuicon}]}
...                                   mainmenuname=${DS_MENU['delmain2'][${menu_col.menuname}]}
...                                   submenuname=${DS_MENU['delsub2'][${menu_col.menuname}]}
...                                   urlmenu=${DS_MENU['delsub2'][${menu_col.menuurl}]}
...                                   ordermenu=${DS_MENU['delsub2'][${menu_col.menuorder}]}

...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[menuMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[menuMgt]


Test Template     Template delete Menu

Test Teardown     Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.  
...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['delsub'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['delsub2'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['delmain'][${menu_col.menuname}]}

...               AND               service-menumgt.Request Service Delete by Menu Name
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   menuname=${DS_MENU['delmain2'][${menu_col.menuname}]}

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.  
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser


*** Test Cases ***
#-------------------------------------------------------------------------------------------------------------------------------------------------#
#                 CASE NAME                     |                   Menu Name                     |       Confirm?       |     Have Sub Menu?     #
#-------------------------------------------------------------------------------------------------------------------------------------------------#

CASE-Click Yes to confirm delete Main Menu            ${DS_MENU['delmain'][${menu_col.menuname}]}      Yes                     No
CASE-Click Yes to confirm delete Sub Menu             ${DS_MENU['delsub'][${menu_col.menuname}]}       Yes                     No
CASE-Click No to cancel delete data                   ${DS_MENU['delmain'][${menu_col.menuname}]}      No                      No
CASE-cannot Delete data (Main menu has sub menu )     ${DS_MENU['delmain2'][${menu_col.menuname}]}     Yes                     Yes

*** Keywords ***
Template delete Menu
   [Arguments]    ${menuname}    ${isConfirm}     ${haveSubmenu}

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

      pagemenumgt.Verify Menu Result Datatable    1    menuname    should be    ${menuname}
      commonkeywords.Click button on list page    ${1ROW_MENU_ACTION}[delete]

      IF   '${isConfirm}'=='Yes' and '${haveSubmenu}'!='Yes'
            commonkeywords.Click Yes Button for confirm
            commonkeywords.Click OK Button
            commonkeywords.Wait Loading progress
            commonkeywords.Verify Page Name is correct    Menu Management
            commonkeywords.Click Expand Search Criteria
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYMENU_SEL}         ${MENUSEARCHBY}[menuname]
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHMENU_KEYWORD}       ${menuname}
            commonkeywords.Click button on list page            ${LOCATOR_SEARCHMENU_BTN}
            commonkeywords.Wait Loading progress
            commonkeywords.Click Hide Search Criteria
            commonkeywords.Verify data table result is No Record Found    ${ROW_MENU_TBODY}
            Log To Console      \nTEST CASE 'Confirm Delete Menu' VERIFIED.


      ELSE IF   '${isConfirm}'=='No'
            commonkeywords.Click No Button for Cancel
            commonkeywords.Wait Loading progress
            commonkeywords.Verify Page Name is correct    Menu Management
            commonkeywords.Click Expand Search Criteria
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYMENU_SEL}         ${MENUSEARCHBY}[menuname]
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHMENU_KEYWORD}       ${menuname}
            commonkeywords.Click button on list page            ${LOCATOR_SEARCHMENU_BTN}
            commonkeywords.Wait Loading progress
            commonkeywords.Click Hide Search Criteria
            pagemenumgt.Verify Menu Result Datatable    1    menuname    should be    ${menuname}
            Log To Console      \nTEST CASE 'Cancel Delete Menu' VERIFIED.

      ELSE IF   '${haveSubmenu}'=='Yes'
            commonkeywords.Click Yes Button for confirm
            commonkeywords.Verify Modal Title message      Error
            commonkeywords.Verify Modal Content message    delete failure
            commonkeywords.Click OK Button
            pagemenumgt.Verify Menu Result Datatable    1    menuname    should be    ${menuname}
            Log To Console      \nTEST CASE 'Cannot delete main menu (Main menu has submenu)' VERIFIED.
      END

      IF  '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
          Log To Console    \nTest User Management Standard Version
          commonkeywords.Go to SUBMENU name               ${mainmenu}[configuration]      ${submenu}[roleMgt]
          commonkeywords.Verify Page Name is correct      Role Management
          commonkeywords.Click button on list page        ${LOCATOR_ADDROLE_BTN}
          commonkeywords.Verify Page Name is correct      Add Role

          IF  '${isConfirm}'=='Yes' and '${haveSubmenu}'!='Yes'
                pageRoleMgt.Verify checkbox role menu not found    ${menuname}
          ELSE IF   '${isConfirm}'=='No' or '${haveSubmenu}'=='Yes'
                pageRoleMgt.Verify checkbox role menu state        ${menuname}         False
          END

      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
          Log To Console    \nTest User Management IE5DEV Version
          commonkeywords.Go to SUBMENU name                         ${mainmenu}[configuration]      ${submenu}[ctypeMgt]
          commonkeywords.Verify Page Name is correct                Company Type Management
          commonkeywords.Click button on list page                  ${LOCATOR_CTYPEMGT_ADD_BTN}
          commonkeywords.Verify Page Name is correct                Add Company Type

          IF  '${isConfirm}'=='Yes' and '${haveSubmenu}'!='Yes'
                pageComTypeMgt.Verify checkbox company type menu not found    ${menuname}
          ELSE IF   '${isConfirm}'=='No' or '${haveSubmenu}'=='Yes'
                pageComTypeMgt.Verify checkbox company type menu state        ${menuname}         False
          END

     ELSE
          Fail    \nPlease Check 'GLOBAL_STANDARD_VERSION' should any 'STANDARD' or 'IE5DEV'
     END
