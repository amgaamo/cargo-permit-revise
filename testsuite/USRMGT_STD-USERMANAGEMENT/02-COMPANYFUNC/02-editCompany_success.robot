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
...               AND               Set Suite Variable    ${companyname_case1}                ${DS_COMPANY['createnewcom1'][${company_col.companyName}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${companytaxid_case1}               ${DS_COMPANY['createnewcom1'][${company_col.taxid}]}${GLOBAL_GENNUMBER}
...               AND               Set Suite Variable    ${companyemail_case1}               ${DS_COMPANY['createnewcom1'][${company_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com
...               AND               Set Suite Variable    ${companyemail_editcase1}           xxx${DS_COMPANY['createnewcom1'][${company_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com
...               AND               Set Suite Variable    ${companycontactmail_editcase1}     xxx${DS_COMPANY['createnewcom1'][${company_col.contactemail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

...               AND               Set Suite Variable    ${companyname_case2}                ${DS_COMPANY['createnewcom2'][${company_col.companyName}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${companytaxid_case2}               ${DS_COMPANY['createnewcom2'][${company_col.taxid}]}${GLOBAL_GENNUMBER}
...               AND               Set Suite Variable    ${companyemail_case2}               ${DS_COMPANY['createnewcom2'][${company_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com
...               AND               Set Suite Variable    ${companyemail_editcase2}           xxx${DS_COMPANY['createnewcom2'][${company_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com
...               AND               Set Suite Variable    ${companycontactmail_editcase2}     xxx${DS_COMPANY['createnewcom2'][${company_col.contactemail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

...               AND               Set Suite Variable    ${companytypestd}     ${COMTYPE_ID}[customer]
...               AND               Set Suite Variable    ${companytypenew}     ${JS_DEFAULTDATA['ctypedata'][0]}[ctypename]
...               AND               Set Company Type Value Data
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.   
...               AND               commonkeywords.Initialize System and Go to Login Page

...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[companyMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[companyMgt]
    
...               AND               service-companymgt.Request Service Create New Company
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     registype=${COMREGISTYPE_ID}[legal]     ctypeid=${companytype_val}
...                                     cname=${companyname_case1}              ctaxid=${companytaxid_case1}     cbranch=00000    cemail=${companyemail_case1}
...                                     limittrypwd=5     limitusr=10     pwdexpire=10      limitrepeatpwd=5      idlesession=120     limitsession=180

...               AND               service-companymgt.Request Service Create New Company
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     registype=${COMREGISTYPE_ID}[legal]     ctypeid=${companytype_val}
...                                     cname=${companyname_case2}              ctaxid=${companytaxid_case2}     cbranch=00000    cemail=${companyemail_case2}
...                                     limittrypwd=10     limitusr=5     pwdexpire=5      limitrepeatpwd=10      idlesession=80     limitsession=150



Test Template     Template Edit Company is success

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
CASE1-Edit Company data is success
         #Company Information data - registerType  taxid   comtype   comname   companyBranch (edit field : comtype, companyBranch )
         ...     ${COMREGISTYPE}[legal]
         ...     ${companytaxid_case1}
         # ...     ${COMTYPE}[${DS_COMPANY['editcom1'][${company_col.companyType}]}]
         ...     ${companyname_case1}
         ...     ${DS_COMPANY['editcom1'][${company_col.companyBranch}]}

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
         ...     ${DS_COMPANY['editcom1'][${company_col.phone}]}
         ...     ${companyemail_editcase1}

         #Company Contact Information  >>>   contactname    contactlastname   contactemail    contactphone
         ...     ${DS_COMPANY['editcom1'][${company_col.contactname}]}
         ...     ${DS_COMPANY['editcom1'][${company_col.contactlastname}]}
         ...     ${DS_COMPANY['editcom1'][${company_col.contactphone}]}
         ...     ${companycontactmail_editcase1}

         #Company Policy Information
            # >>> stateunlimituser   stateunlimitloginattm  stateunlimitrepeatpwd   stateunlimitpwdexpired
         ...      uncheck    uncheck    uncheck    uncheck
            # >>> limituser      limitloginattm    limitrepeatpwd   limitpwdexpired  sessionexpired     limitlogin
         ...      ${DS_COMPANY['editcom1'][${company_col.limituser}]}
         ...      ${DS_COMPANY['editcom1'][${company_col.limitlogin}]}
         ...      ${DS_COMPANY['editcom1'][${company_col.limitrepeatpwd}]}
         ...      ${DS_COMPANY['editcom1'][${company_col.limitexpired}]}
         ...      ${DS_COMPANY['editcom1'][${company_col.limitsession}]}
         ...      ${DS_COMPANY['editcom1'][${company_col.sessionexpired}]}


CASE2-Edit Company data check unlimited policy information Success
         #Company Information data  >>>  registerType   taxid   comtype  comname   companyBranch  (edit field : comtype, companyBranch )
         ...     ${COMREGISTYPE}[legal]
         ...     ${companytaxid_case2}
         # ...     ${COMTYPE}[${DS_COMPANY['editcom2'][${company_col.companyType}]}]
         ...     ${companyname_case2}
         ...     ${DS_COMPANY['editcom2'][${company_col.companyBranch}]}

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
         ...     ${DS_COMPANY['editcom2'][${company_col.phone}]}
         ...     ${companyemail_editcase2}

         #Company Contact Information  >>>   contactname    contactlastname   contactemail    contactphone
         ...     ${DS_COMPANY['editcom2'][${company_col.contactname}]}
         ...     ${DS_COMPANY['editcom2'][${company_col.contactlastname}]}
         ...     ${DS_COMPANY['editcom2'][${company_col.contactphone}]}
         ...     ${companycontactmail_editcase2}

         #Company Policy Information
            # >>> stateunlimituser   stateunlimitloginattm  stateunlimitrepeatpwd   stateunlimitpwdexpired
         ...      check    check    check    check
            # >>> limituser      limitloginattm    limitrepeatpwd   limitpwdexpired  sessionexpired     limitlogin
         ...      -1    -1   -1    -1
         ...      ${DS_COMPANY['editcom2'][${company_col.limitsession}]}
         ...      ${DS_COMPANY['editcom2'][${company_col.sessionexpired}]}

*** Keywords ***
Set Company Type Value Data
      IF  '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
            Set Suite Variable    ${companytype_val}      ${companytypestd}
      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
            service-ctypemgt.Request Service Get Company Type Info    ${DS_LOGIN['robotapi'][${login_col.username}]}    ${DS_LOGIN['robotapi'][${login_col.password}]}    ${companytypenew}
            Set Suite Variable    ${companytype_val}      ${GLOBAL_CTYPEID_DATA}
      ELSE
          Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'STANDARD' or 'IE5DEV'
      END

Template Edit Company is success
   [Arguments]    ${registerType}   ${taxid}             ${comname}          ${companyBranch}      ${houseNum}     ${moo}   ${building}    ${soi}    ${street}     ${subDistrict}    ${district}    ${province}    ${postcode}    ${phone}    ${email}
   ...            ${contactname}    ${contactlastname}   ${contactphone}     ${contactemail}     ${stateunlimituser}   ${stateunlimitloginattm}   ${stateunlimitrepeatpwd}   ${stateunlimitpwdexpired}
   ...            ${limituser}      ${limitloginattm}    ${limitrepeatpwd}   ${limitpwdexpired}  ${sessionexpired}     ${limitlogin}

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.

      Set Local Variable    ${edit_companytypestd}         ${COMTYPE}[${DS_COMPANY['createnewcom1'][${company_col.companyType}]}]
      Set Local Variable    ${edit_companytypenew}         ${JS_DEFAULTDATA['ctypedata'][0]}[ctypename]

      IF  '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
            Set Local Variable    ${edit_companytype_val}      ${edit_companytypestd}

      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
          Set Local Variable    ${edit_companytype_val}        ${edit_companytypenew}
      ELSE
          Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'STANDARD' or 'IE5DEV'
      END

      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYCOM_SEL}        ${COMSEARCHBY}[comname]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHCOM_KEYWORD}      ${comname}
      commonkeywords.Click button on list page            ${LOCATOR_SEARCHCOM_BTN}
      commonkeywords.Click Hide Search Criteria
      commonkeywords.Wait Loading progress

      pageCompanyMgt.Verify Company Result Datatable    1     companytaxid        should be     ${taxid}
      pageCompanyMgt.Verify Company Result Datatable    1     companyname         contains      ${comname}
      pageCompanyMgt.Verify Company Result Datatable    1     status              should be     ${COMSTATUS}[active]

      #verify company data info
      commonkeywords.Click button on list page             ${1ROW_COMPANY_ACTION}[edit]
      commonkeywords.Verify Page Name is correct           Edit Company
      commonkeywords.Wait Loading progress

      commonkeywords.Verify Field State    ${LOCATOR_COMREGISTYPE_SEL}      disabled
      commonkeywords.Verify Field State    ${LOCATOR_COMTAXID_FIELD}        disabled
      commonkeywords.Verify Field State    ${LOCATOR_COMNAME_FIELD}         disabled
      commonkeywords.Verify Field State    ${LOCATOR_COMDISTRICT_FIELD}     disabled
      commonkeywords.Verify Field State    ${LOCATOR_COMPROVINCE_FIELD}     disabled

      #Edit Company Information data
      commonkeywords.Fill in data form     ${LOCATOR_COMPANYTYPE_SEL}        ${edit_companytype_val}

      IF  '${registerType}'=='${COMREGISTYPE}[legal]'
            commonkeywords.Verify Field State   ${LOCATOR_COMBRANCH_FIELD}     visible
            commonkeywords.Fill in data form    ${LOCATOR_COMBRANCH_FIELD}     ${companyBranch}
      ELSE
            commonkeywords.Verify Field State   ${LOCATOR_COMBRANCH_FIELD}    hidden
      END

      #Edit Company Address Information data
      pageCompanyMgt.Fill in Address Information Data
      ...         ${houseNum}       ${moo}         ${building}    ${soi}        ${street}
      ...         ${subDistrict}    ${district}    ${province}    ${postcode}
      ...         ${phone}          ${email}

      #Edit Company Contact Information
      pageCompanyMgt.Fill in Contact Information Data      ${contactname}    ${contactlastname}    ${contactemail}    ${contactphone}

      #Edit Company Policy Information
      pageCompanyMgt.Fill in Company Policy Information
      ...         ${stateunlimituser}     ${stateunlimitloginattm}    ${stateunlimitrepeatpwd}    ${stateunlimitpwdexpired}
      ...         ${limituser}            ${limitloginattm}           ${limitrepeatpwd}           ${limitpwdexpired}
      ...         ${sessionexpired}       ${limitlogin}

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
      pageCompanyMgt.Verify Company Result Datatable    1     companytype         should be     ${edit_companytype_val}

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

      #Company Information data
      pageCompanyMgt.Verify Company Information Data    ${registerType}    ${taxid}    ${edit_companytype_val}    ${comname}    ${companyBranch}

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
      commonkeywords.Verify Page Name is correct     Company Management
