*** Settings ***
Resource        ../../resources/commonkeywords.resource

Suite setup       Run Keywords      dataSources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource REGISTER INFO DATA
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               datasources.Import DataSource ADDRESS DATA
...               AND               commonkeywords.Get Data Current Date
...               AND               commonkeywords.Set Data for Run Automated Test 
...               AND               Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.   
...               AND               Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version
...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Login System     ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to MENU name                ${mainmenu}[registerMgt]
...               AND               commonkeywords.Verify Page Name is correct    ${menuname}[regMgt]

Test Setup        Run Keywords      commonkeywords.Generate Random Number       lengthno=8
...               AND               commonkeywords.Generate Random Values       lengthno=3    lenghtletter=3
...               AND               Set Suite Variable    ${regis_companyname}          ${DS_REGIS['regmlegal'][${reg_col.companyName}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${regis_comtaxid}             ${DS_REGIS['regmlegal'][${reg_col.taxid}]}${GLOBAL_GENNUMBER}
...               AND               Set Suite Variable    ${regis_companyemail}         ${DS_REGIS['regmlegal'][${reg_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Set Suite Variable    ${regis_comcontactmail}       ${DS_REGIS['regmlegal'][${reg_col.contactemail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Set Suite Variable    ${regis_comusername}          ${DS_REGIS['regmlegal'][${reg_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${regis_comuseremail}         ${DS_REGIS['regmlegal'][${reg_col.useremail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com

...               AND               Set Suite Variable    ${regis_personname}          ${DS_REGIS['regmperson'][${reg_col.companyName}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${regis_pstaxid}             ${DS_REGIS['regmperson'][${reg_col.taxid}]}${GLOBAL_GENNUMBER}
...               AND               Set Suite Variable    ${regis_psemail}             ${DS_REGIS['regmperson'][${reg_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Set Suite Variable    ${regis_pscontactmail}       ${DS_REGIS['regmperson'][${reg_col.contactemail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Set Suite Variable    ${regis_psusername}          ${DS_REGIS['regmperson'][${reg_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${regis_psuseremail}         ${DS_REGIS['regmperson'][${reg_col.useremail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com

...               AND               Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.   
...               AND               Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version
...               AND               commonkeywords.Wait Loading progress
...               AND               commonkeywords.Click button on list page    ${LOCATOR_ADDREGISTER_BTN}

Suite Teardown    Run Keywords    Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.   
...               AND             commonkeywords.Release user lock and close all browser
Test Template     Template Register is success

*** Test Cases ***
CASE-Register type Legal is success
         #Company Information data - registerType  taxid   comtype   comname   companyBranch
         ...     ${REGISTYPE}[${DS_REGIS['regmlegal'][${reg_col.regisType}]}]
         ...     ${regis_comtaxid}
         ...     ${REGISCOMTYPE}[${DS_REGIS['regmlegal'][${reg_col.companyType}]}]
         ...     ${regis_companyname}
         ...     ${DS_REGIS['regmlegal'][${reg_col.companyBranch}]}

         #Company Address Information data  >>>  houseNum     moo   building    soi    street     subDistrict    district    province   postcode    phone    email
         ...     ${ADDR_JOMTHONG_BKK}[housenum]
         ...     ${ADDR_JOMTHONG_BKK}[moo]
         ...     ${ADDR_JOMTHONG_BKK}[building]
         ...     ${ADDR_JOMTHONG_BKK}[soi]
         ...     ${ADDR_JOMTHONG_BKK}[street]
         ...     ${ADDR_JOMTHONG_BKK}[subdistrict]
         ...     ${ADDR_JOMTHONG_BKK}[district]
         ...     ${ADDR_JOMTHONG_BKK}[province]
         ...     ${ADDR_JOMTHONG_BKK}[postcode]
         ...     ${DS_REGIS['regmlegal'][${reg_col.phone}]}
         ...     ${regis_companyemail}

         #Company Contact Information  >>>   contactname    contactlastname   contactemail    contactphone
         ...     ${DS_REGIS['regmlegal'][${reg_col.contactname}]}
         ...     ${DS_REGIS['regmlegal'][${reg_col.contactlastname}]}
         ...     ${regis_comcontactmail}
         ...     ${DS_REGIS['regmlegal'][${reg_col.contactphone}]}

         #Company upload path
         ...     ${IDCARD_JPGDATATEST}

         #User Information
            # >>> firstname   lastName  phone   email
         ...      ${DS_REGIS['regmlegal'][${reg_col.firstname}]}
         ...      ${DS_REGIS['regmlegal'][${reg_col.lastname}]}
         ...      ${DS_REGIS['regmlegal'][${reg_col.userphone}]}
         ...      ${regis_comuseremail}

        #Login Information
          # >> username    password    confpassword
         ...      ${regis_comusername}
         ...      ${VAR_DEFAULT_PASSWORD}
         ...      ${VAR_DEFAULTPASSWORD}


CASE-Register type Person is success
         #Company Information data - registerType  taxid   comtype   comname   companyBranch
         ...     ${REGISTYPE}[${DS_REGIS['regmperson'][${reg_col.regisType}]}]
         ...     ${regis_pstaxid}
         ...     ${REGISCOMTYPE}[${DS_REGIS['regmperson'][${reg_col.companyType}]}]
         ...     ${regis_personname}
         ...     ${DS_REGIS['regmperson'][${reg_col.companyBranch}]}

         #Company Address Information data  >>>  houseNum     moo   building    soi    street     subDistrict    district    province   postcode    phone    email
         ...     ${ADDR_PATHUMWAN_BKK}[housenum]
         ...     ${ADDR_PATHUMWAN_BKK}[moo]
         ...     ${ADDR_PATHUMWAN_BKK}[building]
         ...     ${ADDR_PATHUMWAN_BKK}[soi]
         ...     ${ADDR_PATHUMWAN_BKK}[street]
         ...     ${ADDR_PATHUMWAN_BKK}[subdistrict]
         ...     ${ADDR_PATHUMWAN_BKK}[district]
         ...     ${ADDR_PATHUMWAN_BKK}[province]
         ...     ${ADDR_PATHUMWAN_BKK}[postcode]
         ...     ${DS_REGIS['regmperson'][${reg_col.phone}]}
         ...     ${regis_psemail}

         #Company Contact Information  >>>   contactname    contactlastname   contactemail    contactphone
         ...     ${DS_REGIS['regmperson'][${reg_col.contactname}]}
         ...     ${DS_REGIS['regmperson'][${reg_col.contactlastname}]}
         ...     ${regis_pscontactmail}
         ...     ${DS_REGIS['regmperson'][${reg_col.contactphone}]}

         #Company upload path
         ...     ${IDCARD_JPGDATATEST}

         #User Information
            # >>> firstname   lastName  phone   email
         ...      ${DS_REGIS['regmperson'][${reg_col.firstname}]}
         ...      ${DS_REGIS['regmperson'][${reg_col.lastname}]}
         ...      ${DS_REGIS['regmperson'][${reg_col.userphone}]}
         ...      ${regis_psuseremail}

        #Login Information
          # >> username    password    confpassword
         ...      ${regis_psusername}
         ...      ${VAR_DEFAULT_PASSWORD}
         ...      ${VAR_DEFAULTPASSWORD}


CASE-Register Upload File Type is PDF
         #Company Information data - registerType  taxid   comtype   comname   companyBranch
         ...     ${REGISTYPE}[${DS_REGIS['regmlegal'][${reg_col.regisType}]}]
         ...     ${regis_comtaxid}
         ...     ${REGISCOMTYPE}[${DS_REGIS['regmlegal'][${reg_col.companyType}]}]
         ...     ${regis_companyname}
         ...     ${DS_REGIS['regmlegal'][${reg_col.companyBranch}]}

         #Company Address Information data  >>>  houseNum     moo   building    soi    street     subDistrict    district    province   postcode    phone    email
         ...     ${ADDR_JOMTHONG_BKK}[housenum]
         ...     ${ADDR_JOMTHONG_BKK}[moo]
         ...     ${ADDR_JOMTHONG_BKK}[building]
         ...     ${ADDR_JOMTHONG_BKK}[soi]
         ...     ${ADDR_JOMTHONG_BKK}[street]
         ...     ${ADDR_JOMTHONG_BKK}[subdistrict]
         ...     ${ADDR_JOMTHONG_BKK}[district]
         ...     ${ADDR_JOMTHONG_BKK}[province]
         ...     ${ADDR_JOMTHONG_BKK}[postcode]
         ...     ${DS_REGIS['regmlegal'][${reg_col.phone}]}
         ...     ${regis_companyemail}

         #Company Contact Information  >>>   contactname    contactlastname   contactemail    contactphone
         ...     ${DS_REGIS['regmlegal'][${reg_col.contactname}]}
         ...     ${DS_REGIS['regmlegal'][${reg_col.contactlastname}]}
         ...     ${regis_comcontactmail}
         ...     ${DS_REGIS['regmlegal'][${reg_col.contactphone}]}

         #Company upload path
         ...     ${IDCARD_PDFDATATEST}

         #User Information
            # >>> firstname   lastName  phone   email
         ...      ${DS_REGIS['regmlegal'][${reg_col.firstname}]}
         ...      ${DS_REGIS['regmlegal'][${reg_col.lastname}]}
         ...      ${DS_REGIS['regmlegal'][${reg_col.userphone}]}
         ...      ${regis_comuseremail}

        #Login Information
          # >> username    password    confpassword
         ...      ${regis_comusername}
         ...      ${VAR_DEFAULT_PASSWORD}
         ...      ${VAR_DEFAULTPASSWORD}


CASE-Register Upload File Type is JPEG
         #Company Information data - registerType  taxid   comtype   comname   companyBranch
         ...     ${REGISTYPE}[${DS_REGIS['regmlegal'][${reg_col.regisType}]}]
         ...     ${regis_comtaxid}
         ...     ${REGISCOMTYPE}[${DS_REGIS['regmlegal'][${reg_col.companyType}]}]
         ...     ${regis_companyname}
         ...     ${DS_REGIS['regmlegal'][${reg_col.companyBranch}]}

         #Company Address Information data  >>>  houseNum     moo   building    soi    street     subDistrict    district    province   postcode    phone    email
         ...     ${ADDR_JOMTHONG_BKK}[housenum]
         ...     ${ADDR_JOMTHONG_BKK}[moo]
         ...     ${ADDR_JOMTHONG_BKK}[building]
         ...     ${ADDR_JOMTHONG_BKK}[soi]
         ...     ${ADDR_JOMTHONG_BKK}[street]
         ...     ${ADDR_JOMTHONG_BKK}[subdistrict]
         ...     ${ADDR_JOMTHONG_BKK}[district]
         ...     ${ADDR_JOMTHONG_BKK}[province]
         ...     ${ADDR_JOMTHONG_BKK}[postcode]
         ...     ${DS_REGIS['regmlegal'][${reg_col.phone}]}
         ...     ${regis_companyemail}

         #Company Contact Information  >>>   contactname    contactlastname   contactemail    contactphone
         ...     ${DS_REGIS['regmlegal'][${reg_col.contactname}]}
         ...     ${DS_REGIS['regmlegal'][${reg_col.contactlastname}]}
         ...     ${regis_comcontactmail}
         ...     ${DS_REGIS['regmlegal'][${reg_col.contactphone}]}

         #Company upload path
         ...     ${IDCARD_JPGDATATEST}

         #User Information
            # >>> firstname   lastName  phone   email
         ...      ${DS_REGIS['regmlegal'][${reg_col.firstname}]}
         ...      ${DS_REGIS['regmlegal'][${reg_col.lastname}]}
         ...      ${DS_REGIS['regmlegal'][${reg_col.userphone}]}
         ...      ${regis_comuseremail}

        #Login Information
          # >> username    password    confpassword
         ...      ${regis_comusername}
         ...      ${VAR_DEFAULT_PASSWORD}
         ...      ${VAR_DEFAULTPASSWORD}

*** Keywords ***
Template Register is success
   [Arguments]    ${registerType}     ${taxid}              ${comtype}           ${comname}          ${companyBranch}      ${houseNum}       ${moo}
   ...            ${building}         ${soi}                ${street}            ${subDistrict}      ${district}           ${province}       ${postcode}       ${phone}        ${email}
   ...            ${contactname}      ${contactlastname}    ${contactemail}      ${contactphone}     ${uploadpath}
   ...            ${userfirstname}    ${userlastname}       ${userphone}         ${useremail}        ${username}           ${userpwd}        ${usercfpwd}

      Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
      ...       \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}. 
      Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version
      Log To Console    \nRegister Approve Auto Mode : ${GLOBAL_REGISTER_AUTO_APPRV}

      commonkeywords.Fill in data form    ${LOCATOR_VERIFYREGISTYPE_SEL}              ${registerType}
      commonkeywords.Fill in data form    ${LOCATOR_VERIFYREGISCOMTAXID_FIELD}        ${taxid}
      commonkeywords.Click button on detail page    ${LOCATOR_REGISNEXT_BTN}
      Sleep   500ms
      commonkeywords.Wait Loading progress
      commonkeywords.Verify data form       ${LOCATOR_REGISTYPE_SEL}            should be     ${registerType}
      commonkeywords.Verify data form       ${LOCATOR_REGISCOMPANYTAX_FIELD}    should be     ${taxid}
      commonkeywords.Verify Field State     ${LOCATOR_REGISTYPE_SEL}            disabled
      commonkeywords.Verify Field State     ${LOCATOR_REGISCOMPANYTAX_FIELD}    disabled

      pageRegister.Fill in Register Info
      ...     registertype=${registerType}
      ...     companytype=${comtype}
      ...     companyname=${comname}
      ...     companybranch=${companybranch}

      #Company Address Information data
      pageRegister.Fill in Register Company Address Info
      ...     houseNum=${houseNum}
      ...     moo=${moo}
      ...     building=${building}
      ...     soi=${soi}
      ...     street=${street}
      ...     subDistrict=${subDistrict}
      ...     district=${district}
      ...     province=${province}
      ...     postcode=${postcode}
      ...     phone=${phone}
      ...     email=${email}

      #Company Contact Information
      pageRegister.Fill in Register Contact Info
      ...     contactname=${contactname}
      ...     contactlastname=${contactlastname}
      ...     contactphone=${contactphone}
      ...     contactemail=${contactemail}

      commonkeywords.Click button on detail page    ${LOCATOR_REGISNEXT_BTN}

      # Attachment Document Infomation
      Sleep    1s
      commonkeywords.Wait Loading progress
      commonkeywords.Choose file to upload    ${LOCATOR_REGIS_ATTACHMENT}      ${uploadpath}
      commonkeywords.Wait Loading progress
      commonkeywords.Click button on detail page    ${LOCATOR_REGISNEXT_BTN}
      commonkeywords.Wait Loading progress

      #User Information
      pageRegister.Fill in Register User Info
      ...     userfirstname=${userfirstname}
      ...     userlastname=${userlastname}
      ...     useremail=${useremail}
      ...     userphone=${userphone}

      #Login Information
      pageRegister.Fill in Register Login Info
      ...     username=${username}
      ...     password=${userpwd}
      ...     cfpassword=${usercfpwd}

      commonkeywords.Click button on detail page      ${LOCATOR_SUBMITREGIS_BTN}
      PageRegister.Verify register is Successfully    ${LOCATOR_REGISTER_SUCCESS}
      commonkeywords.Click button on detail page      ${LOCATOR_REGISBACK_BTN}

      # ASSERTION
      # verify record in register list
      commonkeywords.Wait Loading progress
      commonkeywords.Verify Page Name is correct    ${menuname}[regMgt]
      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYREGISTYPE_SEL}        ${registerType}
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYREGISTAX_FILED}       ${taxid}
      commonkeywords.Click button on list page            ${LOCATOR_SEARCHREGIS_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Click Hide Search Criteria

      pageRegister.Verify Regis Management Result Datatable    1    type            should be     ${registerType}
      pageRegister.Verify Regis Management Result Datatable    1    taxid           should be     ${taxid}
      pageRegister.Verify Regis Management Result Datatable    1    name            contains      ${comname}
      pageRegister.Verify Regis Management Result Datatable    1    branch          should be     ${companyBranch}
      pageRegister.Verify Regis Management Result Datatable    1    registerdate    contains      ${GLOBAL_CURDATE_YMD}

      IF  '${GLOBAL_REGISTER_AUTO_APPRV}'=='True'
            pageRegister.Verify Regis Management Result Datatable    1     status     should be     ${REGISSTATUS}[appv]
      ELSE IF   '${GLOBAL_REGISTER_AUTO_APPRV}'=='False'
            pageRegister.Verify Regis Management Result Datatable    1     status     should be     ${REGISSTATUS}[waitappv]
      ELSE
            Fail    \nPlease Check 'Register Auto Approve Variable' should be any True or False.
      END

      commonkeywords.Click button on list page    ${1ROW_REGIS_ACTION}[view]
      commonkeywords.Wait Loading progress
      Sleep   1s

      pageRegister.Verify Register Info
      ...     registerType=${registerType}
      ...     taxid=${taxid}
      ...     comname=${comname}
      ...     companytype=${comtype}
      ...     companybranch=${companyBranch}

      pageRegister.Verify Register Company Address Info
      ...     houseNum=${houseNum}
      ...     moo=${moo}
      ...     building=${building}
      ...     soi=${soi}
      ...     street=${street}
      ...     subDistrict=${subDistrict}
      ...     district=${district}
      ...     province=${province}
      ...     postcode=${postcode}
      ...     phone=${phone}
      ...     email=${email}

      pageRegister.Verify Register Contact Info
      ...     contactname=${contactname}
      ...     contactlastname=${contactlastname}
      ...     contactemail=${contactemail}
      ...     contactphone=${contactphone}

      pageRegister.Verify Register User Login Info
      ...     userfirstname=${userfirstname}
      ...     userlastname=${userlastname}
      ...     userphone=${userphone}
      ...     useremail=${useremail}
      ...     username=${username}

      commonkeywords.Verify Button State    ${LOCATOR_REGISTER_VIEWATTACH}      visible

      pageRegister.Verify Register Info should disabled     ${registertype}
      pageRegister.Verify Register Company Address Info should disabled
      pageRegister.Verify Register Contact Info should disabled
      pageRegister.Verify Register User Login Info should disabled

      commonkeywords.Click xClose button  ${LOCATOR_XCLOSECOMPANY_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Verify Page Name is correct    ${menuname}[regMgt]
