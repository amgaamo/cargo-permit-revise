*** Settings ***
Resource        ../../resources/commonkeywords.resource

Suite setup       Run Keywords      dataSources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource REGISTER INFO DATA
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               datasources.Import DataSource ADDRESS DATA
...               AND               commonkeywords.Set Data for Run Automated Test 
...               AND               commonkeywords.Get Data Current Date
...               AND               commonkeywords.Generate Random Number    lengthno=8
...               AND               commonkeywords.Generate Random Values    lengthno=3    lenghtletter=3
...               AND               Set Suite Variable    ${regis_companyname}          ${DS_REGIS['apprvlegal'][${reg_col.companyName}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${regis_comtaxid}             ${DS_REGIS['apprvlegal'][${reg_col.taxid}]}${GLOBAL_GENNUMBER}
...               AND               Set Suite Variable    ${regis_companyemail}         ${DS_REGIS['apprvlegal'][${reg_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Set Suite Variable    ${regis_comcontactmail}       ${DS_REGIS['apprvlegal'][${reg_col.contactemail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Set Suite Variable    ${regis_comusername}          ${DS_REGIS['apprvlegal'][${reg_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${regis_comuseremail}         ${DS_REGIS['apprvlegal'][${reg_col.useremail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com

...               AND               Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}. 
...               AND               Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version

...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               pageRegister.Click Register Link
...               AND               pageRegister.Create Register Data Test
...                                   registerType=${REGISTYPE}[${DS_REGIS['apprvlegal'][${reg_col.regisType}]}]
...                                   taxid=${regis_comtaxid}
...                                   comtype=${REGISCOMTYPE}[${DS_REGIS['apprvlegal'][${reg_col.companyType}]}]
...                                   comname=${regis_companyname}
...                                   companyBranch=${DS_REGIS['apprvlegal'][${reg_col.companyBranch}]}
...                                   houseNum=${ADDR_PATHUMWAN_BKK}[housenum]          moo=${ADDR_PATHUMWAN_BKK}[moo]              building=${ADDR_PATHUMWAN_BKK}[building]    soi=${ADDR_PATHUMWAN_BKK}[soi]              street=${ADDR_PATHUMWAN_BKK}[street]
...                                   subDistrict=${ADDR_PATHUMWAN_BKK}[subdistrict]    district=${ADDR_PATHUMWAN_BKK}[district]    province=${ADDR_PATHUMWAN_BKK}[province]    postcode=${ADDR_PATHUMWAN_BKK}[postcode]
...                                   phone=${DS_REGIS['apprvlegal'][${reg_col.phone}]}
...                                   email=${regis_companyemail}
...                                   contactname=${DS_REGIS['apprvlegal'][${reg_col.contactname}]}    contactlastname=${DS_REGIS['apprvlegal'][${reg_col.contactlastname}]}    contactemail=${regis_comcontactmail}    contactphone=${DS_REGIS['apprvlegal'][${reg_col.contactphone}]}
...                                   uploadpath=${IDCARD_JPGDATATEST}
...                                   userfirstname=${DS_REGIS['apprvlegal'][${reg_col.firstname}]}    userlastname=${DS_REGIS['apprvlegal'][${reg_col.lastname}]}
...                                   userphone=${DS_REGIS['apprvlegal'][${reg_col.userphone}]}        useremail=${regis_comuseremail}
...                                   username=${regis_comusername}
...                                   userpwd=${VAR_DEFAULT_PASSWORD}

...               AND               commonkeywords.Login System     ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to MENU name                ${mainmenu}[registerMgt]
...               AND               commonkeywords.Verify Page Name is correct    ${menuname}[regMgt]

Test Teardown     Run Keywords    Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version
...               AND             Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}. 
...               AND             commonkeywords.Logout System

Suite Teardown    Run Keywords    Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.   
...               AND             commonkeywords.Release user lock and close all browser

*** Variables ***
${REJECT_REASON_VAL}        ตรวจสอบข้อมูลในส่วนของบริษัทไม่ตรงกับเอกสารแนบมาในระบบ

*** Test Cases ***
CASE-Reject Register Success
      Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
      ...       \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}. 
      Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version
      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYREGISTYPE_SEL}        ${REGISTYPE}[${DS_REGIS['apprvlegal'][${reg_col.regisType}]}]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYREGISTAX_FILED}       ${regis_comtaxid}
      commonkeywords.Click button on list page            ${LOCATOR_SEARCHREGIS_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Click Hide Search Criteria

      pageRegister.Verify Regis Management Result Datatable    1    type            should be     ${REGISTYPE}[${DS_REGIS['apprvlegal'][${reg_col.regisType}]}]
      pageRegister.Verify Regis Management Result Datatable    1    taxid           should be     ${regis_comtaxid}
      pageRegister.Verify Regis Management Result Datatable    1    name            contains      ${regis_companyname}
      pageRegister.Verify Regis Management Result Datatable    1    branch          should be     ${DS_REGIS['apprvlegal'][${reg_col.companyBranch}]}
      pageRegister.Verify Regis Management Result Datatable    1    registerdate    contains      ${GLOBAL_CURDATE_YMD}

      IF  '${GLOBAL_REGISTER_AUTO_APPRV}'=='True'
            pageRegister.Verify Regis Management Result Datatable    1      status         should be     ${REGISSTATUS}[appv]
            pageRegister.Verify Regis Management Result Datatable    1      approvedate    contains      ${GLOBAL_CURDATE_YMD}

      ELSE IF   '${GLOBAL_REGISTER_AUTO_APPRV}'=='False'
            pageRegister.Verify Regis Management Result Datatable    1      status          should be     ${REGISSTATUS}[waitappv]
            pageRegister.Verify Regis Management Result Datatable    1      approvedate     should be     -
      ELSE
            Fail    \nPlease Check 'Register Auto Approve Variable' should be any True or False.
      END

      commonkeywords.Click button on list page    ${1ROW_REGIS_ACTION}[view]
      commonkeywords.Wait Loading progress
      Sleep   1s

      pageRegister.Verify Register Info
      ...     registerType=${REGISTYPE}[${DS_REGIS['apprvlegal'][${reg_col.regisType}]}]
      ...     taxid=${regis_comtaxid}
      ...     comname=${regis_companyname}
      ...     companytype=${REGISCOMTYPE}[${DS_REGIS['apprvlegal'][${reg_col.companyType}]}]
      ...     companybranch=${DS_REGIS['apprvlegal'][${reg_col.companyBranch}]}

      commonkeywords.Verify data form    ${LOCATOR_REGISREJECT_REASON_FIELD}    should be     ${EMPTY}

      IF   '${GLOBAL_REGISTER_AUTO_APPRV}'=='False'
            commonkeywords.Fill in data form              ${LOCATOR_REGISREJECT_REASON_FIELD}    ${REJECT_REASON_VAL}
            commonkeywords.Click button on detail page    ${LOCATOR_REGISTER_REJECT_BTN}
            commonkeywords.Verify Modal Title message     Success
            commonkeywords.Verify Modal Content message   Reject completed
            commonkeywords.Click OK Button
      ELSE
            commonkeywords.Click button on detail page    ${LOCATOR_REGISBACK_BTN}
      END

      # Assertion
      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYREGISTYPE_SEL}        ${REGISTYPE}[${DS_REGIS['apprvlegal'][${reg_col.regisType}]}]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYREGISTAX_FILED}       ${regis_comtaxid}
      commonkeywords.Click button on list page            ${LOCATOR_SEARCHREGIS_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Click Hide Search Criteria

      IF   '${GLOBAL_REGISTER_AUTO_APPRV}'=='False'
            pageRegister.Verify Regis Management Result Datatable    1      status         should be     ${REGISSTATUS}[rej]
      ELSE
            pageRegister.Verify Regis Management Result Datatable    1      status         should be     ${REGISSTATUS}[appv]
      END

      pageRegister.Verify Regis Management Result Datatable          1      approvedate    contains      ${GLOBAL_CURDATE_YMD}

      commonkeywords.Click button on list page    ${1ROW_REGIS_ACTION}[view]
      commonkeywords.Wait Loading progress
      commonkeywords.Verify data form    ${LOCATOR_COMTAXID_FIELD}        should be    ${regis_comtaxid}
      commonkeywords.Verify data form    ${LOCATOR_COMNAME_FIELD}         should be    ${regis_companyname}

      IF   '${GLOBAL_REGISTER_AUTO_APPRV}'=='False'
            commonkeywords.Verify data form      ${LOCATOR_REGISREJECT_REASON_FIELD}   contains       ${REJECT_REASON_VAL}
      ELSE
            commonkeywords.Verify Field State    ${LOCATOR_REGISREJECT_REASON_FIELD}    disabled
      END

      commonkeywords.Verify Button State    ${LOCATOR_REGISTER_APPROVE_BTN}    hidden
      commonkeywords.Verify Button State    ${LOCATOR_REGISTER_REJECT_BTN}     hidden

      IF   '${GLOBAL_REGISTER_AUTO_APPRV}'=='False'
            commonkeywords.Logout System
            commonkeywords.Login System     ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
            commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[companyMgt]
            commonkeywords.Verify Page Name is correct    pagename=${menuname}[companyMgt]
            commonkeywords.Wait Loading progress
            commonkeywords.Click Expand Search Criteria
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYCOM_SEL}        ${COMSEARCHBY}[comname]
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHCOM_KEYWORD}      ${regis_companyname}
            commonkeywords.Click button on list page            ${LOCATOR_SEARCHCOM_BTN}
            commonkeywords.Click Hide Search Criteria
            commonkeywords.Wait Loading progress
            commonkeywords.Verify data table result is No Record Found    ${ROW_COMPANY_TBODY}

            commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[usermgt]
            commonkeywords.Verify Page Name is correct    pagename=${menuname}[usermgt]
            commonkeywords.Verify Page Name is correct    User Management
            commonkeywords.Click Expand Search Criteria
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYUSER_SEL}          ${USERSEARCHBY}[username]
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHUSER_KEYWORD}        ${regis_comusername}
            commonkeywords.Click button on list page            ${LOCATOR_SEARCHUSER_BTN}
            commonkeywords.Wait Loading progress
            commonkeywords.Click Hide Search Criteria
            commonkeywords.Wait Loading progress
            commonkeywords.Verify data table result is No Record Found    ${ROW_USER_TBODY}
      ELSE
            Pass Execution    Register Approve Auto Mode : ${GLOBAL_REGISTER_AUTO_APPRV}
      END
