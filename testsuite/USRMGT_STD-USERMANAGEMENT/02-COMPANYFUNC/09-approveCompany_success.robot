*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               datasources.Import DataSource COMPANY INFO DATA
...               AND               datasources.Import DataSource ADDRESS DATA
...               AND               Set Suite Variable    ${VAR_DEFAULTCOMNAME_SYS}     ${JS_DEFAULTDATA['companydata'][0]}[companyname]
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Initialize System and Go to Login Page

Test Setup        Run Keywords      commonkeywords.Generate Random Values    3    3
...               AND               commonkeywords.Generate Random Number    8
...               AND               Set Test Variable    ${companyname}          ${DS_COMPANY['createappvcom'][${company_col.companyName}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Test Variable    ${companytaxid}         ${DS_COMPANY['createappvcom'][${company_col.taxid}]}${GLOBAL_GENNUMBER}
...               AND               Set Test Variable    ${companyemail}         ${DS_COMPANY['createappvcom'][${company_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Set Test Variable    ${companycontactmail}   ${DS_COMPANY['createappvcom'][${company_col.contactemail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com       
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[companyMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[companyMgt]
...               AND               commonkeywords.Wait Loading progress

Test Template     Template Approve Company Data
Test Teardown     Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Logout System

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
#-------------------------------------------------------------------------------------------------------------------------#
#                           Case Name                          | Case Type | is_sysCom |  Company Name                    #
#-------------------------------------------------------------------------------------------------------------------------#
CASE-Approve new company is success                                 add          N       ${companyname}
CASE-Approve edit company is success                                edit         N       ${companyname}
CASE-Approve auto for edit super system company is success          edit         Y       ${VAR_DEFAULTCOMNAME_SYS}


*** Keywords ***
Template Approve Company Data
    [Arguments]   ${casetype}     ${is_sysCompany}     ${companyname_case}
      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
      
      Set Local Variable    ${companytypestd}         ${COMTYPE}[${DS_COMPANY['createappvcom'][${company_col.companyType}]}]
      Set Local Variable    ${companytypestd_id}      ${COMTYPE_ID}[officer]

      Set Local Variable    ${companytypenew}         ${JS_DEFAULTDATA['ctypedata'][0]}[ctypename]

      IF  '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
            Set Local Variable    ${companytype_val}      ${companytypestd}
            Set Local Variable    ${companytype_id}       ${companytypestd_id}

      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
            service-ctypemgt.Request Service Get Company Type Info    ${DS_LOGIN['robotapi'][${login_col.username}]}    ${DS_LOGIN['robotapi'][${login_col.password}]}    ${companytypenew}
            Set Local Variable    ${companytype_id}            ${GLOBAL_CTYPEID_DATA}
            Set Local Variable    ${companytype_val}           ${companytypenew}
      ELSE
            Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'STANDARD' or 'IE5DEV'
      END

      IF  '${casetype}'=='add'
          commonkeywords.Click button on list page      ${LOCATOR_ADDCOMP_BTN}
          commonkeywords.Verify Page Name is correct    Add Company
          commonkeywords.Wait Loading progress
          commonkeywords.Fill in data form    ${LOCATOR_COMREGISTYPE_SEL}       ${COMREGISTYPE}[${DS_COMPANY['createappvcom'][${company_col.registerType}]}]
          commonkeywords.Fill in data form    ${LOCATOR_COMTAXID_FIELD}         ${companytaxid}
          commonkeywords.Click button on detail page     ${LOCATOR_COMNEXT_BTN}
          commonkeywords.Wait Loading progress
          commonkeywords.Verify data form    ${LOCATOR_COMREGISTYPE_SEL}     should be     ${COMREGISTYPE}[${DS_COMPANY['createappvcom'][${company_col.registerType}]}]
          commonkeywords.Verify data form    ${LOCATOR_COMTAXID_FIELD}       should be     ${companytaxid}

          #Company Information data
          pageCompanyMgt.Fill in Company Information Data
          ...     comtype=${companytype_val}
          ...     comname=${companyname}
          ...     registerType=${COMREGISTYPE}[${DS_COMPANY['createappvcom'][${company_col.registerType}]}]
          ...     companyBranch=${DS_COMPANY['createappvcom'][${company_col.companyBranch}]}

          #Company Address Information data
          pageCompanyMgt.Fill in Address Information Data
          ...     houseNum=${ADDR_PATHUMWAN_BKK}[housenum]
          ...     moo=${ADDR_PATHUMWAN_BKK}[moo]
          ...     building=${ADDR_PATHUMWAN_BKK}[building]
          ...     soi=${ADDR_PATHUMWAN_BKK}[soi]
          ...     street=${ADDR_PATHUMWAN_BKK}[street]
          ...     subDistrict=${ADDR_PATHUMWAN_BKK}[subdistrict]
          ...     district=${ADDR_PATHUMWAN_BKK}[district]
          ...     province=${ADDR_PATHUMWAN_BKK}[province]
          ...     postcode=${ADDR_PATHUMWAN_BKK}[postcode]
          ...     phone=${DS_COMPANY['createappvcom'][${company_col.phone}]}
          ...     email=${companyemail}

          #Company Contact Information
          pageCompanyMgt.Fill in Contact Information Data
          ...     contactname=${DS_COMPANY['createappvcom'][${company_col.contactname}]}
          ...     contactlastname=${DS_COMPANY['createappvcom'][${company_col.contactlastname}]}
          ...     contactemail=${companycontactmail}
          ...     contactphone=${DS_COMPANY['createappvcom'][${company_col.contactphone}]}

          #Company Policy Information
          pageCompanyMgt.Fill in Company Policy Information
          ...     stateunlimituser=uncheck
          ...     stateunlimitloginattm=uncheck
          ...     stateunlimitrepeatpwd=uncheck
          ...     stateunlimitpwdexpired=uncheck
          ...     limituser=${DS_COMPANY['createappvcom'][${company_col.limituser}]}
          ...     limitloginattm=${DS_COMPANY['createappvcom'][${company_col.limitlogin}]}
          ...     limitrepeatpwd=${DS_COMPANY['createappvcom'][${company_col.limitrepeatpwd}]}
          ...     limitpwdexpired=${DS_COMPANY['createappvcom'][${company_col.limitexpired}]}
          ...     sessionexpired=${DS_COMPANY['createappvcom'][${company_col.limitsession}]}
          ...     limitlogin=${DS_COMPANY['createappvcom'][${company_col.sessionexpired}]}

          commonkeywords.Click button on detail page    ${LOCATOR_COMSAVE_BTN}
          commonkeywords.Verify Modal Title message     Success
          commonkeywords.Click OK Button

          commonkeywords.Verify Page Name is correct    Company Management

      ELSE IF  '${casetype}'=='edit'
          IF   '${is_sysCompany}'=='N'
                service-companymgt.Request Service Create New Company
                ...     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
                ...     registype=${COMREGISTYPE_ID}[legal]     ctypeid=${companytype_id}
                ...     cname=${companyname}      ctaxid=${companytaxid}     cbranch=00000    cemail=${companyemail}
                ...     limittrypwd=5             limitusr=10                pwdexpire=10     limitrepeatpwd=5          idlesession=120     limitsession=180

                IF  '${GLOBAL_COMPANY_AUTO_APPRV}'=='True'
                      Log To Console    \nCompany Approve Auto Mode : ${GLOBAL_COMPANY_AUTO_APPRV}

                ELSE IF  '${GLOBAL_COMPANY_AUTO_APPRV}'=='False'
                      service-companymgt.Request Service Update Company Status
                      ...   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
                      ...   comname=${companyname}
                      ...   status=true
                ELSE
                      Fail    \nPlease Check 'Company Auto Approve Variable' should be any True or False.
                END

          ELSE IF   '${is_sysCompany}'=='Y'
                Log To Console    \nTest CASE-Approve auto for edit super system company ('${VAR_DEFAULTCOMNAME_SYS}')
          ELSE
               Fail    \nPlease Check '{is_sysCompany} arg.' should be any 'Y' or 'N'
          END

          commonkeywords.Click Expand Search Criteria
          commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYCOM_SEL}        ${COMSEARCHBY}[comname]
          commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHCOM_KEYWORD}      ${companyname_case}
          commonkeywords.Click button on list page            ${LOCATOR_SEARCHCOM_BTN}
          commonkeywords.Click Hide Search Criteria
          commonkeywords.Wait Loading progress
          pageCompanyMgt.Verify Company Result Datatable      1    companyname      contains     ${companyname_case}
          pageCompanyMgt.Verify Company Result Datatable      1    status           should be    ${COMSTATUS}[active]

          commonkeywords.Click button on list page            ${1ROW_COMPANY_ACTION}[edit]
          commonkeywords.Verify Page Name is correct          Edit Company
          commonkeywords.Wait Loading progress

          commonkeywords.Verify data form     ${LOCATOR_COMNAME_FIELD}       should be    ${companyname_case}

          commonkeywords.Fill in data form    ${LOCATOR_COMPHONE_FIELD}               026201888
          commonkeywords.Fill in data form    ${LOCATOR_COMCONTACTPHONE_FIELD}        021190099
          commonkeywords.Click button on detail page    ${LOCATOR_COMSAVE_BTN}
          commonkeywords.Verify Modal Title message     Success
          commonkeywords.Click OK Button
          commonkeywords.Wait Loading progress
          commonkeywords.Verify Page Name is correct    Company Management
      ELSE
          Fail    \nPlease Check '{casetype} arg.' should be any 'add' or 'edit'
      END

##### ASSERTION #####
      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYCOM_SEL}        ${COMSEARCHBY}[comname]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHCOM_KEYWORD}      ${companyname_case}
      commonkeywords.Click button on list page            ${LOCATOR_SEARCHCOM_BTN}
      commonkeywords.Click Hide Search Criteria
      commonkeywords.Wait Loading progress
      pageCompanyMgt.Verify Company Result Datatable      1    companyname      contains     ${companyname_case}

      IF  '${GLOBAL_COMPANY_AUTO_APPRV}'=='True'
           pageCompanyMgt.Verify Company Result Datatable    1     status     should be     ${COMSTATUS}[active]
           Log To Console    \nCompany Approve Auto Mode : ${GLOBAL_COMPANY_AUTO_APPRV}

      ELSE IF   '${GLOBAL_COMPANY_AUTO_APPRV}'=='False'
          IF    '${is_sysCompany}'=='N'
                pageCompanyMgt.Verify Company Result Datatable    1     status     should be     ${COMSTATUS}[inactive]
          ELSE IF  '${is_sysCompany}'=='Y'
                pageCompanyMgt.Verify Company Result Datatable    1     status     should be     ${COMSTATUS}[active]
          ELSE
               Fail    \nPlease Check '{is_sysCompany} arg.' should be any 'Y' or 'N'
          END
      ELSE
          Fail    \nPlease Check 'Company Auto Approve Variable' should be any True or False.
      END

      # Admin User2 Approve Company
      IF   '${GLOBAL_COMPANY_AUTO_APPRV}'=='False'
          IF   '${is_sysCompany}'=='N'
                commonkeywords.Logout System
                commonkeywords.Login System    ${DS_LOGIN['robotadmin2'][${login_col.username}]}   ${DS_LOGIN['robotadmin2'][${login_col.password}]}
                commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[companyMgt]
                commonkeywords.Verify Page Name is correct    pagename=${menuname}[companyMgt]
                commonkeywords.Wait Loading progress
                commonkeywords.Click Expand Search Criteria
                commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYCOM_SEL}        ${COMSEARCHBY}[comname]
                commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHCOM_KEYWORD}      ${companyname_case}
                commonkeywords.Click button on list page            ${LOCATOR_SEARCHCOM_BTN}
                commonkeywords.Click Hide Search Criteria
                commonkeywords.Wait Loading progress
                pageCompanyMgt.Verify Company Result Datatable      1    companyname    contains      ${companyname_case}
                pageCompanyMgt.Verify Company Result Datatable      1    status         should be     ${COMSTATUS}[inactive]

                commonkeywords.Click button on list page       ${1ROW_COMPANY_ACTION}[changeStatus]
                commonkeywords.Verify Modal Title message      Warning
                commonkeywords.Verify Modal Content message    change this company status
                commonkeywords.Click Yes Button for confirm
                commonkeywords.Click OK Button
                commonkeywords.Wait Loading progress
                pageCompanyMgt.Verify Company Result Datatable      1    status         should be     ${COMSTATUS}[active]
           ELSE IF   '${is_sysCompany}'=='Y'
                Log To Console    \nCase Auto Approve
           ELSE
                Log to Console    \nPlease Check '{is_sysCompany} arg.' should be any 'Y' or 'N'
           END
      ELSE IF   '${GLOBAL_COMPANY_AUTO_APPRV}'=='True'
              Log To Console      \nCase Auto Approve
      ELSE
          Fail    \nPlease Check '{GLOBAL_COMPANY_AUTO_APPRV} arg.' should be any 'True' or 'False'
      END
