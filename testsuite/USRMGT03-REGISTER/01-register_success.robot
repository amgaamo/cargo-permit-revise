*** Settings ***
Resource        ../../resources/commonkeywords.resource

Suite setup       Run Keywords      dataSources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource REGISTER INFO DATA
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               datasources.Import DataSource ADDRESS DATA
...               AND               commonkeywords.Set Data for Run Automated Test 
...               AND               Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.    
...               AND               commonkeywords.Get Data Current Date
...               AND               Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version
...               AND               commonkeywords.Initialize System and Go to Login Page


Test Setup        Run Keywords      commonkeywords.Generate Random Number    lengthno=8
...               AND               commonkeywords.Generate Random Values    lengthno=3    lenghtletter=3

...               AND               Set Test Variable    ${regis_companyname}          ${DS_REGIS['reglegal'][${reg_col.companyName}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Test Variable    ${regis_comtaxid}             ${DS_REGIS['reglegal'][${reg_col.taxid}]}${GLOBAL_GENNUMBER}
...               AND               Set Test Variable    ${regis_companyemail}         ${DS_REGIS['reglegal'][${reg_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Set Test Variable    ${regis_comcontactmail}       ${DS_REGIS['reglegal'][${reg_col.contactemail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Set Test Variable    ${regis_comusername}          ${DS_REGIS['reglegal'][${reg_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Test Variable    ${regis_comuseremail}         ${DS_REGIS['reglegal'][${reg_col.useremail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com

...               AND               Set Test Variable    ${regis_personname}          ${DS_REGIS['regperson'][${reg_col.companyName}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Test Variable    ${regis_pstaxid}             ${DS_REGIS['regperson'][${reg_col.taxid}]}${GLOBAL_GENNUMBER}
...               AND               Set Test Variable    ${regis_psemail}             ${DS_REGIS['regperson'][${reg_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Set Test Variable    ${regis_pscontactmail}       ${DS_REGIS['regperson'][${reg_col.contactemail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Set Test Variable    ${regis_psusername}          ${DS_REGIS['regperson'][${reg_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Test Variable    ${regis_psuseremail}         ${DS_REGIS['regperson'][${reg_col.useremail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.
...               AND               Pass Execution If   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version
...               AND               pageRegister.Click Register Link

Test Template     Template Register is success

Test Teardown     Run Keywords      Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version
...               AND               Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.
...               AND               commonkeywords.Logout System
   
Suite Teardown    Run Keywords      Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version
...               AND               Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.
...               AND               commonkeywords.Release user lock and close all browser


*** Test Cases ***
CASE-Register type Legal is success
         #Company Information data - registerType  taxid   comtype   comname   companyBranch
         ...     ${REGISTYPE}[${DS_REGIS['reglegal'][${reg_col.regisType}]}]
         ...     ${regis_comtaxid}
         ...     ${REGISCOMTYPE}[${DS_REGIS['reglegal'][${reg_col.companyType}]}]
         ...     ${regis_companyname}
         ...     ${DS_REGIS['reglegal'][${reg_col.companyBranch}]}

         #Company Address Information data  >>>  houseNum     moo   building    soi    street     subDistrict    district    province   postcode    phone    email
         ...     ${ADDR_MUANG_KKN}[housenum]
         ...     ${ADDR_MUANG_KKN}[moo]
         ...     ${ADDR_MUANG_KKN}[building]
         ...     ${ADDR_MUANG_KKN}[soi]
         ...     ${ADDR_MUANG_KKN}[street]
         ...     ${ADDR_MUANG_KKN}[subdistrict]
         ...     ${ADDR_MUANG_KKN}[district]
         ...     ${ADDR_MUANG_KKN}[province]
         ...     ${ADDR_MUANG_KKN}[postcode]
         ...     ${DS_REGIS['reglegal'][${reg_col.phone}]}
         ...     ${regis_companyemail}

         #Company Contact Information  >>>   contactname    contactlastname   contactemail    contactphone
         ...     ${DS_REGIS['reglegal'][${reg_col.contactname}]}
         ...     ${DS_REGIS['reglegal'][${reg_col.contactlastname}]}
         ...     ${regis_comcontactmail}
         ...     ${DS_REGIS['reglegal'][${reg_col.contactphone}]}

         #Company upload path
         ...     ${IDCARD_JPGDATATEST}

         #User Information
            # >>> firstname   lastName  phone   email
         ...      ${DS_REGIS['reglegal'][${reg_col.firstname}]}
         ...      ${DS_REGIS['reglegal'][${reg_col.lastname}]}
         ...      ${DS_REGIS['reglegal'][${reg_col.userphone}]}
         ...      ${regis_comuseremail}

        #Login Information
          # >> username    password    confpassword
         ...      ${regis_comusername}
         ...      ${VAR_DEFAULT_PASSWORD}
         ...      ${VAR_DEFAULTPASSWORD}


CASE-Register type Person is success
         #Company Information data - registerType  taxid   comtype   comname   companyBranch
         ...     ${REGISTYPE}[${DS_REGIS['regperson'][${reg_col.regisType}]}]
         ...     ${regis_pstaxid}
         ...     ${REGISCOMTYPE}[${DS_REGIS['regperson'][${reg_col.companyType}]}]
         ...     ${regis_personname}
         ...     ${DS_REGIS['regperson'][${reg_col.companyBranch}]}

         #Company Address Information data  >>>  houseNum     moo   building    soi    street     subDistrict    district    province   postcode    phone    email
         ...     ${ADDR_ARAN_SKW}[housenum]
         ...     ${ADDR_ARAN_SKW}[moo]
         ...     ${ADDR_ARAN_SKW}[building]
         ...     ${ADDR_ARAN_SKW}[soi]
         ...     ${ADDR_ARAN_SKW}[street]
         ...     ${ADDR_ARAN_SKW}[subdistrict]
         ...     ${ADDR_ARAN_SKW}[district]
         ...     ${ADDR_ARAN_SKW}[province]
         ...     ${ADDR_ARAN_SKW}[postcode]
         ...     ${DS_REGIS['regperson'][${reg_col.phone}]}
         ...     ${regis_psemail}

         #Company Contact Information  >>>   contactname    contactlastname   contactemail    contactphone
         ...     ${DS_REGIS['regperson'][${reg_col.contactname}]}
         ...     ${DS_REGIS['regperson'][${reg_col.contactlastname}]}
         ...     ${regis_pscontactmail}
         ...     ${DS_REGIS['regperson'][${reg_col.contactphone}]}

         #Company upload path
         ...     ${IDCARD_JPGDATATEST}

         #User Information
            # >>> firstname   lastName  phone   email
         ...      ${DS_REGIS['regperson'][${reg_col.firstname}]}
         ...      ${DS_REGIS['regperson'][${reg_col.lastname}]}
         ...      ${DS_REGIS['regperson'][${reg_col.userphone}]}
         ...      ${regis_psuseremail}

        #Login Information
          # >> username    password    confpassword
         ...      ${regis_psusername}
         ...      ${VAR_DEFAULT_PASSWORD}
         ...      ${VAR_DEFAULTPASSWORD}


CASE-Register Upload File Type is PDF
         #Company Information data - registerType  taxid   comtype   comname   companyBranch
         ...     ${REGISTYPE}[${DS_REGIS['reglegal'][${reg_col.regisType}]}]
         ...     ${regis_comtaxid}
         ...     ${REGISCOMTYPE}[${DS_REGIS['reglegal'][${reg_col.companyType}]}]
         ...     ${regis_companyname}
         ...     ${DS_REGIS['reglegal'][${reg_col.companyBranch}]}

         #Company Address Information data  >>>  houseNum     moo   building    soi    street     subDistrict    district    province   postcode    phone    email
         ...     ${ADDR_MUANG_KKN}[housenum]
         ...     ${ADDR_MUANG_KKN}[moo]
         ...     ${ADDR_MUANG_KKN}[building]
         ...     ${ADDR_MUANG_KKN}[soi]
         ...     ${ADDR_MUANG_KKN}[street]
         ...     ${ADDR_MUANG_KKN}[subdistrict]
         ...     ${ADDR_MUANG_KKN}[district]
         ...     ${ADDR_MUANG_KKN}[province]
         ...     ${ADDR_MUANG_KKN}[postcode]
         ...     ${DS_REGIS['reglegal'][${reg_col.phone}]}
         ...     ${regis_companyemail}

         #Company Contact Information  >>>   contactname    contactlastname   contactemail    contactphone
         ...     ${DS_REGIS['reglegal'][${reg_col.contactname}]}
         ...     ${DS_REGIS['reglegal'][${reg_col.contactlastname}]}
         ...     ${regis_comcontactmail}
         ...     ${DS_REGIS['reglegal'][${reg_col.contactphone}]}

         #Company upload path
         ...     ${IDCARD_PDFDATATEST}

         #User Information
            # >>> firstname   lastName  phone   email
         ...      ${DS_REGIS['reglegal'][${reg_col.firstname}]}
         ...      ${DS_REGIS['reglegal'][${reg_col.lastname}]}
         ...      ${DS_REGIS['reglegal'][${reg_col.userphone}]}
         ...      ${regis_comuseremail}

        #Login Information
          # >> username    password    confpassword
         ...      ${regis_comusername}
         ...      ${VAR_DEFAULT_PASSWORD}
         ...      ${VAR_DEFAULTPASSWORD}


CASE-Register Upload File Type is JPEG
         #Company Information data - registerType  taxid   comtype   comname   companyBranch
         ...     ${REGISTYPE}[${DS_REGIS['reglegal'][${reg_col.regisType}]}]
         ...     ${regis_comtaxid}
         ...     ${REGISCOMTYPE}[${DS_REGIS['reglegal'][${reg_col.companyType}]}]
         ...     ${regis_companyname}
         ...     ${DS_REGIS['reglegal'][${reg_col.companyBranch}]}

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
         ...     ${DS_REGIS['reglegal'][${reg_col.phone}]}
         ...     ${regis_companyemail}

         #Company Contact Information  >>>   contactname    contactlastname   contactemail    contactphone
         ...     ${DS_REGIS['reglegal'][${reg_col.contactname}]}
         ...     ${DS_REGIS['reglegal'][${reg_col.contactlastname}]}
         ...     ${regis_comcontactmail}
         ...     ${DS_REGIS['reglegal'][${reg_col.contactphone}]}

         #Company upload path
         ...     ${IDCARD_JPGDATATEST}

         #User Information
            # >>> firstname   lastName  phone   email
         ...      ${DS_REGIS['reglegal'][${reg_col.firstname}]}
         ...      ${DS_REGIS['reglegal'][${reg_col.lastname}]}
         ...      ${DS_REGIS['reglegal'][${reg_col.userphone}]}
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
          ...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.
          Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version
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
          commonkeywords.Verify Login Page
          commonkeywords.Login System     ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}

          commonkeywords.Go to MENU name                ${mainmenu}[registerMgt]
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
