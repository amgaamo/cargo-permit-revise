*** Settings ***
Resource    ../resources/commonkeywords.resource

*** Variables ***
${LOCATOR_CTYPEMGT_ADD_BTN}                   //*[@id="rmnl-add-btn"]
${LOCATOR_XCLOSECTYPE_BTN}                    //*[@id="rmnc-x-btn"]

${LOCATOR_CTYPEMGT_SEARCHBY_SEL}              //*[@id="rmnl-search-by"]
${LOCATOR_CTYPEMGT_SEARCHKEYWORD_SEL}         //*[@formcontrolname="searchKeyword"]

${LOCATOR_CTYPEMGT_SEARCH_BTN}                //*[@id="rmnl-search-btn"]
${LOCATOR_CTYPEMGT_CLEAR_BTN}                 //*[@id="rmnl-clearsearch-btn"]

${LOCATOR_CTYPEMGT_COMTYPE_SEL}               //*[@id="ctmnc-company-type-register-type"]
${LOCATOR_CTYPEMGT_CTYPENAME_FIELD}           //*[@id="ctmnc-company-type-name"]

${LOCATOR_CTYPEMGT_SAVE_BTN}                  //*[@id="umnc-save-btn"]
${LOCATOR_CTYPEMGT_CANCEL_BTN}                //*[@id="umnc-cancel-btn"]

${LOCATOR_CTYPEMGT_CTYPE_WARNFIELD}           //*[contains(@class,'card-body')]/form/div[1]/div/div/div/span
${LOCATOR_CTYPEMGT_CTYPENAME_WARNFIELD}       //*[contains(@class,'card-body')]/form/div[2]/div/div/div/span

#Warning Message
&{CTYPEMGT_REQUIREWARNING}            ctype=Company Type is required
...                                   ctypename=Company Name is required
...                                   ctypemenu=Please select less than one menu

${CTYPEMGT_DUPLICATEWARNING}          Duplicate Company Type Name
&{COMTYPESEARCHBY}                    ctype=Company Type
...                                   ctypename=Company Type Name

&{CTYPETH}      legal=นิติบุคคล     person=บุคคลธรรมดา
&{CTYPE_ID}     legal=1           person=2

${CTYPE_ROW1EDIT}       //*[@id="rmnl-items-edit-0"]

${CTYPEMGT_THEAD}       //*[@id="rmnl-items-list"]/thead
${CTYPEMGT_TBODY}       //*[@id="rmnl-items-list"]/tbody


*** Keywords ***
Check checkbox company type menu
   [Arguments]    ${menuname}
         ${getlocator}=             Get Attribute        //label[contains(text(),'${menuname}')]         for
         Check Checkbox             //*[@id="${getlocator}"]
         Get Checkbox State         //*[@id="${getlocator}"]     should be      True

Uncheck checkbox company type menu
   [Arguments]    ${menuname}
         ${getlocator}=             Get Attribute        //label[contains(text(),'${menuname}')]         for
         Uncheck Checkbox           //*[@id="${getlocator}"]
         Get Checkbox State         //*[@id="${getlocator}"]     should be      False

Verify checkbox company type menu state
   [Arguments]    ${menuname}    ${statecheck}
         ${getlocator}=             Get Attribute        //label[contains(text(),'${menuname}')]         for
         commonkeywords.Verify Field State    //*[@id="${getlocator}"]      visible
         Get Checkbox State                   //*[@id="${getlocator}"]      should be      ${statecheck}

Verify checkbox company type menu not found
   [Arguments]    ${menuname}
         commonkeywords.Verify Field State         //label[contains(text(),'${menuname}')]         hidden

Verify Company Type Result Datatable
    [Arguments]     ${rowdata}    ${columnname}     ${assertion}    ${expresult}
      commonkeywords.Get Column of Data Table    ${CTYPEMGT_THEAD}
      Set Local Variable    ${CTYPE_COL}    ${col_datatable}
      commonkeywords.verify result data table on list page    ${CTYPEMGT_TBODY}    ${CTYPE_COL}[${columnname}]    ${assertion}    ${expresult}   ${rowdata}


Verify Company Type Result Data Table for search function
      [Arguments]    ${casetype}    ${searchby}    ${searchkeyword}

        commonkeywords.Get row entries of Data Table      ${CTYPEMGT_TBODY}

          IF    '${casetype}'=='P'
                    Should Be True      '${GLOBAL_ENTRIES_RESULTOFPAGE}'!='0'
              IF  '${searchby}'=='${COMTYPESEARCHBY}[ctype]'
                    Verify Company Type Result Datatable    all    companytype        should be     ${searchkeyword}
                    Log To Console        \nTEST CASE VERIFIED: Positive Case-${COMTYPESEARCHBY}[ctype]
              ELSE IF   '${searchby}'=='${COMTYPESEARCHBY}[ctypename]'
                    Verify Company Type Result Datatable    all    companytypename    contains      ${searchkeyword}
                    Log To Console      \nTEST CASE VERIFIED: Positive Case-${COMTYPESEARCHBY}[ctypename]
              ELSE
                    Fail    Check condition "Check Result Company Type Data records correct" keyword !!!
              END
          ELSE IF   '${casetype}'=='E'
                Should Be True    '${GLOBAL_ENTRIES_RESULTOFPAGE}'=='0'
                commonkeywords.Verify data table result is No Record Found    ${CTYPEMGT_TBODY}
                Log To Console      \nTEST CASE VERIFIED: Negative Cases
          ELSE
                Fail    \nCheck condition "Verify Company Type Result Data Table for search function" keyword !!!
          END
