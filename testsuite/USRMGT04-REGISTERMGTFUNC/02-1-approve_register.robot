*** Settings ***
Resource        ../../resources/commonkeywords.resource

Suite setup       Run Keywords      dataSources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource REGISTER INFO DATA
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               datasources.Import DataSource ADDRESS DATA
...               AND               commonkeywords.Set Data for Run Automated Test 
...               AND               commonkeywords.Get Data Current Date
...               AND               Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version
...               AND               commonkeywords.Initialize System and Go to Login Page

Test Setup        Run Keywords      commonkeywords.Generate Random Number    lengthno=8
...               AND               commonkeywords.Generate Random Values    lengthno=3    lenghtletter=3

...               AND               Set Test Variable    ${regis_companyname}          ${DS_REGIS['apprvlegal'][${reg_col.companyName}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Test Variable    ${regis_comtaxid}             ${DS_REGIS['apprvlegal'][${reg_col.taxid}]}${GLOBAL_GENNUMBER}
...               AND               Set Test Variable    ${regis_companyemail}         ${DS_REGIS['apprvlegal'][${reg_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Set Test Variable    ${regis_comcontactmail}       ${DS_REGIS['apprvlegal'][${reg_col.contactemail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Set Test Variable    ${regis_comusername}          ${DS_REGIS['apprvlegal'][${reg_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Test Variable    ${regis_comuseremail}         ${DS_REGIS['apprvlegal'][${reg_col.useremail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com

...               AND               Set Test Variable    ${regis_personname}           ${DS_REGIS['apprvperson'][${reg_col.companyName}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Test Variable    ${regis_pstaxid}              ${DS_REGIS['apprvperson'][${reg_col.taxid}]}${GLOBAL_GENNUMBER}
...               AND               Set Test Variable    ${regis_psemail}              ${DS_REGIS['apprvperson'][${reg_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Set Test Variable    ${regis_pscontactmail}        ${DS_REGIS['apprvperson'][${reg_col.contactemail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Set Test Variable    ${regis_psusername}           ${DS_REGIS['apprvperson'][${reg_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Test Variable    ${regis_psuseremail}          ${DS_REGIS['apprvperson'][${reg_col.useremail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}. 
...               AND               Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version
...               AND               pageRegister.Click Register Link

Test Template     Template Approve Register Data

Test Teardown     Run Keywords    Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version
...               AND             Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}. 
...               AND             commonkeywords.Logout System

Suite Teardown    Run Keywords    Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.   
...               AND             commonkeywords.Release user lock and close all browser

*** Test Cases ***
CASE-Approve Register Legal Type
         #Company Information data - registerType  taxid   comtype   comname   companyBranch
         ...     ${REGISTYPE}[${DS_REGIS['apprvlegal'][${reg_col.regisType}]}]
         ...     ${regis_comtaxid}
         ...     ${REGISCOMTYPE}[${DS_REGIS['apprvlegal'][${reg_col.companyType}]}]
         ...     ${regis_companyname}
         ...     ${DS_REGIS['apprvlegal'][${reg_col.companyBranch}]}

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
         ...     ${DS_REGIS['apprvlegal'][${reg_col.phone}]}
         ...     ${regis_companyemail}

         #Company Contact Information  >>>   contactname    contactlastname   contactemail    contactphone
         ...     ${DS_REGIS['apprvlegal'][${reg_col.contactname}]}
         ...     ${DS_REGIS['apprvlegal'][${reg_col.contactlastname}]}
         ...     ${regis_comcontactmail}
         ...     ${DS_REGIS['apprvlegal'][${reg_col.contactphone}]}

         #Company upload path
         ...     ${IDCARD_JPGDATATEST}

         #User Information
            # >>> firstname   lastName  phone   email
         ...      ${DS_REGIS['apprvlegal'][${reg_col.firstname}]}
         ...      ${DS_REGIS['apprvlegal'][${reg_col.lastname}]}
         ...      ${DS_REGIS['apprvlegal'][${reg_col.userphone}]}
         ...      ${regis_comuseremail}

        #Login Information
          # >> username    password    confpassword
         ...      ${regis_comusername}
         ...      ${VAR_DEFAULT_PASSWORD}


CASE-Approve Register Person Type
         #Company Information data - registerType  taxid   comtype   comname   companyBranch
         ...     ${REGISTYPE}[${DS_REGIS['apprvperson'][${reg_col.regisType}]}]
         ...     ${regis_pstaxid}
         ...     ${REGISCOMTYPE}[${DS_REGIS['apprvperson'][${reg_col.companyType}]}]
         ...     ${regis_personname}
         ...     ${DS_REGIS['apprvperson'][${reg_col.companyBranch}]}

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
         ...     ${DS_REGIS['apprvperson'][${reg_col.phone}]}
         ...     ${regis_psemail}

         #Company Contact Information  >>>   contactname    contactlastname   contactemail    contactphone
         ...     ${DS_REGIS['apprvperson'][${reg_col.contactname}]}
         ...     ${DS_REGIS['apprvperson'][${reg_col.contactlastname}]}
         ...     ${regis_pscontactmail}
         ...     ${DS_REGIS['apprvperson'][${reg_col.contactphone}]}

         #Company upload path
         ...     ${IDCARD_JPGDATATEST}

         #User Information
            # >>> firstname   lastName  phone   email
         ...      ${DS_REGIS['apprvperson'][${reg_col.firstname}]}
         ...      ${DS_REGIS['apprvperson'][${reg_col.lastname}]}
         ...      ${DS_REGIS['apprvperson'][${reg_col.userphone}]}
         ...      ${regis_psuseremail}

        #Login Information
          # >> username    password    confpassword
         ...      ${regis_psusername}
         ...      ${VAR_DEFAULT_PASSWORD}


*** Keywords ***
Template Approve Register Data
   [Arguments]    ${registerType}     ${taxid}              ${comtype}           ${comname}          ${companyBranch}      ${houseNum}       ${moo}
   ...            ${building}         ${soi}                ${street}            ${subDistrict}      ${district}           ${province}       ${postcode}       ${phone}        ${email}
   ...            ${contactname}      ${contactlastname}    ${contactemail}      ${contactphone}     ${uploadpath}
   ...            ${userfirstname}    ${userlastname}       ${userphone}         ${useremail}        ${username}           ${userpwd}

      Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
      ...       \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}. 
      Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version

      pageRegister.Create Register Data Test
      ...       ${registerType}     ${taxid}              ${comtype}          ${comname}          ${companyBranch}
      ...       ${houseNum}         ${moo}                ${building}         ${soi}              ${street}                  ${subDistrict}    ${district}    ${province}    ${postcode}
      ...       ${phone}            ${email}
      ...       ${contactname}      ${contactlastname}    ${contactemail}     ${contactphone}
      ...       ${uploadpath}
      ...       ${userfirstname}    ${userlastname}       ${userphone}        ${useremail}
      ...       ${username}         ${userpwd}

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
            pageRegister.Verify Regis Management Result Datatable    1      status         should be     ${REGISSTATUS}[appv]
            pageRegister.Verify Regis Management Result Datatable    1      approvedate    contains      ${GLOBAL_CURDATE_YMD}

      ELSE IF   '${GLOBAL_REGISTER_AUTO_APPRV}'=='False'
            pageRegister.Verify Regis Management Result Datatable    1      status          should be     ${REGISSTATUS}[waitappv]
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

      pageRegister.Verify Register Info should disabled     ${registertype}
      pageRegister.Verify Register Company Address Info should disabled
      pageRegister.Verify Register Contact Info should disabled
      pageRegister.Verify Register User Login Info should disabled

      IF  '${GLOBAL_REGISTER_AUTO_APPRV}'=='True'
            Log To Console    \nStatus Approved. Mode Register Approve is auto approve.
            commonkeywords.Click button on detail page    ${LOCATOR_REGISBACK_BTN}


      ELSE IF   '${GLOBAL_REGISTER_AUTO_APPRV}'=='False'
            commonkeywords.Click button on detail page    ${LOCATOR_REGISTER_APPROVE_BTN}
            commonkeywords.Verify Modal Title message       Success
            commonkeywords.Verify Modal Content message     Approved completed
            commonkeywords.Click OK Button
      ELSE
            Fail    \nPlease Check 'Register Auto Approve Variable' should be any True or False.
      END

      commonkeywords.Verify Page Name is correct    ${menuname}[regMgt]

      # Assertion
      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYREGISTYPE_SEL}        ${registerType}
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYREGISTAX_FILED}       ${taxid}
      commonkeywords.Click button on list page            ${LOCATOR_SEARCHREGIS_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Click Hide Search Criteria

      pageRegister.Verify Regis Management Result Datatable    1    name           contains       ${comname}
      pageRegister.Verify Regis Management Result Datatable    1    status         should be      ${REGISSTATUS}[appv]
      pageRegister.Verify Regis Management Result Datatable    1    approvedate    contains       ${GLOBAL_CURDATE_YMD}

      commonkeywords.Click button on list page    ${1ROW_REGIS_ACTION}[view]
      commonkeywords.Wait Loading progress
      Sleep   1s

      pageRegister.Verify Register Info
      ...     registerType=${registerType}
      ...     taxid=${taxid}
      ...     comname=${comname}
      ...     companytype=${comtype}
      ...     companybranch=${companyBranch}

      commonkeywords.Verify Field State    ${LOCATOR_REGISTER_APPROVE_BTN}      hidden
      commonkeywords.Verify Field State    ${LOCATOR_REGISTER_REJECT_BTN}       hidden

      ############################## Assertion Company Data  ##############################

      commonkeywords.Logout System
      commonkeywords.Verify Login Page
      commonkeywords.Login System     ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
      commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[companyMgt]
      commonkeywords.Verify Page Name is correct    pagename=${menuname}[companyMgt]
      commonkeywords.Wait Loading progress
      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYCOM_SEL}        ${COMSEARCHBY}[comname]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHCOM_KEYWORD}      ${comname}
      commonkeywords.Click button on list page            ${LOCATOR_SEARCHCOM_BTN}
      commonkeywords.Click Hide Search Criteria
      commonkeywords.Wait Loading progress

      pageCompanyMgt.Verify Company Result Datatable    1     type                should be     ${registerType}
      pageCompanyMgt.Verify Company Result Datatable    1     companytaxid        should be     ${taxid}
      pageCompanyMgt.Verify Company Result Datatable    1     companyname         contains      ${comname}
      pageCompanyMgt.Verify Company Result Datatable    1     companytype         should be     ${comtype}
      pageCompanyMgt.Verify Company Result Datatable    1     status              should be     ${COMSTATUS}[active]

      #verify company data info
      commonkeywords.Click button on list page             ${1ROW_COMPANY_ACTION}[edit]
      commonkeywords.Verify Page Name is correct           Edit Company
      commonkeywords.Wait Loading progress
      commonkeywords.Wait Loading progress

      #Company Information data
      pageCompanyMgt.Verify Company Information Data    ${registerType}    ${taxid}    ${comtype}    ${comname}    ${companyBranch}

      #Company Address Information data
      pageCompanyMgt.Verify Company Address Information Data
      ...         ${houseNum}       ${moo}         ${building}    ${soi}      ${street}
      ...         ${subDistrict}    ${district}    ${province}    ${postcode}
      ...         ${phone}          ${email}

      #Company Contact Information
      pageCompanyMgt.Verify Contact Information Data
      ...         ${contactname}    ${contactlastname}    ${contactemail}    ${contactphone}

      #Company Policy Information
      pageCompanyMgt.Verify Company Policy Information
      ...         limituser=-1           limitloginattm=-1    limitrepeatpwd=-1    limitpwdexpired=-1
      ...         sessionexpired=15      limitlogin=1440

      commonkeywords.Click xClose button    ${LOCATOR_XCLOSECOMPANY_BTN}
      commonkeywords.Verify Page Name is correct           Company Management

      ############################## Assertion User Data  ##############################

      commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[usermgt]
      commonkeywords.Verify Page Name is correct    pagename=${menuname}[usermgt]

      commonkeywords.Verify Page Name is correct    User Management
      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYUSER_SEL}          ${USERSEARCHBY}[username]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHUSER_KEYWORD}        ${username}
      commonkeywords.Click button on list page            ${LOCATOR_SEARCHUSER_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Click Hide Search Criteria
      commonkeywords.Wait Loading progress

      pageUserMgt.Verify User Result Datatable    1    name             contains      ${userfirstname}
      pageUserMgt.Verify User Result Datatable    1    name             contains      ${userlastname}
      pageUserMgt.Verify User Result Datatable    1    username         should be     ${username}
      pageUserMgt.Verify User Result Datatable    1    companyname      contains      ${comname}
      pageUserMgt.Verify User Result Datatable    1    email            should be     ${useremail}
      pageUserMgt.Verify User Result Datatable    1    approve          should be     Y
      pageUserMgt.Verify User Result Datatable    1    status           should be     ${USERSTATUS}[active]

      IF   '${registerType}'=='${COMREGISTYPE}[legal]'
            pageUserMgt.Verify User Result Datatable    1    group      should be     officer admin       ignore_case=true
      ELSE IF   '${registerType}'=='${COMREGISTYPE}[person]'
            pageUserMgt.Verify User Result Datatable    1    group      should be     personal            ignore_case=true
      ELSE
            Fail    Register Type is incorrect, please check data!
      END

      #verify use data info

      commonkeywords.Click button on list page      ${1ROW_USER_ACTION}[edit]
      commonkeywords.Verify Page Name is correct    Edit User
      commonkeywords.Wait Loading progress
      commonkeywords.Verify data form       ${LOCATOR_USERCOMPANY_SEL}      should be    ${comname}

      IF   '${registerType}'=='${COMREGISTYPE}[legal]'
            commonkeywords.Verify data form       ${LOCATOR_USERGROUP_SEL}      should be    OFFICER ADMIN
      ELSE IF   '${registerType}'=='${COMREGISTYPE}[person]'
            commonkeywords.Verify data form       ${LOCATOR_USERGROUP_SEL}      should be    PERSONAL
      ELSE
            Fail    Register Type is incorrect, please check data!
      END

      commonkeywords.Verify Field State     ${LOCATOR_USERUSRNAME_FIELD}    disabled
      commonkeywords.Verify Field State     ${LOCATOR_USERPWD_FIELD}        disabled

      pageUserMgt.Verify user profile Info
      ...     username=${username}
      ...     firstname=${userfirstname}
      ...     lastname=${userlastname}
      ...     phone=${userphone}
      ...     email=${useremail}

      commonkeywords.Click xClose button    ${LOCATOR_XCLOSEUSER_BTN}
      commonkeywords.Verify Page Name is correct    User Management

      commonkeywords.Logout System
      commonkeywords.Verify Login Page
      commonkeywords.Login System     ${username}    ${userpwd}
      commonkeywords.Verify Welcome page
      commonkeywords.Verify Profile Detail data    ${LOCATOR_USRNAME_WELCOME_BAR}      ${username}

      Log To Console      TEST CASE VERIFIED.
