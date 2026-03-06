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
Check Default Company Type Data is found in system

      Pass Execution If    '${GLOBAL_DEFAULTDATA_FUNCTEST}'=='False'             
      ...       \nNo Execute Create Default Data: GLOBAL_DEFAULTDATA_FUNCTEST is ${GLOBAL_DEFAULTDATA_FUNCTEST}. 
      
      Set Local Variable      ${defaultmainmenu}              ${JS_DEFAULTDATA['menudata'][0]}[menuname]
      Set Local Variable      ${defaultsubmenu01}             ${JS_DEFAULTDATA['menudata'][1]}[menuname]
      Set Local Variable      ${defaultsubmenu02}             ${JS_DEFAULTDATA['menudata'][2]}[menuname]
      Set Local Variable      ${defaultsubmenu03}             ${JS_DEFAULTDATA['menudata'][3]}[menuname]
      Set Local Variable      ${defaultsubmenu04}             ${JS_DEFAULTDATA['menudata'][4]}[menuname]

      Set Local Variable      ${defaultcomtype01}             ${JS_DEFAULTDATA['ctypedata'][0]}
      Set Local Variable      ${defaultcomtype02}             ${JS_DEFAULTDATA['ctypedata'][1]}
      Set Local Variable      ${defaultcomtype03}             ${JS_DEFAULTDATA['ctypedata'][2]}

      IF  '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
          Pass Execution    \nTest Cases for User Standard Version IE5DEV Version
      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
          service-ctypemgt.Request Service Add Company Type Data
          ...     ${DS_LOGIN['robotapi'][${login_col.username}]}    ${DS_LOGIN['robotapi'][${login_col.password}]}
          ...     ${defaultcomtype01}[ctype]
          ...     ${defaultcomtype01}[ctypename]
          ...     ${defaultmainmenu}            ${defaultsubmenu01}           ${defaultsubmenu02}           ${defaultsubmenu03}           ${defaultsubmenu04}
          ...     ${VAR_MENUNAME_MAINCONF}      ${VAR_MENUNAME_USERMGT}       ${VAR_MENUNAME_GROUPMGT}      ${VAR_MENUNAME_COMPANYMGT}

          service-ctypemgt.Request Service Add Company Type Data
          ...     ${DS_LOGIN['robotapi'][${login_col.username}]}    ${DS_LOGIN['robotapi'][${login_col.password}]}
          ...     ${defaultcomtype02}[ctype]
          ...     ${defaultcomtype02}[ctypename]
          ...     ${VAR_MENUNAME_MAINCONF}      ${VAR_MENUNAME_USERMGT}       ${VAR_MENUNAME_GROUPMGT}     ${VAR_MENUNAME_COMPANYMGT}

          service-ctypemgt.Request Service Add Company Type Data
          ...     ${DS_LOGIN['robotapi'][${login_col.username}]}    ${DS_LOGIN['robotapi'][${login_col.password}]}
          ...     ${defaultcomtype03}[ctype]
          ...     ${defaultcomtype03}[ctypename]
          ...     ${defaultmainmenu}            ${defaultsubmenu01}           ${defaultsubmenu02}           ${defaultsubmenu03}           ${defaultsubmenu04}

        FOR   ${index}   IN RANGE   1     13
            ${runningindex}=    Evaluate    ${index}+44
            ${runningindex}=    Convert To String    ${runningindex}
            
            service-ctypemgt.Request Service Add Company Type Data
            ...     ${DS_LOGIN['robotapi'][${login_col.username}]}    ${DS_LOGIN['robotapi'][${login_col.password}]}
            ...     ${defaultcomtype03}[ctype]
            ...     XBOTPAGING${runningindex}
            ...     ${defaultmainmenu}            ${defaultsubmenu01}           ${defaultsubmenu02}     

             Log To Console    \n\n***** Create Paging Function Company Type (COMTYPE_PAGE${runningindex}): CHECK! *****\n\n              
        END

      ELSE
          Fail    \nPlease Check 'GLOBAL_STANDARD_VERSION' should any 'STANDARD' or 'IE5DEV'
      END
