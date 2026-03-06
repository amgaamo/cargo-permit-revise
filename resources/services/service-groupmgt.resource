*** Settings ***
Resource    ../../resources/commonkeywords.resource

*** Keywords ***
Request Service Get list Group
   [Arguments]    ${headeruser}    ${headerpassword}        ${groupname}

      main-service.Create Header Authen Service       ${headeruser}    ${headerpassword}
      ${bodydata}=      Catenate      {"pageNum":1,"pageSize":10,"cpid":null,"name":"${groupname}"}
      &{resp_getlistgroup}=   HTTP     ${SERVICE_GETLISTGROUP_PATH}    method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}
      Set Local Variable   ${status_val}       ${resp_getlistgroup.body.status}

      IF   '${status_val}'=='success'
             Log To Console       \nGet list Group (${groupname}): ${status_val}
             Set Global Variable  ${GLOBAL_GROUPRECORD_FOUND}       ${resp_getlistgroup.body.data.row}
          IF    '${GLOBAL_GROUPRECORD_FOUND}'=='1'
              Set Global Variable    ${GLOBALGETGROUP_GID}           ${resp_getlistgroup.body.data.data[0].gid}
              Set Global Variable    ${GLOBALGETGROUP_COMNANE}       ${resp_getlistgroup.body.data.data[0].companyName}
          ELSE IF   '${GLOBAL_GROUPRECORD_FOUND}'=='0'
              Log To Console    \n${groupname}: No record found
          ELSE
              Fail        \n${groupname}: Found Data ${GLOBAL_GROUPRECORD_FOUND} records
          END
      ELSE
            Fail    \nGet list Group: status is ${status_val}, ${resp_getlistgroup.body.message}
      END
      Log    \nService:${SERVICE_GETLISTGROUP_PATH} \nBody: ${bodydata}

Request Service Get list Group by Company name
   [Arguments]    ${headeruser}    ${headerpassword}        ${companyname}

      main-service.Create Header Authen Service        ${headeruser}    ${headerpassword}
      Request Service Get list Company    ${headeruser}    ${headerpassword}     ${companyname}

      ${bodydata}=      Catenate      {"pageNum":1,"pageSize":10,"cpid":"${GLOBAL_GETCOMDATA_CPID}","name":null}
      &{resp_getlistgroup}=   HTTP     ${SERVICE_GETLISTGROUP_PATH}    method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}
      Set Local Variable   ${status_val}       ${resp_getlistgroup.body.status}

      IF   '${status_val}'=='success'
             Log To Console       \nGet list Group by company name: ${status_val}
             Set Global Variable  ${GLOBAL_GROUPRECORD_FOUND}       ${resp_getlistgroup.body.data.row}
          IF    '${GLOBAL_GROUPRECORD_FOUND}'=='1'
              Set Global Variable    ${GLOBALGETGROUP_GID}           ${resp_getlistgroup.body.data.data[0].gid}
              Set Global Variable    ${GLOBALGETGROUP_NAME}           ${resp_getlistgroup.body.data.data[0].name}
              Set Global Variable    ${GLOBALGETGROUP_COMNANE}       ${resp_getlistgroup.body.data.data[0].companyName}
          ELSE IF   '${GLOBAL_GROUPRECORD_FOUND}'=='0'
              Log To Console    \nGet list Group by company name: No record found
          ELSE
              Fail        \nGet list Group by company name: Found Data ${GLOBAL_GROUPRECORD_FOUND} records
          END
      ELSE
            Fail    \nGet list Group by company name: status is ${status_val}, ${resp_getlistgroup.body.message}
      END
      Log    \nService:${SERVICE_GETLISTGROUP_PATH} \nBody: ${bodydata}
Request Service Create New Group
   [Arguments]    ${headeruser}    ${headerpassword}     ${companyname}    ${groupname}   ${limitusr}    ${isActive}      ${isApproval}     ${approvalId}    @{rolename}

      Request Service Get list Company     ${headeruser}    ${headerpassword}    ${companyname}
      Should Be True    '${GLOBAL_COMPANYRECORD_FOUND}'=='1'

      ${grouprole_datalist}=      Create List
      ${length_role}=   Get Length    ${rolename}

      FOR  ${index}     IN RANGE     ${length_role}
            Request Service Get list Role     ${headeruser}    ${headerpassword}      ${rolename}[${index}]
            Insert Into List    ${grouprole_datalist}       ${index}          {"gid": null,"name": "${rolename}[${index}]","roleId": ${GLOBAL_GETROLEID}}
      END
      ${grouprole_datalist}=         Convert To String     ${grouprole_datalist}
      ${grouprole_datalist}=         Remove String         ${grouprole_datalist}    '

      ${bodydata}=      Catenate       { "cpid": "${GLOBAL_GETCOMDATA_CPID}",
      ...                                "name": "${groupname}",
      ...                                "limitUser": ${limitusr},
      ...                                "grouprole": ${grouprole_datalist},
      ...                                "isActive": ${isActive},
      ...                                "approval":${isApproval},
      ...                                "approvalId":"${approvalId}"}

      &{resp_creategroup}=   HTTP     ${SERVICE_CREATEGROUP_PATH}       method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}

      Set Local Variable   ${status_val}       ${resp_creategroup.body.status}

      IF  '${status_val}'=='success'
            Set Global Variable       ${GLOBAL_NEWGROUPID}      ${resp_creategroup.body.data.gid}
            Log To Console    \nCreate New Group (${groupname}) is ${status_val}
      ELSE
           Fail    \nCreate Group Status: ${status_val}, ${resp_creategroup.body.message}
      END
      Log    \nService:${SERVICE_CREATEGROUP_PATH} \nBody: ${bodydata}
Request Service Update Group
   [Arguments]    ${headeruser}    ${headerpassword}     ${companyname}    ${groupname}     ${limitusr}      ${isApproval}     ${approvalId}     @{rolename}

      Request Service Get list Company     ${headeruser}    ${headerpassword}    ${companyname}
      Request Service Get list Group       ${headeruser}    ${headerpassword}    ${groupname}

      ${grouprole_datalist}=      Create List
      ${lengthrole}=    Get Length    ${rolename}

      FOR  ${index}     IN RANGE     ${lengthrole}
            Request Service Get list Role     ${headeruser}    ${headerpassword}      ${rolename}[${index}]
            Insert Into List    ${grouprole_datalist}       ${index}          {"gid": null,"name": "${rolename}[${index}]","roleId": ${GLOBAL_GETROLEID}}
      END
      ${grouprole_datalist}=         Convert To String     ${grouprole_datalist}
      ${grouprole_datalist}=         Remove String         ${grouprole_datalist}    '

      ${bodydata}=      Catenate       {"cpid":"${GLOBAL_GETCOMDATA_CPID}","name":"${groupname}","limitUser":${limitusr},"gid":"${GLOBALGETGROUP_GID}","grouprole": ${grouprole_datalist},"approval":${isApproval} ,"approvalId":"${approvalId}"}

      &{resp_updategroup}=   HTTP     ${SERVICE_UPDATEGROUP_PATH}       method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}
      Set Local Variable   ${status_val}       ${resp_updategroup.body.status}

      IF  '${status_val}'=='success'
          Log To Console      \nUpdate Group(groupname) Status: ${status_val}
      ELSE
          Fail    \nUpdate Group(groupname) Status: ${status_val}, ${resp_updategroup.body.message}
      END
      Log    \nService:${SERVICE_UPDATEGROUP_PATH} \nBody: ${bodydata}

Request Service Add Default Group data test
   [Arguments]   ${headeruser}    ${headerpassword}     ${companyname}    ${groupname}
   ...           ${limitusr}      ${isActive}           ${isApproval}     ${approvalId}     @{rolename}

      Request Service Get list Group         ${headeruser}    ${headerpassword}    ${groupname}

      IF  '${GLOBAL_GROUPRECORD_FOUND}'=='0'
          Request Service Create New Group
          ...        ${headeruser}    ${headerpassword}    ${companyname}    ${groupname}
          ...        ${limitusr}      ${isActive}          ${isApproval}     ${approvalId}    @{rolename}
          Request Service Get list Group        ${headeruser}    ${headerpassword}    ${groupname}
      ELSE IF   '${GLOBAL_GROUPRECORD_FOUND}'=='1'
          Request Service Get list Group        ${headeruser}    ${headerpassword}    ${groupname}
          Request Service Update Group
          ...        ${headeruser}    ${headerpassword}    ${companyname}    ${groupname}
          ...        ${limitusr}      ${isApproval}        ${approvalId}     @{rolename}
      ELSE
          Fail    Please Check Group Name should be 1 record.
      END

Request Service Verify Group Company List is found
   [Arguments]    ${headeruser}    ${headerpassword}     ${expcompany}

      main-service.Create Header Authen Service    ${headeruser}    ${headerpassword}
      ${bodydata}=      Catenate      {"pageNum":1,"pageSize":9999}

      &{resp_getgcomlist}=   HTTP     ${SERVICE_GETLISTGROUPCOMPANY_PATH}    method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}

      Set Local Variable   ${status_val}       ${resp_getgcomlist.body.status}

      IF    '${status_val}'=='success'
            Set Global Variable                  ${GLOBAL_GETGROUPCOMLIST}        ${resp_getgcomlist.body}
            Extract Value from JSON data         ${GLOBAL_GETGROUPCOMLIST}        $.data.data[*].name
            Should Contain         ${GLOBAL_JSONVALUE}     ${expcompany}
      ELSE
            Fail    \nVerify Group Company List (${expcompany}) status: ${status_val}, ${resp_getgcomlist.body.message}
      END
      Log    \nService:${SERVICE_GETLISTGROUPCOMPANY_PATH} \nBody: ${bodydata}

Request Service Verify Group of Company List is found
   [Arguments]    ${headeruser}    ${headerpassword}     ${companyname}    ${expgroupname}

      Request Service Get Company Data     ${headeruser}    ${headerpassword}    ${companyname}

      ${bodydata}=      Catenate      {"pageNum":1,"pageSize":99,"cpid":"${GLOBAL_GETCOMDATA_CPID}","name":null}

      &{resp_getgroupofcom}=   HTTP     ${SERVICE_GETLISTGROUPOFCOMPANY_PATH}       method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}

      Set Local Variable   ${status_val}       ${resp_getgroupofcom.body.status}

      IF   '${status_val}'=='success'
            Set Global Variable                  ${GLOBAL_GETGROUPOFCOMLIST}      ${resp_getgroupofcom.body}
            Extract Value from JSON data         ${GLOBAL_GETGROUPOFCOMLIST}      $.data.data[*].name
            Should Contain         ${GLOBAL_JSONVALUE}     ${expgroupname}
      ELSE
            Fail    \nRequest Service Status: ${status_val}, ${resp_getgroupofcom.body.message}
      END
      Log    \nService:${SERVICE_GETLISTGROUPOFCOMPANY_PATH} \nBody: ${bodydata}

Request Service Group Management Create data test
   [Arguments]    ${headeruser}      ${headerpassword}

   defaultdatalist.Create List Data Test Default Role Value
   Set Local Variable    ${default_companygroup01}         ${JS_DEFAULTDATA['companydata'][1]}[companyname]
   Set Local Variable    ${default_companygroup02}         ${JS_DEFAULTDATA['companydata'][3]}[companyname]

     FOR   ${index}    IN RANGE    3
        ${data_index}=    Evaluate    ${index}+1

        Request Service Get list Group      ${headeruser}    ${headerpassword}    ${DS_GROUP['data_${data_index}'][${group_col.groupname}]}

        IF   '${GLOBAL_GROUPRECORD_FOUND}'=='0'
                Request Service Create New Group
                ...       ${headeruser}    ${headerpassword}
                ...       ${default_companygroup01}
                ...       ${DS_GROUP['data_${data_index}'][${group_col.groupname}]}
                ...       ${DS_GROUP['data_${data_index}'][${group_col.limituser}]}
                ...       true    false    ${EMPTY}
                ...       @{GLOBAL_DEFAULTROLE_LIST}
        ELSE
              Request Service Get list Group    ${headeruser}    ${headerpassword}    ${DS_GROUP['data_${data_index}'][${group_col.groupname}]}
              Request Service Update Group
              ...         ${headeruser}    ${headerpassword}
              ...         ${default_companygroup01}
              ...         ${DS_GROUP['data_${data_index}'][${group_col.groupname}]}
              ...         ${DS_GROUP['data_${data_index}'][${group_col.limituser}]}
              ...         false    ${EMPTY}
              ...         @{GLOBAL_DEFAULTROLE_LIST}
        END
      END

     FOR   ${index}    IN RANGE    3      5
        ${data_index}=    Evaluate    ${index}+1
        Request Service Get list Group      ${headeruser}    ${headerpassword}    ${DS_GROUP['data_${data_index}'][${group_col.groupname}]}

        IF   '${GLOBAL_GROUPRECORD_FOUND}'=='0'
                Request Service Create New Group
                ...       ${headeruser}    ${headerpassword}
                ...       ${default_companygroup02}
                ...       ${DS_GROUP['data_${data_index}'][${group_col.groupname}]}
                ...       ${DS_GROUP['data_${data_index}'][${group_col.limituser}]}
                ...       true    false    ${EMPTY}
                ...       @{GLOBAL_DEFAULTROLE_LIST}
        ELSE
              Request Service Get list Group    ${headeruser}    ${headerpassword}    ${DS_GROUP['data_${data_index}'][${group_col.groupname}]}
              Request Service Update Group
              ...         ${headeruser}    ${headerpassword}
              ...         ${default_companygroup02}
              ...         ${DS_GROUP['data_${data_index}'][${group_col.groupname}]}
              ...         ${DS_GROUP['data_${data_index}'][${group_col.limituser}]}
              ...         false    ${EMPTY}
              ...         @{GLOBAL_DEFAULTROLE_LIST}
        END
      END
