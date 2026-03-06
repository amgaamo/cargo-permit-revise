*** Settings ***
Resource    ../resources/commonkeywords.resource

*** Variables ***
${LOCATOR_ADDCOMP_BTN}             //*[@id="cmnl-add-btn"]
${LOCATOR_XCLOSECOMPANY_BTN}       //*[@id="cmnc-close-btn"]

${LOCATOR_SEARCHBYCOM_SEL}         select[name="cmnl-search-by"]
${LOCATOR_SEARCHCOM_KEYWORD}       //*[@id="cmnl-search-keyword"]
${LOCATOR_SEARCHCOM_BTN}           //*[@id="cmnl-search-btn"]
${LOCATOR_CLEARSEARCHCOM_BTN}      //*[@id="cmnl-clearsearch-btn"]
${LOCATOR_COMNEXT_BTN}             //*[@id="cmnc-next-btn"]
${LOCATOR_COMCANCEL_BTN}           //*[@id="cmnc-cancel-btn"]
${LOCATOR_COMBACK_BTN}             //*[@id="cmnc-next-btn"]
${LOCATOR_COMSAVE_BTN}             //*[@id="cmnc-save-btn"]

${LOCATOR_COMPANY_LIST}            //*[@id="cmnl-items-list"]

#Company Information
${LOCATOR_COMREGISTYPE_SEL}        select[name="cmnc-company-register-type"]
${LOCATOR_COMTAXID_FIELD}          //*[@id="cmnc-company-tax-id"]
${LOCATOR_COMPANYTYPE_SEL}         select[name="cmnc-company-type"]
${LOCATOR_COMNAME_FIELD}           //*[@id="cmnc-company-name"]
${LOCATOR_COMBRANCH_FIELD}         //*[@id="cmnc-company-branch"]

#Company Address Information
${LOCATOR_COMHOUSENUM_FIELD}        //input[@id="cmnc-company-house-no"]
${LOCATOR_COMMOO_FIELD}             //input[@id="cmnc-company-moo"]
${LOCATOR_COMBUILDING_FIELD}        //input[@id="cmnc-company-building"]
${LOCATOR_COMSOI_FIELD}             //input[@id="cmnc-company-soi"]
${LOCATOR_COMSTREET_FIELD}          //input[@id="cmnc-company-street"]
${LOCATOR_COMSUBDISTRICT_FIELD}     //input[@id="cmnc-company-sub-district"]
${LOCATOR_COMDISTRICT_FIELD}        //input[@id="cmnc-company-district"]
${LOCATOR_COMPROVINCE_FIELD}        //input[@id="cmnc-company-province"]
${LOCATOR_COMPOSTCODE_FIELD}        //input[@id="cmnc-company-postcode"]
${LOCATOR_COMPHONE_FIELD}           //input[@id="cmnc-company-phone"]
${LOCATOR_COMEMAIL_FIELD}           //input[@id="cmnc-company-email"]

#Company Contact Information
${LOCATOR_COMCONTACTNAME_FIELD}       //input[@id="cmnc-company-contact-name"]
${LOCATOR_COMCONTACTLASTNAME_FIELD}   //input[@id="cmnc-company-contact-lastname"]
${LOCATOR_COMCONTACTPHONE_FIELD}      //input[@id="cmnc-company-contact-phone"]
${LOCATOR_COMCONTACTEMAIL_FIELD}      //input[@id="cmnc-company-contact-email"]

#Company Policy Information
${LOCATOR_COMLIMITUSR_FIELD}          //*[@id="cmnc-limit-user"]
${LOCATOR_COMLIMITLOGINATTM_FIELD}    //*[@id="cmnc-limit-login"]
${LOCATOR_COMLIMITREPEATPWD_FIELD}    //*[@id="cmnc-limit-pwd"]
${LOCATOR_COMPWDEXPIRED_FIELD}        //*[@id="cmnc-passwordExpireDays"]
${LOCATOR_COMUNLIMITUSR_CHK}          //*[@id="cmnc-limit-user-checked"]
${LOCATOR_COMUNLIMITLOGINATTM_CHK}    //*[@id="cmnc-limit-login-checked"]
${LOCATOR_COMUNLIMITREPEATPWD_CHK}    //*[@id="cmnc-limit-pwd-checked"]
${LOCATOR_COMUNLIMITPWDEXPIRED_CHK}   //*[@id="cmnc-passwordExpireDays-checked"]

${LOCATOR_COMLIMITLOGIN_FIELD}        //*[@id="cmnc-limitSessionInSec"]
${LOCATOR_COMSESSIONEX_FIELD}         //*[@id="cmnc-idleSessionInSec"]

#Warning Company Info Span
${LOCATOR_WARN_COMREGISTYPE_INFOPAGE}    //*[@class="card-body"]/form/div[1]/div[2]/div/div/span
${LOCATOR_WARN_COMTAXID_INFOPAGE}        //*[@class="card-body"]/form/div[2]/div/div/div

${LOCATOR_WARN_COMPANYTYPE}         //*[@class="card-body"]/form/div[2]/div[1]/div/div/span
${LOCATOR_WARN_COMTAXID}            //*[@class="card-body"]/form/div[2]/div[2]/div/div
${LOCATOR_WARN_COMNAME}             //*[@class="card-body"]/form/div[3]/div[1]/div/div/span
${LOCATOR_WARN_COMBRANCH}           //*[@class="card-body"]/form/div[3]/div[2]/div/div/span

${LOCATOR_WARN_COMHOUSENUM}        //*[@class="card-body"]/form/div[4]/div[2]/div/div/span
${LOCATOR_WARN_COMSUBDISTRICT}     //*[@class="card-body"]/form/div[6]/div[2]/div/app-sub-district/div/span
${LOCATOR_WARN_COMDISTRICT}        //*[@class="card-body"]/form/div[7]/div[1]/div/div/span
${LOCATOR_WARN_COMPROVINCE}        //*[@class="card-body"]/form/div[7]/div[2]/div/div/span
${LOCATOR_WARN_COMPOSTCODE}        //*[@class="card-body"]/form/div[8]/div[1]/div/div/span
${LOCATOR_WARN_COMEMAIL}           //*[@class="card-body"]/form/div[9]/div/div/div/span
${LOCATOR_WARN_COMPHONE}           //*[@class="card-body"]/form/div[8]/div[2]/div/div/span
${LOCATOR_WARN_CONTACTPHONE}       //*[@class="card-body"]/form/div[11]/div[1]/div/div/span

${LOCATOR_WARN_COMLIMITUSR}             //*[@class="card-body"]/form/div[12]/div[2]/div/div[2]/span
${LOCATOR_WARN_COMLIMITLOGINATTM}       //*[@class="card-body"]/form/div[12]/div[3]/div/div[2]/span
${LOCATOR_WARN_COMLIMITREPEATPWD}       //*[@class="card-body"]/form/div[13]/div[1]/div/div[2]/span
${LOCATOR_WARN_COMPWDEXPIRED}           //*[@class="card-body"]/form/div[13]/div[2]/div/div[2]/span
${LOCATOR_WARN_COMLIMITLOGIN}           //*[@class="card-body"]/form/div[14]/div[1]/div/div/span
${LOCATOR_WARN_COMSESSIONEX}            //*[@class="card-body"]/form/div[14]/div[2]/div/div/span


${LOCATOR_LISTBOXSUBDISTRICT}      //*[@role="listbox"]/button[1]/div

#Warning Message
&{COMPANY_REQUIREWARNMSG}        companyType=Company Type is required              companyTax=Company Tax ID is required         companyName=Company Name is required           companyBranch=Company Branch is required
...                              houseNum=House No is required                     subDistrict=Sub District is required          district=District is required                  province=Province is required     postCode=Post Code is required
...                              eMail=E-Mail is required                          limitUser=Limit Users is required             limitLoginAttm=Limit Login Attempts is required    limitRepeatPwd=Limit Repeat Password is required
...                              pwdExpired=Password Expire Days is required       limitLogin=Limit Login Session is required    sessionExpired=Session Expire is required
...                              personalType=Personal Type is required            personalName=Personal Name is required.

&{COMPANY_OTHERWARNMSG}          dupcompanyname=Duplicate company name
...                              duptaxid=Company create failure
...                              tax13=Please input at least 13 minlength
...                              taxInvalid=Tax ID is invalid
...                              emailInv=E-Mail is invalid
...                              limitusr0=Limit User Cannot equal zero
...                              limitattm0=Limit Login Attempts Cannot equal zero
...                              repeatpwd0=Limit Repeat Password Cannot equal zero
...                              pwdexpired0=Password Expire Days Cannot equal zero
...                              loginsession0=Limit Login Session Cannot less than or equal zero
...                              sessionexpire0=Session Expire Cannot less than or equal zero
...                              limitusrless-1=Limit User Cannot less than -1
...                              limitattmless-1=Limit Login Attempts Cannot less than -1
...                              repeatpwdless-1=Limit Repeat Password Cannot less than -1
...                              pwdexpiredless-1=Password Expire Days Cannot less than -1
...                              invphonnum=Phone is invalid

#Dropdown list company management
&{COMREGISTYPE}      legal=นิติบุคคล     person=บุคคลธรรมดา
&{COMREGISTYPE_ID}   legal=1           person=2
&{COMTYPE}           netbay=NETBAY     officer=OFFICER      customer=CUSTOMER    person=PERSONAL
&{COMTYPE_ID}        netbay=1          officer=2            customer=3           person=4
&{COMSEARCHBY}       comtype=Company Type      comname=Company Name
&{COMSTATUS}         active=Active             inactive=Inactive

${COMPANY_NORECORD_FOUND}    //*[@id="cmnl-items-list"]/tbody/tr/td

#Company Data table
&{1ROW_COMPANY_ACTION}        edit=//*[@id="cmnl-items-edit-0"]      changeStatus=//*[@id="cmnl-change-status-btn"]

${COMPANY_THEAD}             //*[@id="cmnl-items-list"]/thead
${ROW_COMPANY_TBODY}         //*[@id="cmnl-items-list"]/tbody

*** Keywords ***
Service Create New Company Data Test
   [Arguments]   ${headeruser}      ${headerpassword}      ${amountdata}


      Set Local Variable    ${companytypestd}         ${COMTYPE_ID}[netbay]
      Set Local Variable    ${companytypenew}         ${JS_DEFAULTDATA['ctypedata'][0]}[ctypename]

      IF  '${VAR_USERMGTSTD_VERSION}'=='STANDARD'
            Set Local Variable    ${companytype_val}      ${companytypestd}

      ELSE IF   '${VAR_USERMGTSTD_VERSION}'=='IE5DEV'
          service-ctypemgt.Request Service Get Company Type Info    ${DS_LOGIN['robotapi'][${login_col.username}]}    ${DS_LOGIN['robotapi'][${login_col.password}]}    ${companytypenew}
          Set Local Variable    ${companytype_val}            ${GLOBAL_CTYPEID_DATA}
      ELSE
          Fail    \nPlease Check '{VAR_USERMGTSTD_VERSION}' should any 'STANDARD' or 'IE5DEV'
      END

     FOR   ${index}    IN RANGE    ${amountdata}
        ${data_index}=    Evaluate    ${index}+1
        service-companymgt.Request Service Get list Company    ${headeruser}    ${headerpassword}    ${DS_COMPANY['data${data_index}'][${company_col.companyName}]}

        IF  '${GLOBAL_COMPANYRECORD_FOUND}'=='0'
              service-companymgt.Request Service Create New Company
              ...       ${headeruser}    ${headerpassword}
              ...       ${COMREGISTYPE_ID}[${DS_COMPANY['data${data_index}'][${company_col.registerType}]}]    ${companytype_val}
              ...       ${DS_COMPANY['data${data_index}'][${company_col.companyName}]}
              ...       ${DS_COMPANY['data${data_index}'][${company_col.taxid}]}
              ...       ${DS_COMPANY['data${data_index}'][${company_col.companyBranch}]}
              ...       ${DS_COMPANY['data${data_index}'][${company_col.email}]}
              ...       10    10    10    10    60    60
        ELSE
              service-companymgt.Request Service Get list Company       ${headeruser}    ${headerpassword}    ${DS_COMPANY['data${data_index}'][${company_col.companyName}]}
              service-companymgt.Request Service Get Company Data       ${headeruser}    ${headerpassword}    ${DS_COMPANY['data${data_index}'][${company_col.companyName}]}
              service-companymgt.Request Service Update Company data
              ...       ${headeruser}                 ${headerpassword}
              ...       ${GLOBAL_GETCOMDATA_CPID}     ${GLOBAL_GETCOMDATA_ID}
              ...       ${COMREGISTYPE_ID}[${DS_COMPANY['data${data_index}'][${company_col.registerType}]}]
              ...       ${companytype_val}
              ...       ${DS_COMPANY['data${data_index}'][${company_col.companyName}]}
              ...       ${DS_COMPANY['data${data_index}'][${company_col.taxid}]}
              ...       ${DS_COMPANY['data${data_index}'][${company_col.companyBranch}]}
              ...       ${DS_COMPANY['data${data_index}'][${company_col.email}]}
              ...       10    10    10    10    60    60
        END
      END

Choose subdictrict autocomplete for first row
      [Arguments]     ${subdistrict}
      # Sleep   1500ms
      Sleep   500ms
      Wait For Elements State       ${LOCATOR_LISTBOXSUBDISTRICT}      visible     timeout=50
      Get Text                      ${LOCATOR_LISTBOXSUBDISTRICT}      contains    ${subdistrict}
      Keyboard Key    press      Enter
      Sleep   500ms


Fill in Company Information Data
    [Arguments]     ${comtype}    ${comname}     ${registerType}     ${companyBranch}
      commonkeywords.Fill in data form   ${LOCATOR_COMPANYTYPE_SEL}        ${comtype}
      commonkeywords.Fill in data form   ${LOCATOR_COMNAME_FIELD}          ${comname}

      IF    '${registerType}'=='${COMREGISTYPE}[legal]'
            commonkeywords.Fill in data form    ${LOCATOR_COMBRANCH_FIELD}        ${companyBranch}
      ELSE
            commonkeywords.Verify Field State   ${LOCATOR_COMBRANCH_FIELD}        hidden
      END


Fill in Address Information Data
    [Arguments]   ${houseNum}   ${moo}    ${building}   ${soi}    ${street}   ${subDistrict}    ${district}   ${province}   ${postcode}    ${phone}   ${email}

      commonkeywords.Fill in data form    ${LOCATOR_COMHOUSENUM_FIELD}      ${houseNum}
      commonkeywords.Fill in data form    ${LOCATOR_COMMOO_FIELD}           ${moo}
      commonkeywords.Fill in data form    ${LOCATOR_COMBUILDING_FIELD}      ${building}
      commonkeywords.Fill in data form    ${LOCATOR_COMSOI_FIELD}           ${soi}
      commonkeywords.Fill in data form    ${LOCATOR_COMSTREET_FIELD}        ${street}

      commonkeywords.Fill in data form    ${LOCATOR_COMSUBDISTRICT_FIELD}   ${subDistrict}
      pageCompanyMgt.Choose subdictrict autocomplete for first row          ${subDistrict}
      commonkeywords.Verify data form     ${LOCATOR_COMDISTRICT_FIELD}      should be     ${district}
      commonkeywords.Verify Field State   ${LOCATOR_COMDISTRICT_FIELD}      disabled
      commonkeywords.Verify data form     ${LOCATOR_COMPROVINCE_FIELD}      should be     ${province}
      commonkeywords.Verify Field State   ${LOCATOR_COMPROVINCE_FIELD}      disabled
      commonkeywords.Verify data form     ${LOCATOR_COMPOSTCODE_FIELD}      should be     ${postcode}

      commonkeywords.Fill in data form    ${LOCATOR_COMPHONE_FIELD}         ${phone}
      commonkeywords.Fill in data form    ${LOCATOR_COMEMAIL_FIELD}         ${email}


Fill in Contact Information Data
    [Arguments]   ${contactname}    ${contactlastname}    ${contactemail}   ${contactphone}

      commonkeywords.Fill in data form    ${LOCATOR_COMCONTACTNAME_FIELD}          ${contactname}
      commonkeywords.Fill in data form    ${LOCATOR_COMCONTACTLASTNAME_FIELD}      ${contactlastname}
      commonkeywords.Fill in data form    ${LOCATOR_COMCONTACTEMAIL_FIELD}         ${contactemail}
      commonkeywords.Fill in data form    ${LOCATOR_COMCONTACTPHONE_FIELD}         ${contactphone}


Fill in Company Policy Information
    [Arguments]   ${stateunlimituser}   ${stateunlimitloginattm}    ${stateunlimitrepeatpwd}    ${stateunlimitpwdexpired}
    ...           ${limituser}          ${limitloginattm}           ${limitrepeatpwd}           ${limitpwdexpired}          ${sessionexpired}     ${limitlogin}

      commonkeywords.Fill in data form    ${LOCATOR_COMUNLIMITUSR_CHK}              ${stateunlimituser}
      commonkeywords.Fill in data form    ${LOCATOR_COMUNLIMITLOGINATTM_CHK}        ${stateunlimitloginattm}
      commonkeywords.Fill in data form    ${LOCATOR_COMUNLIMITREPEATPWD_CHK}        ${stateunlimitrepeatpwd}
      commonkeywords.Fill in data form    ${LOCATOR_COMUNLIMITPWDEXPIRED_CHK}       ${stateunlimitpwdexpired}

      IF  '${stateunlimituser}'=='check'
            commonkeywords.Verify data form    ${LOCATOR_COMLIMITUSR_FIELD}           should be    ${limituser}
      END
      IF  '${stateunlimitloginattm}'=='check'
            commonkeywords.Verify data form    ${LOCATOR_COMLIMITLOGINATTM_FIELD}     should be    ${limitloginattm}
      END
      IF  '${stateunlimitrepeatpwd}'=='check'
            commonkeywords.Verify data form    ${LOCATOR_COMLIMITREPEATPWD_FIELD}     should be    ${limitrepeatpwd}
      END
      IF  '${stateunlimitpwdexpired}'=='check'
            commonkeywords.Verify data form    ${LOCATOR_COMPWDEXPIRED_FIELD}         should be    ${limitpwdexpired}
      END

      IF  '${stateunlimituser}'=='uncheck'
            commonkeywords.Fill in data form    ${LOCATOR_COMLIMITUSR_FIELD}              ${limituser}
      END
      IF  '${stateunlimitloginattm}'=='uncheck'
            commonkeywords.Fill in data form    ${LOCATOR_COMLIMITLOGINATTM_FIELD}        ${limitloginattm}
      END
      IF  '${stateunlimitrepeatpwd}'=='uncheck'
            commonkeywords.Fill in data form    ${LOCATOR_COMLIMITREPEATPWD_FIELD}        ${limitrepeatpwd}
      END
      IF  '${stateunlimitpwdexpired}'=='uncheck'
            commonkeywords.Fill in data form    ${LOCATOR_COMPWDEXPIRED_FIELD}            ${limitpwdexpired}
      END

      commonkeywords.Fill in data form          ${LOCATOR_COMSESSIONEX_FIELD}          ${sessionexpired}
      commonkeywords.Fill in data form          ${LOCATOR_COMLIMITLOGIN_FIELD}         ${limitlogin}


Verify Company Information Data
    [Arguments]   ${registerType}   ${taxid}    ${comtype}      ${comname}     ${companyBranch}
      commonkeywords.Verify data form    ${LOCATOR_COMREGISTYPE_SEL}    should be    ${registerType}
      commonkeywords.Verify data form    ${LOCATOR_COMTAXID_FIELD}      should be    ${taxid}
      commonkeywords.Verify data form    ${LOCATOR_COMPANYTYPE_SEL}     should be    ${comtype}
      commonkeywords.Verify data form    ${LOCATOR_COMNAME_FIELD}       should be    ${comname}

      IF  '${registerType}'=='${COMREGISTYPE}[legal]'
            commonkeywords.Verify data form     ${LOCATOR_COMBRANCH_FIELD}    should be    ${companyBranch}
      ELSE
            commonkeywords.Verify Field State   ${LOCATOR_COMBRANCH_FIELD}    hidden
      END


Verify Company Address Information Data
    [Arguments]   ${houseNum}   ${moo}   ${building}   ${soi}   ${street}   ${subDistrict}   ${district}   ${province}   ${postcode}   ${phone}   ${email}

      commonkeywords.Verify data form     ${LOCATOR_COMHOUSENUM_FIELD}            should be    ${houseNum}
      commonkeywords.Verify data form     ${LOCATOR_COMMOO_FIELD}                 should be    ${moo}
      commonkeywords.Verify data form     ${LOCATOR_COMBUILDING_FIELD}            should be    ${building}
      commonkeywords.Verify data form     ${LOCATOR_COMSOI_FIELD}                 should be    ${soi}
      commonkeywords.Verify data form     ${LOCATOR_COMSTREET_FIELD}              should be    ${street}
      commonkeywords.Verify data form     ${LOCATOR_COMSUBDISTRICT_FIELD}         should be    ${subDistrict}
      commonkeywords.Verify data form     ${LOCATOR_COMDISTRICT_FIELD}            should be    ${district}
      commonkeywords.Verify Field State   ${LOCATOR_COMDISTRICT_FIELD}            disabled
      commonkeywords.Verify data form     ${LOCATOR_COMPROVINCE_FIELD}            should be    ${province}
      commonkeywords.Verify Field State   ${LOCATOR_COMPROVINCE_FIELD}            disabled

      commonkeywords.Verify data form    ${LOCATOR_COMPOSTCODE_FIELD}             should be    ${postcode}
      commonkeywords.Verify data form    ${LOCATOR_COMPHONE_FIELD}                should be    ${phone}
      commonkeywords.Verify data form    ${LOCATOR_COMEMAIL_FIELD}                should be    ${email}


Verify Contact Information Data
    [Arguments]   ${contactname}    ${contactlastname}    ${contactemail}   ${contactphone}
      commonkeywords.Verify data form    ${LOCATOR_COMCONTACTNAME_FIELD}          should be    ${contactname}
      commonkeywords.Verify data form    ${LOCATOR_COMCONTACTLASTNAME_FIELD}      should be    ${contactlastname}
      commonkeywords.Verify data form    ${LOCATOR_COMCONTACTEMAIL_FIELD}         should be    ${contactemail}
      commonkeywords.Verify data form    ${LOCATOR_COMCONTACTPHONE_FIELD}         should be    ${contactphone}


Verify Company Policy Information
    [Arguments]   ${limituser}    ${limitloginattm}   ${limitrepeatpwd}   ${limitpwdexpired}    ${sessionexpired}   ${limitlogin}

      commonkeywords.Verify data form    ${LOCATOR_COMLIMITUSR_FIELD}             should be    ${limituser}
      commonkeywords.Verify data form    ${LOCATOR_COMLIMITLOGINATTM_FIELD}       should be    ${limitloginattm}
      commonkeywords.Verify data form    ${LOCATOR_COMLIMITREPEATPWD_FIELD}       should be    ${limitrepeatpwd}
      commonkeywords.Verify data form    ${LOCATOR_COMPWDEXPIRED_FIELD}           should be    ${limitpwdexpired}
      commonkeywords.Verify data form    ${LOCATOR_COMSESSIONEX_FIELD}            should be    ${sessionexpired}
      commonkeywords.Verify data form    ${LOCATOR_COMLIMITLOGIN_FIELD}           should be    ${limitlogin}

Verify Company Result Datatable
    [Arguments]     ${rowdata}    ${columnname}     ${assertion}    ${expresult}
      commonkeywords.Get Column of Data Table    ${COMPANY_THEAD}
      Set Local Variable    ${COMPANY_COL}    ${col_datatable}
      commonkeywords.verify result data table on list page    ${ROW_COMPANY_TBODY}    ${COMPANY_COL}[${columnname}]    ${assertion}    ${expresult}   ${rowdata}


Verify Company Result Data Table for search function
      [Arguments]    ${casetype}    ${searchby}    ${searchkeyword}

        commonkeywords.Get row entries of Data Table      ${ROW_COMPANY_TBODY}

          IF    '${casetype}'=='P'
                    Should Be True    '${GLOBAL_ENTRIES_RESULTOFPAGE}'!='0'
              IF  '${searchby}'=='${COMSEARCHBY}[comtype]'
                    Verify Company Result Datatable    all    companytype    should be    ${searchkeyword}
                    Log To Console      \nTEST CASE VERIFIED: Positive Case-${COMSEARCHBY}[comtype]
              ELSE IF   '${searchby}'=='${COMSEARCHBY}[comname]'
                    Verify Company Result Datatable    all    companyname    contains    ${searchkeyword}
                    Log To Console      \nTEST CASE VERIFIED: Positive Case-${COMSEARCHBY}[comname]
              ELSE
                    Fail    Check condition "Check Result Company Data records correct" keyword !!!
              END
          ELSE IF   '${casetype}'=='E'
                Should Be True    '${GLOBAL_ENTRIES_RESULTOFPAGE}'=='0'
                commonkeywords.Verify data table result is No Record Found    ${ROW_COMPANY_TBODY}
                Log To Console      \nTEST CASE VERIFIED: Negative Cases
          ELSE
                Fail    \nCheck condition "Verify Company Result Data Table for search function" keyword !!!
          END
