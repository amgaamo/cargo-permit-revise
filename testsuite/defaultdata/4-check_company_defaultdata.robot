*** Settings ***
Resource      ../../resources/commonkeywords.resource

Suite Setup       Run Keywords      commonkeywords.Set Data for Run Automated Test
...               AND               Log    ${VAR_BOTVERSION} : ${GLOBAL_STANDARD_VERSION}      console=True
...               AND               Pass Execution If    '${GLOBAL_DEFAULTDATA_FUNCTEST}'=='False'             
...                                       \nNo Execute Create Default Data: GLOBAL_DEFAULTDATA_FUNCTEST is ${GLOBAL_DEFAULTDATA_FUNCTEST}. 
...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               Set Data for Run Automated Test
...               AND               commonkeywords.Open Browser and Go to website    ${URLTEST}

Suite Teardown    Run keywords      Pass Execution If    '${GLOBAL_DEFAULTDATA_FUNCTEST}'=='False'             
...                                       \nNo Execute Create Default Data: GLOBAL_DEFAULTDATA_FUNCTEST is ${GLOBAL_DEFAULTDATA_FUNCTEST}. 
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
Check Default Company Data is found in system

      Pass Execution If    '${GLOBAL_DEFAULTDATA_FUNCTEST}'=='False'             
      ...       \nNo Execute Create Default Data: GLOBAL_DEFAULTDATA_FUNCTEST is ${GLOBAL_DEFAULTDATA_FUNCTEST}. 
      

      Set Local Variable      ${defaultcustcompany01}      ${JS_DEFAULTDATA['companydata'][1]}
      Set Local Variable      ${defaultcustcompany02}      ${JS_DEFAULTDATA['companydata'][2]}
      Set Local Variable      ${defaultcustcompany03}      ${JS_DEFAULTDATA['companydata'][3]}
      Set Local Variable      ${defaultcustcompany04}      ${JS_DEFAULTDATA['companydata'][4]}
      Set Local Variable      ${defaultcompanypaging}      ${JS_DEFAULTDATA['companydata'][5]}

      Set Local Variable      ${defaultcomtype01}          ${JS_DEFAULTDATA['ctypedata'][0]}[ctypename]
      Set Local Variable      ${defaultcomtype02}          ${JS_DEFAULTDATA['ctypedata'][1]}[ctypename]
      Set Local Variable      ${defaultcomtype03}          ${JS_DEFAULTDATA['ctypedata'][2]}[ctypename]

      IF  '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
            Set Local Variable    ${var_companyType01}      ${defaultcustcompany01}[companytype]
            Set Local Variable    ${var_companyType03}      ${defaultcustcompany03}[companytype]

      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
          service-ctypemgt.Request Service Get Company Type Info    ${DS_LOGIN['robotapi'][${login_col.username}]}    ${DS_LOGIN['robotapi'][${login_col.password}]}    ${defaultcomtype01}
          Set Local Variable    ${var_companyType01}          ${GLOBAL_CTYPEID_DATA}
          Set Local Variable    ${var_companyType03}          ${GLOBAL_CTYPEID_DATA}
      ELSE
          Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'STANDARD' or 'IE5DEV'
      END

      Log To Console    \n

      service-companymgt.Request Service Add Default Company data test
      ...      headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...      registype=${defaultcustcompany01}[registertype]
      ...      ctypeid=${var_companyType01}
      ...      cname=${defaultcustcompany01}[companyname]
      ...      ctaxid=${defaultcustcompany01}[taxid]
      ...      cbranch=${defaultcustcompany01}[branch]
      ...      cemail=${defaultcustcompany01}[email]
      ...      limittrypwd=${defaultcustcompany01}[limitlogin]
      ...      limitusr=${defaultcustcompany01}[limituser]
      ...      pwdexpire=${defaultcustcompany01}[limitexpired]
      ...      limitrepeatpwd=${defaultcustcompany01}[limitrepeatpwd]
      ...      idlesession=${defaultcustcompany01}[limitsession]
      ...      limitsession=${defaultcustcompany01}[sessionexpired]

      Log To Console    \n\n***** Create Default Company: '${defaultcustcompany01}[companyname]' CHECK! *****\n\n

      service-companymgt.Request Service Add Default Company data test
      ...      headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...      registype=${defaultcustcompany03}[registertype]
      ...      ctypeid=${var_companyType03}
      ...      cname=${defaultcustcompany03}[companyname]
      ...      ctaxid=${defaultcustcompany03}[taxid]
      ...      cbranch=${defaultcustcompany03}[branch]
      ...      cemail=${defaultcustcompany03}[email]
      ...      limittrypwd=${defaultcustcompany03}[limitlogin]
      ...      limitusr=${defaultcustcompany03}[limituser]
      ...      pwdexpire=${defaultcustcompany03}[limitexpired]
      ...      limitrepeatpwd=${defaultcustcompany03}[limitrepeatpwd]
      ...      idlesession=${defaultcustcompany03}[limitsession]
      ...      limitsession=${defaultcustcompany03}[sessionexpired]
      Log To Console    \n\n***** Create Default Company: '${defaultcustcompany03}[companyname]' CHECK! *****\n\n

      Log To Console    \n

      IF  '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
            Set Local Variable    ${var_companyType02}      ${defaultcustcompany02}[companytype]

      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
          service-ctypemgt.Request Service Get Company Type Info    ${DS_LOGIN['robotapi'][${login_col.username}]}    ${DS_LOGIN['robotapi'][${login_col.password}]}    ${defaultcomtype02}
          Set Local Variable    ${var_companyType02}          ${GLOBAL_CTYPEID_DATA}
      ELSE
          Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'STANDARD' or 'IE5DEV'
      END

      service-companymgt.Request Service Add Default Company data test
      ...      headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...      registype=${defaultcustcompany02}[registertype]
      ...      ctypeid=${var_companyType02}
      ...      cname=${defaultcustcompany02}[companyname]
      ...      ctaxid=${defaultcustcompany02}[taxid]
      ...      cbranch=${defaultcustcompany02}[branch]
      ...      cemail=${defaultcustcompany02}[email]
      ...      limittrypwd=${defaultcustcompany02}[limitlogin]
      ...      limitusr=${defaultcustcompany02}[limituser]
      ...      pwdexpire=${defaultcustcompany02}[limitexpired]
      ...      limitrepeatpwd=${defaultcustcompany02}[limitrepeatpwd]
      ...      idlesession=${defaultcustcompany02}[limitsession]
      ...      limitsession=${defaultcustcompany02}[sessionexpired]

      Log To Console    \n\n***** Create Default Company: '${defaultcustcompany02}[companyname]' CHECK! *****\n\n

      Log To Console    \n

      IF  '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
            Set Local Variable    ${var_companyType03}      ${defaultcustcompany03}[companytype]

      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
          service-ctypemgt.Request Service Get Company Type Info    ${DS_LOGIN['robotapi'][${login_col.username}]}    ${DS_LOGIN['robotapi'][${login_col.password}]}    ${defaultcomtype03}
          Set Local Variable    ${var_companyType03}          ${GLOBAL_CTYPEID_DATA}
      ELSE
          Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'STANDARD' or 'IE5DEV'
      END

      service-companymgt.Request Service Add Default Company data test
      ...      headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...      registype=${defaultcustcompany02}[registertype]
      ...      ctypeid=${var_companyType03}
      ...      cname=${defaultcustcompany04}[companyname]
      ...      ctaxid=${defaultcustcompany04}[taxid]
      ...      cbranch=${defaultcustcompany04}[branch]
      ...      cemail=${defaultcustcompany04}[email]
      ...      limittrypwd=${defaultcustcompany04}[limitlogin]
      ...      limitusr=${defaultcustcompany04}[limituser]
      ...      pwdexpire=${defaultcustcompany04}[limitexpired]
      ...      limitrepeatpwd=${defaultcustcompany04}[limitrepeatpwd]
      ...      idlesession=${defaultcustcompany04}[limitsession]
      ...      limitsession=${defaultcustcompany04}[sessionexpired]

      Log To Console    \n\n***** Create Default Company: '${defaultcustcompany04}[companyname]' CHECK! *****\n\n

      IF   '${GLOBAL_COMPANY_AUTO_APPRV}'=='False'
            service-companymgt.Request Service Update Company Status
            ...     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
            ...     comname=${defaultcustcompany01}[companyname]
            ...     status=true

            service-companymgt.Request Service Update Company Status
            ...     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
            ...     comname=${defaultcustcompany02}[companyname]
            ...     status=true

            service-companymgt.Request Service Update Company Status
            ...     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
            ...     comname=${defaultcustcompany03}[companyname]
            ...     status=true

            service-companymgt.Request Service Update Company Status
            ...     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
            ...     comname=${defaultcustcompany04}[companyname]
            ...     status=true
      ELSE
            Log To Console      Company Approve Auto Mode : ${GLOBAL_COMPANY_AUTO_APPRV}
      END

      
      FOR   ${index}   IN RANGE   1     13
        ${runningindex}=    Evaluate    ${index}+44
        ${runningindex}=    Convert To String    ${runningindex}
        ${paging_company_taxid}=    Replace String    ${defaultcompanypaging}[taxid]          XX    ${runningindex}
        ${paging_company_Name}=     Replace String    ${defaultcompanypaging}[companyname]    XX    ${runningindex}
        ${paging_company_Email}=    Replace String    ${defaultcompanypaging}[email]          XX    ${runningindex}

        service-companymgt.Request Service Add Default Company data test
        ...      headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
        ...      registype=${defaultcompanypaging}[registertype]
        ...      ctypeid=${var_companyType03}
        ...      cname=${paging_company_Name}
        ...      ctaxid=${paging_company_taxid}
        ...      cbranch=${defaultcompanypaging}[branch]
        ...      cemail=${paging_company_Email}
        ...      limittrypwd=${defaultcompanypaging}[limitlogin]
        ...      limitusr=${defaultcompanypaging}[limituser]
        ...      pwdexpire=${defaultcompanypaging}[limitexpired]
        ...      limitrepeatpwd=${defaultcompanypaging}[limitrepeatpwd]
        ...      idlesession=${defaultcompanypaging}[limitsession]
        ...      limitsession=${defaultcompanypaging}[sessionexpired]
        Log To Console    \n\n***** Create/Update Data Paging Function Company: ${paging_company_Name}' CHECK! *****\n\n          
      END