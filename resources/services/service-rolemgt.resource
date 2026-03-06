*** Settings ***
Resource    ../../resources/commonkeywords.resource

*** Keywords ***
Request Service Get list Role
   [Arguments]    ${headeruser}    ${headerpassword}        ${rolename}

      main-service.Create Header Authen Service    ${headeruser}    ${headerpassword}

      IF  '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
            ${bodydata}=      Catenate      {"pageNum":1,"pageSize":10,"id":null,"cpid": null, "name":"${rolename}"}
      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
            ${bodydata}=      Catenate      {"pageNum":1,"pageSize":10,"id":null, "name":"${rolename}"}
      ELSE
          Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'IE5DEV' or STANDARD
      END

      &{resp_getlistrole}=   HTTP     ${SERVICE_GETLISTROLE_PATH}    method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}

      Set Local Variable   ${status_val}       ${resp_getlistrole.body.status}

      IF  '${status_val}'=='success'
          Log To Console      \nRequest Service Status: ${status_val}
          Set Global Variable  ${GLOBAL_ROLERECORD_FOUND}       ${resp_getlistrole.body.data.row}
           IF   '${GLOBAL_ROLERECORD_FOUND}'=='1'
                Log To Console    \n${rolename}: Found Data
                Set Global Variable    ${GLOBAL_GETROLEID}         ${resp_getlistrole.body.data.data[0].id}
                Should Be True        '${GLOBAL_GETROLEID}'!='1'
           ELSE IF  '${GLOBAL_ROLERECORD_FOUND}'=='0'
                Log To Console     \n${rolename}: No record found
           ELSE
                Fail    \n${rolename}:  Found data ${GLOBAL_ROLERECORD_FOUND} records
           END
      ELSE
          Fail    \nGet List Role (${rolename}) Status: ${status_val}, ${resp_getlistrole.body.message}
      END
      Log    \nService:${SERVICE_GETLISTROLE_PATH} \nBody: ${bodydata}

Request Service Verify Role of Group List is found
   [Arguments]    ${headeruser}    ${headerpassword}      ${exprole}

      main-service.Create Header Authen Service       ${headeruser}    ${headerpassword}

      IF  '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
            ${bodydata}=      Catenate      {"pageNum":1,"pageSize":9999,"id":null,"cpid":null, "name":""}
      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
            ${bodydata}=      Catenate      {"pageNum":1,"pageSize":9999,"id":null, "name":""}
      ELSE
          Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'IE5DEV' or STANDARD
      END

      &{resp_getroleofgroup}=   HTTP     ${SERVICE_GETLISTROLE_PATH}       method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}

      Set Local Variable   ${status_val}       ${resp_getroleofgroup.body.status}

      IF   '${status_val}'=='success'
            Log To Console    \nFound Role (${exprole})
            Set Global Variable     ${GLOBAL_GET_ROLEOFGROUP_LIST}      ${resp_getroleofgroup.body}
            commonkeywords.Extract Value from JSON data     ${GLOBAL_GET_ROLEOFGROUP_LIST}      $.data.data[*].name
            Should Contain    ${GLOBAL_JSONVALUE}     ${exprole}
      ELSE
            Fail    \nRequest Service Verify Role of Group List Status: ${status_val}, ${resp_getroleofgroup.body.message}
      END
      Log    \nService:${SERVICE_GETLISTROLE_PATH} \nBody: ${bodydata}

Request Service Verify Get Role Menu
   [Arguments]    ${headeruser}    ${headerpassword}     ${rolename}

      Request Service Get list Role    ${headeruser}    ${headerpassword}        ${rolename}
      ${bodydata}=      Catenate      {"id":${GLOBAL_GETROLEID} ,"menuId":null,"roleId":null}

      &{resp_getrolemenu}=   HTTP     ${SERVICE_GETROLEMENU_PATH}    method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}

      Set Local Variable   ${status_val}       ${resp_getrolemenu.body.status}

      IF  '${status_val}'=='success'
            Log To Console      \nVerify Get Role Menu (${rolename}) Status: ${status_val}
      ELSE
              Fail    \nRequest Service Verify Get Role Menu Status: ${status_val}, ${resp_getrolemenu.body.message}
      END
      Log    \nService:${SERVICE_GETROLEMENU_PATH} \nBody: ${bodydata}

Request Service Verify Get Role Permission
   [Arguments]    ${headeruser}    ${headerpassword}        ${rolename}
      Request Service Get list Role    ${headeruser}    ${headerpassword}        ${rolename}
      ${bodydata}=      Catenate      {"id":"${GLOBAL_GETROLEID}"}

      &{resp_getroleperm}=   HTTP     ${SERVICE_GETROLEPERM_PATH}    method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}

      Set Local Variable   ${status_val}       ${resp_getroleperm.body.status}

      IF  '${status_val}'=='success'
            Log To Console      \nVerify Get Role Permission (${rolename}) Status: ${status_val}
      ELSE
              Fail    \nRequest Service Verify Get Role Permission Status: ${status_val}, ${resp_getroleperm.body.message}
      END
      Log    \nService:${SERVICE_GETROLEPERM_PATH} \nBody: ${bodydata}

Request Service Create Role Data Test
    [Arguments]   ${headeruser}    ${headerpassword}    ${rolename}     ${menudatalist}   ${permdatalist}   ${companyname}=${EMPTY}

      main-service.Create Header Authen Service      ${headeruser}    ${headerpassword}

      IF  '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
          Request Service Get list Company    ${headeruser}    ${headerpassword}    ${companyname}
          ${bodydata}=      Catenate   {"cpid":"${GLOBAL_GETCOMDATA_CPID}","name":"${rolename}","rolemenu": ${menudatalist},"rolepermission": ${permdatalist}}
      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
          ${bodydata}=      Catenate   {"name":"${rolename}","rolemenu": ${menudatalist},"rolepermission": ${permdatalist}}
      ELSE
          Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'IE5DEV' or STANDARD
      END

      &{resp_createroledata}=   HTTP     ${SERVICE_CREATEROLE_PATH}       method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}

      Set Local Variable   ${status_val}       ${resp_createroledata.body.status}

      IF   '${status_val}'=='success'
            Log To Console    \nCreate New Role (${rolename}): ${status_val}
            Set Global Variable       ${GLOBAL_NEWROLEDATA_ID}      ${resp_createroledata.body.data.id}
      ELSE
            Fail    \nRequest Service Create New Role(${rolename}) Status: ${status_val}, ${resp_createroledata.body.message}
      END
      Log    \nService:${SERVICE_CREATEROLE_PATH} \nBody: ${bodydata}
Request Service Update Role Data Test
    [Arguments]   ${headeruser}    ${headerpassword}    ${rolename}     ${menudatalist}   ${permdatalist}   ${companyname}=${EMPTY}

      Request Service Get list Role    ${headeruser}    ${headerpassword}    ${rolename}
      Should Be True    '${GLOBAL_ROLERECORD_FOUND}'!='0'

      IF  '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
            Request Service Get list Company    ${headeruser}    ${headerpassword}    ${companyname}
            ${bodydata}=          Catenate      {"cpid":"${GLOBAL_GETCOMDATA_CPID}","id":${GLOBAL_GETROLEID} ,"name":"${rolename}","rolemenu": ${menu_datalist},"rolepermission": ${perm_datalist}}
      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
            ${bodydata}=          Catenate   {"id":${GLOBAL_GETROLEID} ,"name":"${rolename}","rolemenu": ${menudatalist},"rolepermission": ${permdatalist}}
      ELSE
          Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'IE5DEV' or STANDARD
      END

      &{resp_updaterole}=   HTTP     ${SERVICE_UPDATEROLE_PATH}       method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}

      Set Local Variable   ${status_val}       ${resp_updaterole.body.status}

      IF   '${status_val}'=='success'
            Log To Console    \nUpdate Role (${rolename}): ${status_val}
      ELSE
            Fail    \nRequest Service Update Role(${rolename}) Status: ${status_val}
      END
      Log    \nService:${SERVICE_UPDATEROLE_PATH} \nBody: ${bodydata}
Request Service Add Default Role data test
   [Arguments]   ${headeruser}    ${headerpassword}     ${rolename}     ${menudatalist}     ${permdatalist}     ${companyname}=${EMPTY}
      Request Service Get list Role     ${headeruser}    ${headerpassword}    ${rolename}
      IF   '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
        IF   '${GLOBAL_ROLERECORD_FOUND}'=='0'
            Request Service Create Role Data Test   ${headeruser}     ${headerpassword}     ${rolename}     ${menudatalist}     ${permdatalist}

        ELSE IF   '${GLOBAL_ROLERECORD_FOUND}'=='1'
            Log To Console    \nDefault Role(${rolename}) already exist. Updating data...
            Request Service Update Role Data Test    ${headeruser}     ${headerpassword}     ${rolename}     ${menudatalist}     ${permdatalist}
            Log To Console    \nDefault Role(${rolename}) update successful.
        ELSE
          Fail    Check Service "Request Service Add Default Role data test" !
        END

      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
        IF   '${GLOBAL_ROLERECORD_FOUND}'=='0'
            Request Service Create Role Data Test     ${headeruser}     ${headerpassword}     ${rolename}     ${menudatalist}     ${permdatalist}     ${companyname}

        ELSE IF   '${GLOBAL_ROLERECORD_FOUND}'=='1'
            Log To Console    \nDefault Role(${rolename}) already exist. Updating data...
            Request Service Update Role Data Test    ${headeruser}     ${headerpassword}     ${rolename}     ${menudatalist}     ${permdatalist}    ${companyname}
            Log To Console    \nDefault Role(${rolename}) update successful.
        ELSE
          Fail    Check Service "Request Service Add Default Role data test" !
        END
      ELSE
          Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'IE5DEV' or STANDARD
      END
