*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource COMPANY INFO DATA
...               AND               datasources.Import DataSource ADDRESS DATA
...               AND               datasources.Import DataSource DEFAULT DATA                   
...               AND               commonkeywords.Generate Random Values    3    3
...               AND               commonkeywords.Generate Random Number    8
...               AND               Set Suite Variable    ${companyname_case1}            ${DS_COMPANY['createnewcom1'][${company_col.companyName}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${companytaxid_case1}           ${DS_COMPANY['createnewcom1'][${company_col.taxid}]}${GLOBAL_GENNUMBER}
...               AND               Set Suite Variable    ${companyemail_case1}           ${DS_COMPANY['createnewcom1'][${company_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com
...               AND               Set Suite Variable    ${companycontactmail_case1}     ${DS_COMPANY['createnewcom1'][${company_col.contactemail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

...               AND               Set Suite Variable    ${companyname_case2}            ${DS_COMPANY['createnewcom2'][${company_col.companyName}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${companytaxid_case2}           ${DS_COMPANY['createnewcom2'][${company_col.taxid}]}${GLOBAL_GENNUMBER}
...               AND               Set Suite Variable    ${companyemail_case2}           ${DS_COMPANY['createnewcom2'][${company_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com
...               AND               Set Suite Variable    ${companycontactmail_case2}     ${DS_COMPANY['createnewcom2'][${company_col.contactemail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.   
...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[companyMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[companyMgt]


Test Template     Template Add new Company is success

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
CASE1-Add new company is success

         #Company Information data - registerType  taxid   comtype   comname   companyBranch
         ...     ${COMREGISTYPE}[${DS_COMPANY['createnewcom1'][${company_col.registerType}]}]
         ...     ${companytaxid_case1}
         # ...     ${COMTYPE}[${DS_COMPANY['createnewcom1'][${company_col.companyType}]}]
         ...     ${companyname_case1}
         ...     ${DS_COMPANY['createnewcom1'][${company_col.companyBranch}]}

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
         ...     ${DS_COMPANY['createnewcom1'][${company_col.phone}]}
         ...     ${companyemail_case1}

         #Company Contact Information  >>>   contactname    contactlastname   contactemail    contactphone
         ...     ${DS_COMPANY['createnewcom1'][${company_col.contactname}]}
         ...     ${DS_COMPANY['createnewcom1'][${company_col.contactlastname}]}
         ...     ${DS_COMPANY['createnewcom1'][${company_col.contactphone}]}
         ...     ${companycontactmail_case1}


         #Company Policy Information
            # >>> stateunlimituser   stateunlimitloginattm  stateunlimitrepeatpwd   stateunlimitpwdexpired
         ...      uncheck    uncheck    uncheck    uncheck
            # >>> limituser      limitloginattm    limitrepeatpwd   limitpwdexpired  sessionexpired     limitlogin
         ...      ${DS_COMPANY['createnewcom1'][${company_col.limituser}]}
         ...      ${DS_COMPANY['createnewcom1'][${company_col.limitlogin}]}
         ...      ${DS_COMPANY['createnewcom1'][${company_col.limitrepeatpwd}]}
         ...      ${DS_COMPANY['createnewcom1'][${company_col.limitexpired}]}
         ...      ${DS_COMPANY['createnewcom1'][${company_col.limitsession}]}
         ...      ${DS_COMPANY['createnewcom1'][${company_col.sessionexpired}]}

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------#

CASE2-Add new company check unlimited policy information Success

         #Company Information data  >>>  registerType     taxid           comtype         comname           companyBranch
         ...     ${COMREGISTYPE}[${DS_COMPANY['createnewcom2'][${company_col.registerType}]}]
         ...     ${companytaxid_case2}
         # ...     ${COMTYPE}[${DS_COMPANY['createnewcom2'][${company_col.companyType}]}]
         ...     ${companyname_case2}
         ...     ${DS_COMPANY['createnewcom2'][${company_col.companyBranch}]}

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
         ...     ${DS_COMPANY['createnewcom2'][${company_col.phone}]}
         ...     ${companyemail_case2}

         #Company Contact Information  >>>   contactname    contactlastname   contactemail    contactphone
         ...     ${DS_COMPANY['createnewcom2'][${company_col.contactname}]}
         ...     ${DS_COMPANY['createnewcom2'][${company_col.contactlastname}]}
         ...     ${DS_COMPANY['createnewcom2'][${company_col.contactphone}]}
         ...     ${companycontactmail_case2}

         #Company Policy Information
            # >>> stateunlimituser   stateunlimitloginattm  stateunlimitrepeatpwd   stateunlimitpwdexpired
         ...      check    check    check    check
            # >>> limituser      limitloginattm    limitrepeatpwd   limitpwdexpired  sessionexpired     limitlogin
         ...      -1    -1   -1    -1
         ...      ${DS_COMPANY['createnewcom2'][${company_col.limitsession}]}
         ...      ${DS_COMPANY['createnewcom2'][${company_col.sessionexpired}]}


*** Keywords ***
Template Add new Company is success
   [Arguments]    ${registerType}   ${taxid}              ${comname}          ${companyBranch}      ${houseNum}           ${moo}      ${building}       ${soi}      ${street}
   ...            ${subDistrict}    ${district}           ${province}         ${postcode}           ${phone}              ${email}
   ...            ${contactname}    ${contactlastname}    ${contactphone}     ${contactemail}       ${stateunlimituser}   ${stateunlimitloginattm}   ${stateunlimitrepeatpwd}   ${stateunlimitpwdexpired}
   ...            ${limituser}      ${limitloginattm}     ${limitrepeatpwd}   ${limitpwdexpired}    ${sessionexpired}     ${limitlogin}

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.

      Set Local Variable    ${companytypestd}         ${COMTYPE}[${DS_COMPANY['createnewcom1'][${company_col.companyType}]}]
      Set Local Variable    ${companytypenew}         ${JS_DEFAULTDATA['ctypedata'][0]}[ctypename]

      IF  '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
            Set Local Variable    ${companytype_val}      ${companytypestd}

      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
          Set Local Variable    ${companytype_val}        ${companytypenew}
      ELSE
          Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'STANDARD' or 'IE5DEV'
      END

      commonkeywords.Wait Loading progress
      commonkeywords.Click button on list page      ${LOCATOR_ADDCOMP_BTN}
      commonkeywords.Verify Page Name is correct    Add Company
      commonkeywords.Wait Loading progress
      commonkeywords.Fill in data form    ${LOCATOR_COMREGISTYPE_SEL}       ${registerType}
      commonkeywords.Fill in data form    ${LOCATOR_COMTAXID_FIELD}         ${taxid}
      commonkeywords.Click button on detail page     ${LOCATOR_COMNEXT_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Verify data form    ${LOCATOR_COMREGISTYPE_SEL}     should be     ${registerType}
      commonkeywords.Verify data form    ${LOCATOR_COMTAXID_FIELD}       should be     ${taxid}

      #Company Information data
      pageCompanyMgt.Fill in Company Information Data    ${companytype_val}     ${comname}    ${registerType}    ${companyBranch}

      #Company Address Information data
      pageCompanyMgt.Fill in Address Information Data
      ...         ${houseNum}       ${moo}         ${building}    ${soi}        ${street}
      ...         ${subDistrict}    ${district}    ${province}    ${postcode}
      ...         ${phone}          ${email}

      #Company Contact Information
      pageCompanyMgt.Fill in Contact Information Data    ${contactname}    ${contactlastname}    ${contactemail}    ${contactphone}

      #Company Policy Information
      pageCompanyMgt.Fill in Company Policy Information
      ...         ${stateunlimituser}     ${stateunlimitloginattm}    ${stateunlimitrepeatpwd}    ${stateunlimitpwdexpired}
      ...         ${limituser}            ${limitloginattm}           ${limitrepeatpwd}           ${limitpwdexpired}          ${sessionexpired}    ${limitlogin}

      commonkeywords.Click button on detail page    ${LOCATOR_COMSAVE_BTN}
      commonkeywords.Verify Modal Title message     Success
      commonkeywords.Click OK Button

      # ASSERTION
      # verify record in company list
      commonkeywords.Verify Page Name is correct    Company Management

      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYCOM_SEL}        ${COMSEARCHBY}[comname]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHCOM_KEYWORD}      ${comname}
      commonkeywords.Click button on list page            ${LOCATOR_SEARCHCOM_BTN}
      commonkeywords.Click Hide Search Criteria
      commonkeywords.Wait Loading progress

      pageCompanyMgt.Verify Company Result Datatable    1     type                should be     ${registerType}
      pageCompanyMgt.Verify Company Result Datatable    1     companytaxid        should be     ${taxid}
      pageCompanyMgt.Verify Company Result Datatable    1     companyname         contains      ${comname}
      pageCompanyMgt.Verify Company Result Datatable    1     companytype         should be     ${companytype_val}

      IF  '${GLOBAL_COMPANY_AUTO_APPRV}'=='True'
            pageCompanyMgt.Verify Company Result Datatable    1     status              should be     ${COMSTATUS}[active]
      ELSE IF   '${GLOBAL_COMPANY_AUTO_APPRV}'=='False'
            pageCompanyMgt.Verify Company Result Datatable    1     status              should be     ${COMSTATUS}[inactive]
      ELSE
            Fail    \nPlease Check 'Company Auto Approve Variable' should be any True or False.
      END


      #verify company data info
      commonkeywords.Click button on list page             ${1ROW_COMPANY_ACTION}[edit]
      commonkeywords.Verify Page Name is correct           Edit Company
      commonkeywords.Wait Loading progress
      commonkeywords.Wait Loading progress

      #Company Information data
      pageCompanyMgt.Verify Company Information Data    ${registerType}    ${taxid}    ${companytype_val}    ${comname}    ${companyBranch}

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
      ...         ${limituser}         ${limitloginattm}    ${limitrepeatpwd}    ${limitpwdexpired}
      ...         ${sessionexpired}    ${limitlogin}

      Log To Console      \nTEST CASE VERIFIED.
      commonkeywords.Click xClose button    ${LOCATOR_XCLOSECOMPANY_BTN}
      commonkeywords.Verify Page Name is correct           Company Management
      service-groupmgt.Request Service Verify Group Company List is found
      ...       headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...       expcompany=${comname}
