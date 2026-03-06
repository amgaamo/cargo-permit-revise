*** Settings ***
Resource    ../../resources/commonkeywords.resource

*** Keywords ***
Request Service Create Permission
   [Arguments]    ${headeruser}    ${headerpassword}     ${permcode}

      main-service.Create Header Authen Service       ${headeruser}     ${headerpassword}
      ${bodydata}=        Catenate        {"permissionCode": "${permcode}"}

      &{resp_createperm}=   HTTP     ${SERVICE_CREATEPERM_PATH}    method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}

      Set Local Variable    ${status_val}         ${resp_createperm.body.status}

      IF  '${status_val}'=='success'
            Log To Console    \nRequest Service Create Permission (${permcode}) Status: ${status_val}
            Set Global Variable    ${GLOBAL_NEW_PERMID}      ${resp_createperm.body.data.id}
      ELSE
            Fail    \nRequest Service Create Permission Status: ${status_val}, ${resp_createperm.body.message}
      END
      Log    \nService:${SERVICE_CREATEPERM_PATH} \nBody: ${bodydata}

Request Service Delete by Permission Code
      [Arguments]   ${headeruser}    ${headerpassword}      ${permcode}

      Request Service Get list Permission     ${headeruser}    ${headerpassword}    ${permcode}

      IF   '${GLOBAL_PERMRECORD_FOUND}'=='1'
              ${bodydata}=          Catenate    {"id":${GLOBAL_GETPERMID},"permissionCode":"${permcode}"}
              &{resp_delmenu}=      HTTP        ${SERVICE_DELETEPERM_PATH}    method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}
              Set Local Variable    ${status_val}         ${resp_delmenu.body.status}
            IF    '${status_val}'=='success'
                 Log To Console      \nRequest Service Delete Permission (${permcode}) Status: ${status_val}
            ELSE
                 Fail    \nRequest Service Delete Permission Status: ${status_val}, ${resp_delmenu.body.message}
            END
            Log    \nService:${SERVICE_DELETEPERM_PATH} \nBody: ${bodydata}
      ELSE IF    '${GLOBAL_PERMRECORD_FOUND}'=='0'
            Log To Console      \nPermission Code no record found
      ELSE
            Fail      \nRequest Service Delete Permission (${permcode}) should equal 1 record.
      END
      

Request Service Get list Permission
   [Arguments]    ${headeruser}    ${headerpassword}        ${permcode}

      main-service.Create Header Authen Service     ${headeruser}    ${headerpassword}
      ${bodydata}=      Catenate       {"permissionCode": "${permcode}","pageNum":1,"pageSize":10}

      &{resp_getlistperm}=   HTTP     ${SERVICE_GETLISTPREM_PATH}    method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}

      Set Local Variable   ${status_val}       ${resp_getlistperm.body.status}

      IF    '${status_val}'=='success'
          Log To Console      \nRequest Service Get list Permission (${permcode}) Status: ${status_val}
          Set Global Variable  ${GLOBAL_PERMRECORD_FOUND}       ${resp_getlistperm.body.data.row}
        IF    '${GLOBAL_PERMRECORD_FOUND}'=='1'
            Set Global Variable    ${GLOBAL_GETPERMID}         ${resp_getlistperm.body.data.data[0].id}
        ELSE IF  '${GLOBAL_PERMRECORD_FOUND}'=='0'
            Log To Console    \nRequest Service Get list Permission (${permcode}) Status: Not found data
        ELSE
           Fail    Request Service Get list Permission (${permcode}) Status: Found data ${GLOBAL_PERMRECORD_FOUND} records
        END
      ELSE
        Fail    \nRequest Service Get list Permission status: ${status_val}, ${resp_getlistperm.body.message}
     END
     Log    \nService:${SERVICE_GETLISTPREM_PATH} \nBody: ${bodydata}

Create Data List of Permission
    [Arguments]     ${headeruser}    ${headerpassword}    @{permissionname}

      ${GLOBAL_PERMDATALIST}=      Create List
      ${lengthperm}=         Get Length    ${permissionname}

      FOR  ${index}     IN RANGE     ${lengthperm}
            Request Service Get list Permission        ${headeruser}    ${headerpassword}      ${permissionname}[${index}]
            Insert Into List    ${GLOBAL_PERMDATALIST}       ${index}       {"permissionCode":${GLOBAL_GETPERMID},"roleId":null}
      END
      ${GLOBAL_PERMDATALIST}=         Convert To String     ${GLOBAL_PERMDATALIST}
      ${GLOBAL_PERMDATALIST}=         Remove String         ${GLOBAL_PERMDATALIST}    '

      Set Global Variable    ${GLOBAL_PERMDATALIST}
