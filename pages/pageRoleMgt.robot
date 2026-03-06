*** Settings ***
Resource    ../resources/commonkeywords.resource

*** Variables ***
${LOCATOR_ADDROLE_BTN}               //*[@id="rmnl-add-btn"]
${LOCATOR_XCLOSEROLE_BTN}            //*[@id="rmnc-x-btn"]

${LOCATOR_SEARCHBYROLE_SEL}          select[name="rmnl-search-by"]
${LOCATOR_SEARCHROLE_KEYWORD}        //*[@formcontrolname="searchKeyword"]
${LOCATOR_SEARCHROLE_BTN}            //*[@id="rmnl-search-btn"]
${LOCATOR_CLEARSEARCHROLE_BTN}       //*[@id="rmnl-clearsearch-btn"]
${LOCATOR_ROLECANCEL_BTN}            //*[@id="umnc-cancel-btn"]
${LOCATOR_ROLEPSAVE_BTN}             //*[@id="umnc-save-btn"]

${LOCATOR_ROLE_LIST}                 //*[@id="rmnl-items-list"]

# Role Field
${LOCATOR_COMPANYROLE_SEL}           //*[@id="rmnc-role-company"]
${LOCATOR_ROLENAME_FIELD}            //*[@id="rmnc-role-name"]

#Warning Role Info Span
${LOCATOR_WARN_ROLENAME}             //*[contains(@class,'card-body')]/form/div[1]/div/div/div
${LOCATOR_WARN_COMROLENAME}          //*[contains(@class,'card-body')]/form/div[1]/div/div/div
${LOCATOR_WARN_IE5DEVROLENAME}       //*[contains(@class,'card-body')]/form/div[2]/div/div/div

#Warning Message
&{ROLE_REQUIREWARNMSG}        roleName=Role Name is required
...                           comName=Please select company
&{ROLE_OTHRWARNMSG}           duplicate=Duplicate Role Name

#Role Data table
${ROLE_THEAD}              //*[@id="rmnl-items-list"]/thead
${ROW_ROLE_TBODY}          //*[@id="rmnl-items-list"]/tbody
&{1ROW_ROLE_ACTION}        edit=//*[@id="rmnl-items-edit-0"]
&{ROLESEARCHBY}            rolename=Role Name
...                        companyname=Company Name

*** Keywords ***
Check checkbox role menu
   [Arguments]    ${menuname}
         ${getlocator}=             Get Attribute        //label[contains(text(),'${menuname}')]         for
         Check Checkbox             //*[@id="${getlocator}"]
         Get Checkbox State         //*[@id="${getlocator}"]     should be      True

Uncheck checkbox role menu
   [Arguments]    ${menuname}
         ${getlocator}=             Get Attribute        //label[contains(text(),'${menuname}')]         for
         Uncheck Checkbox           //*[@id="${getlocator}"]
         Get Checkbox State         //*[@id="${getlocator}"]     should be      False

Check checkbox role permission
   [Arguments]    ${permission}
         ${getlocator}=             Get Attribute        //label[contains(text(),'${permission}')]       for
         Check Checkbox             //*[@id="${getlocator}"]
         Get Checkbox State         //*[@id="${getlocator}"]     should be      True

Uncheck checkbox role permission
   [Arguments]    ${permission}
         ${getlocator}=             Get Attribute        //label[contains(text(),'${permission}')]       for
         Uncheck Checkbox           //*[@id="${getlocator}"]
         Get Checkbox State         //*[@id="${getlocator}"]     should be      False

Verify checkbox role menu state
   [Arguments]    ${menuname}    ${statecheck}
         ${getlocator}=             Get Attribute        //label[contains(text(),'${menuname}')]         for
         commonkeywords.Verify Field State               //label[contains(text(),'${menuname}')]         visible
         Get Checkbox State          //*[@id="${getlocator}"]    should be      ${statecheck}


Verify checkbox role permission state
   [Arguments]    ${permission}    ${statecheck}
         ${getlocator}=             Get Attribute        //label[contains(text(),'${permission}')]       for
         commonkeywords.Verify Field State               //label[contains(text(),'${permission}')]       visible
         Get Checkbox State          //*[@id="${getlocator}"]    should be      ${statecheck}

Verify checkbox role menu not found
   [Arguments]    ${menuname}
        commonkeywords.Verify Field State    //label[contains(text(),'${menuname}')]     hidden

Verify checkbox role permission not found
   [Arguments]    ${permission}
        commonkeywords.Verify Field State    //label[contains(text(),'${permission}')]    hidden

Verify Amount Menu Checkbox
    [Arguments]   ${typemenu}     ${amount}

        ${amountmenu}=       Get Element Count     //*[@id="role-menu"]/li/ul/li
        Should Be True      '${submenu}'=='4'

Verify Role Result Datatable
    [Arguments]     ${rowdata}    ${columnname}     ${assertion}    ${expresult}
      commonkeywords.Get Column of Data Table   ${ROLE_THEAD}
      Set Local Variable    ${ROLE_COL}    ${col_datatable}
      commonkeywords.verify result data table on list page    ${ROW_ROLE_TBODY}    ${ROLE_COL}[${columnname}]    ${assertion}    ${expresult}   ${rowdata}


Verify Role Result Data Table for search function
      [Arguments]    ${casetype}    ${searchby}    ${searchkeyword}

        commonkeywords.Get row entries of Data Table      ${ROW_ROLE_TBODY}

          IF    '${casetype}'=='P'
                    Should Be True    '${GLOBAL_ENTRIES_RESULTOFPAGE}'!='0'
              IF   '${searchby}'=='${ROLESEARCHBY}[rolename]'
                    Verify Role Result Datatable      all    rolename    contains    ${searchkeyword}
                    Log To Console      \nTEST CASE VERIFIED: Positive Case-${ROLESEARCHBY}[rolename]
              ELSE
                    Fail    Check condition "Check Result Role Data records correct" keyword !!!
              END
          ELSE IF   '${casetype}'=='E'
                Should Be True    '${GLOBAL_ENTRIES_RESULTOFPAGE}'=='0'
                commonkeywords.Verify data table result is No Record Found    ${ROW_ROLE_TBODY}
                Log To Console      \nTEST CASE VERIFIED: Negative Cases

          ELSE IF   '${casetype}'=='X'
              IF   '${VAR_USERMGTSTD_VERSION}'=='IE5DEV'
                    Should Be True    '${GLOBAL_ENTRIES_RESULTOFPAGE}'!='0'
                    Verify Role Result Datatable      all    companyname    contains    ${searchkeyword}
                    Log To Console      \nTEST CASE VERIFIED: Positive Case-${ROLESEARCHBY}[companyname]
              ELSE IF   '${VAR_USERMGTSTD_VERSION}'=='STANDARD'
                    Log To Console      \nExecute Test only IE5DEV Version
              ELSE
                  Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'IE5DEV' or STANDARD
              END
          ELSE
                Fail    \nCheck condition "Verify Role Result Data Table for search function" keyword !!!
          END
