*** Settings ***
Resource    ../resources/commonkeywords.resource

*** Variables ***
${LOCATOR_ADDPERM_BTN}               //*[@id="perm-add-btn"]
${LOCATOR_XCLOSEPERM_BTN}            //*[@id="umnc-close-btn"]

${LOCATOR_SEARCHBYPERM_SEL}          select[name="perm-search-by"]
${LOCATOR_SEARCHPERM_KEYWORD}        //*[@id="perm-search-keyword"]
${LOCATOR_SEARCHPERM_BTN}            //*[@id="perm-search-btn"]
${LOCATOR_CLEARSEARCHPERM_BTN}       //*[@id="perm-clearsearch-btn"]
${LOCATOR_PERMCANCEL_BTN}            //*[@id="umnc-cancel-btn"]
${LOCATOR_PERMSAVE_BTN}             //*[@id="umnc-save-btn"]

${LOCATOR_PERM_LIST}                 //*[@id="perm-items-list"]

# Permission Field
${LOCATOR_PERMCODE_FIELD}            //*[@id="perm-code"]

#Warning Role Info Span
${LOCATOR_WARN_PERMCODE}             //*[contains(@class,'card-body')]/form/div/div/div/div/span

#Warning Message
&{PERM_REQUIREWARNMSG}        permcode=Permission Code is required
&{PERM_OTHRWARNMSG}           duplicate=Duplicate Permission Code
${PERM_NORECORD_FOUND}       //*[@id="perm-items-list"]/tbody/tr/td

#Role Data table
${PERM_THEAD}                 //*[@id="perm-items-list"]/thead
${ROW_PERM_TBODY}             //*[@id="perm-items-list"]/tbody

&{1ROW_PERM_ACTION}           edit=//*[@id="perm-items-edit-0"]      delete=//*[@id="perm-items-del-0"]
&{PERMSEARCHBY}               permcode=Permission Code

*** Keywords ***
Verify Permission Result Datatable
    [Arguments]     ${rowdata}    ${columnname}     ${assertion}    ${expresult}
      commonkeywords.Get Column of Data Table   ${PERM_THEAD}
      Set Local Variable    ${PERMISSON_COL}    ${col_datatable}
      commonkeywords.verify result data table on list page    ${ROW_PERM_TBODY}    ${PERMISSON_COL}[${columnname}]    ${assertion}    ${expresult}   ${rowdata}


Verify Permission Result Data Table for search function
      [Arguments]    ${casetype}    ${searchby}    ${searchkeyword}

        commonkeywords.Get row entries of Data Table      ${ROW_PERM_TBODY}

          IF    '${casetype}'=='P'
                    Should Be True    '${GLOBAL_ENTRIES_RESULTOFPAGE}'!='0'
              IF   '${searchby}'=='${PERMSEARCHBY}[permcode]'
                    Verify Permission Result Datatable    all    permissioncode    contains    ${searchkeyword}
                    Log To Console      \nTEST CASE VERIFIED: Positive Case-${PERMSEARCHBY}[permcode]
              ELSE
                    Fail    Check condition "Check Result Permission Data records correct" keyword !!!
              END
          ELSE IF   '${casetype}'=='E'
                Should Be True    '${GLOBAL_ENTRIES_RESULTOFPAGE}'=='0'
                commonkeywords.Verify data table result is No Record Found    ${ROW_PERM_TBODY}
                Log To Console      \nTEST CASE VERIFIED: Negative Cases
          ELSE
                Fail    \nCheck condition "Verify Permission Result Data Table for search function" keyword !!!
          END
