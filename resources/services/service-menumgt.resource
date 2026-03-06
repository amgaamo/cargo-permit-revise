*** Settings ***
Resource    ../../resources/commonkeywords.resource

*** Keywords ***
Request Service Get list Menu
   [Arguments]    ${headeruser}    ${headerpassword}        ${menuname}

      main-service.Create Header Authen Service          ${headeruser}    ${headerpassword}

      ${bodydata}=      Catenate      {"pageNum":1,"pageSize":10,"gid":null,"name":"${menuname}","url":null}
      &{resp_getlistmenu}=   HTTP     ${SERVICE_GETLISTMENU_PATH}    method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}

      Set Local Variable   ${status_val}                    ${resp_getlistmenu.body.status}

      IF   '${status_val}'=='success'
            Log To Console      \nRequest Service Get List Menu Status: ${status_val}
            Set Global Variable  ${GLOBAL_MENURECORD_FOUND}       ${resp_getlistmenu.body.data.row}
          IF    '${GLOBAL_MENURECORD_FOUND}'=='1'
                Set Global Variable    ${GLOBAL_GETMENUID}        ${resp_getlistmenu.body.data.data[0].id}
          ELSE IF   '${GLOBAL_MENURECORD_FOUND}'=='0'
                Log To Console   \nGet list Menu: No record found
          ELSE
                Fail      \nGet list Menu: Found Data ${GLOBAL_MENURECORD_FOUND} records
          END
      ELSE
            Fail    \nRequest Service Get list Menu Status: ${status_val}, ${resp_getlistmenu.body.message}
      END
      Log    \nService:${SERVICE_GETLISTMENU_PATH} \nBody: ${bodydata}

Request Service Create Menu
   [Arguments]    ${headeruser}    ${headerpassword}    ${icon}       ${menuname}    ${isSubmenu}      ${parentMenuId}    ${urlmenu}      ${ordermenu}

      main-service.Create Header Authen Service          ${headeruser}     ${headerpassword}
      ${bodydata}=        Catenate          {"icon":"${icon}","name":"${menuname}","isSubMenu":${isSubmenu},"parentMenuId":"${parentMenuId}","url":"${urlmenu}","order":${ordermenu}}
      &{resp_createmenu}=   HTTP     ${SERVICE_CREATEMENU_PATH}    method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}

      Set Local Variable    ${status_val}         ${resp_createmenu.body.status}

      IF  '${status_val}'=='success'
            Set Global Variable    ${GLOBAL_NEW_MENUID}      ${resp_createmenu.body.data.id}
      ELSE
           Fail    \nRequest Service Status: ${status_val}, ${resp_createmenu.body.message}
      END
      Log    \nService:${SERVICE_CREATEMENU_PATH} \nBody: ${bodydata}

Request Service Add Parent Menu
   [Arguments]   ${headeruser}    ${headerpassword}     ${icon}   ${menuname}      ${ordermenu}

      Request Service Get list Menu           ${headeruser}    ${headerpassword}    ${menuname}

      IF    '${GLOBAL_MENURECORD_FOUND}'=='0'
            Request Service Create Menu            ${headeruser}    ${headerpassword}     ${icon}    ${menuname}    false    ${EMPTY}    ${EMPTY}    ${ordermenu}
      ELSE IF   '${GLOBAL_MENURECORD_FOUND}'=='1'
            Request Service Delete by Menu Name    ${headeruser}    ${headerpassword}     ${menuname}
            Request Service Create Menu            ${headeruser}    ${headerpassword}     ${icon}    ${menuname}    false    ${EMPTY}    ${EMPTY}    ${ordermenu}
      ELSE
            Fail    Cannot Add Parent Menu: Menu found ${GLOBAL_MENURECORD_FOUND} records, should be 1 record.
      END

Request Service Add Sub Menu
   [Arguments]   ${headeruser}    ${headerpassword}     ${icon}   ${mainmenuname}   ${submenuname}    ${urlmenu}    ${ordermenu}
      Request Service Get list Menu           ${headeruser}    ${headerpassword}    ${submenuname}

      IF    '${GLOBAL_MENURECORD_FOUND}'=='0'
          Request Service Get list Menu         ${headeruser}    ${headerpassword}    ${mainmenuname}
          Request Service Create Menu           ${headeruser}    ${headerpassword}     ${icon}    ${submenuname}    true    ${GLOBAL_GETMENUID}   ${urlmenu}    ${ordermenu}
      ELSE IF   '${GLOBAL_MENURECORD_FOUND}'=='1'
           Request Service Delete by Menu Name   ${headeruser}    ${headerpassword}     ${submenuname}
           Request Service Get list Menu         ${headeruser}    ${headerpassword}     ${mainmenuname}
           Request Service Create Menu           ${headeruser}    ${headerpassword}     ${icon}    ${submenuname}    false    ${EMPTY}    ${urlmenu}    ${ordermenu}
      ELSE
          Fail    Cannot Add Sub Menu: Found ${GLOBAL_MENURECORD_FOUND} records, should be 1 record.
      END


Request Service Delete by Menu Name
      [Arguments]   ${headeruser}    ${headerpassword}      ${menuname}

      Request Service Get list Menu           ${headeruser}    ${headerpassword}    ${menuname}

      IF   '${GLOBAL_MENURECORD_FOUND}'=='1'
            ${bodydata}=        Catenate          {"id":"${GLOBAL_GETMENUID}"}
            &{resp_delmenu}=   HTTP     ${SERVICE_DELETEMENU_PATH}    method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}
            Set Local Variable   ${status_val}    ${resp_delmenu.body.status}
          IF   '${status_val}'=='success'
              Log To Console      \nRequest Service Delete Menu (${menuname}) Status: ${status_val}
          ELSE
              Fail    \nRequest Service Delete Menu Status: ${status_val}, ${resp_delmenu.body.message}
          END
          Log    \nService:${SERVICE_DELETEMENU_PATH} \nBody: ${bodydata}
          
      ELSE IF   '${GLOBAL_MENURECORD_FOUND}'=='0'
              Log To Console    \nRequest Service Delete Menu (${menuname}) Status: Not Found Record
      ELSE
            Fail      \nRequest Service Delete Menu (${menuname}) should equal 1 record.
      END
      
Request Service Verify Get list Menu load success
   [Arguments]    ${headeruser}    ${headerpassword}        ${menuname}    ${menuurl}=${EMPTY}

      main-service.Create Header Authen Service        ${headeruser}    ${headerpassword}
      ${bodydata}=      Catenate      {"pageNum":1,"pageSize":10,"gid":null,"name":"${menuname}","url":"${menuurl}"}

      &{resp_getlistmenu}=   HTTP     ${SERVICE_GETLISTMENU_PATH}    method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}

      Set Local Variable   ${status_val}       ${resp_getlistmenu.body.status}
      IF  '${status_val}'=='success'
           Log To Console      \nRequest Service Verify Get list Menu load Status: ${status_val}
      ELSE
           Fail    \nRequest Service Get list Menu load Status: ${status_val}, ${resp_getlistmenu.body.message}
      END
      Log    \nService:${SERVICE_GETLISTMENU_PATH} \nBody: ${bodydata}

Request Service Verify Get Menu by Menu Name
      [Arguments]   ${headeruser}    ${headerpassword}      ${menuname}

      Request Service Get list Menu           ${headeruser}    ${headerpassword}    ${menuname}
      ${bodydata}=      Catenate      {"id":"${GLOBAL_GETMENUID}"}

      &{resp_getmenudata}=   HTTP     ${SERVICE_GETMENUBYID_PATH}    method=POST         body=${bodydata}    headers=${GLOBAL_APIAUTH_HEADERS}

      Set Local Variable   ${status_val}       ${resp_getmenudata.body.status}
      IF   '${status_val}'=='success'
            Log To Console      \nRequest Service Verify Get Menu by Menu Name Status: ${status_val}
      ELSE
            Fail    \nRequest Service Verify Get Menu by Menu Name Status: ${status_val}, ${resp_getmenudata.body.message}
      END
      Log    \nService:${SERVICE_GETMENUBYID_PATH} \nBody: ${bodydata}
Create Data List of Menu
    [Arguments]     ${headeruser}    ${headerpassword}    @{menuname}

      ${GLOBAL_MENUDATALIST}=      Create List
      ${lengthmenu}=         Get Length    ${menuname}

      FOR  ${index}     IN RANGE     ${lengthmenu}
            Request Service Get list Menu          ${headeruser}    ${headerpassword}      ${menuname}[${index}]
            Insert Into List    ${GLOBAL_MENUDATALIST}       ${index}          {"menuId":${GLOBAL_GETMENUID},"companyTypeId":null}
      END
      ${GLOBAL_MENUDATALIST}=         Convert To String     ${GLOBAL_MENUDATALIST}
      ${GLOBAL_MENUDATALIST}=         Remove String         ${GLOBAL_MENUDATALIST}    '

      Set Global Variable    ${GLOBAL_MENUDATALIST}
