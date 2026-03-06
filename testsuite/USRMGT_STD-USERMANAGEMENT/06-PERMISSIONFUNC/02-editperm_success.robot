*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               datasources.Import DataSource PERMISSION INFO DATA
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               commonkeywords.Initialize System and Go to Login Page

...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[permMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[permMgt]

...               AND               service-permmgt.Request Service Delete by Permission Code
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   permcode=${DS_PERM['addnew'][${perm_col.permCode}]}
...               AND               service-permmgt.Request Service Delete by Permission Code
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   permcode=${DS_PERM['editdata'][${perm_col.permCode}]}

...               AND               service-permmgt.Request Service Create Permission
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   permcode=${DS_PERM['addnew'][${perm_col.permCode}]}


Suite Teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               service-permmgt.Request Service Delete by Permission Code
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   permcode=${DS_PERM['addnew'][${perm_col.permCode}]}
...               AND               service-permmgt.Request Service Delete by Permission Code
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   permcode=${DS_PERM['editdata'][${perm_col.permCode}]}

...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser


*** Test Cases ***
CASE01-Edit Permission code

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
    
      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYPERM_SEL}         ${PERMSEARCHBY}[permcode]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHPERM_KEYWORD}       ${DS_PERM['addnew'][${perm_col.permCode}]}
      commonkeywords.Click button on list page    ${LOCATOR_SEARCHPERM_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Click Hide Search Criteria

      pagePermMgt.Verify Permission Result Datatable    1    permissioncode    should be    ${DS_PERM['addnew'][${perm_col.permCode}]}
      commonkeywords.Click button on list page      ${1ROW_PERM_ACTION}[edit]

      commonkeywords.Verify Page Name is correct      Edit Permission
      commonkeywords.Verify data form         ${LOCATOR_PERMCODE_FIELD}    should be    ${DS_PERM['addnew'][${perm_col.permCode}]}
      commonkeywords.Fill in data form        ${LOCATOR_PERMCODE_FIELD}    ${DS_PERM['editdata'][${perm_col.permCode}]}
      commonkeywords.Click button on detail page    ${LOCATOR_PERMSAVE_BTN}
      commonkeywords.Verify Modal Title message     Success
      commonkeywords.Click OK Button


      # ASSERTION
      # verify record in permission list
      commonkeywords.Wait Loading progress
      commonkeywords.Verify Page Name is correct    Permission Management
      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYPERM_SEL}         ${PERMSEARCHBY}[permcode]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHPERM_KEYWORD}       ${DS_PERM['addnew'][${perm_col.permCode}]}
      commonkeywords.Click button on list page    ${LOCATOR_SEARCHPERM_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Verify data table result is No Record Found     ${ROW_PERM_TBODY}
      commonkeywords.Click button on list page      ${LOCATOR_CLEARSEARCHPERM_BTN}
      commonkeywords.Wait Loading progress

      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYPERM_SEL}         ${PERMSEARCHBY}[permcode]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHPERM_KEYWORD}       ${DS_PERM['editdata'][${perm_col.permCode}]}
      commonkeywords.Click button on list page    ${LOCATOR_SEARCHPERM_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Click Hide Search Criteria

      pagePermMgt.Verify Permission Result Datatable    1    permissioncode    should be    ${DS_PERM['editdata'][${perm_col.permCode}]}

      #verify permission data info
      commonkeywords.Click button on list page      ${1ROW_PERM_ACTION}[edit]
      commonkeywords.Verify Page Name is correct    Edit Permission
      commonkeywords.Wait Loading progress
      commonkeywords.Verify data form               ${LOCATOR_PERMCODE_FIELD}    should be    ${DS_PERM['editdata'][${perm_col.permCode}]}
      commonkeywords.Click xClose button            ${LOCATOR_XCLOSEPERM_BTN}
      commonkeywords.Verify Page Name is correct    Permission Management

      Log To Console      \nTEST CASE VERIFIED.
