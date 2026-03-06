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
Check Default Group Data is found in system

      Pass Execution If    '${GLOBAL_DEFAULTDATA_FUNCTEST}'=='False'             
      ...       \nNo Execute Create Default Data: GLOBAL_DEFAULTDATA_FUNCTEST is ${GLOBAL_DEFAULTDATA_FUNCTEST}. 
      
      Set Local Variable    ${defaultsupercompany}       ${JS_DEFAULTDATA['companydata'][0]}
      Set Local Variable    ${defaultcustcompany01}      ${JS_DEFAULTDATA['companydata'][1]}
      Set Local Variable    ${defaultcustcompany02}      ${JS_DEFAULTDATA['companydata'][2]}

      Set Local Variable    ${defaultsuper_grouprobot}    ${JS_DEFAULTDATA['groupdata'][0]}
      Set Local Variable    ${defaultcom1_groupadmin}     ${JS_DEFAULTDATA['groupdata'][1]}
      Set Local Variable    ${defaultcom1_groupuser}      ${JS_DEFAULTDATA['groupdata'][2]}
      Set Local Variable    ${defaultcom2_groupadmin}     ${JS_DEFAULTDATA['groupdata'][3]}
      Set Local Variable    ${defaultgrouppaging}         ${JS_DEFAULTDATA['groupdata'][4]}

      Set Local Variable    ${super_robotrole}            ${JS_DEFAULTDATA['roledata'][4]}[rolename]
      Set Local Variable    ${custadmin_robotrole}        ${JS_DEFAULTDATA['roledata'][5]}[rolename]

      service-groupmgt.Request Service Add Default Group data test
      ...      ${DS_LOGIN['robotapi'][${login_col.username}]}    ${DS_LOGIN['robotapi'][${login_col.password}]}
      ...      ${defaultsupercompany}[companyname]
      ...      ${defaultsuper_grouprobot}[groupname]
      ...      ${defaultsuper_grouprobot}[limituser]
      ...      true    false    ${EMPTY}
      ...      ${super_robotrole}

      service-groupmgt.Request Service Add Default Group data test
      ...      ${DS_LOGIN['robotapi'][${login_col.username}]}    ${DS_LOGIN['robotapi'][${login_col.password}]}
      ...      ${defaultcustcompany01}[companyname]
      ...      ${defaultcom1_groupadmin}[groupname]
      ...      ${defaultcom1_groupadmin}[limituser]
      ...      true    false    ${EMPTY}
      ...      ${custadmin_robotrole}

      service-groupmgt.Request Service Add Default Group data test
      ...      ${DS_LOGIN['robotapi'][${login_col.username}]}    ${DS_LOGIN['robotapi'][${login_col.password}]}
      ...      ${defaultcustcompany01}[companyname]
      ...      ${defaultcom1_groupuser}[groupname]
      ...      ${defaultcom1_groupuser}[limituser]
      ...      true    false    ${EMPTY}
      ...      ${custadmin_robotrole}

      service-groupmgt.Request Service Add Default Group data test
      ...      ${DS_LOGIN['robotapi'][${login_col.username}]}    ${DS_LOGIN['robotapi'][${login_col.password}]}
      ...      ${defaultcustcompany02}[companyname]
      ...      ${defaultcom2_groupadmin}[groupname]
      ...      ${defaultcom2_groupadmin}[limituser]
      ...      true    false    ${EMPTY}
      ...      ${custadmin_robotrole}

      Log To Console    \n\n***** Create/Update Default Group Data-'${defaultsuper_grouprobot}[groupname]', '${defaultcom1_groupadmin}[groupname]', '${defaultcom1_groupuser}[groupname]', '${defaultcom2_groupadmin}[groupname]' : CHECK! *****\n\n

      FOR   ${index}   IN RANGE   1     13
        ${runningindex}=    Evaluate    ${index}+44
        ${runningindex}=    Convert To String    ${runningindex}
        ${paging_groupname}=    Replace String    ${defaultgrouppaging}[groupname]          XX    ${runningindex}  

            service-groupmgt.Request Service Add Default Group data test
            ...      ${DS_LOGIN['robotapi'][${login_col.username}]}    ${DS_LOGIN['robotapi'][${login_col.password}]}
            ...      ${defaultcustcompany02}[companyname]
            ...      ${paging_groupname}
            ...      ${defaultgrouppaging}[limituser]
            ...      true    false    ${EMPTY}
            ...      ${custadmin_robotrole}

            Log To Console    \n\n***** Create/Update Paging Function Group Data-'${paging_groupname}': CHECK! *****\n\n
      END      