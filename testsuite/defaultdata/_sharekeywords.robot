*** Settings ***
Resource    ../../resources/commonkeywords.resource

*** Keywords ***
Create New User Data Test
    [Arguments]   ${headeruser}   ${headerpassword}     ${username}     ${password}     ${newpassword}
    ...           ${firstname}    ${lastname}           ${telnumber}    ${email}        ${companyuser}=${EMPTY}    ${groupuser}=${EMPTY}    ${email_company}=${EMPTY}

      Set Local Variable    ${superadmin_email}         ${JS_DEFAULTDATA['companydata'][0]}[email]
      service-usermgt.Request Service Get list User
      ...     headeruser=${headeruser}    headerpassword=${headerpassword}
      ...     username=${username}
      ...     firstName=${EMPTY}    lastname=${EMPTY}     email=${EMPTY}

      IF    '${GLOBAL_USERRECORD_FOUND}'=='0'
          IF   '${email_company}'=='${superadmin_email}'
                service-usermgt.Request Service Get list User
                ...     headeruser=${headeruser}    headerpassword=${headerpassword}
                ...     username=${EMPTY}
                ...     firstName=${EMPTY}    lastname=${EMPTY}     email=${email_company}

                service-usermgt.Request Service Add New User Data Test
                ...     headeruser=${headeruser}      headerpassword=${headerpassword}
                ...     companyname=${GLOBAL_USERCOMPANY}
                ...     groupname=${GLOBAL_USERGROUPNAME}
                ...     username=${username}
                ...     password=${password}          newpassword=${newpassword}
                ...     firstname=${firstname}
                ...     lastname=${lastname}
                ...     telnumber=${telnumber}
                ...     email=${email}

          ELSE
                service-usermgt.Request Service Add New User Data Test
                ...     headeruser=${headeruser}      headerpassword=${headerpassword}
                ...     companyname=${companyuser}
                ...     groupname=${groupuser}
                ...     username=${username}
                ...     password=${password}          newpassword=${newpassword}
                ...     firstname=${firstname}
                ...     lastname=${lastname}
                ...     telnumber=${telnumber}
                ...     email=${email}
          END

      ELSE
          IF   '${email_company}'=='${superadmin_email}'
                service-usermgt.Request Service Get list User
                ...     headeruser=${headeruser}    headerpassword=${headerpassword}
                ...     username=${EMPTY}
                ...     firstName=${EMPTY}    lastname=${EMPTY}     email=${email_company}

              service-usermgt.Request Service Update User
              ...     headeruser=${headeruser}    headerpassword=${headerpassword}
              ...     companyname=${GLOBAL_USERCOMPANY}
              ...     groupname=${GLOBAL_USERGROUPNAME}
              ...     username=${username}
              ...     firstname=${firstname}
              ...     lastname=${lastname}
              ...     telnumber=${telnumber}
              ...     email=${email}

              service-usermgt.Request Service Update User Status
              ...     headeruser=${headeruser}    headerpassword=${headerpassword}
              ...     username=${username}
              ...     isActive=true
          ELSE
              service-usermgt.Request Service Update User
              ...     headeruser=${headeruser}    headerpassword=${headerpassword}
              ...     companyname=${companyuser}
              ...     groupname=${groupuser}
              ...     username=${username}
              ...     firstname=${firstname}
              ...     lastname=${lastname}
              ...     telnumber=${telnumber}
              ...     email=${email}

              service-usermgt.Request Service Update User Status
              ...     headeruser=${headeruser}    headerpassword=${headerpassword}
              ...     username=${username}
              ...     isActive=true
          END
      END

      service-profile.Request Service Logout System    username=${username}    password=${newpassword}
      service-profile.Request Service Login System     username=${username}    password=${newpassword}
      service-profile.Request Service Logout System    username=${username}    password=${newpassword}
      Log To Console    \n\n***** Create/Update '${username}' : CHECK! *****\n\n
