*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               datasources.Import DataSource COMPANY INFO DATA
...               AND               datasources.Import DataSource GROUP INFO DATA
...               AND               datasources.Import DataSource ROLE INFO DATA
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Generate Random Values    lengthno=3    lenghtletter=3
...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               defaultdatalist.Create List Data Test Default Role Value
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[groupMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[groupMgt]

Test Setup        Run Keywords      commonkeywords.Generate Random Values    lengthno=3    lenghtletter=3
...               AND               Set Test Variable    ${default_companygroup}        ${JS_DEFAULTDATA['companydata'][1]}[companyname]
...               AND               Set Test Variable    ${groupnew_name}               ${DS_GROUP['createnew'][${group_col.groupname}]}${GLOBAL_RANDOMLETTER}${SPACE}${GLOBAL_RANDOMNO}
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.



Test template     Template Change Status Group is success

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
#--------------------------------------------------------------------------------------------------------------------------------------#
#                 CASE                  |           Group Name      |     isActive Data    |     Confirm?     |     Expected Status    #
#--------------------------------------------------------------------------------------------------------------------------------------#
CASE1-Change status ACTIVE to INACTIVE          ${groupnew_name}        true                     Yes                 INACTIVE 
CASE2-Change status INACTIVE to ACTIVE          ${groupnew_name}        false                    Yes                 ACTIVE
CASE3-Cancel to change status                   ${groupnew_name}        true                     No                  ACTIVE

*** Keywords ***
Template Change Status Group is success
   [Arguments]    ${groupnamevalue}    ${isActive}     ${isConfirm}     ${expectedstatus}

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
    
      service-groupmgt.Request Service Create New Group
      ...       ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
      ...       ${default_companygroup}
      ...       ${groupnamevalue}
      ...       ${DS_GROUP['createnew'][${group_col.limituser}]}
      ...       ${isActive}    false     ${EMPTY}
      ...       @{GLOBAL_DEFAULTROLE_LIST}

      commonkeywords.Wait Loading progress
      commonkeywords.Verify Page Name is correct    Group Management
      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYGROUP_SEL}         ${GROUPSEARCHBY}[groupname]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHGROUP_KEYWORD}       ${groupnamevalue}
      commonkeywords.Click button on list page    ${LOCATOR_SEARCHGROUP_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Click Hide Search Criteria
      pageGroupMgt.Verify Group Result Datatable    1    groupname      contains      ${groupnamevalue}

    

      IF  '${isActive}'=='true'
            pageGroupMgt.Verify Group Result Datatable    1    status         should be     ${GROUPSTATUS}[active]
      ELSE
            pageGroupMgt.Verify Group Result Datatable    1    status         should be     ${GROUPSTATUS}[inactive]
      END

      commonkeywords.Click button on list page    ${1ROW_GROUP_ACTION}[changeStatus]
      commonkeywords.Verify Modal Title message    Warning

      IF    '${isConfirm}'=='Yes'
          commonkeywords.Click Yes Button for confirm
          commonkeywords.Click OK Button
      ELSE
          commonkeywords.Click No Button for Cancel
      END

      commonkeywords.Wait Loading progress
      commonkeywords.Verify Page Name is correct    Group Management
      commonkeywords.Click Expand Search Criteria
      commonkeywords.Click button on list page     ${LOCATOR_CLEARSEARCHGROUP_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYGROUP_SEL}         ${GROUPSEARCHBY}[groupname]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHGROUP_KEYWORD}       ${groupnamevalue}
      commonkeywords.Click button on list page    ${LOCATOR_SEARCHGROUP_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Click Hide Search Criteria
      pageGroupMgt.Verify Group Result Datatable    1    status         should be     ${expectedstatus}
      Log To Console      TEST CASE VERIFIED.
