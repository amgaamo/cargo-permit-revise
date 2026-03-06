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
Check Default Permission Data is found in system

      Pass Execution If    '${GLOBAL_DEFAULTDATA_FUNCTEST}'=='False'             
      ...       \nNo Execute Create Default Data: GLOBAL_DEFAULTDATA_FUNCTEST is ${GLOBAL_DEFAULTDATA_FUNCTEST}. 
      
      Set Local Variable    ${defaultperm01}          ${JS_DEFAULTDATA['permdata'][0]}
      Set Local Variable    ${defaultperm02}          ${JS_DEFAULTDATA['permdata'][1]}
      Set Local Variable    ${defaultperm03}          ${JS_DEFAULTDATA['permdata'][2]}

      service-permmgt.Request Service Delete by Permission Code
      ...       headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...       permcode=${defaultperm01}[permissioncode]

      service-permmgt.Request Service Delete by Permission Code
      ...       headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...       permcode=${defaultperm02}[permissioncode]

      service-permmgt.Request Service Delete by Permission Code
      ...       headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...       permcode=${defaultperm03}[permissioncode]

      service-permmgt.Request Service Create Permission
      ...       headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...       permcode=${defaultperm01}[permissioncode]

      service-permmgt.Request Service Create Permission
      ...       headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...       permcode=${defaultperm02}[permissioncode]

      service-permmgt.Request Service Create Permission
      ...       headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...       permcode=${defaultperm03}[permissioncode]

      Log To Console    \n\n***** Create Default Permission (Permission Code-'${defaultperm01}[permissioncode]' , '${defaultperm02}[permissioncode]', '${defaultperm03}[permissioncode])' : CHECK! *****\n\n


    FOR   ${index}   IN RANGE   1     13
        ${runningindex}=      Evaluate    ${index}+44
        ${runningindex}=      Convert To String    ${runningindex}

      service-permmgt.Request Service Delete by Permission Code
      ...       headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...       permcode=XBOTPAGING_PERM${runningindex}

      service-permmgt.Request Service Create Permission
      ...       headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...       permcode=XBOTPAGING_PERM${runningindex}
      
       Log To Console    \n\n***** Create Paging Function Permission (PERM_PAGING${runningindex}): CHECK! *****\n\n
    END