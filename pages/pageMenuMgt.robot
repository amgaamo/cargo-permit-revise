*** Settings ***
Resource    ../resources/commonkeywords.resource

*** Variables ***
${LOCATOR_ADDMENU_BTN}               //*[@id="mmnl-add-btn"]
${LOCATOR_XCLOSEMENU_BTN}            //*[@id="mmnc-close-btn"]

${LOCATOR_SEARCHBYMENU_SEL}          select[name="mmnl-search-by"]
${LOCATOR_SEARCHMENU_KEYWORD}        //*[@id="mmnl-search-keyword"]
${LOCATOR_SEARCHMENU_BTN}            //*[@id="mmnl-search-btn"]
${LOCATOR_CLEARSEARCHMENU_BTN}       //*[@id="mmnl-clearsearch-btn"]
${LOCATOR_MENUCANCEL_BTN}            //*[@id="umnc-cancel-btn"]
${LOCATOR_MENUSAVE_BTN}              //*[@id="umnc-save-btn"]

${LOCATOR_MENU_LIST}                 //*[@id="mmnl-items-list"]

# Menu Field
${LOCATOR_MENUNAME_FIELD}             //*[@id="mmnc-menu-name"]
${LOCATOR_MENUURL_FIELD}              //*[@id="mmnc-menu-url"]
${LOCATOR_MENUICON_FIELD}             //*[@id="mmnc-menu-icon"]
${LOCATOR_MENUORDER_FIELD}            //*[@id="mmnc-menu-order"]
${LOCATOR_MENUSWITCHSUB_CHK}          //*[@for="mmnc-menu-is-submenu"]
${LOCATOR_MENUSWITCH_CHK}             //*[@id="mmnc-menu-is-submenu"]
${LOCATOR_MENUPARENT_SEL}             select[name="mmnc-menu-parent-id"]

#Warning Menu Info Span
${LOCATOR_WARN_MENUNAME}              //*[contains(@class,'card-body')]/form/div[1]/div[1]/div/div/span
${LOCATOR_WARN_MENUURL}               //*[contains(@class,'card-body')]/form/div[1]/div[2]/div/div/span
${LOCATOR_WARN_MENUORDER}             //*[contains(@class,'card-body')]/form/div[2]/div[2]/div/div/span
${LOCATOR_WARN_MENUPARENT}            //*[contains(@class,'card-body')]/form/div[3]/div/div/div/span

#Warning Message
&{MENU_REQUIREWARNMSG}        menuname=Menu Name is required     menuurl=Menu Url is required   menuparent=Menu Parent Id is required     menuorder=Menu Order is required

${MENU_NORECORD_FOUND}       //*[@id="mmnl-items-list"]/tbody/tr/td

#Menu Data table
${MENU_THEAD}                //*[@id="mmnl-items-list"]/thead
${ROW_MENU_TBODY}            //*[@id="mmnl-items-list"]/tbody
&{1ROW_MENU_ACTION}          edit=//*[@id="mmnl-items-edit-0"]     delete=//*[@id="mmnl-items-del-0"]
&{MENUSEARCHBY}              menuname=Menu Name         menuurl=Menu Url

*** Keywords ***
Fill in menu data info
    [Arguments]   ${menuname}   ${menuurl}   ${menuicon}   ${menuorder}

      commonkeywords.Fill in data form    ${LOCATOR_MENUNAME_FIELD}           ${menuname}
      commonkeywords.Fill in data form    ${LOCATOR_MENUURL_FIELD}            ${menuurl}
      commonkeywords.Fill in data form    ${LOCATOR_MENUICON_FIELD}           ${menuicon}
      commonkeywords.Fill in data form    ${LOCATOR_MENUORDER_FIELD}          ${menuorder}

Check Switch to Sub Menu
      Check Checkbox        ${LOCATOR_MENUSWITCHSUB_CHK}
      Get Checkbox State    ${LOCATOR_MENUSWITCH_CHK}    should be      True

Uncheck Switch to Sub Menu
      Uncheck Checkbox       ${LOCATOR_MENUSWITCHSUB_CHK}
      Get Checkbox State     ${LOCATOR_MENUSWITCH_CHK}     should be      False

Verify menu data info
    [Arguments]   ${menuname}   ${menuurl}   ${menuicon}   ${menuorder}

      commonkeywords.Verify data form     ${LOCATOR_MENUNAME_FIELD}      should be     ${menuname}
      commonkeywords.Verify data form     ${LOCATOR_MENUURL_FIELD}       should be     ${menuurl}
      commonkeywords.Verify data form     ${LOCATOR_MENUICON_FIELD}      should be     ${menuicon}
      commonkeywords.Verify data form     ${LOCATOR_MENUORDER_FIELD}     should be     ${menuorder}

Verify Menu Result Datatable
    [Arguments]     ${rowdata}    ${columnname}     ${assertion}    ${expresult}
      commonkeywords.Get Column of Data Table   ${MENU_THEAD}
      Set Local Variable    ${MENU_COL}    ${col_datatable}
      commonkeywords.verify result data table on list page    ${ROW_MENU_TBODY}    ${MENU_COL}[${columnname}]    ${assertion}    ${expresult}   ${rowdata}


Verify Menu Result Data Table for search function
      [Arguments]    ${casetype}    ${searchby}    ${searchkeyword}

        commonkeywords.Get row entries of Data Table      ${ROW_MENU_TBODY}

          IF    '${casetype}'=='P'
                    Should Be True    '${GLOBAL_ENTRIES_RESULTOFPAGE}'!='0'
              IF   '${searchby}'=='${MENUSEARCHBY}[menuname]'
                    Verify Menu Result Datatable    all    menuname    contains    ${searchkeyword}
                    Log To Console      \nTEST CASE VERIFIED: Positive Case-${MENUSEARCHBY}[menuname]
              ELSE IF   '${searchby}'=='${MENUSEARCHBY}[menuurl]'
                    Verify Menu Result Datatable    all    menuurl    contains    ${searchkeyword}
                    Log To Console      \nTEST CASE VERIFIED: Positive Case-${MENUSEARCHBY}[menuurl]
              ELSE
                    Fail    Check condition "Check Result Menu Data records correct" keyword !!!
              END
          ELSE IF   '${casetype}'=='E'
                Should Be True    '${GLOBAL_ENTRIES_RESULTOFPAGE}'=='0'
                commonkeywords.Verify data table result is No Record Found    ${ROW_MENU_TBODY}
                Log To Console      \nTEST CASE VERIFIED: Negative Cases
          ELSE
                Fail    \nCheck condition "Verify Menu Result Data Table for search function" keyword !!!
          END
