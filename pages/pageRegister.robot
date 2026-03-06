*** Settings ***
Resource       ../resources/commonkeywords.resource

*** Variables ***
${LOCATOR_REGISTER_LINK}                 //*[@title="Register"]
${LOCATOR_SEARCHREGIS_BTN}              //*[@id="rmnl-search-btn"]
${LOCATOR_CLEARSEARCHREGIS_BTN}         //*[@id="rmnl-clearsearch-btn"]

${LOCATOR_ADDREGISTER_BTN}              //*[@id="rmnl-add-btn"]

${LOCATOR_SEARCHBYREGISTYPE_SEL}        //*[@formcontrolname="registerType"]
${LOCATOR_SEARCHBYREGISTAX_FILED}       //*[@id="rmnl-search-register-company-tax-id"]
${LOCATOR_SEARCHBYREGISNAME_FILED}      //*[@id="rmnl-search-register-company-name"]
${LOCATOR_SEARCHBYREGISBRANCH_FILED}    //*[@id="rmnl-search-register-company-branch"]
${LOCATOR_SEARCHBYREGISSTATUS_SEL}      //*[@id="rmnl-search-register-status"]

${LOCATOR_SEARCHBYREGISDATE_TODAY}      //*[contains(@class, 'custom-today-class')]
${LOCATOR_SEARCHBYAPPVDATE_TODAY}       //*[contains(@class, 'custom-today-class')]

${LOCATOR_SEARCHBYREGISDATE_FROM}      //*[@id="rmnl-search-register-createdate-from"]
${LOCATOR_SEARCHBYREGISDATE_TO}        //*[@id="rmnl-search-register-createdate-to"]
${LOCATOR_SEARCHBYAPPVDATE_FROM}       //*[@id="rmnl-search-register-aprrovedate-from"]
${LOCATOR_SEARCHBYAPPVDATE_TO}         //*[@id="rmnl-search-register-aprrovedate-to"]

${LOCATOR_REGISREJECT_REASON_FIELD}     //*[@id="cmnc-company-reject-reason"]
${LOCATOR_REGISTER_APPROVE_BTN}         //*[@id="cmnc-approve-btn"]
${LOCATOR_REGISTER_REJECT_BTN}          //*[@id="cmnc-reject-btn"]
${LOCATOR_REGISTER_BACK_BTN}            //*[@id="cmnc-back-btn"]

${LOCATOR_REGISNEXT_BTN}               //*[@title="Next"]
${LOCATOR_REGISBACK_BTN}               //button[contains(text(),'Back')]
${LOCATOR_SUBMITREGIS_BTN}             //button[contains(text(),'Submit')]

#Company Information
${LOCATOR_VERIFYREGISTYPE_SEL}          //*[@name="verify-register-type"]
${LOCATOR_VERIFYREGISCOMTAXID_FIELD}    //*[@id="verify-company-tax"]

${LOCATOR_REGISTYPE_SEL}                //*[@id="reg-com-type"]
${LOCATOR_REGISCOMPANYTYPE_SEL}         //*[@id="reg-com-company-type"]
${LOCATOR_REGISCOMPANYTAX_FIELD}        //*[@id="reg-com-company-tax-id"]
${LOCATOR_REGISCOMNAME_FIELD}           //*[@id="reg-com-company-name"]
${LOCATOR_REGISCOMBRANCH_FIELD}         //*[@id="reg-com-company-branch"]

#Company Address Information
${LOCATOR_REGISCOMHOUSENUM_FIELD}        //input[@id="reg-com-company-house-no"]
${LOCATOR_REGISCOMMOO_FIELD}             //input[@id="reg-com-company-moo"]
${LOCATOR_REGISCOMBUILDING_FIELD}        //input[@id="reg-com-company-building"]
${LOCATOR_REGISCOMSOI_FIELD}             //input[@id="reg-com-company-soi"]
${LOCATOR_REGISCOMSTREET_FIELD}          //input[@id="reg-com-company-street"]
${LOCATOR_REGISCOMSUBDISTRICT_FIELD}     //input[@id="reg-com-company-sub-district"]
${LOCATOR_REGISCOMDISTRICT_FIELD}        //input[@id="reg-com-company-district"]
${LOCATOR_REGISCOMPROVINCE_FIELD}        //input[@id="reg-com-company-province"]
${LOCATOR_REGISCOMPOSTCODE_FIELD}        //input[@id="reg-com-company-postcode"]
${LOCATOR_REGISCOMPHONE_FIELD}           //input[@id="reg-com-company-phone"]
${LOCATOR_REGISCOMEMAIL_FIELD}           //input[@id="reg-com-company-email"]

#Company Contact Information
${LOCATOR_REGISCOMCONTACTNAME_FIELD}       //input[@id="reg-com-company-contact-name"]
${LOCATOR_REGISCOMCONTACTLASTNAME_FIELD}   //input[@id="reg-com-company-contact-lastname"]
${LOCATOR_REGISCOMCONTACTPHONE_FIELD}      //input[@id="reg-com-company-contact-phone"]
${LOCATOR_REGISCOMCONTACTEMAIL_FIELD}      //input[@id="reg-com-company-contact-email"]

${LOCATOR_REGIS_ATTACHMENT}           \#regisfile--attachment-0

${LOCATOR_REGISTER_FIRSTNAME}         //*[@id="cmnc-company-user-first-name"]
${LOCATOR_REGISTER_LASTNAMENAME}      //*[@id="cmnc-company-user-last-name"]
${LOCATOR_REGISTER_PHONE}             //*[@id="cmnc-company-user-phone"]
${LOCATOR_REGISTER_EMAIL}             //*[@id="cmnc-company-user-email"]
${LOCATOR_REGISTER_USERNAME}          //*[@id="cmnc-company-username"]

${LOCATOR_REGISTER_VIEWATTACH}        //*[@id="rmnl-items-view-0"]

#User Information
${LOCATOR_REGIS_USERFIRSTNAME_FIELD}      //*[@id="reg-user-firstname"]
${LOCATOR_REGIS_USERLASTNAME_FIELD}       //*[@id="reg-user-lastname"]
${LOCATOR_REGIS_USERPHONE_FIELD}          //*[@id="reg-user-phone"]
${LOCATOR_REGIS_USEREMAIL_FIELD}          //*[@id="reg-user-email"]

#Login Information
${LOCATOR_REGIS_USERNAME_FIELD}          //*[@id="reg-user-username"]
${LOCATOR_REGIS_USERPWD_FIELD}           //*[@id="reg-user-password"]
${LOCATOR_REGIS_USERCFPWD_FIELD}         //*[@id="reg-user-confirm-password"]

#Warning Company Info Span
${LOCATOR_WARN_REGISTYPE_REGISPAGE}     //*[contains(@class,'tab-content')]/div/div/app-register-verify/div/div[1]/form/div/div[1]/div/div/span
${LOCATOR_WARN_REGISTAXID_REGISPAGE}    //*[contains(@class,'tab-content')]/div/div/app-register-verify/div/div[1]/form/div/div[2]/div/div/span[1]
${LOCATOR_WARN_REGISTAXID_REGISPAGE2}   //*[contains(@class,'tab-content')]/div/div/app-register-verify/div/div[1]/form/div/div[2]/div/div/span[2]

${LOCATOR_WARN_REGISCOMTYPE}          //*[contains(@class,'tab-content')]/div/app-register-company/div/div[1]/form/div[1]/div[2]/div/div/span
${LOCATOR_WARN_REGISPERSONNAME}       //*[contains(@class,'tab-content')]/div/app-register-company/div/div[1]/form/div[1]/div[3]/div/div/span
${LOCATOR_WARN_REGISCOMNAME}          //*[contains(@class,'tab-content')]/div/app-register-company/div/div[1]/form/div[1]/div[4]/div/div/span
${LOCATOR_WARN_REGISCOMBRANCH}        //*[contains(@class,'tab-content')]/div/app-register-company/div/div[1]/form/div[1]/div[5]/div/div/span

${LOCATOR_WARN_REGISHOUSENUM}        //*[contains(@class,'tab-content')]/div/app-register-company/div/div[1]/form/div[2]/div[1]/div/div/span
${LOCATOR_WARN_REGISUBDISTRICT}      //*[contains(@class,'tab-content')]/div/app-register-company/div/div[1]/form/div[2]/div[6]/div/app-sub-district/div/span

${LOCATOR_WARN_REGISDISTRICT}        //*[contains(@class,'tab-content')]/div/app-register-company/div/div[1]/form/div[2]/div[7]/div/div/span
${LOCATOR_WARN_REGISPROVINCE}        //*[contains(@class,'tab-content')]/div/app-register-company/div/div[1]/form/div[2]/div[8]/div/div/span

${LOCATOR_WARN_REGISPOSTCODE}        //*[contains(@class,'tab-content')]/div/app-register-company/div/div[1]/form/div[2]/div[9]/div/div/span
${LOCATOR_WARN_REGISEMAIL}           //*[contains(@class,'tab-content')]/div/app-register-company/div/div[1]/form/div[2]/div[11]/div/div/span
${LOCATOR_WARN_REGISCONTACTPHONE}    //*[contains(@class,'tab-content')]/div/app-register-company/div/div[1]/form/div[3]/div[3]/div/div

${LOCATOR_WARN_UPLOADATTACH}         //*[contains(@class,'tab-content')]/div/app-register-attachment/div/div[1]/form/div/div/div/div[2]/span

${LOCATOR_WARN_REGIS_USERFIRSTNAME}   //*[contains(@class,'tab-content')]/div/app-register-user/div/div[1]/form/div[1]/div[1]/div/div/span
${LOCATOR_WARN_REGIS_USERLASTNAME}    //*[contains(@class,'tab-content')]/div/app-register-user/div/div[1]/form/div[1]/div[2]/div/div/span
${LOCATOR_WARN_REGIS_USEREMAIL}       //*[contains(@class,'tab-content')]/div/app-register-user/div/div[1]/form/div[1]/div[4]/div/div/span
${LOCATOR_WARN_REGIS_USERNAME}        //*[contains(@class,'tab-content')]/div/app-register-user/div/div[1]/form/div[2]/div/div/div/span
${LOCATOR_WARN_REGIS_USERPWD}         //*[contains(@class,'tab-content')]/div/app-register-user/div/div[1]/form/div[3]/div[1]/div/div/span
${LOCATOR_WARN_REGIS_USERCFPWD}       //*[contains(@class,'tab-content')]/div/app-register-user/div/div[1]/form/div[3]/div[2]/div/div/span
${LOCATOR_WARN_REGIS_USERPHONE}       //*[contains(@class,'tab-content')]/div/app-register-user/div/div[1]/form/div[1]/div[3]/div/div/span

#Warning Message
&{REGISTER_REQUIREWARNMSG}       registerType=Please choose a type
...                              companyType=Company Type is required
...                              taxid=Please enter a Tax ID
...                              companyTax=Please enter a Company Tax ID
...                              personTax=Please enter a Personal Tax ID
...                              companyName=Company Name is required
...                              personName=Personal Name is required
...                              companyBranch=Company Branch is required
...                              houseNum=House No is required
...                              subDistrict=Sub District is required
...                              district=District is required
...                              province=Province is required
...                              postCode=Postcode is required
...                              eMail=Email is required
...                              firstname=First Name is required
...                              lastname=Last Name is required
...                              useremail=E-mail is required
...                              username=Username is required
...                              password=Password is required
...                              cfpwd=Confirm Password is required
...                              upload=ID Card is required


&{REGISTER_OTHERWARNMSG}         tax13=Please input at least 13 minlength
...                              taxduplicate=The Company tax ID has already registered
...                              taxInvalid=Tax ID is invalid
...                              duplicate=Duplicate Username
...                              condUsername=More than 4 characters
...                              condPWD=Password should be at least 8-30 characters, Lowercase letters, Uppercase letters, Numbers and Special characters
...                              CFPwdnotMatch=Confirm password is not match with the password
...                              emailInv=Invalid email pattern
...                              useremailInv=Invalid e-mail pattern
...                              formatemail=User Email Is Wrong Format
...                              dupemail=Duplicate User Email.
...                              invphonnum=Contact Phone should be only numbers
...                              invuserphone=Phone should be only numbers

${REJECT_WARNMSG}               Please input reject reason

${LOCATOR_REGISTER_SUCCESS}       //*[contains(text(),'Successfully registered')]

#Dropdown list company management
&{REGISTYPE}         legal=นิติบุคคล      person=บุคคลธรรมดา
&{REGISTYPE_ID}      legal=1            person=2
&{REGISCOMTYPE}      officer=OFFICER    customer=CUSTOMER    person=PERSONAL
&{REGISCOMTYPE_ID}   netbay=1           officer=2            customer=3           person=4
&{REGISSTATUS}       appv=Approved      rej=Reject           waitappv=Waiting Approved

${REGISTER_NORECORD_FOUND}    //*[@id="rmnl-items-list"]/tbody/tr/td

#Register Management Data table
&{1ROW_REGIS_ACTION}        view=//*[@id="rmnl-items-edit-0" and @tooltip="View"]
${ROW_REGIS_TBODY}         //*[@id="rmnl-items-list"]/tbody
${REGIS_THEAD}             //*[@id="rmnl-items-list"]/thead

*** Keywords ***
Click Register Link
      Wait For Elements State    ${LOCATOR_REGISTER_LINK}          visible      timeout=10
      Click       ${LOCATOR_REGISTER_LINK}
      Wait For Elements State    ${LOCATOR_REGISBACK_BTN}          visible      timeout=5


Fill in Register Info
      [Arguments]   ${registertype}    ${companytype}    ${companyname}    ${companybranch}

      commonkeywords.Fill in data form      ${LOCATOR_REGISCOMNAME_FIELD}       ${companyname}

      IF  '${registertype}'=='${REGISTYPE}[legal]'
            commonkeywords.Fill in data form    ${LOCATOR_REGISCOMPANYTYPE_SEL}            ${companytype}
            commonkeywords.Fill in data form    ${LOCATOR_REGISCOMBRANCH_FIELD}            ${companybranch}
      ELSE
          commonkeywords.Verify Field State     ${LOCATOR_REGISCOMPANYTYPE_SEL}            hidden
          commonkeywords.Verify Field State     ${LOCATOR_REGISCOMBRANCH_FIELD}            hidden
      END


Fill in Register Company Address Info
    [Arguments]   ${houseNum}    ${moo}   ${building}     ${soi}    ${street}     ${subDistrict}    ${district}     ${province}     ${postcode}     ${phone}    ${email}

      commonkeywords.Fill in data form      ${LOCATOR_REGISCOMHOUSENUM_FIELD}      ${houseNum}
      commonkeywords.Fill in data form      ${LOCATOR_REGISCOMMOO_FIELD}           ${moo}
      commonkeywords.Fill in data form      ${LOCATOR_REGISCOMBUILDING_FIELD}      ${building}
      commonkeywords.Fill in data form      ${LOCATOR_REGISCOMSOI_FIELD}           ${soi}
      commonkeywords.Fill in data form      ${LOCATOR_REGISCOMSTREET_FIELD}        ${street}
      commonkeywords.Fill in data form      ${LOCATOR_REGISCOMSUBDISTRICT_FIELD}   ${subDistrict}
      PageCompanyMgt.Choose subdictrict autocomplete for first row                 ${subDistrict}
      commonkeywords.Verify data form       ${LOCATOR_REGISCOMDISTRICT_FIELD}      should be      ${district}
      commonkeywords.Verify Field State     ${LOCATOR_REGISCOMDISTRICT_FIELD}      disabled
      commonkeywords.Verify data form       ${LOCATOR_REGISCOMPROVINCE_FIELD}      should be      ${province}
      commonkeywords.Verify Field State     ${LOCATOR_REGISCOMPROVINCE_FIELD}      disabled
      commonkeywords.Verify data form       ${LOCATOR_REGISCOMPOSTCODE_FIELD}      should be      ${postcode}
      commonkeywords.Fill in data form      ${LOCATOR_REGISCOMPHONE_FIELD}         ${phone}
      commonkeywords.Fill in data form      ${LOCATOR_REGISCOMEMAIL_FIELD}         ${email}

Fill in Register Contact Info
    [Arguments]   ${contactname}    ${contactlastname}    ${contactphone}   ${contactemail}
      commonkeywords.Fill in data form      ${LOCATOR_REGISCOMCONTACTNAME_FIELD}         ${contactname}
      commonkeywords.Fill in data form      ${LOCATOR_REGISCOMCONTACTLASTNAME_FIELD}     ${contactlastname}
      commonkeywords.Fill in data form      ${LOCATOR_REGISCOMCONTACTPHONE_FIELD}        ${contactphone}
      commonkeywords.Fill in data form      ${LOCATOR_REGISCOMCONTACTEMAIL_FIELD}        ${contactemail}

Fill in Register User Info
    [Arguments]   ${userfirstname}    ${userlastname}    ${useremail}    ${userphone}
      commonkeywords.Fill in data form              ${LOCATOR_REGIS_USERFIRSTNAME_FIELD}       ${userfirstname}
      commonkeywords.Fill in data form              ${LOCATOR_REGIS_USERLASTNAME_FIELD}        ${userlastname}
      commonkeywords.Fill in data form              ${LOCATOR_REGIS_USEREMAIL_FIELD}           ${useremail}
      commonkeywords.Fill in data form              ${LOCATOR_REGIS_USERPHONE_FIELD}           ${userphone}

Fill in Register Login Info
    [Arguments]   ${username}   ${password}   ${cfpassword}
      commonkeywords.Fill in data form              ${LOCATOR_REGIS_USERNAME_FIELD}            ${username}
      commonkeywords.Fill in data form              ${LOCATOR_REGIS_USERPWD_FIELD}             ${password}
      commonkeywords.Fill in data form              ${LOCATOR_REGIS_USERCFPWD_FIELD}           ${cfpassword}


Verify register is Successfully
   [Arguments]    ${locator}
         Wait For Elements State      ${locator}       visible       timeout=20s

Verify Register Info
    [Arguments]   ${registerType}   ${taxid}    ${comname}    ${companytype}    ${companybranch}

      commonkeywords.Verify data form    ${LOCATOR_COMREGISTYPE_SEL}      should be    ${registerType}
      commonkeywords.Verify data form    ${LOCATOR_COMTAXID_FIELD}        should be    ${taxid}
      commonkeywords.Verify data form    ${LOCATOR_COMNAME_FIELD}         should be    ${comname}

      IF  '${registertype}'=='${REGISTYPE}[legal]'
            commonkeywords.Verify data form    ${LOCATOR_COMPANYTYPE_SEL}         should be        ${companytype}
            commonkeywords.Verify data form    ${LOCATOR_COMBRANCH_FIELD}         should be        ${companybranch}
      ELSE
          commonkeywords.Verify Field State     ${LOCATOR_COMPANYTYPE_SEL}        hidden
          commonkeywords.Verify Field State     ${LOCATOR_COMBRANCH_FIELD}        hidden
      END

Verify Register Info should disabled
    [Arguments]     ${registertype}
      commonkeywords.Verify Field State     ${LOCATOR_COMREGISTYPE_SEL}         disabled
      commonkeywords.Verify Field State     ${LOCATOR_COMTAXID_FIELD}           disabled
      commonkeywords.Verify Field State     ${LOCATOR_COMNAME_FIELD}            disabled

      IF  '${registertype}'=='${REGISTYPE}[legal]'
            commonkeywords.Verify Field State   ${LOCATOR_COMPANYTYPE_SEL}      disabled
            commonkeywords.Verify Field State   ${LOCATOR_COMBRANCH_FIELD}      disabled
      ELSE
          commonkeywords.Verify Field State     ${LOCATOR_COMPANYTYPE_SEL}      hidden
          commonkeywords.Verify Field State     ${LOCATOR_COMBRANCH_FIELD}      hidden
      END

Verify Register Company Address Info
    [Arguments]   ${houseNum}    ${moo}    ${building}   ${soi}    ${street}    ${subDistrict}    ${district}    ${province}    ${postcode}    ${phone}    ${email}

      commonkeywords.Verify data form     ${LOCATOR_COMHOUSENUM_FIELD}       should be    ${houseNum}
      commonkeywords.Verify data form     ${LOCATOR_COMMOO_FIELD}            should be    ${moo}
      commonkeywords.Verify data form     ${LOCATOR_COMBUILDING_FIELD}       should be    ${building}
      commonkeywords.Verify data form     ${LOCATOR_COMSOI_FIELD}            should be    ${soi}
      commonkeywords.Verify data form     ${LOCATOR_COMSTREET_FIELD}         should be    ${street}
      commonkeywords.Verify data form     ${LOCATOR_COMSUBDISTRICT_FIELD}    should be    ${subDistrict}
      commonkeywords.Verify data form     ${LOCATOR_COMDISTRICT_FIELD}       should be    ${district}
      commonkeywords.Verify Field State   ${LOCATOR_COMDISTRICT_FIELD}       disabled
      commonkeywords.Verify data form     ${LOCATOR_COMPROVINCE_FIELD}       should be    ${province}
      commonkeywords.Verify Field State   ${LOCATOR_COMPROVINCE_FIELD}       disabled
      commonkeywords.Verify data form     ${LOCATOR_COMPOSTCODE_FIELD}       should be    ${postcode}
      commonkeywords.Verify data form     ${LOCATOR_COMPHONE_FIELD}          should be    ${phone}
      commonkeywords.Verify data form     ${LOCATOR_COMEMAIL_FIELD}          should be    ${email}

Verify Register Company Address Info should disabled

      commonkeywords.Verify Field State    ${LOCATOR_COMHOUSENUM_FIELD}       disabled
      commonkeywords.Verify Field State    ${LOCATOR_COMMOO_FIELD}            disabled
      commonkeywords.Verify Field State    ${LOCATOR_COMBUILDING_FIELD}       disabled
      commonkeywords.Verify Field State    ${LOCATOR_COMSOI_FIELD}            disabled
      commonkeywords.Verify Field State    ${LOCATOR_COMSTREET_FIELD}         disabled
      commonkeywords.Verify Field State    ${LOCATOR_COMSUBDISTRICT_FIELD}    disabled
      commonkeywords.Verify Field State    ${LOCATOR_COMDISTRICT_FIELD}       disabled
      commonkeywords.Verify Field State    ${LOCATOR_COMPROVINCE_FIELD}       disabled
      commonkeywords.Verify Field State    ${LOCATOR_COMPOSTCODE_FIELD}       disabled
      commonkeywords.Verify Field State    ${LOCATOR_COMPHONE_FIELD}          disabled
      commonkeywords.Verify Field State    ${LOCATOR_COMEMAIL_FIELD}          disabled


Verify Register Contact Info
    [Arguments]   ${contactname}    ${contactlastname}    ${contactemail}    ${contactphone}

      commonkeywords.Verify data form    ${LOCATOR_COMCONTACTNAME_FIELD}           should be    ${contactname}
      commonkeywords.Verify data form    ${LOCATOR_COMCONTACTLASTNAME_FIELD}       should be    ${contactlastname}
      commonkeywords.Verify data form    ${LOCATOR_COMCONTACTEMAIL_FIELD}          should be    ${contactemail}
      commonkeywords.Verify data form    ${LOCATOR_COMCONTACTPHONE_FIELD}          should be    ${contactphone}


Verify Register Contact Info should disabled
      commonkeywords.Verify Field State    ${LOCATOR_COMCONTACTNAME_FIELD}           disabled
      commonkeywords.Verify Field State    ${LOCATOR_COMCONTACTLASTNAME_FIELD}       disabled
      commonkeywords.Verify Field State    ${LOCATOR_COMCONTACTEMAIL_FIELD}          disabled
      commonkeywords.Verify Field State    ${LOCATOR_COMCONTACTPHONE_FIELD}          disabled


Verify Register User Login Info
    [Arguments]   ${userfirstname}    ${userlastname}    ${userphone}    ${useremail}    ${username}

      commonkeywords.Verify data form    ${LOCATOR_REGISTER_FIRSTNAME}              should be    ${userfirstname}
      commonkeywords.Verify data form    ${LOCATOR_REGISTER_LASTNAMENAME}           should be    ${userlastname}
      commonkeywords.Verify data form    ${LOCATOR_REGISTER_PHONE}                  should be    ${userphone}
      commonkeywords.Verify data form    ${LOCATOR_REGISTER_EMAIL}                  should be    ${useremail}
      commonkeywords.Verify data form    ${LOCATOR_REGISTER_USERNAME}               should be    ${username}

Verify Register User Login Info should disabled
      commonkeywords.Verify Field State    ${LOCATOR_REGISTER_FIRSTNAME}              disabled
      commonkeywords.Verify Field State    ${LOCATOR_REGISTER_LASTNAMENAME}           disabled
      commonkeywords.Verify Field State    ${LOCATOR_REGISTER_PHONE}                  disabled
      commonkeywords.Verify Field State    ${LOCATOR_REGISTER_EMAIL}                  disabled
      commonkeywords.Verify Field State    ${LOCATOR_REGISTER_USERNAME}               disabled


Verify Regis Management Result Datatable
    [Arguments]     ${rowdata}    ${columnname}     ${assertion}    ${expresult}    ${ignore_case}=false
      commonkeywords.Get Column of Data Table    ${REGIS_THEAD}
      Set Local Variable    ${REGIS_COL}    ${col_datatable}
      commonkeywords.verify result data table on list page    ${ROW_REGIS_TBODY}    ${REGIS_COL}[${columnname}]    ${assertion}    ${expresult}   ${rowdata}    ${ignore_case}


Verify Regis Management Result Data Table for search function
      [Arguments]    ${casetype}     ${registype}      ${taxid}      ${name}     ${branch}    ${status}   ${registerdate}     ${approvedate}

        commonkeywords.Get row entries of Data Table      ${ROW_REGIS_TBODY}

          IF    '${casetype}'=='P'
                    Should Be True    '${GLOBAL_ENTRIES_RESULTOFPAGE}'!='0'
              IF  '${registype}'!='Please Select'
                    Verify Regis Management Result Datatable     all    type    should be    ${registype}
                    Log To Console      \nTEST CASE VERIFIED: Positive Case-Search by Type
              END
              IF   '${taxid}'!=''
                    Verify Regis Management Result Datatable      all    taxid    contains    ${taxid}
                    Log To Console      \nTEST CASE VERIFIED: Positive Case-Search by Taxid
              END
              IF   '${name}'!=''
                    Verify Regis Management Result Datatable      all    name    contains    ${name}
                    Log To Console      \nTEST CASE VERIFIED: Positive Case-Search by Name
              END
              IF   '${branch}'!=''
                    Verify Regis Management Result Datatable      all    branch    should be    ${branch}
                    Log To Console      \nTEST CASE VERIFIED: Positive Case-Search by Branch
              END
              IF   '${registerdate}'=='Today'
                    Verify Regis Management Result Datatable      all    registerdate    contains     ${GLOBAL_CURDATE_YMD}
                    Log To Console      \nTEST CASE VERIFIED: Positive Case-Search by register date
              END
              IF   '${approvedate}'=='Today'
                    Verify Regis Management Result Datatable      all    approvedate    contains      ${GLOBAL_CURDATE_YMD}
                    Log To Console      \nTEST CASE VERIFIED: Positive Case-Search by approve date
              END
              IF   '${status}'!='Please Select'
                    Verify Regis Management Result Datatable      all    status         contains    ${status}
                    Log To Console      \nTEST CASE VERIFIED: Positive Case-Search by status
              END

          ELSE IF   '${casetype}'=='X' and '${GLOBAL_REGISTER_AUTO_APPRV}'=='False'
                      Should Be True    '${GLOBAL_ENTRIES_RESULTOFPAGE}'!='0'
                  IF  '${registype}'!='Please Select'
                        Verify Regis Management Result Datatable     all    type    should be    ${registype}
                        Log To Console      \nTEST CASE VERIFIED: Positive Case-Search by Type
                  END
                  IF   '${taxid}'!=''
                        Verify Regis Management Result Datatable      all    taxid    contains    ${taxid}
                        Log To Console      \nTEST CASE VERIFIED: Positive Case-Search by Taxid
                  END
                  IF   '${name}'!=''
                        Verify Regis Management Result Datatable      all    name    contains    ${name}
                        Log To Console      \nTEST CASE VERIFIED: Positive Case-Search by Name
                  END
                  IF   '${branch}'!=''
                        Verify Regis Management Result Datatable      all    branch    should be    ${branch}
                        Log To Console      \nTEST CASE VERIFIED: Positive Case-Search by Branch
                  END
                  IF   '${registerdate}'=='Today'
                        Verify Regis Management Result Datatable      all    registerdate    contains     ${GLOBAL_CURDATE_YMD}
                        Log To Console      \nTEST CASE VERIFIED: Positive Case-Search by register date
                  END
                  IF   '${approvedate}'=='Today'
                        Verify Regis Management Result Datatable      all    approvedate    contains      ${GLOBAL_CURDATE_YMD}
                        Log To Console      \nTEST CASE VERIFIED: Positive Case-Search by approve date
                  END
                  IF   '${status}'!='Please Select'
                        Verify Regis Management Result Datatable      all    status         contains    ${status}
                        Log To Console      \nTEST CASE VERIFIED: Positive Case-Search by status
                  END

          ELSE IF   '${casetype}'=='E'
                Should Be True    '${GLOBAL_ENTRIES_RESULTOFPAGE}'=='0'
                commonkeywords.Verify data table result is No Record Found    ${ROW_REGIS_TBODY}
                Log To Console      \nTEST CASE VERIFIED: Negative Cases

          ELSE IF   '${casetype}'=='X' and '${GLOBAL_REGISTER_AUTO_APPRV}'=='True'
                Pass Execution    \Test Case for Register Auto Approve: False
          ELSE
                Fail    \nCheck condition "Verify Register Management Result Data Table for search function" keyword !!!
          END


Create Register Data Test
   [Arguments]    ${registerType}     ${taxid}              ${comtype}           ${comname}          ${companyBranch}      ${houseNum}       ${moo}
   ...            ${building}         ${soi}                ${street}            ${subDistrict}      ${district}           ${province}       ${postcode}       ${phone}        ${email}
   ...            ${contactname}      ${contactlastname}    ${contactemail}      ${contactphone}     ${uploadpath}
   ...            ${userfirstname}    ${userlastname}       ${userphone}         ${useremail}        ${username}           ${userpwd}

      commonkeywords.Fill in data form    ${LOCATOR_VERIFYREGISTYPE_SEL}              ${registerType}
      commonkeywords.Fill in data form    ${LOCATOR_VERIFYREGISCOMTAXID_FIELD}        ${taxid}
      commonkeywords.Click button on detail page    ${LOCATOR_REGISNEXT_BTN}
      Sleep   500ms
      commonkeywords.Wait Loading progress
      commonkeywords.Verify data form       ${LOCATOR_REGISTYPE_SEL}            should be     ${registerType}
      commonkeywords.Verify data form       ${LOCATOR_REGISCOMPANYTAX_FIELD}    should be     ${taxid}
      commonkeywords.Verify Field State     ${LOCATOR_REGISTYPE_SEL}            disabled
      commonkeywords.Verify Field State     ${LOCATOR_REGISCOMPANYTAX_FIELD}    disabled

      Fill in Register Info
      ...     ${registerType}      ${comtype}      ${comname}       ${companybranch}

      #Company Address Information data
      Fill in Register Company Address Info
      ...     ${houseNum}     ${moo}      ${building}     ${soi}      ${street}     ${subDistrict}      ${district}     ${province}     ${postcode}     ${phone}      ${email}

      #Company Contact Information
      Fill in Register Contact Info
      ...     ${contactname}      ${contactlastname}      ${contactphone}     ${contactemail}
      commonkeywords.Click button on detail page    ${LOCATOR_REGISNEXT_BTN}

      # Attachment Document Infomation
      Sleep    1s
      commonkeywords.Wait Loading progress
      commonkeywords.Choose file to upload    ${LOCATOR_REGIS_ATTACHMENT}      ${uploadpath}
      commonkeywords.Wait Loading progress
      commonkeywords.Click button on detail page    ${LOCATOR_REGISNEXT_BTN}
      commonkeywords.Wait Loading progress

      #User Information
      Fill in Register User Info
      ...     ${userfirstname}    ${userlastname}     ${useremail}      ${userphone}

      #Login Information
      Fill in Register Login Info
      ...     ${username}     ${userpwd}      ${userpwd}

      commonkeywords.Click button on detail page      ${LOCATOR_SUBMITREGIS_BTN}
      Verify register is Successfully    ${LOCATOR_REGISTER_SUCCESS}
      commonkeywords.Click button on detail page      ${LOCATOR_REGISBACK_BTN}
