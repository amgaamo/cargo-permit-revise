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
Check Default Menu Data is found in system

      Pass Execution If    '${GLOBAL_DEFAULTDATA_FUNCTEST}'=='False'             
      ...       \nNo Execute Create Default Data: GLOBAL_DEFAULTDATA_FUNCTEST is ${GLOBAL_DEFAULTDATA_FUNCTEST}. 
      
      Set Local Variable    ${defaultmainmenu}           ${JS_DEFAULTDATA['menudata'][0]}
      Set Local Variable    ${defaultsubmenu01}          ${JS_DEFAULTDATA['menudata'][1]}
      Set Local Variable    ${defaultsubmenu02}          ${JS_DEFAULTDATA['menudata'][2]}
      Set Local Variable    ${defaultsubmenu03}          ${JS_DEFAULTDATA['menudata'][3]}
      Set Local Variable    ${defaultsubmenu04}          ${JS_DEFAULTDATA['menudata'][4]}

      service-menumgt.Request Service Delete by Menu Name
      ...     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...     menuname=${defaultsubmenu01}[menuname]
      service-menumgt.Request Service Delete by Menu Name
      ...     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...     menuname=${defaultsubmenu02}[menuname]
      service-menumgt.Request Service Delete by Menu Name
      ...     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...     menuname=${defaultsubmenu03}[menuname]
      service-menumgt.Request Service Delete by Menu Name
      ...     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...     menuname=${defaultsubmenu04}[menuname]
      service-menumgt.Request Service Delete by Menu Name
      ...     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...     menuname=${defaultmainmenu}[menuname]

      service-menumgt.Request Service Add Parent Menu
      ...     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...     icon=${defaultmainmenu}[iconmenu]         menuname=${defaultmainmenu}[menuname]         ordermenu=${defaultmainmenu}[ordermenu]

      service-menumgt.Request Service Add Sub Menu
      ...     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...     icon=${defaultsubmenu01}[iconmenu]        mainmenuname=${defaultsubmenu01}[mainmenu]    submenuname=${defaultsubmenu01}[menuname]
      ...     urlmenu=${defaultsubmenu01}[urlmenu]      ordermenu=${defaultsubmenu01}[ordermenu]

      service-menumgt.Request Service Add Sub Menu
      ...     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...     icon=${defaultsubmenu02}[iconmenu]        mainmenuname=${defaultsubmenu02}[mainmenu]    submenuname=${defaultsubmenu02}[menuname]
      ...     urlmenu=${defaultsubmenu02}[urlmenu]     ordermenu=${defaultsubmenu02}[ordermenu]

      service-menumgt.Request Service Add Sub Menu
      ...     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...     icon=${defaultsubmenu03}[iconmenu]        mainmenuname=${defaultsubmenu03}[mainmenu]    submenuname=${defaultsubmenu03}[menuname]
      ...     urlmenu=${defaultsubmenu03}[urlmenu]     ordermenu=${defaultsubmenu03}[ordermenu]

      service-menumgt.Request Service Add Sub Menu
      ...     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...     icon=${defaultsubmenu04}[iconmenu]        mainmenuname=${defaultsubmenu04}[mainmenu]    submenuname=${defaultsubmenu04}[menuname]
      ...     urlmenu=${defaultsubmenu04}[urlmenu]     ordermenu=${defaultsubmenu04}[ordermenu]

      Log To Console    \n\n***** Create Default Menu (Main Menu-'${defaultmainmenu}[menuname]')
      Log To Console    \nSub Menu-'${defaultsubmenu01}[menuname]', '${defaultsubmenu02}[menuname]', '${defaultsubmenu03}[menuname]', '${defaultsubmenu04}[menuname]') : CHECK! *****\n\n


    FOR   ${index}   IN RANGE   1     13
        ${runningindex}=      Evaluate    ${index}+44
        ${runningindex}=      Convert To String    ${runningindex}
        
      service-menumgt.Request Service Delete by Menu Name
      ...     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...     menuname=XBOTPAGING${runningindex}
      
      service-menumgt.Request Service Add Parent Menu
      ...     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...     icon=${defaultmainmenu}[iconmenu]         menuname=XBOTPAGING${runningindex}        ordermenu=99     
      
       Log To Console    \n\n***** Create Paging Function Menu (XBOTPAGING${runningindex}): CHECK! *****\n\n
    END      