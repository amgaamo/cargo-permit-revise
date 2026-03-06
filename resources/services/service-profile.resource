*** Settings ***
Resource    ../../resources/commonkeywords.resource

*** Keywords ***
Request Service Login System
   [Arguments]    ${username}     ${password}      ${status}=success

    main-service.Set Path Request URL

    ${bodydata}=            Catenate      {"username": "${username}", "password": "${password}"}
    &{resp_login}=          HTTP     ${SERVICE_LOGINUSER_PATH}     method=POST       body=${bodydata}
    Set Local Variable       ${status_val}    ${resp_login.body.status}

    IF   '${status_val}'=='success'
        Should Be True      '${status_val}'=='${status}'
    ELSE
        Should Be True      '${status_val}'=='${status}'
        Set Global Variable     ${GLOBAL_LOGIN_WARNMSG}          ${resp_login.body.message}
    END
    Set Global Variable     ${GLOBAL_MSGLOGIN}         ${resp_login.body.data}
    Log    \nService:${SERVICE_LOGINUSER_PATH} \nBody: ${bodydata}
Request Service Logout System
    [Arguments]     ${username}     ${password}
      main-service.Set Path Request URL
      main-service.Create Header Authen Service       ${username}      ${password}

      ${headers}=       Set Variable      ${GLOBAL_APIAUTH_HEADERS}
      &{resp_logout}=   HTTP     ${SERVICE_LOGOUT_PATH}     method=POST         body={}    headers=${headers}

      Set Local Variable    ${status_val}       ${resp_logout.body.status}
      Should Be Equal       ${status_val}       success
      
Request Service Change Password
    [Arguments]      ${headeruser}       ${headerpassword}     ${cpid}     ${uid}      ${oldpwd}     ${newpwd}

      main-service.Set Path Request URL
      main-service.Create Header Authen Service       ${headeruser}       ${headerpassword}

      ${bodydata}=        Catenate          { "cpid": "${cpid}", "uid": "${uid}", "oldPassword": "${oldpwd}", "password": "${newpwd}"}
      &{resp_changepass}=     HTTP          ${SERVICE_CHANGEPWD_PATH}    method=POST         body=${bodydata}     headers=${GLOBAL_APIAUTH_HEADERS}
      Set Local Variable    ${status_val}         ${resp_changepass.body.status}

      IF  '${status_val}'=='success'
            Log To Console      \nChange Password status: ${status_val}
      ELSE
            Fail    \Change Password status: ${status_val}, ${resp_changepass.body.message}
      END
      Log    \nService:${SERVICE_CHANGEPWD_PATH} \nBody: ${bodydata}