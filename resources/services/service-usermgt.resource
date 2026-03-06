*** Settings ***
Resource    ../../resources/commonkeywords.resource

*** Keywords ***
Request Service Get list User
   [Arguments]    ${headeruser}    ${headerpassword}        ${username}       ${firstName}    ${lastname}    ${email}

      main-service.Create Header Authen Service       ${headeruser}    ${headerpassword}
      ${bodydata}=          Catenate      { "pageSize": 10, "pageNum": 1, "firstName": "${firstName}", "lastName": "${lastname}", "username": "${username}", "email": "${email}" }
      &{resp_getlistusr}=   HTTP     ${SERVICE_GETLISTUSER_PATH}    method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}
      Set Local Variable   ${status_val}       ${resp_getlistusr.body.status}

      IF   '${status_val}'=='success'
             Log To Console      \nGet list User (${username}): ${status_val}
             Set Global Variable     ${GLOBAL_USERRECORD_FOUND}       ${resp_getlistusr.body.data.row}
          IF    '${GLOBAL_USERRECORD_FOUND}'=='1'
              Set Global Variable    ${GLOBAL_USERID}           ${resp_getlistusr.body.data.data[0].uid}
              Set Global Variable    ${GLOBAL_USERNAME}         ${resp_getlistusr.body.data.data[0].username}
              Set Global Variable    ${GLOBAL_USERACTIVE}       ${resp_getlistusr.body.data.data[0].active}
              Set Global Variable    ${GLOBAL_USERGROUPNAME}    ${resp_getlistusr.body.data.data[0].group}
              Set Global Variable    ${GLOBAL_USERCOMPANY}      ${resp_getlistusr.body.data.data[0].company}
          ELSE IF   '${GLOBAL_USERRECORD_FOUND}'=='0'
              Log To Console    \nGet list User ${username}: No record found
          ELSE
              Fail    \nGet list User ${username}:  found data  ${GLOBAL_USERRECORD_FOUND} records
          END
      ELSE
            Fail    \nGet list User: status is ${status_val}, ${resp_getlistusr.body.message}
      END
      Log    \nService:${SERVICE_GETLISTUSER_PATH} \nBody: ${bodydata}
Request Service Create New User
   [Arguments]    ${headeruser}    ${headerpassword}    ${username}       ${password}    ${companyname}   ${groupname}    ${firstname}      ${lastname}    ${telnumber}      ${email}

      Request Service Get list Company      ${headeruser}    ${headerpassword}    ${companyname}
      Request Service Get list Group        ${headeruser}    ${headerpassword}    ${groupname}

      main-service.Create Header Authen Service       ${headeruser}     ${headerpassword}
      ${bodydata}=        Catenate       {"username": "${username}", "password": "${password}",
      ...                                 "firstName": "${firstname}", "lastName": "${lastname}", "telNumber": "${telnumber}", "email": "${email}",
      ...                                 "gid": "${GLOBALGETGROUP_GID}", "cpid": "${GLOBAL_GETCOMDATA_CPID}" }

      &{resp_createusr}=   HTTP     ${SERVICE_CREATEUSER_PATH}    method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}
      Set Local Variable    ${status_val}         ${resp_createusr.body.status}

      IF  '${status_val}'=='success'
          Set Global Variable    ${GLOBAL_NEWUSER_UID}      ${resp_createusr.body.data.uid}
          Set Global Variable    ${GLOBAL_NEWUSER_CPID}     ${resp_createusr.body.data.cpid}
      ELSE
          Fail    \nCreate '${username}' status: ${status_val}, ${resp_createusr.body.message}
      END
      Log    \nService:${SERVICE_CREATEUSER_PATH} \nBody: ${bodydata}

Request Service Update User
   [Arguments]    ${headeruser}    ${headerpassword}    ${companyname}    ${groupname}     ${username}    ${firstname}      ${lastname}    ${telnumber}      ${email}

      Request Service Get list Company    ${headeruser}    ${headerpassword}    ${companyname}
      Request Service Get list Group      ${headeruser}    ${headerpassword}    ${groupname}
      Request Service Get list User       ${headeruser}    ${headerpassword}    ${username}       ${EMPTY}      ${EMPTY}    ${EMPTY}

      ${bodydata}=        Catenate        { "uid":"${GLOBAL_USERID}",
      ...                                   "username": "${username}", "firstName": "${firstname}", "lastName": "${lastname}",
      ...                                   "telNumber": "${telnumber}", "email": "${email}",
      ...                                   "gid": "${GLOBALGETGROUP_GID}", "cpid": "${GLOBAL_GETCOMDATA_CPID}"}
      &{resp_updateusr}=   HTTP     ${SERVICE_UPDATEUSER_PATH}    method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}

      Set Local Variable    ${status_val}         ${resp_updateusr.body.status}

      IF  '${status_val}'=='success'
            Log To Console    \nUpdate '${username}' success.
      ELSE
            Fail    \nUpdate ${username} Status: ${status_val}, ${resp_updateusr.body.message}
      END
      Log    \nService:${SERVICE_UPDATEUSER_PATH} \nBody: ${bodydata}

Request Service Update User Status
   [Arguments]    ${headeruser}    ${headerpassword}     ${username}       ${isActive}

      Request Service Get list User       ${headeruser}     ${headerpassword}    ${username}    ${EMPTY}     ${EMPTY}   ${EMPTY}
      ${bodydata}=        Catenate        {"uid":"${GLOBAL_USERID}","isActive":${isActive}}

      &{resp_updateusrstatus}=   HTTP     ${SERVICE_UPDATEUSERSTATUS_PATH}    method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}

      Set Local Variable    ${status_val}         ${resp_updateusrstatus.body.status}

      IF    '${status_val}'=='success'
            Log To Console      \nUpdate '${username}' Status:  ${status_val}
      ELSE
            Fail    \nUpdate '${username}' Status: ${status_val}, ${resp_updateusrstatus.body.message}
      END
      Log    \nService:${SERVICE_UPDATEUSERSTATUS_PATH} \nBody: ${bodydata}

Request Service Add New User Data Test
   [Arguments]    ${headeruser}    ${headerpassword}    ${companyname}    ${groupname}    ${username}       ${password}    ${newpassword}    ${firstname}      ${lastname}    ${telnumber}      ${email}

      Request Service Get list Company      ${headeruser}    ${headerpassword}    ${companyname}
      Request Service Get list Group        ${headeruser}    ${headerpassword}    ${groupname}

      ${bodydata}=        Catenate   {  "username": "${username}", "password": "${password}",
      ...                                "firstName": "${firstname}", "lastName": "${lastname}",
      ...                                "telNumber": "${telnumber}","email": "${email}",
      ...                                "gid": "${GLOBALGETGROUP_GID}","cpid": "${GLOBAL_GETCOMDATA_CPID}"}

      &{resp_createusrtest}=   HTTP     ${SERVICE_CREATEUSER_PATH}    method=POST   body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}
      Set Local Variable    ${status_val}       ${resp_createusrtest.body.status}

      IF    '${status_val}'=='success'
              Request Service Update User Status     ${headeruser}    ${headerpassword}     ${username}    true
              Set Global Variable    ${GLOBAL_NEWUSERTEST_UID}      ${resp_createusrtest.body.data.uid}
              Set Global Variable    ${GLOBAL_NEWUSERTEST_CPID}     ${resp_createusrtest.body.data.cpid}
              Request Service Change Password     ${username}      ${password}      ${GLOBAL_NEWUSERTEST_CPID}     ${GLOBAL_NEWUSERTEST_UID}     ${password}     ${newpassword}
              Request Service Login System        ${username}      ${newpassword}   success
              Request Service Logout System       ${username}      ${newpassword}
              Log To Console    \nCreate/Update '${username}' success.
      ELSE
              Fail    \nCreate/Update ${username}: status is ${status_val}, ${resp_createusrtest.body.message}
      END
      Log    \nService:${SERVICE_CREATEUSER_PATH} \nBody: ${bodydata}