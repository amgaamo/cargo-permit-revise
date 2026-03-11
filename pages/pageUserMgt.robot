*** Settings ***
Resource       ../resources/commonkeywords.resource

*** Variables ***
${LOCATOR_ADDUSER_BTN}               //*[@id="umnl-add-btn"]
${LOCATOR_XCLOSEUSER_BTN}            //*[@id="umnc-close-btn"]
${LOCATOR_USERLOCK_ICON}             //*[contains(@class,"fa-lock")]

${LOCATOR_SEARCHBYUSER_SEL}          select[name="umnl-search-by"]
${LOCATOR_SEARCHUSER_KEYWORD}        //*[@formcontrolname="searchKeyword"]
${LOCATOR_SEARCHUSER_BTN}            //*[@id="umnl-search-btn"]
${LOCATOR_CLEARSEARCHUSER_BTN}       //*[@id="umnl-clearsearch-btn"]
${LOCATOR_USERCANCEL_BTN}            //*[@id="umnc-cancel-btn"]
${LOCATOR_USERSAVE_BTN}              //*[@id="umnc-save-btn"]

${LOCATOR_USER_LIST}                 //*[@id="umnl-items-list"]

# USER Field
${LOCATOR_USERCOMPANY_SEL}           select[name="umnc-company"]
${LOCATOR_USERGROUP_SEL}             select[name="umnc-group"]
${LOCATOR_USERUSRNAME_FIELD}         //*[@id="umnc-username"]
${LOCATOR_USERPWD_FIELD}             //*[@id="umnc-password"]
${LOCATOR_USERCFPWD_FIELD}           //*[@id="umnc-confirm-password"]
${LOCATOR_USERFIRSTNAME_FIELD}       //*[@id="umnc-firstname"]
${LOCATOR_USERLASTNAME_FIELD}        //*[@id="umnc-lastname"]
${LOCATOR_USERPHONE_FIELD}           //*[@id="umnc-phone"]
${LOCATOR_USEREMAIL_FIELD}           //*[@id="umnc-email"]

#Warning user Info Span
${LOCATOR_WARN_USERCOMPANY_SEL}           //*[contains(@class,'card-body')]/form/div[1]/div[1]/div/div/span
${LOCATOR_WARN_USERGROUP_SEL}             //*[contains(@class,'card-body')]/form/div[1]/div[2]/div/div/span
${LOCATOR_WARN_USERNAME_FIELD}            //*[contains(@class,'card-body')]/form/div[2]/div[1]/div/div/span
${LOCATOR_WARN_USERPWD_FIELD}             //*[contains(@class,'card-body')]/form/div[2]/div[2]/div/div/span
${LOCATOR_WARN_USERCFPWD_FIELD}           //*[contains(@class,'card-body')]/form/div[3]/div[2]/div/div/span
${LOCATOR_WARN_USERFIRSTNAME_FIELD}       //*[contains(@class,'card-body')]/form/div[4]/div[1]/div/div/span
${LOCATOR_WARN_USERLASTNAME_FIELD}        //*[contains(@class,'card-body')]/form/div[4]/div[2]/div/div/span
${LOCATOR_WARN_USEREMAIL_FIELD}           //*[contains(@class,'card-body')]/form/div[5]/div[2]/div/div/span
${LOCATOR_WARN_PHONENUM_FIELD}            //*[contains(@class,'card-body')]/form/div[5]/div[1]/div/div/span

#Warning Message
&{USER_REQWARNING}            emptyCom=Please select company            emptyGroup=Please select group         emptyUsername=Username is required     emptyPwd=Password is required    emptyCFPwd=Confirm password is required
...                           emptyFirstname=Firstname is required      emptyLastname=Lastname is required     emptyEmail=Email is required

&{USER_OTHRWARNMSG}           duplicate=User is duplicated                                         condPWD=Password should be at least 8-30 characters, Lowercase letters, Uppercase letters, Numbers and Special characters
...                           CFPwdnotMatch=Confirm password is not match with the password        emailInv=Invalid email pattern            condUsername=More than 5 characters          dupemail=Duplicate email
...                           maxusrcomp=Maximum User This Company                                 maxusrgroup=Maximum User This Group       usrwrongformat=Username Is Wrong Format      phonenum=Phone should be only numbers

&{USERMGT_WARNMSG}            resetpwd=Password has been reset    changestatus=Status has been change   unlock=User has been unlocked

${USER_NORECORD_FOUND}       //*[@id="umnl-items-list"]/tbody/tr/td

#user Data table
${USER_THEAD}              //*[@id="umnl-items-list"]/thead
${ROW_USER_TBODY}          //*[@id="umnl-items-list"]/tbody

&{1ROW_USER_ACTION}        edit=//*[@id="umnl-edit-btn"]
...                        changeStatus=//*[@id="umnl-change-status-btn"]
...                        resetPWD=//*[@id="umnl-reset-password-btn"]
...                        unlock=//*[@id="umnl-unlock-user-btn"]
...                        approve=//*[@id="umnl-approve-user-btn"]

&{USERSEARCHBY}            companyname=Company Name      username=Username    email=Email    firstname=First Name    lastname=Last Name
&{USERSTATUS}              active=ACTIVE      inactive=INACTIVE
&{column_usermgt}          name=1   username=2   companyName=3    group=4   email=5    status=6   approve=7

*** Keywords ***
Fill in user profile info
    [Arguments]     ${firstname}    ${lastname}   ${phone}    ${email}

      commonkeywords.Fill in data form              ${LOCATOR_USERFIRSTNAME_FIELD}        ${firstname}
      commonkeywords.Fill in data form              ${LOCATOR_USERLASTNAME_FIELD}         ${lastname}
      commonkeywords.Fill in data form              ${LOCATOR_USERPHONE_FIELD}            ${phone}
      commonkeywords.Fill in data form              ${LOCATOR_USEREMAIL_FIELD}            ${email}


Verify user profile Info
    [Arguments]   ${username}      ${firstname}    ${lastname}   ${phone}    ${email}
      commonkeywords.Verify data form       ${LOCATOR_USERUSRNAME_FIELD}      should be       ${username}
      commonkeywords.Verify data form       ${LOCATOR_USERFIRSTNAME_FIELD}    should be       ${firstname}
      commonkeywords.Verify data form       ${LOCATOR_USERLASTNAME_FIELD}     should be       ${lastname}
      commonkeywords.Verify data form       ${LOCATOR_USERPHONE_FIELD}        should be       ${phone}
      commonkeywords.Verify data form       ${LOCATOR_USEREMAIL_FIELD}        should be       ${email}

Verify User Result Datatable
    [Arguments]     ${rowdata}    ${columnname}     ${assertion}    ${expresult}    ${ignore_case}=false
      commonkeywords.Get Column of Data Table    ${USER_THEAD}
      Set Local Variable    ${USER_COL}    ${col_datatable}
      commonkeywords.verify result data table on list page    ${ROW_USER_TBODY}    ${USER_COL}[${columnname}]    ${assertion}    ${expresult}   ${rowdata}    ${ignore_case}


Verify User Result Data Table for search function
      [Arguments]    ${casetype}    ${searchby}    ${searchkeyword}

        commonkeywords.Get row entries of Data Table      ${ROW_USER_TBODY}

          IF    '${casetype}'=='P'
                    Should Be True    '${GLOBAL_ENTRIES_RESULTOFPAGE}'!='0'
              IF  '${searchby}'=='${USERSEARCHBY}[companyname]'
                    Verify User Result Datatable      all    companyname    contains    ${searchkeyword}
                    Log To Console      \nTEST CASE VERIFIED: Positive Case-${USERSEARCHBY}[companyname]

              ELSE IF   '${searchby}'=='${USERSEARCHBY}[username]'
                    Verify User Result Datatable      all    username    contains    ${searchkeyword}
                    Log To Console      \nTEST CASE VERIFIED: Positive Case-${USERSEARCHBY}[username]

              ELSE IF   '${searchby}'=='${USERSEARCHBY}[email]'
                    Verify User Result Datatable      all    email    contains    ${searchkeyword}
                    Log To Console      \nTEST CASE VERIFIED: Positive Case-${USERSEARCHBY}[email]

              ELSE IF   '${searchby}'=='${USERSEARCHBY}[firstname]'
                    Verify User Result Datatable      all    name    contains    ${searchkeyword}
                    Log To Console      \nTEST CASE VERIFIED: Positive Case-${USERSEARCHBY}[firstname]

              ELSE IF   '${searchby}'=='${USERSEARCHBY}[lastname]'
                    Verify User Result Datatable      all    name    contains    ${searchkeyword}
                    Log To Console      \nTEST CASE VERIFIED: Positive Case-${USERSEARCHBY}[lastname]
              ELSE
                    Fail    Check condition "Check Result User Data records correct" keyword !!!
              END

          ELSE IF   '${casetype}'=='E'
                Should Be True    '${GLOBAL_ENTRIES_RESULTOFPAGE}'=='0'
                commonkeywords.Verify data table result is No Record Found    ${ROW_USER_TBODY}
                Log To Console      \nTEST CASE VERIFIED: Negative Cases
          ELSE
                Fail    \nCheck condition "Verify User Result Data Table for search function" keyword !!!
          END
