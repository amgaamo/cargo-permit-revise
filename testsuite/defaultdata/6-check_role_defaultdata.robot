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
Check Default Role Data is found in system

      Pass Execution If    '${GLOBAL_DEFAULTDATA_FUNCTEST}'=='False'             
      ...       \nNo Execute Create Default Data: GLOBAL_DEFAULTDATA_FUNCTEST is ${GLOBAL_DEFAULTDATA_FUNCTEST}. 
      
      Set Local Variable      ${default_adminrole01}          ${JS_DEFAULTDATA['roledata'][0]}[rolename]
      Set Local Variable      ${default_adminrole02}          ${JS_DEFAULTDATA['roledata'][1]}[rolename]
      Set Local Variable      ${default_supportrole}          ${JS_DEFAULTDATA['roledata'][2]}[rolename]
      Set Local Variable      ${default_custrole}             ${JS_DEFAULTDATA['roledata'][3]}[rolename]

      Set Local Variable      ${super_robotrole}              ${JS_DEFAULTDATA['roledata'][4]}[rolename]
      Set Local Variable      ${custadmin_robotrole}          ${JS_DEFAULTDATA['roledata'][5]}[rolename]

      Set Local Variable      ${defaultmainmenu}              ${JS_DEFAULTDATA['menudata'][0]}[menuname]
      Set Local Variable      ${defaultsubmenu01}             ${JS_DEFAULTDATA['menudata'][1]}[menuname]
      Set Local Variable      ${defaultsubmenu02}             ${JS_DEFAULTDATA['menudata'][2]}[menuname]
      Set Local Variable      ${defaultsubmenu03}             ${JS_DEFAULTDATA['menudata'][3]}[menuname]

      Set Local Variable      ${defaultperm01}                ${JS_DEFAULTDATA['permdata'][0]}[permissioncode]
      Set Local Variable      ${defaultperm02}                ${JS_DEFAULTDATA['permdata'][1]}[permissioncode]
      Set Local Variable      ${defaultperm03}                ${JS_DEFAULTDATA['permdata'][2]}[permissioncode]

      Set Local Variable      ${defaultcustcompany01}         ${JS_DEFAULTDATA['companydata'][1]}[companyname]
      Set Local Variable      ${defaultcustcompany02}         ${JS_DEFAULTDATA['companydata'][2]}[companyname]
      Set Local Variable      ${defaultcustcompany03}         ${JS_DEFAULTDATA['companydata'][3]}[companyname]

      service-menumgt.Create Data List of Menu
      ...     ${DS_LOGIN['robotapi'][${login_col.username}]}            ${DS_LOGIN['robotapi'][${login_col.password}]}
      ...     ${defaultmainmenu}     ${defaultsubmenu01}     ${defaultsubmenu02}      ${defaultsubmenu03}

      service-permmgt.Create Data List of Permission
      ...     ${DS_LOGIN['robotapi'][${login_col.username}]}           ${DS_LOGIN['robotapi'][${login_col.password}]}
      ...     ${defaultperm01}       ${defaultperm02}        ${defaultperm03}

      IF  '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
            service-rolemgt.Request Service Add Default Role data test
            ...     ${DS_LOGIN['robotapi'][${login_col.username}]}      ${DS_LOGIN['robotapi'][${login_col.password}]}
            ...     ${default_adminrole01}
            ...     ${GLOBAL_MENUDATALIST}    ${GLOBAL_PERMDATALIST}

            service-rolemgt.Request Service Add Default Role data test
            ...     ${DS_LOGIN['robotapi'][${login_col.username}]}      ${DS_LOGIN['robotapi'][${login_col.password}]}
            ...     ${default_adminrole02}
            ...     ${GLOBAL_MENUDATALIST}    ${GLOBAL_PERMDATALIST}

            service-rolemgt.Request Service Add Default Role data test
            ...     ${DS_LOGIN['robotapi'][${login_col.username}]}      ${DS_LOGIN['robotapi'][${login_col.password}]}
            ...     ${default_supportrole}
            ...     ${GLOBAL_MENUDATALIST}    ${GLOBAL_PERMDATALIST}

            service-rolemgt.Request Service Add Default Role data test
            ...     ${DS_LOGIN['robotapi'][${login_col.username}]}      ${DS_LOGIN['robotapi'][${login_col.password}]}
            ...     ${default_custrole}
            ...     ${GLOBAL_MENUDATALIST}     ${GLOBAL_PERMDATALIST}
            
            FOR   ${index}   IN RANGE   1     13
                ${runningindex}=      Evaluate    ${index}+44
                ${runningindex}=      Convert To String    ${runningindex}
                
                service-rolemgt.Request Service Add Default Role data test
                ...     ${DS_LOGIN['robotapi'][${login_col.username}]}      ${DS_LOGIN['robotapi'][${login_col.password}]}
                ...     XBOTPAGING_ROLE${runningindex}
                ...     ${GLOBAL_MENUDATALIST}     ${GLOBAL_PERMDATALIST}                
                Log To Console    \n\n***** Create Default Role (XBOTPAGING_ROLE${runningindex}) : CHECK! *****\n\n
            END

      ELSE IF  '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
            service-rolemgt.Request Service Add Default Role data test
            ...     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
            ...     ${default_adminrole01}
            ...     ${GLOBAL_MENUDATALIST}        ${GLOBAL_PERMDATALIST}
            ...     ${defaultcustcompany01}

            service-rolemgt.Request Service Add Default Role data test
            ...     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
            ...     ${default_adminrole02}
            ...     ${GLOBAL_MENUDATALIST}        ${GLOBAL_PERMDATALIST}
            ...     ${defaultcustcompany01}

            service-rolemgt.Request Service Add Default Role data test
            ...     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
            ...     ${default_supportrole}
            ...     ${GLOBAL_MENUDATALIST}        ${GLOBAL_PERMDATALIST}
            ...     ${defaultcustcompany01}

            service-rolemgt.Request Service Add Default Role data test
            ...     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
            ...     ${default_custrole}
            ...     ${GLOBAL_MENUDATALIST}        ${GLOBAL_PERMDATALIST}
            ...     ${defaultcustcompany01}
      
            FOR   ${index}   IN RANGE   1     13
                ${runningindex}=      Evaluate    ${index}+44
                ${runningindex}=      Convert To String    ${runningindex}
                
                service-rolemgt.Request Service Add Default Role data test
                ...     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
                ...     XBOTPAGING_ROLE${runningindex}
                ...     ${GLOBAL_MENUDATALIST}        ${GLOBAL_PERMDATALIST}
                ...     ${defaultcustcompany01}             
                Log To Console    \n\n***** Create Paging Function Role (ROLE_PAGING${runningindex}) : CHECK! *****\n\n
            END
      
      ELSE
            Fail    \nPlease Check 'GLOBAL_STANDARD_VERSION' variable should any 'IE5DEV' or 'STANDARD'
      END
      Log To Console    \n\n***** Create Default Role (${default_adminrole01}, ${default_adminrole02}, ${default_supportrole}, ${default_custrole}) : CHECK! *****\n\n

      #---------------------------------------------------------#

      service-menumgt.Create Data List of Menu
      ...     ${DS_LOGIN['robotapi'][${login_col.username}]}            ${DS_LOGIN['robotapi'][${login_col.password}]}
      ...     ${VAR_MENUNAME_MAINCONF}       ${VAR_MENUNAME_COMPANYMGT}      ${VAR_MENUNAME_GROUPMGT}      ${VAR_MENUNAME_USERMGT}
      service-permmgt.Create Data List of Permission
      ...     ${DS_LOGIN['robotapi'][${login_col.username}]}           ${DS_LOGIN['robotapi'][${login_col.password}]}
      ...     ${VAR_PERM_COMPANYMGT}[0]      ${VAR_PERM_COMPANYMGT}[1]       ${VAR_PERM_COMPANYMGT}[2]
      ...     ${VAR_PERM_USERMGT}[0]         ${VAR_PERM_USERMGT}[1]          ${VAR_PERM_USERMGT}[2]    ${VAR_PERM_USERMGT}[3]    ${VAR_PERM_USERMGT}[4]    ${VAR_PERM_USERMGT}[5]
      ...     ${VAR_PERM_GROUPMGT}[0]        ${VAR_PERM_GROUPMGT}[1]         ${VAR_PERM_GROUPMGT}[2]

      IF  '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
          service-rolemgt.Request Service Add Default Role data test
          ...     ${DS_LOGIN['robotapi'][${login_col.username}]}      ${DS_LOGIN['robotapi'][${login_col.password}]}
          ...     ${super_robotrole}
          ...     ${GLOBAL_MENUDATALIST}    ${GLOBAL_PERMDATALIST}

      ELSE IF  '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
          service-rolemgt.Request Service Add Default Role data test
          ...     ${DS_LOGIN['robotapi'][${login_col.username}]}      ${DS_LOGIN['robotapi'][${login_col.password}]}
          ...     ${super_robotrole}
          ...     ${GLOBAL_MENUDATALIST}    ${GLOBAL_PERMDATALIST}
          ...     ${defaultcustcompany01}
      ELSE
          Fail    \nPlease Check 'GLOBAL_STANDARD_VERSION' variable should any 'IE5DEV' or 'STANDARD'
      END

      service-menumgt.Create Data List of Menu
      ...     ${DS_LOGIN['robotapi'][${login_col.username}]}            ${DS_LOGIN['robotapi'][${login_col.password}]}
      ...     ${VAR_MENUNAME_MAINCONF}       ${VAR_MENUNAME_GROUPMGT}        ${VAR_MENUNAME_USERMGT}
      service-permmgt.Create Data List of Permission
      ...     ${DS_LOGIN['robotapi'][${login_col.username}]}           ${DS_LOGIN['robotapi'][${login_col.password}]}
      ...     ${VAR_PERM_USERMGT}[0]         ${VAR_PERM_USERMGT}[1]          ${VAR_PERM_USERMGT}[2]    ${VAR_PERM_USERMGT}[3]    ${VAR_PERM_USERMGT}[4]    ${VAR_PERM_USERMGT}[5]
      ...     ${VAR_PERM_GROUPMGT}[0]        ${VAR_PERM_GROUPMGT}[1]         ${VAR_PERM_GROUPMGT}[2]

      IF  '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
          service-rolemgt.Request Service Add Default Role data test
          ...     ${DS_LOGIN['robotapi'][${login_col.username}]}      ${DS_LOGIN['robotapi'][${login_col.password}]}
          ...     ${custadmin_robotrole}
          ...     ${GLOBAL_MENUDATALIST}    ${GLOBAL_PERMDATALIST}

      ELSE IF  '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
          service-rolemgt.Request Service Add Default Role data test
          ...     ${DS_LOGIN['robotapi'][${login_col.username}]}      ${DS_LOGIN['robotapi'][${login_col.password}]}
          ...     ${custadmin_robotrole}
          ...     ${GLOBAL_MENUDATALIST}    ${GLOBAL_PERMDATALIST}
          ...     ${defaultcustcompany01}

          service-rolemgt.Request Service Add Default Role data test
          ...     ${DS_LOGIN['robotapi'][${login_col.username}]}      ${DS_LOGIN['robotapi'][${login_col.password}]}
          ...     ${custadmin_robotrole}
          ...     ${GLOBAL_MENUDATALIST}    ${GLOBAL_PERMDATALIST}
          ...     ${defaultcustcompany02}

      ELSE
          Fail    \nPlease Check 'GLOBAL_STANDARD_VERSION' variable should any 'IE5DEV' or 'STANDARD'
      END

      Log To Console    \n\n***** Create Default Role ('${super_robotrole}', '${custadmin_robotrole}') : CHECK! *****\n\n
