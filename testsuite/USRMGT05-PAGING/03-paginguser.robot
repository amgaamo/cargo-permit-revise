*** Settings ***
Resource        ../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test
...               AND               Pass Execution If    '${GLOBAL_PAGING_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_PAGING_FUNCTEST is ${GLOBAL_PAGING_FUNCTEST}.
...               AND               datasources.Import DataSource USER LOGIN
...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[usermgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[usermgt]
...               AND               commonkeywords.Click Expand Search Criteria
    
Test Setup        Run Keywords      Pass Execution If    '${GLOBAL_PAGING_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_PAGING_FUNCTEST is ${GLOBAL_PAGING_FUNCTEST}.
...               AND               commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYUSER_SEL}        ${USERSEARCHBY}[username]
...               AND               commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHUSER_KEYWORD}      xbotpaging
...               AND               commonkeywords.Click button on list page            ${LOCATOR_SEARCHUSER_BTN}
...               AND               commonkeywords.Wait Loading progress
...               AND               Sleep    800ms

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_PAGING_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_PAGING_FUNCTEST is ${GLOBAL_PAGING_FUNCTEST}.
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
CASE-Paging is correct
        Pass Execution If    '${GLOBAL_PAGING_FUNCTEST}'=='False'             
        ...                                       \nNo Execute this function: GLOBAL_PAGING_FUNCTEST is ${GLOBAL_PAGING_FUNCTEST}.
        commonkeywords.Get data paging entries of Data Table    ${LOCATOR_PAGING}
        Should Be True    '${GLOBAL_TOTALENTRIES}'=='12'
        Should Be True    '${GLOBAL_SHOWING_PAGE}'=='1'
        Should Be True    '${GLOBAL_SHOWINGPAGE_OF_ENTRIES}'=='10'

        commonkeywords.Page Link of Data Table is visible    2
        commonkeywords.Page Link of Data Table is Active     1
        commonkeywords.Click page number link    2
        commonkeywords.Page Link of Data Table is Active     2
        commonkeywords.Get data paging entries of Data Table    ${LOCATOR_PAGING}
        Should Be True    '${GLOBAL_SHOWING_PAGE}'=='11'
        Should Be True    '${GLOBAL_SHOWINGPAGE_OF_ENTRIES}'=='12'
        
        commonkeywords.Click page number link    1
        commonkeywords.Page Link of Data Table is Active     1
        commonkeywords.Get data paging entries of Data Table    ${LOCATOR_PAGING}
        Should Be True    '${GLOBAL_SHOWING_PAGE}'=='1'
        Should Be True    '${GLOBAL_SHOWINGPAGE_OF_ENTRIES}'=='10'

        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYUSER_SEL}         ${USERSEARCHBY}[username]
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHUSER_KEYWORD}       xbotpaging
        commonkeywords.Click button on list page            ${LOCATOR_SEARCHUSER_BTN}
        commonkeywords.Wait Loading progress
        Sleep    750ms

        commonkeywords.Get data paging entries of Data Table    ${LOCATOR_PAGING}
        Should Be True    '${GLOBAL_TOTALENTRIES}'=='12'
        Should Be True    '${GLOBAL_SHOWING_PAGE}'=='1'
        Should Be True    '${GLOBAL_SHOWINGPAGE_OF_ENTRIES}'=='10'
        commonkeywords.Page Link of Data Table is visible    2
        commonkeywords.Page Link of Data Table is Active     1

CASE-Change Showing Page
        Pass Execution If    '${GLOBAL_PAGING_FUNCTEST}'=='False'             
        ...                                       \nNo Execute this function: GLOBAL_PAGING_FUNCTEST is ${GLOBAL_PAGING_FUNCTEST}.
        commonkeywords.Verify default showing page              ${LOCATOR_SHOWINGPAGE_SEL}    10
        commonkeywords.Get data paging entries of Data Table    ${LOCATOR_PAGING}
        Should Be True    '${GLOBAL_SHOWING_PAGE}'=='1'
        Should Be True    '${GLOBAL_SHOWINGPAGE_OF_ENTRIES}'=='10'
        commonkeywords.Page Link of Data Table is visible    2
        commonkeywords.Page Link of Data Table is Active     1

        #Change showing Page and verify showing entries per page
        commonkeywords.Fill in data form              ${LOCATOR_SHOWINGPAGE_SEL}    25
        sleep   2s
        commonkeywords.Get data paging entries of Data Table    ${LOCATOR_PAGING}
        Should Be True    '${GLOBAL_SHOWING_PAGE}'=='1'
        Should Be True    '${GLOBAL_SHOWINGPAGE_OF_ENTRIES}'=='12'
        commonkeywords.Page Link of Data Table is visible    1
        commonkeywords.Page Link of Data Table is Active     1

        #Go to Page and Search data should verify showing page reset to default
        commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[groupMgt]
        commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[usermgt]
        commonkeywords.Verify Page Name is correct    pagename=${menuname}[usermgt]
        commonkeywords.Click Expand Search Criteria
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYUSER_SEL}         ${USERSEARCHBY}[username]
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHUSER_KEYWORD}       xbotpaging
        commonkeywords.Click button on list page            ${LOCATOR_SEARCHUSER_BTN}
        commonkeywords.Wait Loading progress
        Sleep    750ms

        commonkeywords.Get data paging entries of Data Table    ${LOCATOR_PAGING}
        Should Be True    '${GLOBAL_TOTALENTRIES}'=='12'
        Should Be True    '${GLOBAL_SHOWINGPAGE_OF_ENTRIES}'=='10'
        commonkeywords.Page Link of Data Table is visible    2
        commonkeywords.Page Link of Data Table is Active     1

