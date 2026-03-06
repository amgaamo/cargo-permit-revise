*** Settings ***
Resource    ../../resources/commonkeywords.resource

*** Keywords ***
Request Service Register Verify
    [Arguments]     ${taxid}      ${registype}
      main-service.Set Path Request URL
      ${bodydata}=      Catenate       {"companyTaxId":"${taxid}","registerType":"${registype}"}

      &{resp_getregisverify}=   HTTP     ${SERVICE_REGISVERIFY_PATH}    method=POST         body=${bodydata}

      Set Local Variable   ${status_val}     ${resp_getregisverify.body.status}
      Should Be Equal      ${status_val}     success     ignore_case=True

      Set Local Variable   ${passedverify}     ${resp_getregisverify.body.data.passedVerify}
      Should Be Equal      '${passedverify}'   'true'     ignore_case=True
      Log    \nService:${SERVICE_REGISVERIFY_PATH} \nBody: ${bodydata}