*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               datasources.Import DataSource COMPANY INFO DATA
...               AND               datasources.Import DataSource GROUP INFO DATA
...               AND               datasources.Import DataSource ROLE INFO DATA
...               AND               Set Suite Variable    ${default_companygroup}        ${JS_DEFAULTDATA['companydata'][1]}[companyname]
...               AND               Set Suite Variable    ${default_companygroup2}       ${JS_DEFAULTDATA['companydata'][3]}[companyname]
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.    
...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               defaultdatalist.Create List Data Test Default Role Value
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[groupMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[groupMgt]

...               AND               service-groupmgt.Request Service Group Management Create data test
...                                       headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}        headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}

...               AND               commonkeywords.Click Expand Search Criteria

Test Template     Template Group Search Function

Test Teardown     Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Click button on list page    ${LOCATOR_CLEARSEARCHGROUP_BTN}
...               AND               commonkeywords.Wait Loading progress

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
#------------------------------------------------------------------------------------------------------------------------------------#
#                             CASE NAME                      |  Case Type   |        Search By        |            Search Keyword             #
#-----------------------------------------------------------------------------------------------------------------------------------#

CASE-Search by company name 1                                       P        ${GROUPSEARCHBY}[comname]        ${default_companygroup}
CASE-Search by company name 2                                       P        ${GROUPSEARCHBY}[comname]        ${default_companygroup2}
CASE-Search by Group name > Full Search                             P        ${GROUPSEARCHBY}[groupname]      ${DS_GROUP['data_2'][${group_col.groupname}]}
CASE-Search by Group name > Partail Search (Start wording)          P        ${GROUPSEARCHBY}[groupname]      Robotgx
CASE-Search by Group name > Partail Search (Middle wording)         E        ${GROUPSEARCHBY}[groupname]      tbot Auto
CASE-Search by Group name > Partail Search (Last wording)           E        ${GROUPSEARCHBY}[groupname]      xAutogroupx

*** Keywords ***
Template Group Search Function
      [Arguments]    ${casetype}    ${searchby}    ${searchkeyword}

        Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
        ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
    
        commonkeywords.Click Expand Search Criteria
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYGROUP_SEL}       ${searchby}
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHGROUP_KEYWORD}     ${searchkeyword}
        commonkeywords.Click button on list page            ${LOCATOR_SEARCHGROUP_BTN}
        commonkeywords.Wait Loading progress
        Sleep   1s
        commonkeywords.Wait Loading progress
        pageGroupMgt.Verify Group Result Data Table for search function    ${casetype}     ${searchby}      ${searchkeyword}
