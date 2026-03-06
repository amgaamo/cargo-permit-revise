*** Settings ***
Resource          ../../resources/datasources.resource
Resource          ../../resources/commonkeywords.resource

Suite Setup       Run Keywords    commonkeywords.Initialize System and Go to Login Page
...               AND             datasources.Import DataSource USER LOGIN
...               AND             commonkeywords.Login System                   ${DS_LOGIN['superadmin'][${login_col.username}]}      ${DS_LOGIN['superadmin'][${login_col.password}]}
...               AND             commonkeywords.Go to SUBMENU name             ${mainmenu}[configuration]    ${submenu}[usermgt]
...               AND             commonkeywords.Verify Page Name is correct    ${menuname}[usermgt]
...               AND             commonkeywords.Click Expand Search Criteria

Test Setup        commonkeywords.Click Expand Search Criteria

Test Teardown     Run Keywords    commonkeywords.Click button on list page    ${LOCATOR_CLEAR_BTN}
...               AND             commonkeywords.Click Hide Search Criteria

Suite Teardown    commonkeywords.Release user lock and close all browser

*** Variables ***
${LOCATOR_USRMGT_TBODY}       //*[@id="umnl-items-list"]/tbody
${LOCATOR_SEARCHBY_SEL}       \#umnl-search-by
${LOCATOR_SEARCHKW_FIELD}     //*[@id="umnl-search-keyword"]
${LOCATOR_SEARCH_BTN}         //*[@id="umnl-search-btn"]
${LOCATOR_CLEAR_BTN}          //*[@id="umnl-clearsearch-btn"]

&{columnusrmgt}               name=1    username=2    companyname=3

*** Test Cases ***
CASE-Found 1 record
      commonkeywords.Fill in search field on list page        ${LOCATOR_SEARCHBY_SEL}       Username
      commonkeywords.Fill in search field on list page        ${LOCATOR_SEARCHKW_FIELD}     adminqa
      commonkeywords.Click button on list page                ${LOCATOR_SEARCH_BTN}
      commonkeywords.verify result data table on list page    ${LOCATOR_USRMGT_TBODY}       ${columnusrmgt}[username]   contains    adminqa

CASE-Found 0 records
      commonkeywords.Fill in search field on list page        ${LOCATOR_SEARCHBY_SEL}       Username
      commonkeywords.Fill in search field on list page        ${LOCATOR_SEARCHKW_FIELD}     not found
      commonkeywords.Click button on list page                ${LOCATOR_SEARCH_BTN}
      commonkeywords.Verify data table result is No Record Found     ${LOCATOR_USRMGT_TBODY}

CASE-Found > 1 records
      commonkeywords.Fill in search field on list page        ${LOCATOR_SEARCHBY_SEL}       Username
      commonkeywords.Fill in search field on list page        ${LOCATOR_SEARCHKW_FIELD}     admin
      commonkeywords.Click button on list page                ${LOCATOR_SEARCH_BTN}
      commonkeywords.verify result data table on list page    ${LOCATOR_USRMGT_TBODY}       ${columnusrmgt}[username]    contains    admin
