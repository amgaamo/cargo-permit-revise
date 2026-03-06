*** Settings ***
Resource    ../../resources/commonkeywords.resource

*** Keywords ***
Request Service Company Get total record
    [Arguments]    ${headeruser}    ${headerpassword}      ${companyname}
      main-service.Create Header Authen Service      ${headeruser}    ${headerpassword}
      ${bodydata}=      Catenate        {"pageNum": 1, "pageSize": 50, "name": "${companyname}"}
      &{resp_getlistcomp}=    HTTP      ${SERVICE_GETLISTCOMPANY_PATH}      method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}
      Set Local Variable      ${status_val}       ${resp_getlistcomp.body.status}

      IF    '${status_val}'=='success'    
            Log To Console      \nCompany Get total record (${companyname}): ${status_val}
            Set Global Variable  ${GLOBAL_COMPANY_TOTALRECORD}       ${resp_getlistcomp.body.data.row}
      ELSE
          Fail    \nGet list Company: status is ${status_val}, ${resp_getlistcomp.body.message}
      END           

Request Service Get list Company
   [Arguments]    ${headeruser}    ${headerpassword}      ${companyname}

      main-service.Create Header Authen Service      ${headeruser}    ${headerpassword}
      ${bodydata}=      Catenate        {"pageNum": 1, "pageSize": 10, "name": "${companyname}"}
      &{resp_getlistcomp}=    HTTP      ${SERVICE_GETLISTCOMPANY_PATH}      method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}
      Set Local Variable      ${status_val}       ${resp_getlistcomp.body.status}

      IF    '${status_val}'=='success'
            Log To Console      \nGet list Company (${companyname}): ${status_val}
            Set Global Variable  ${GLOBAL_COMPANYRECORD_FOUND}       ${resp_getlistcomp.body.data.row}
          IF   '${GLOBAL_COMPANYRECORD_FOUND}'=='1'
              Should Be Equal        ${resp_getlistcomp.body.data.data[0].name}     ${companyname}
              Set Global Variable    ${GLOBAL_GETCOMDATA_CPID}        ${resp_getlistcomp.body.data.data[0].cpid}
              Set Global Variable    ${GLOBALGETCOM_ISACTIVE}         ${resp_getlistcomp.body.data.data[0].isActive}
          ELSE IF   '${GLOBAL_COMPANYRECORD_FOUND}'=='0'
              Log To Console    \n${companyname}: No record found
          ELSE
              Fail    \nPlease Check company data (${companyname}): found data ${GLOBAL_COMPANYRECORD_FOUND} records
          END
      ELSE
          Fail    \nGet list Company: status is ${status_val}, ${resp_getlistcomp.body.message}
      END
      Log    \nService:${SERVICE_GETLISTCOMPANY_PATH} \nBody: ${bodydata}

Request Service Get Company Data
   [Arguments]    ${headeruser}    ${headerpassword}        ${comname}

      main-service.Create Header Authen Service    ${headeruser}    ${headerpassword}
      ${bodydata}=      Catenate      {"pageNum": 1, "pageSize": 10, "name": "${comname}"}
      &{resp_getcompdata}=   HTTP     ${SERVICE_GETLISTCOMPANY_PATH}    method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}
      Set Local Variable   ${status_val}       ${resp_getcompdata.body.status}
      Log    \nService:${SERVICE_GETLISTCOMPANY_PATH} \nBody: ${bodydata}

      IF  '${status_val}'=='success'
          Set Global Variable    ${GLOBAL_GETCOMDATA_CPID}              ${resp_getcompdata.body.data.data[0].cpid}
          Set Global Variable    ${GLOBAL_GETCOMDATA_ISACTIVE}          ${resp_getcompdata.body.data.data[0].isActive}
          Set Global Variable    ${GLOBAL_GETCOMDATA_NAME}              ${resp_getcompdata.body.data.data[0].name}
          Set Global Variable    ${GLOBAL_GETCOMDATA_TYPENAME}          ${resp_getcompdata.body.data.data[0].companyTypeName}
          Set Global Variable    ${GLOBAL_GETCOMDATA_IDLE}              ${resp_getcompdata.body.data.data[0].idleSessionInSec}
          Set Global Variable    ${GLOBAL_GETCOMDATA_LIMITREPEATPWD}    ${resp_getcompdata.body.data.data[0].limitRepeatPassword}
          Set Global Variable    ${GLOBAL_GETCOMDATA_LIMITSESSION}      ${resp_getcompdata.body.data.data[0].limitSessionInSec}
          Set Global Variable    ${GLOBAL_GETCOMDATA_LIMITTRYPWD}       ${resp_getcompdata.body.data.data[0].limitTryPassword}
          Set Global Variable    ${GLOBAL_GETCOMDATA_LIMITUSR}          ${resp_getcompdata.body.data.data[0].limitUser}
          Set Global Variable    ${GLOBAL_GETCOMDATA_PWDEXPIRED}        ${resp_getcompdata.body.data.data[0].passwordExpireDays}
          Set Global Variable    ${GLOBAL_GETCOMDATA_REGISTYPE}         ${resp_getcompdata.body.data.data[0].registerType}
          Set Global Variable    ${GLOBAL_GETCOMDATA_COMTAX}            ${resp_getcompdata.body.data.data[0].companyTaxId}
          Set Global Variable    ${GLOBAL_GETCOMDATA_COMBRANCH}         ${resp_getcompdata.body.data.data[0].companyBranch}
      ELSE
          Fail    \nGet Company Data (${comname}) status: ${status_val}, ${resp_getcompdata.body.message}
      END

      ${bodygetdid}=    Catenate      {"cpid":"${GLOBAL_GETCOMDATA_CPID}"}
      &{resp_getcomdid}=   HTTP     ${SERVICE_GETCOMPANYDATA_PATH}      method=POST     body=${bodygetdid}    headers=${GLOBAL_APIAUTH_HEADERS}

      Set Local Variable   ${status_didval}       ${resp_getcomdid.body.status}

      IF  '${status_didval}'=='success'
            Set Global Variable    ${GLOBAL_GETCOMDATA_ID}          ${resp_getcomdid.body.data.detail.id}
      ELSE
            Fail    Get Company Detail data status: ${status_val}, ${resp_getcomdid.body.message}
      END
      Log    \nService:${SERVICE_GETCOMPANYDATA_PATH} \nBody: ${bodygetdid}

Request Service Create New Company
      [Arguments]   ${headeruser}     ${headerpassword}      ${registype}       ${ctypeid}           ${cname}          ${ctaxid}        ${cbranch}      ${cemail}
      ...           ${limittrypwd}    ${limitusr}            ${pwdexpire}       ${limitrepeatpwd}    ${idlesession}    ${limitsession}

    main-service.Create Header Authen Service         ${headeruser}    ${headerpassword}

    ${bodydata}=     Catenate  { "header": {
    ...                                      "name": "${cname}",
    ...                                      "companyTypeId": "${ctypeid}",
    ...                                      "limitTryPassword": ${limittrypwd},
    ...                                      "limitUser": ${limitusr},
    ...                                      "passwordExpireDays": ${pwdexpire},
    ...                                      "limitRepeatPassword": ${limitrepeatpwd},
    ...                                      "idleSessionInSec": ${idlesession},
    ...                                      "limitSessionInSec": ${limitsession}
    ...                          },
    ...                          "detail": {
    ...                                      "registerType": "${registype}",
    ...                                      "companyTaxId": "${ctaxid}",
    ...                                      "companyBranch": "${cbranch}",
    ...                                      "houseNo": "22/11",
    ...                                      "moo": "19",
    ...                                      "building": "อาคารทดสอบบอท",
    ...                                      "soi": "จุฬา 11",
    ...                                      "street": "พระรามที่ 6",
    ...                                      "subDistrictCode": "100702",
    ...                                      "subDistrictName": "วังใหม่",
    ...                                      "districtCode": "1007",
    ...                                      "districtName": "ปทุมวัน",
    ...                                      "provinceCode": "10",
    ...                                      "provinceName": "กรุงเทพฯ",
    ...                                      "postCode": "10330",
    ...                                      "companyPhone": "027768899",
    ...                                      "companyEmail": "${cemail}",
    ...                                      "contactName": "ออโต้บอท",
    ...                                      "contactLastName": "ทดสอบ",
    ...                                      "contactPhone": "0299990000",
    ...                                      "contactEmail": "robottest@mail.co.th",
    ...                                      "id": null
    ...                            } }
    
    Log    ${bodydata}
    
      &{resp_createcompany}=   HTTP     ${SERVICE_CREATECOMPANY_PATH}    method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}
      Set Local Variable   ${status_val}       ${resp_createcompany.body.status}

      IF  '${status_val}'=='success'
          Set Global Variable    ${GLOBAL_GETCOMDATA_CPID}     ${resp_createcompany.body.data.cpid}
          Set Global Variable    ${GLOBAL_NEWCOM_ISACTIVE}     ${resp_createcompany.body.data.isActive}
      ELSE
          Fail    \nCreate New Company (${cname}) status: ${status_val}, ${resp_createcompany.body.message}
      END
      Log    \nService:${SERVICE_CREATECOMPANY_PATH} \nBody: ${bodydata}

Request Service Update Company data
      [Arguments]   ${headeruser}    ${headerpwd}      ${cpid}        ${dataid}
      ...           ${registype}     ${ctypeid}        ${cname}       ${ctaxid}            ${cbranch}        ${cemail}
      ...           ${limittrypwd}   ${limitusr}       ${pwdexpire}   ${limitrepeatpwd}    ${idlesession}    ${limitsession}

    main-service.Create Header Authen Service     ${headeruser}    ${headerpwd}

    ${bodydata}=     Catenate  { "header": {
    ...                                      "cpid": "${cpid}",
    ...                                      "name": "${cname}",
    ...                                      "companyTypeId": "${ctypeid}",
    ...                                      "limitTryPassword": ${limittrypwd},
    ...                                      "limitUser": ${limitusr},
    ...                                      "passwordExpireDays": ${pwdexpire},
    ...                                      "limitRepeatPassword": ${limitrepeatpwd},
    ...                                      "idleSessionInSec": ${idlesession},
    ...                                      "limitSessionInSec": ${limitsession}
    ...                          },
    ...                          "detail": {
    ...                                      "id": "${dataid}",
    ...                                      "cpid": "${cpid}",
    ...                                      "registerType": "${registype}",
    ...                                      "companyTaxId": "${ctaxid}",
    ...                                      "companyBranch": "${cbranch}",
    ...                                      "houseNo": "22/11",
    ...                                      "moo": "19",
    ...                                      "building": "อาคารทดสอบบอท",
    ...                                      "soi": "จุฬา 11",
    ...                                      "street": "พระรามที่ 6",
    ...                                      "subDistrictCode": "100702",
    ...                                      "subDistrictName": "วังใหม่",
    ...                                      "districtCode": "1007",
    ...                                      "districtName": "ปทุมวัน",
    ...                                      "provinceCode": "10",
    ...                                      "provinceName": "กรุงเทพฯ",
    ...                                      "postCode": "10330",
    ...                                      "companyPhone": "027768899",
    ...                                      "companyEmail": "${cemail}",
    ...                                      "contactName": "ออโต้บอท",
    ...                                      "contactLastName": "ทดสอบ",
    ...                                      "contactPhone": "0299990000",
    ...                                      "contactEmail": "robottest@mail.co.th"
    ...                            } }
    
      
      &{resp_updatecompany}=   HTTP     ${SERVICE_UPDATECOMPANY_PATH}    method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}
      Set Local Variable   ${status_val}       ${resp_updatecompany.body.status}

      IF  '${status_val}'=='success'
           Log To Console      \nUpdate Company data (${cname}) status:  ${status_val}
      ELSE
          Fail    \nUpdate Company data (${cname}) status: ${status_val}, ${resp_updatecompany.body.message}
      END
      Log    \nService:${SERVICE_UPDATECOMPANY_PATH} \nBody: ${bodydata}

Request Service Update Company Status
   [Arguments]    ${headeruser}    ${headerpassword}     ${comname}     ${status}

      main-service.Create Header Authen Service         ${headeruser}    ${headerpassword}
      Request Service Get Company Data     ${headeruser}    ${headerpassword}     ${comname}

      ${bodydata}=      Catenate   { "name": "${GLOBAL_GETCOMDATA_CPID}",
      ...                            "companyTypeName": "${GLOBAL_GETCOMDATA_TYPENAME}",
      ...                            "cpid": "${GLOBAL_GETCOMDATA_CPID}",
      ...                            "isActive": ${status},
      ...                            "idleSessionInSec": ${GLOBAL_GETCOMDATA_IDLE},
      ...                            "limitRepeatPassword": ${GLOBAL_GETCOMDATA_LIMITREPEATPWD},
      ...                            "limitSessionInSec": ${GLOBAL_GETCOMDATA_LIMITSESSION},
      ...                            "limitTryPassword": ${GLOBAL_GETCOMDATA_LIMITTRYPWD},
      ...                            "limitUser": ${GLOBAL_GETCOMDATA_LIMITUSR},
      ...                            "passwordExpireDays": ${GLOBAL_GETCOMDATA_PWDEXPIRED},
      ...                            "registerType": ${GLOBAL_GETCOMDATA_REGISTYPE},
      ...                            "companyTaxId": "${GLOBAL_GETCOMDATA_COMTAX}",
      ...                            "companyBranch": "${GLOBAL_GETCOMDATA_COMBRANCH}"
      ...                            }

      &{resp_updatecompstatus}=     HTTP     ${SERVICE_UPDATECOMSATUS_PATH}      method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}
      Set Local Variable   ${status_val}     ${resp_updatecompstatus.body.status}

      IF  '${status_val}'=='success'
          Log To Console      \nUpdate Company status (${comname}):  ${status_val}
      ELSE
          Fail    \nUpdate Company status: ${status_val}, ${resp_updatecompstatus.body.message}
      END
      Log    \nService:${SERVICE_UPDATECOMSATUS_PATH} \nBody: ${bodydata}

Request Service Add Default Company data test
   [Arguments]   ${headeruser}    ${headerpassword}     ${registype}    ${ctypeid}           ${cname}          ${ctaxid}        ${cbranch}    ${cemail}
   ...           ${limittrypwd}   ${limitusr}           ${pwdexpire}    ${limitrepeatpwd}    ${idlesession}    ${limitsession}

      Request Service Get list Company   ${headeruser}    ${headerpassword}    ${cname}

      IF    '${GLOBAL_COMPANYRECORD_FOUND}'=='0'
            Request Service Create New Company    ${headeruser}     ${headerpassword}
            ...                                   ${registype}      ${ctypeid}        ${cname}        ${ctaxid}             ${cbranch}        ${cemail}
            ...                                   ${limittrypwd}    ${limitusr}       ${pwdexpire}    ${limitrepeatpwd}     ${idlesession}    ${limitsession}
      ELSE
            Request Service Get list Company      ${headeruser}    ${headerpassword}    ${cname}
            Request Service Get Company Data      ${headeruser}    ${headerpassword}    ${cname}
            Request Service Update Company data
            ...       ${headeruser}                 ${headerpassword}
            ...       ${GLOBAL_GETCOMDATA_CPID}     ${GLOBAL_GETCOMDATA_ID}     ${registype}    ${ctypeid}           ${cname}          ${ctaxid}        ${cbranch}    ${cemail}
            ...       ${limittrypwd}                ${limitusr}                 ${pwdexpire}    ${limitrepeatpwd}    ${idlesession}    ${limitsession}
      END