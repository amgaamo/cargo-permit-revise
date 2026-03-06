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
...               AND               commonkeywords.Open Browser and Go to website    ${URLTEST}

Suite Teardown    Run keywords      Pass Execution If    '${GLOBAL_DEFAULTDATA_FUNCTEST}'=='False'             
...                                       \nNo Execute Create Default Data: GLOBAL_DEFAULTDATA_FUNCTEST is ${GLOBAL_DEFAULTDATA_FUNCTEST}. 
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
Check Default User Customer Type

      Pass Execution If    '${GLOBAL_DEFAULTDATA_FUNCTEST}'=='False'             
      ...       \nNo Execute Create Default Data: GLOBAL_DEFAULTDATA_FUNCTEST is ${GLOBAL_DEFAULTDATA_FUNCTEST}. 
      
      Set Local Variable    ${defaultcustcompany01}         ${JS_DEFAULTDATA['companydata'][1]}
      Set Local Variable    ${defaultcom1_groupadmin}       ${JS_DEFAULTDATA['groupdata'][1]}
      Set Local Variable    ${defaultbotcustomer}           ${JS_DEFAULTDATA['userdata'][3]}

      Set Local Variable    ${defaultcustcompany02}         ${JS_DEFAULTDATA['companydata'][2]}
      Set Local Variable    ${defaultcom2_groupadmin}       ${JS_DEFAULTDATA['groupdata'][3]}
      Set Local Variable    ${defaultbotcustomer02}         ${JS_DEFAULTDATA['userdata'][4]}

      Set Local Variable    ${defaultuserpaging}            ${JS_DEFAULTDATA['userdata'][5]}

      Create New User Data Test
      ...       headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...       username=${defaultbotcustomer}[username]
      ...       password=${VAR_DEFAULTPASSWORD}
      ...       newpassword=${DS_LOGIN['robotcustomer'][${login_col.password}]}
      ...       firstname=${defaultbotcustomer}[firstname]
      ...       lastname=${defaultbotcustomer}[lastname]
      ...       telnumber=${defaultbotcustomer}[phone]
      ...       email=${defaultbotcustomer}[email]
      ...       companyuser=${defaultcustcompany01}[companyname]
      ...       groupuser=${defaultcom1_groupadmin}[groupname]


      Create New User Data Test
      ...       headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
      ...       username=${defaultbotcustomer02}[username]
      ...       password=${VAR_DEFAULTPASSWORD}
      ...       newpassword=${DS_LOGIN['robotcustomer2'][${login_col.password}]}
      ...       firstname=${defaultbotcustomer02}[firstname]
      ...       lastname=${defaultbotcustomer02}[lastname]
      ...       telnumber=${defaultbotcustomer02}[phone]
      ...       email=${defaultbotcustomer02}[email]
      ...       companyuser=${defaultcustcompany02}[companyname]
      ...       groupuser=${defaultcom2_groupadmin}[groupname]

      FOR   ${index}   IN RANGE   1     13
        ${runningindex}=      Evaluate    ${index}+44
        ${runningindex}=      Convert To String    ${runningindex}
        ${paging_username}=   Replace String    ${defaultuserpaging}[username]       XX    ${runningindex}  
        ${paging_email}=      Replace String    ${defaultuserpaging}[email]          XX    ${runningindex}  

            Create New User Data Test
            ...       headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
            ...       username=${paging_username}
            ...       password=${VAR_DEFAULTPASSWORD}
            ...       newpassword=${DS_LOGIN['robotcustomer2'][${login_col.password}]}
            ...       firstname=${defaultuserpaging}[firstname]
            ...       lastname=${defaultuserpaging}[lastname]
            ...       telnumber=${defaultuserpaging}[phone]
            ...       email=${paging_email}
            ...       companyuser=${defaultcustcompany02}[companyname]
            ...       groupuser=${defaultcom2_groupadmin}[groupname]

            Log To Console    \n\n***** Create/Update Paging Function User Data-'${paging_username}': CHECK! *****\n\n
      END  