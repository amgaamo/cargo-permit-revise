*** Settings ***
Resource    ../../resources/commonkeywords.resource

*** Keywords ***
Request Service Get Company Type Menu
    [Arguments]   ${headeruser}    ${headerpwd}     ${companyName}

      Request Service Get list Company    ${headeruser}    ${headerpwd}    ${companyName}
      ${bodydata}=        Catenate          {"cpid": "${GLOBAL_GETCOMDATA_CPID}"}
      &{resp_getcomtype}=   HTTP     ${SERVICE_GETCOMTYPEMENU_PATH}    method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}

      Set Local Variable    ${status_val}         ${resp_getcomtype.body.status}

      IF  '${status_val}'=='success'
            Set Global Variable    ${GLOBAL_COMTYPEMENU_DATA}       ${resp_getcomtype.body.data}
      ELSE
           Fail    \nRequest Service Status: ${status_val}, ${resp_getcomtype.body.message}
      END
      Log    \nService:${SERVICE_GETCOMTYPEMENU_PATH} \nBody: ${bodydata}

Request Service Get Company Type Info
    [Arguments]   ${headeruser}    ${headerpwd}     ${companytypename}

      main-service.Create Header Authen Service    ${headeruser}    ${headerpwd}
      ${bodydata}=        Catenate        {"pageNum":1,"pageSize":10,"name":"${companytypename}","registerType":null}
      &{resp_getctypeinfo}=     HTTP      ${SERVICE_GETCOMTYPEINFO_PATH}    method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}

      Set Local Variable        ${status_val}                     ${resp_getctypeinfo.body.status}
      Set Global Variable       ${GLOBAL_CTYPE_ROWRECORD}         ${resp_getctypeinfo.body.data.row}

      IF  '${status_val}'=='success'
          IF   '${GLOBAL_CTYPE_ROWRECORD}'=='1'
            Set Global Variable     ${GLOBAL_CTYPEID_DATA}       ${resp_getctypeinfo.body.data.data[0].id}
          ELSE
            Log To Console    \nCompany Type Not found record or record(s) found: ${GLOBAL_CTYPE_ROWRECORD}
          END
      ELSE
           Fail    \nRequest Service Status: ${status_val}, ${resp_getctypeinfo.body.message}
      END
      Log    \nService:${SERVICE_GETCOMTYPEINFO_PATH} \nBody: ${bodydata}

Request Service Create Company Type
    [Arguments]   ${headeruser}    ${headerpwd}     ${registertype}     ${companytypename}     @{menuname}

      ${menu_datalist}=      Create List
      ${lengthmenu}=         Get Length    ${menuname}

      FOR  ${index}     IN RANGE     ${lengthmenu}
            Request Service Get list Menu          ${headeruser}    ${headerpwd}      ${menuname}[${index}]
            Insert Into List    ${menu_datalist}       ${index}          {"menuId":${GLOBAL_GETMENUID},"companyTypeId":null}
      END
      ${menu_datalist}=         Convert To String     ${menu_datalist}
      ${menu_datalist}=         Remove String         ${menu_datalist}    '

      main-service.Create Header Authen Service    ${headeruser}    ${headerpwd}
      ${bodydata}=      Catenate      {"registerType":"${registertype}","name":"${companytypename}","companyTypeMenu":${menu_datalist}}

      &{resp_createcomtype}=    HTTP     ${SERVICE_CREATECOMTYPE_PATH}    method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}

      Set Local Variable    ${status_val}         ${resp_createcomtype.body.status}

      IF  '${status_val}'=='success'
                  Log To Console    \nRequest Service Create Company Type (${companytypename}) Status: ${status_val}
                  Set Global Variable    ${GLOBAL_CREATE_CTYPEID}      ${resp_createcomtype.body.data.id}
      ELSE
          Fail    \nRequest Service Create Company Type Status: ${status_val}, ${resp_createcomtype.body.message}
      END
      Log    \nService:${SERVICE_CREATECOMTYPE_PATH} \nBody: ${bodydata}

Requset Service Update Company Type
    [Arguments]   ${headeruser}    ${headerpwd}     ${registertype}     ${companytypename}     @{menuname}

      Request Service Get Company Type Info     ${headeruser}    ${headerpwd}    ${companytypename}

      ${MENUDATALIST}=    Create List
      ${lengthmenu}=      Get Length    ${menuname}

      FOR  ${index}     IN RANGE     ${lengthmenu}
            Request Service Get list Menu          ${headeruser}    ${headerpwd}      ${menuname}[${index}]
            Insert Into List    ${MENUDATALIST}    ${index}          {"menuId":${GLOBAL_GETMENUID},"companyTypeId":${GLOBAL_CTYPEID_DATA}}
      END
      ${MENUDATALIST}=         Convert To String     ${MENUDATALIST}
      ${MENUDATALIST}=         Remove String         ${MENUDATALIST}    '

      Set Local Variable     ${MENUDATALIST}

      main-service.Create Header Authen Service    ${headeruser}    ${headerpwd}
      ${bodydata}=      Catenate      {"id":${GLOBAL_CTYPEID_DATA},"registerType":"${registertype}","name":"${companytypename}","companyTypeMenu":${MENUDATALIST}}

      &{resp_updatectype}=    HTTP     ${SERVICE_UPDATECOMTYPE_PATH}     method=POST         body=${bodydata}     headers=${GLOBAL_APIAUTH_HEADERS}

      Set Local Variable    ${status_val}         ${resp_updatectype.body.status}

      IF  '${status_val}'=='success'
                  Log To Console    \nRequest Service Create Company Type (${companytypename}) Status: ${status_val}
                  Set Global Variable     ${GLOBAL_UPDATE_CTYPEID}      ${resp_updatectype.body.data.id}
      ELSE
          Fail    \nRequest Service Create Company Type Status: ${status_val}, ${resp_updatectype.body.message}
      END
      Log    \nService:${SERVICE_UPDATECOMTYPE_PATH} \nBody: ${bodydata}

Request Service Add Company Type Data
      [Arguments]   ${headeruser}   ${headerpwd}    ${registertype}     ${companytypename}         @{menuname}

      Request Service Get Company Type Info    ${headeruser}    ${headerpwd}    ${companytypename}

      IF  '${GLOBAL_CTYPE_ROWRECORD}'=='0'
          Request Service Create Company Type
          ...     ${headeruser}     ${headerpwd}      ${registertype}       ${companytypename}     @{menuname}
      ELSE IF   '${GLOBAL_CTYPE_ROWRECORD}'=='1'
          Requset Service Update Company Type
          ...     ${headeruser}     ${headerpwd}      ${registertype}       ${companytypename}     @{menuname}
      ELSE
          Fail    \nPlease Check row record should any 0 or 1 record.
      END