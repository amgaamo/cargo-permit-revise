*** Settings ***
Resource      ../../resources/commonkeywords.resource
Resource      _sharekeywords.robot

Suite Setup       Run Keywords      commonkeywords.Set Data for Run Automated Test
...               AND               Log    ${VAR_BOTVERSION} : ${GLOBAL_STANDARD_VERSION}      console=True
...               AND               Pass Execution If    '${GLOBAL_DEFAULTDATA_FUNCTEST}'=='False'             
...                                       \nNo Execute Create Default Data: GLOBAL_DEFAULTDATA_FUNCTEST is ${GLOBAL_DEFAULTDATA_FUNCTEST}. 
...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               Set Data for Run Automated Test
...               AND               commonkeywords.Initialize System and Go to Login Page

Suite Teardown    commonkeywords.Release user lock and close all browser

*** Test Cases ***
Check Robot User and API Robot User found in system

      Pass Execution If    '${GLOBAL_DEFAULTDATA_FUNCTEST}'=='False'             
      ...       \nNo Execute Create Default Data: GLOBAL_DEFAULTDATA_FUNCTEST is ${GLOBAL_DEFAULTDATA_FUNCTEST}. 
      
      Set Local Variable    ${superadmin_email}           ${JS_DEFAULTDATA['companydata'][0]}[email]
      #Create/Update Admin Robot User
      Set Local Variable    ${defaultbotadmin01}          ${JS_DEFAULTDATA['userdata'][0]}
      Set Local Variable    ${defaultbotadmin02}          ${JS_DEFAULTDATA['userdata'][1]}
      Set Local Variable    ${defaultrobotapi}            ${JS_DEFAULTDATA['userdata'][2]}
      Log To Console    \n

      Create New User Data Test
      ...         headeruser=${DS_LOGIN['superadmin'][${login_col.username}]}    headerpassword=${DS_LOGIN['superadmin'][${login_col.password}]}
      ...         username=${defaultrobotapi}[username]
      ...         password=${VAR_DEFAULTPASSWORD}
      ...         newpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...         firstname=${defaultrobotapi}[firstname]
      ...         lastname=${defaultrobotapi}[lastname]
      ...         telnumber=${defaultrobotapi}[phone]
      ...         email=${defaultrobotapi}[email]
      ...         email_company=${superadmin_email}

      Create New User Data Test
      ...         headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...         username=${defaultbotadmin01}[username]
      ...         password=${VAR_DEFAULTPASSWORD}
      ...         newpassword=${DS_LOGIN['robotadmin1'][${login_col.password}]}
      ...         firstname=${defaultbotadmin01}[firstname]
      ...         lastname=${defaultbotadmin01}[lastname]
      ...         telnumber=${defaultbotadmin01}[phone]
      ...         email=${defaultbotadmin01}[email]
      ...         email_company=${superadmin_email}

      Create New User Data Test
      ...         headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...         username=${defaultbotadmin02}[username]
      ...         password=${VAR_DEFAULTPASSWORD}
      ...         newpassword=${DS_LOGIN['robotadmin2'][${login_col.password}]}
      ...         firstname=${defaultbotadmin02}[firstname]
      ...         lastname=${defaultbotadmin02}[lastname]
      ...         telnumber=${defaultbotadmin02}[phone]
      ...         email=${defaultbotadmin02}[email]
      ...         email_company=${superadmin_email}         