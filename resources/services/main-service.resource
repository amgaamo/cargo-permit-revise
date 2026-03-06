*** Settings ***

Resource    ../../resources/commonkeywords.resource
Resource    service-profile.resource
Resource    service-companymgt.resource
Resource    service-ctypemgt.resource
Resource    service-groupmgt.resource
Resource    service-menumgt.resource
Resource    service-permmgt.resource
Resource    service-register.resource
Resource    service-rolemgt.resource
Resource    service-usermgt.resource


*** Variables ***
${VAR_PATH_LOGIN}                    users/login
${VAR_PATH_GETSESSION}               users/getsession
${VAR_PATH_LOGOUT}                   users/logout
${VAR_PATH_CHANGEPASSWORD}           users/changepassword

${VAR_PATH_CREATECOMPANY}            users/v2/createcompany
${VAR_PATH_UPDATECOMPANY}            users/v2/updatecompany
${VAR_PATH_UPDATECOMSTATUS}          users/updatecompanystatus
${VAR_PATH_GETLISTCOMPANY}           users/v2/getlistcompany
${VAR_PATH_GETCOMPANY_INFO}          users/v2/getcompany
${VAR_PATH_GROUPGETLISTCOMPANY}      users/getlistcompany
${VAR_PATH_GETCOMTYPEREGISTYPE}      users/getlistcompanytypebyregistertype

${VAR_PATH_CREATEUSER}               users/createuser
${VAR_PATH_UPDATEUSER}               users/updateuser
${VAR_PATH_GETLISTUSER}              users/getlistuser
${VAR_PATH_UPDATEUSERTATUS}          users/updatestatus

${VAR_PATH_GETGROUPOFCOM}            users/getlistgroup
${VAR_PATH_CREATEGROUP}              users/creategroup
${VAR_PATH_UPDATEGROUP}              users/updategroup
${VAR_PATH_GETLISTGROUP}             users/getlistgroup

${VAR_PATH_GETLISTROLE}              users/getlistrole
${VAR_PATH_CREATEROLE}               users/createrole
${VAR_PATH_UPDATEROLE}               users/updaterole
${VAR_PATH_GETROLEMENU}              users/getrolemenu
${VAR_PATH_GETROLEPERM}              users/getrolepermission

${VAR_PATH_CREATEMENU}               users/createmenu
${VAR_PATH_UPDATEMENU}               users/updatemenu
${VAR_PATH_DELETEMENU}               users/deletemenu
${VAR_PATH_GETLISTMENUNAME}          users/getlistmenumanage
${VAR_PATH_GETMAINMENU}              users/getmainmenu
${VAR_PATH_GETMENUBYID}              users/getmenubyid

${VAR_PATH_CREATEPERM}               users/createpermission
${VAR_PATH_DELETEPERM}               users/deletepermission
${VAR_PATH_GETLISTPERM}              users/getlistpermission

${VAR_PATH_REGISVERIFY}              users/register/verify

${VAR_PATH_GETCOMTYPEMENU}           users/getcompanytypemenu
${VAR_PATH_GETCOMTYPEINFO}           users/gettrackingcompanytype
${VAR_PATH_CREATECOMTYPE}            users/createcompanytype
${VAR_PATH_UPDATECOMTYPE}            users/updatecompanytype

*** Keywords ***
Set Path Request URL
      commonkeywords.Set Data for Run Automated Test
      Set Global Variable         ${SERVICE_LOGINUSER_PATH}               ${URLTEST}/${APIPATHTEST}/${VAR_PATH_LOGIN}
      Set Global Variable         ${SERVICE_GETSESSION_PATH}              ${URLTEST}/${APIPATHTEST}/${VAR_PATH_GETSESSION}
      Set Global Variable         ${SERVICE_LOGOUT_PATH}                  ${URLTEST}/${APIPATHTEST}/${VAR_PATH_LOGOUT}
      Set Global Variable         ${SERVICE_CHANGEPWD_PATH}               ${URLTEST}/${APIPATHTEST}/${VAR_PATH_CHANGEPASSWORD}

      Set Global Variable         ${SERVICE_CREATECOMPANY_PATH}           ${URLTEST}/${APIPATHTEST}/${VAR_PATH_CREATECOMPANY}
      Set Global Variable         ${SERVICE_UPDATECOMPANY_PATH}           ${URLTEST}/${APIPATHTEST}/${VAR_PATH_UPDATECOMPANY}
      Set Global Variable         ${SERVICE_UPDATECOMSATUS_PATH}          ${URLTEST}/${APIPATHTEST}/${VAR_PATH_UPDATECOMSTATUS}
      Set Global Variable         ${SERVICE_GETLISTCOMPANY_PATH}          ${URLTEST}/${APIPATHTEST}/${VAR_PATH_GETLISTCOMPANY}
      Set Global Variable         ${SERVICE_GETCOMPANYDATA_PATH}          ${URLTEST}/${APIPATHTEST}/${VAR_PATH_GETCOMPANY_INFO}
      Set Global Variable         ${SERVICE_GETLISTGROUPCOMPANY_PATH}     ${URLTEST}/${APIPATHTEST}/${VAR_PATH_GROUPGETLISTCOMPANY}
      Set Global Variable         ${SERVICE_GETCOMTYPEREGISTYPE_PATH}     ${URLTEST}/${APIPATHTEST}/${VAR_PATH_GETCOMTYPEREGISTYPE}

      Set Global Variable         ${SERVICE_CREATEUSER_PATH}              ${URLTEST}/${APIPATHTEST}/${VAR_PATH_CREATEUSER}
      Set Global Variable         ${SERVICE_UPDATEUSER_PATH}              ${URLTEST}/${APIPATHTEST}/${VAR_PATH_UPDATEUSER}
      Set Global Variable         ${SERVICE_GETLISTUSER_PATH}             ${URLTEST}/${APIPATHTEST}/${VAR_PATH_GETLISTUSER}
      Set Global Variable         ${SERVICE_UPDATEUSERSTATUS_PATH}        ${URLTEST}/${APIPATHTEST}/${VAR_PATH_UPDATEUSERTATUS}

      Set Global Variable         ${SERVICE_GETLISTGROUPOFCOMPANY_PATH}   ${URLTEST}/${APIPATHTEST}/${VAR_PATH_GETGROUPOFCOM}
      Set Global Variable         ${SERVICE_CREATEGROUP_PATH}             ${URLTEST}/${APIPATHTEST}/${VAR_PATH_CREATEGROUP}
      Set Global Variable         ${SERVICE_UPDATEGROUP_PATH}             ${URLTEST}/${APIPATHTEST}/${VAR_PATH_UPDATEGROUP}
      Set Global Variable         ${SERVICE_GETLISTGROUP_PATH}            ${URLTEST}/${APIPATHTEST}/${VAR_PATH_GETLISTGROUP}

      Set Global Variable         ${SERVICE_GETLISTROLE_PATH}             ${URLTEST}/${APIPATHTEST}/${VAR_PATH_GETLISTROLE}
      Set Global Variable         ${SERVICE_CREATEROLE_PATH}              ${URLTEST}/${APIPATHTEST}/${VAR_PATH_CREATEROLE}
      Set Global Variable         ${SERVICE_UPDATEROLE_PATH}              ${URLTEST}/${APIPATHTEST}/${VAR_PATH_UPDATEROLE}
      Set Global Variable         ${SERVICE_GETROLEMENU_PATH}             ${URLTEST}/${APIPATHTEST}/${VAR_PATH_GETROLEMENU}
      Set Global Variable         ${SERVICE_GETROLEPERM_PATH}             ${URLTEST}/${APIPATHTEST}/${VAR_PATH_GETROLEPERM}

      Set Global Variable         ${SERVICE_CREATEMENU_PATH}              ${URLTEST}/${APIPATHTEST}/${VAR_PATH_CREATEMENU}
      Set Global Variable         ${SERVICE_UPDATEMENU_PATH}              ${URLTEST}/${APIPATHTEST}/${VAR_PATH_UPDATEMENU}
      Set Global Variable         ${SERVICE_DELETEMENU_PATH}              ${URLTEST}/${APIPATHTEST}/${VAR_PATH_DELETEMENU}
      Set Global Variable         ${SERVICE_GETLISTMENU_PATH}             ${URLTEST}/${APIPATHTEST}/${VAR_PATH_GETLISTMENUNAME}
      Set Global Variable         ${SERVICE_GETMAINMENU_PATH}             ${URLTEST}/${APIPATHTEST}/${VAR_PATH_GETMAINMENU}
      Set Global Variable         ${SERVICE_GETMENUBYID_PATH}             ${URLTEST}/${APIPATHTEST}/${VAR_PATH_GETMENUBYID}

      Set Global Variable         ${SERVICE_CREATEPERM_PATH}              ${URLTEST}/${APIPATHTEST}/${VAR_PATH_CREATEPERM}
      Set Global Variable         ${SERVICE_DELETEPERM_PATH}              ${URLTEST}/${APIPATHTEST}/${VAR_PATH_DELETEPERM}
      Set Global Variable         ${SERVICE_GETLISTPREM_PATH}             ${URLTEST}/${APIPATHTEST}/${VAR_PATH_GETLISTPERM}

      Set Global Variable         ${SERVICE_REGISVERIFY_PATH}             ${URLTEST}/${APIPATHTEST}/${VAR_PATH_REGISVERIFY}

      Set Global Variable         ${SERVICE_GETCOMTYPEMENU_PATH}          ${URLTEST}/${APIPATHTEST}/${VAR_PATH_GETCOMTYPEMENU}
      Set Global Variable         ${SERVICE_GETCOMTYPEINFO_PATH}          ${URLTEST}/${APIPATHTEST}/${VAR_PATH_GETCOMTYPEINFO}
      Set Global Variable         ${SERVICE_CREATECOMTYPE_PATH}           ${URLTEST}/${APIPATHTEST}/${VAR_PATH_CREATECOMTYPE}
      Set Global Variable         ${SERVICE_UPDATECOMTYPE_PATH}           ${URLTEST}/${APIPATHTEST}/${VAR_PATH_UPDATECOMTYPE}


Request Service Get Session Data
    [Arguments]     ${username}     ${password}

    Set Path Request URL
    ${bodydata}=    Catenate       {"username": "${username}", "password": "${password}"}

    &{resp_getsession}=       HTTP     ${SERVICE_GETSESSION_PATH}     method=POST       body=${bodydata}

    Set Local Variable        ${status_val}       ${resp_getsession.body.status}
    Should Be Equal           ${status_val}       success

    Run Keyword If    '${status_val}'=='success'
    ...               Run Keywords        Set Global Variable         ${GLOBAL_APIUID}         ${resp_getsession.body.data.uid}
    ...               AND                 Set Global Variable         ${GLOBAL_APIUCODE}       ${resp_getsession.body.data.ucode}
    ...               AND                 Set Global Variable         ${GLOBAL_APIUSERNAME}    ${resp_getsession.body.data.username}
    ...               AND                 Set Global Variable         ${GLOBAL_APICPID}        ${resp_getsession.body.data.cpid}
    ...               AND                 Set Global Variable         ${GLOBAL_APIGID}         ${resp_getsession.body.data.gid}
    ...       ELSE    Fail                Please check request service get session keyword!


Create Header Authen Service
   [Arguments]    ${headerusr}    ${headerpwd}
    Request Service Get Session Data    ${headerusr}        ${headerpwd}
    ${GLOBAL_APIAUTH_HEADERS}=     Create Dictionary        Content-Type=application/json       uid=${GLOBAL_APIUID}      ucode=${GLOBAL_APIUCODE}

    Set Global Variable            ${GLOBAL_APIAUTH_HEADERS}
