*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test
...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               datasources.Import DataSource COMPANY TYPE INFO DATA

...               AND               commonkeywords.Generate Random Values    lengthno=3    lenghtletter=2

...               AND               Set Suite Variable     ${default_mainmenu}          ${JS_DEFAULTDATA['menudata'][0]}[menuname]
...               AND               Set Suite Variable     ${default_submenu1}          ${JS_DEFAULTDATA['menudata'][1]}[menuname]
...               AND               Set Suite Variable     ${default_submenu2}          ${JS_DEFAULTDATA['menudata'][2]}[menuname]
...               AND               Set Suite Variable     ${default_submenu3}          ${JS_DEFAULTDATA['menudata'][3]}[menuname]
...               AND               Set Suite Variable     ${default_submenu4}          ${JS_DEFAULTDATA['menudata'][4]}[menuname]

...               AND               Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='STANDARD'          \nExecute Test Only IE5DEV Version

...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Login System     ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}

...               AND               service-ctypemgt.Request Service Add Company Type Data
...                                   ${DS_LOGIN['robotapi'][${login_col.username}]}      ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   ${CTYPE_ID}[legal]
...                                   Robotx Typex
...                                   ${default_mainmenu}     ${default_submenu1}     ${default_submenu2}     ${default_submenu3}

...               AND               service-ctypemgt.Request Service Add Company Type Data
...                                   ${DS_LOGIN['robotapi'][${login_col.username}]}      ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   ${CTYPE_ID}[person]
...                                   Bottestx01 Type Personx
...                                   ${default_mainmenu}     ${default_submenu1}     ${default_submenu2}     ${default_submenu3}

...               AND               service-ctypemgt.Request Service Add Company Type Data
...                                   ${DS_LOGIN['robotapi'][${login_col.username}]}      ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   ${CTYPE_ID}[legal]
...                                   Autobotx Typed01
...                                   ${default_mainmenu}     ${default_submenu1}     ${default_submenu2}     ${default_submenu3}

...               AND               commonkeywords.Go to SUBMENU name               ${mainmenu}[configuration]      ${submenu}[ctypeMgt]
...               AND               commonkeywords.Verify Page Name is correct      Company Type Management
...               AND               commonkeywords.Wait Loading progress
...               AND               commonkeywords.Click Expand Search Criteria

Test Template     Template Company Type Search Function

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='STANDARD'          \nExecute Test Only IE5DEV Version
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
#-----------------------------------------------------------------------------------------------------------------------------------------------------#
#                             CASE NAME                       |  Case Type    |           Search By           |            Search Keyword             #
#-----------------------------------------------------------------------------------------------------------------------------------------------------#

CASE-Search by Company Type is Legal                                  P         ${COMTYPESEARCHBY}[ctype]         ${CTYPETH}[legal]
CASE-Search by Company Type is Person                                 P         ${COMTYPESEARCHBY}[ctype]         ${CTYPETH}[person]
CASE-Search by Company Type Name > Full Search                        P         ${COMTYPESEARCHBY}[ctypename]     Robotx Typex
CASE-Search by Company Type Name > Partail Search (Start wording)     P         ${COMTYPESEARCHBY}[ctypename]     Bottestx01
CASE-Search by Company Type Name > Partail Search (Middle wording)    E         ${COMTYPESEARCHBY}[ctypename]     botx Type
CASE-Search by Company Type Name > Partail Search (Last wording)      E         ${COMTYPESEARCHBY}[ctypename]     Personx

*** Keywords ***
Template Company Type Search Function
    [Arguments]     ${casetype}     ${searchby}     ${keyword}

      Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='STANDARD'          \nExecute Test Only IE5DEV Version

      commonkeywords.Fill in search field on list page    ${LOCATOR_CTYPEMGT_SEARCHBY_SEL}              ${searchby}
      commonkeywords.Fill in search field on list page    ${LOCATOR_CTYPEMGT_SEARCHKEYWORD_SEL}         ${keyword}
      commonkeywords.Click button on list page            ${LOCATOR_CTYPEMGT_SEARCH_BTN}
      commonkeywords.Wait Loading progress
      pageComTypeMgt.Verify Company Type Result Data Table for search function    ${casetype}     ${searchby}     ${keyword}
