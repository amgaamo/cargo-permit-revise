*** Settings ***
Resource    ../resources/commonkeywords.resource

*** Variables ***
${LOCATOR_ADDGROUP_BTN}               //*[@id="gmnl-add-btn"]
${LOCATOR_XCLOSEGROUP_BTN}            //*[@id="gmnc-close-btn"]

${LOCATOR_SEARCHBYGROUP_SEL}          select[name="gmnl-search-by"]
${LOCATOR_SEARCHGROUP_KEYWORD}        //*[@formcontrolname="searchKeyword"]
${LOCATOR_SEARCHGROUP_BTN}            //*[@id="gmnl-search-btn"]
${LOCATOR_CLEARSEARCHGROUP_BTN}       //*[@id="gmnl-clearsearch-btn"]
${LOCATOR_GROUPCANCEL_BTN}            //*[@id="gmnc-cancel-btn"]
${LOCATOR_GROUPSAVE_BTN}              //*[@id="gmnc-save-btn"]

${LOCATOR_GROUP_LIST}                 //*[@id="gmnl-items-list"]

#Group Field
${LOCATOR_GROUPCOMPANY_SEL}           select[name=umnc-company]
${LOCATOR_GROUPNAME_FIELD}            //*[@id="gmnc-group-name"]
${LOCATOR_GROUPLIMITUSER_FIELD}       //*[@id="gmnc-limit-user"]
${LOCATOR_GROUPUNLIMITUSER_CHK}       //*[@id="gmnc-limit-user-checked"]

${LOCATOR_GROUPAPPROVAL_FIELD}        //*[@id="umnc-approve"]
${LOCATOR_GROUP_GROUPAPPV_FIELD}      //*[@id="umnc-approval-id"]

#Warning Group Info Span
${LOCATOR_WARN_GROUPCOMPANY}          //*[contains(@class,'card-body')]/form/div[1]/div/div/div/span
${LOCATOR_WARN_GROUPNAME}             //*[contains(@class,'card-body')]/form/div[2]/div[1]/div/div/span
${LOCATOR_WARN_GROUPLIMITUSER}        //*[contains(@class,'card-body')]/form/div[2]/div[2]/div/div[2]/span
${LOCATOR_WARN_GROUPROLE}             //*[@class="role-error-text"]

${LOCATOR_WARN_GROUPAPPVAL}           //*[contains(@class,'card-body')]/form/div[3]/div[1]/div/div/span
${LOCATOR_WARN_GROUP_GROUPAPPV}       //*[contains(@class,'card-body')]/form/div[3]/div[2]/div/div/span

#Warning Message
&{GROUP_REQUIREWARNMSG}        company=Please select company            groupName=Group Name is required        limitUser=Limit Users is required          role=Role is required
...                            approval=Please select approval          groupappv=Please select group approval

${GROUP_ROLENOTFOUND_WARNMSG}    Role not found

${GROUP_NORECORD_FOUND}         //*[@id="gmnl-items-list"]/tbody/tr/td

#Group Data table
&{1ROW_GROUP_ACTION}        edit=//*[@id="gmnl-items-edit-0"]      changeStatus=//*[@id="gmnl-change-status-btn"]
${GROUP_THEAD}             //*[@id="gmnl-items-list"]/thead
${ROW_GROUP_TBODY}         //*[@id="gmnl-items-list"]/tbody

&{GROUPSEARCHBY}            groupname=Group Name      comname=Company Name
&{GROUPSTATUS}              active=Active             inactive=Inactive

*** Keywords ***
Check checkbox role group
   [Arguments]    ${rolename}
         Check Checkbox             //*[@title="Roles ${rolename}"]
         Get Checkbox State         //*[@title="Roles ${rolename}"]     should be      True

Uncheck checkbox role group
   [Arguments]    ${rolename}
         Uncheck Checkbox            //*[@title="Roles ${rolename}"]
         Get Checkbox State         //*[@title="Roles ${rolename}"]     should be      False


Verify checkbox role group state
   [Arguments]    ${rolename}    ${statecheck}
        commonkeywords.Verify Field State      //*[@title="Roles ${rolename}"]        visible
         Get Checkbox State         //*[@title="Roles ${rolename}"]     should be      ${statecheck}

Verify checkbox role group not found
   [Arguments]    ${rolename}
        commonkeywords.Verify Field State     //*[@title="Roles ${rolename}"]      hidden

Verify checkbox role menu group state
   [Arguments]    ${menuname}    ${statecheck}
         ${getlocator}=             Get Attribute        //label[contains(text(),'${menuname}')]         for
         commonkeywords.Verify Field State    //*[@id="${getlocator}"]      visible
         Get Checkbox State                   //*[@id="${getlocator}"]      should be      ${statecheck}

Verify checkbox role menu group not found
    [Arguments]    ${menuname}
        commonkeywords.Verify Field State     //label[contains(text(),'${menuname}')]       hidden

Verify Group Result Datatable
    [Arguments]     ${rowdata}    ${columnname}     ${assertion}    ${expresult}
      commonkeywords.Get Column of Data Table    ${GROUP_THEAD}
      Set Local Variable    ${GROUP_COL}    ${col_datatable}
      commonkeywords.verify result data table on list page    ${ROW_GROUP_TBODY}    ${GROUP_COL}[${columnname}]    ${assertion}    ${expresult}   ${rowdata}

Verify Group Result Data Table for search function
      [Arguments]    ${casetype}      ${searchby}       ${searchkeyword}

        commonkeywords.Get row entries of Data Table      ${ROW_GROUP_TBODY}

          IF    '${casetype}'=='P'
                    Should Be True    '${GLOBAL_ENTRIES_RESULTOFPAGE}'!='0'
              IF  '${searchby}'=='${GROUPSEARCHBY}[comname]'
                    Verify Group Result Datatable    all    companyname    contains    ${searchkeyword}
                    Log To Console      \nTEST CASE VERIFIED: Positive Case-${GROUPSEARCHBY}[comname]
              ELSE IF   '${searchby}'=='${GROUPSEARCHBY}[groupname]'
                    Verify Group Result Datatable    all    groupname    contains      ${searchkeyword}
                    Log To Console      \nTEST CASE VERIFIED: Positive Case-${GROUPSEARCHBY}[groupname]
              ELSE
                    Fail    Check condition "Check Result Group Data records correct" keyword !!!
              END
          ELSE IF   '${casetype}'=='E'
                Should Be True    '${GLOBAL_ENTRIES_RESULTOFPAGE}'=='0'
                commonkeywords.Verify data table result is No Record Found    ${ROW_GROUP_TBODY}
                Log To Console      \nTEST CASE VERIFIED: Negative Cases
          ELSE
                Fail    \nCheck condition "Verify Group Result Data Table for search function" keyword !!!
          END
