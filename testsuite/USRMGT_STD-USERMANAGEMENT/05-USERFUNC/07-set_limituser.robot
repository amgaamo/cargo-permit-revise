*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource COMPANY INFO DATA
...               AND               datasources.Import DataSource GROUP INFO DATA
...               AND               datasources.Import DataSource ROLE INFO DATA
...               AND               datasources.Import DataSource ADDRESS DATA
...               AND               defaultdatalist.Create List Data Test Default Role Value
...               AND               commonkeywords.Generate Random Values    2    3
...               AND               commonkeywords.Generate Random Number    5
...               AND               Set Default Variable Test Cases
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}

...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[usermgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[usermgt]
...               AND               commonkeywords.Wait Loading progress


#----------- Create Company Data Test -----------#
...               AND               Set Suite Variable    ${cname_equal}            ${DS_COMPANY['createnewcom1'][${company_col.companyName}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}${SPACE}EQUAL
...               AND               Set Suite Variable    ${ctaxid_equal}           ${DS_COMPANY['createnewcom1'][${company_col.taxid}]}${GLOBAL_GENNUMBER}010
...               AND               Set Suite Variable    ${cemail_equal}           equal${DS_COMPANY['createnewcom1'][${company_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

...               AND               Set Suite Variable    ${cname_greater}          ${DS_COMPANY['createnewcom1'][${company_col.companyName}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}${SPACE}GREATER
...               AND               Set Suite Variable    ${ctaxid_greater}         ${DS_COMPANY['createnewcom1'][${company_col.taxid}]}${GLOBAL_GENNUMBER}020
...               AND               Set Suite Variable    ${cemail_greater}         greater${DS_COMPANY['createnewcom1'][${company_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

...               AND               Set Suite Variable    ${cname_less}             ${DS_COMPANY['createnewcom1'][${company_col.companyName}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}${SPACE}LESS
...               AND               Set Suite Variable    ${ctaxid_less}            ${DS_COMPANY['createnewcom1'][${company_col.taxid}]}${GLOBAL_GENNUMBER}030
...               AND               Set Suite Variable    ${cemail_less}            less${DS_COMPANY['createnewcom1'][${company_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

...               AND               Set Suite Variable    ${cname_contain}          ${DS_COMPANY['createnewcom1'][${company_col.companyName}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}${SPACE}CONTAIN
...               AND               Set Suite Variable    ${ctaxid_contain}         ${DS_COMPANY['createnewcom1'][${company_col.taxid}]}${GLOBAL_GENNUMBER}040
...               AND               Set Suite Variable    ${cemail_contain}         contain${DS_COMPANY['createnewcom1'][${company_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

...               AND               service-companymgt.Request Service Create New Company
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     registype=${COMREGISTYPE_ID}[legal]     ctypeid=${COMTYPE_ID}[officer]
...                                     cname=${cname_equal}      ctaxid=${ctaxid_equal}     cbranch=00000    cemail=${cemail_equal}
...                                     limittrypwd=-1      limitusr=3      pwdexpire=-1      limitrepeatpwd=-1      idlesession=120     limitsession=180

...               AND               service-companymgt.Request Service Create New Company
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     registype=${COMREGISTYPE_ID}[legal]     ctypeid=${COMTYPE_ID}[officer]
...                                     cname=${cname_greater}    ctaxid=${ctaxid_greater}     cbranch=00000    cemail=${cemail_greater}
...                                     limittrypwd=-1     limitusr=3     pwdexpire=-1      limitrepeatpwd=-1      idlesession=120     limitsession=180

...               AND               service-companymgt.Request Service Create New Company
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     registype=${COMREGISTYPE_ID}[legal]     ctypeid=${COMTYPE_ID}[officer]
...                                     cname=${cname_less}              ctaxid=${ctaxid_less}     cbranch=00000    cemail=${cemail_less}
...                                     limittrypwd=-1     limitusr=3     pwdexpire=-1      limitrepeatpwd=-1      idlesession=120     limitsession=180

...               AND               service-companymgt.Request Service Create New Company
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     registype=${COMREGISTYPE_ID}[legal]     ctypeid=${COMTYPE_ID}[officer]
...                                     cname=${cname_contain}           ctaxid=${ctaxid_contain}     cbranch=00000    cemail=${cemail_contain}
...                                     limittrypwd=-1    limitusr=5     pwdexpire=-1      limitrepeatpwd=-1      idlesession=120     limitsession=180
...               AND               Log To Console    Add Company Data Test Success !

#----------- Create Group Data Test -----------#
...               AND               Set Suite Variable    ${gname_equal}            equal${SPACE}${DS_GROUP['createnew'][${group_col.groupname}]}${GLOBAL_RANDOMLETTER}${SPACE}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${gname_greater}          greater${SPACE}${DS_GROUP['createnew'][${group_col.groupname}]}${GLOBAL_RANDOMLETTER}${SPACE}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${gname_less}             less${SPACE}${DS_GROUP['createnew'][${group_col.groupname}]}${GLOBAL_RANDOMLETTER}${SPACE}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${gname01_contain}        contain1${SPACE}${DS_GROUP['createnew'][${group_col.groupname}]}${GLOBAL_RANDOMLETTER}${SPACE}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${gname02_contain}        contain2${SPACE}${DS_GROUP['createnew'][${group_col.groupname}]}${GLOBAL_RANDOMLETTER}${SPACE}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${gname03_contain}        contain3${SPACE}${DS_GROUP['createnew'][${group_col.groupname}]}${GLOBAL_RANDOMLETTER}${SPACE}${GLOBAL_RANDOMNO}


...               AND               service-groupmgt.Request Service Create New Group
...                                             ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                             ${cname_equal}    ${gname_equal}
...                                             3
...                                             true    false     ${EMPTY}     ${GLOBAL_DEFAULTROLE_LIST}[0]

...               AND               service-groupmgt.Request Service Create New Group
...                                             ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                             ${cname_greater}    ${gname_greater}
...                                             5
...                                             true    false     ${EMPTY}     ${GLOBAL_DEFAULTROLE_LIST}[0]

...               AND               service-groupmgt.Request Service Create New Group
...                                             ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                             ${cname_less}    ${gname_less}    2
...                                             true    false    ${EMPTY}         ${GLOBAL_DEFAULTROLE_LIST}[0]

...               AND               service-groupmgt.Request Service Create New Group
...                                             ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                             ${cname_contain}    ${gname01_contain}    2
...                                             true    false       ${EMPTY}              ${GLOBAL_DEFAULTROLE_LIST}[0]

...               AND               service-groupmgt.Request Service Create New Group
...                                             ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                             ${cname_contain}    ${gname02_contain}     2
...                                             true    false       ${EMPTY}               ${GLOBAL_DEFAULTROLE_LIST}[0]

...               AND               service-groupmgt.Request Service Create New Group
...                                             ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                             ${cname_contain}    ${gname03_contain}     2
...                                             true    false       ${EMPTY}               ${GLOBAL_DEFAULTROLE_LIST}[0]
...               AND               Log To Console    Add Group Data Test Success !

...               AND               Log To Console   \n\nINFO: ${cname_equal} (Limit User is 3) - ${gname_equal} (Limit User is 3)
...               AND               Log To Console   \nINFO: ${cname_greater} (Limit User is 3) - ${gname_greater} (Limit User is 5)
...               AND               Log To Console   \nINFO: ${cname_less} (Limit User is 3) - ${gname_less} (Limit User is 2)
...               AND               Log To Console   \nINFO: ${cname_contain} (Limit User is 5) - ${gname01_contain} (Limit User is 2),${gname02_contain} (Limit User is 2),${gname03_contain} (Limit User is 2) \n\n

#----------- Create User Data Test -----------#

...               AND               Set Suite Variable    ${usrname_equal}             equal${DS_USERPROFILE['adduserdata'][${usrdata_col.username}]}${GLOBAL_RANDOMNO}${GLOBAL_RANDOMLETTER}
...               AND               Set Suite Variable    ${usrname_greater}           greater${DS_USERPROFILE['adduserdata'][${usrdata_col.username}]}${GLOBAL_RANDOMNO}${GLOBAL_RANDOMLETTER}
...               AND               Set Suite Variable    ${usrname_less}              less${DS_USERPROFILE['adduserdata'][${usrdata_col.username}]}${GLOBAL_RANDOMNO}${GLOBAL_RANDOMLETTER}
...               AND               Set Suite Variable    ${usrname11_contain}         ct01${DS_USERPROFILE['adduserdata'][${usrdata_col.username}]}${GLOBAL_RANDOMNO}${GLOBAL_RANDOMLETTER}
...               AND               Set Suite Variable    ${usrname12_contain}         ct02${DS_USERPROFILE['adduserdata'][${usrdata_col.username}]}${GLOBAL_RANDOMNO}${GLOBAL_RANDOMLETTER}
...               AND               Set Suite Variable    ${usrname21_contain}         ct03${DS_USERPROFILE['adduserdata'][${usrdata_col.username}]}${GLOBAL_RANDOMNO}${GLOBAL_RANDOMLETTER}
...               AND               Set Suite Variable    ${usrname31_contain}         ct04${DS_USERPROFILE['adduserdata'][${usrdata_col.username}]}${GLOBAL_RANDOMNO}${GLOBAL_RANDOMLETTER}

...               AND               service-usermgt.Request Service Add New User Data Test
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}               headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     companyname=${cname_equal}    groupname=${gname_equal}
...                                     username=${usrname_equal}     password=${VAR_DEFAULTPASSWORD}           newpassword=${VAR_CHGPASSWORD}
...                                     firstname=Eqfirstname    lastname=Eqlastname    telnumber=021120011     email=equalbotusr_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

...               AND               service-usermgt.Request Service Add New User Data Test
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}               headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     companyname=${cname_greater}    groupname=${gname_greater}
...                                     username=${usrname_greater}     password=${VAR_DEFAULTPASSWORD}         newpassword=${VAR_CHGPASSWORD}
...                                     firstname=Gtfirstname    lastname=Gtlastname    telnumber=021120011     email=greaterbotusr_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

...               AND               service-usermgt.Request Service Add New User Data Test
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}               headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     companyname=${cname_less}    groupname=${gname_less}
...                                     username=${usrname_less}     password=${VAR_DEFAULTPASSWORD}            newpassword=${VAR_CHGPASSWORD}
...                                     firstname=Lsfirstname    lastname=Lslastname    telnumber=021120011     email=lessbotusr_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

...               AND               service-usermgt.Request Service Add New User Data Test
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}               headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     companyname=${cname_contain}      groupname=${gname01_contain}
...                                     username=${usrname11_contain}     password=${VAR_DEFAULTPASSWORD}       newpassword=${VAR_CHGPASSWORD}
...                                     firstname=Ctfirstname    lastname=Ctlastname    telnumber=021120011     email=ct01botusr_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

...               AND               service-usermgt.Request Service Add New User Data Test
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}               headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     companyname=${cname_contain}      groupname=${gname01_contain}
...                                     username=${usrname12_contain}     password=${VAR_DEFAULTPASSWORD}       newpassword=${VAR_CHGPASSWORD}
...                                     firstname=Ctfirstname    lastname=Ctlastname    telnumber=021120011     email=ct02botusr_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

...               AND               service-usermgt.Request Service Add New User Data Test
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}               headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     companyname=${cname_contain}      groupname=${gname02_contain}
...                                     username=${usrname21_contain}     password=${VAR_DEFAULTPASSWORD}       newpassword=${VAR_CHGPASSWORD}
...                                     firstname=Ctfirstname    lastname=Ctlastname    telnumber=021120011     email=ct03botusr_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

...               AND               service-usermgt.Request Service Add New User Data Test
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}               headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     companyname=${cname_contain}      groupname=${gname03_contain}
...                                     username=${usrname31_contain}     password=${VAR_DEFAULTPASSWORD}       newpassword=${VAR_CHGPASSWORD}
...                                     firstname=Ctfirstname    lastname=Ctlastname    telnumber=021120011     email=ct04botusr_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

...               AND               Log To Console    Add User Data Test Success !

Test Template     Template Limit User Function

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#
#                    Case Name                             |               Username             |            Company Name         |              Group Name               |         Expected Message        #
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#

CASE-Limit User Group EQUAL Limit User Company                ${usrname_equal}                    ${cname_equal}                      ${gname_equal}                          ${USER_OTHRWARNMSG}[maxusrcomp]
CASE-Limit User Group GREATER than Limit User Company         ${usrname_greater}                  ${cname_greater}                    ${gname_greater}                        ${USER_OTHRWARNMSG}[maxusrcomp]
CASE-Limit User Group LESS than Limit User Company            ${usrname_less}                     ${cname_less}                       ${gname_less}                           ${USER_OTHRWARNMSG}[maxusrgroup]
CASE-Company CONTAIN Group > 1 add new user group3            ${usrname21_contain}                ${cname_contain}                    ${gname03_contain}                      ${USER_OTHRWARNMSG}[maxusrcomp]

*** Keywords ***
Template Limit User Function
   [Arguments]    ${username}    ${companyname}      ${groupname}      ${expmsg}

    Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
    ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
    
   Set Suite Variable    ${usrname_equal02}             equal2${DS_USERPROFILE['adduserdata'][${usrdata_col.username}]}${GLOBAL_RANDOMNO}${GLOBAL_RANDOMLETTER}
   Set Suite Variable    ${usrname_equal03}             equal3${DS_USERPROFILE['adduserdata'][${usrdata_col.username}]}${GLOBAL_RANDOMNO}${GLOBAL_RANDOMLETTER}
   Set Suite Variable    ${usrname_greater02}           greater2${DS_USERPROFILE['adduserdata'][${usrdata_col.username}]}${GLOBAL_RANDOMNO}${GLOBAL_RANDOMLETTER}
   Set Suite Variable    ${usrname_greater03}           greater3${DS_USERPROFILE['adduserdata'][${usrdata_col.username}]}${GLOBAL_RANDOMNO}${GLOBAL_RANDOMLETTER}
   Set Suite Variable    ${usrname_less02}              less2${DS_USERPROFILE['adduserdata'][${usrdata_col.username}]}${GLOBAL_RANDOMNO}${GLOBAL_RANDOMLETTER}
   Set Suite Variable    ${usrname22_contain}           ct22${DS_USERPROFILE['adduserdata'][${usrdata_col.username}]}${GLOBAL_RANDOMNO}${GLOBAL_RANDOMLETTER}

    IF  '${username}'=='${usrname_equal}'

                service-usermgt.Request Service Add New User Data Test
                ...     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}               headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
                ...     companyname=${cname_equal}      groupname=${gname_equal}
                ...     username=${usrname_equal02}     password=${VAR_DEFAULTPASSWORD}         newpassword=${VAR_CHGPASSWORD}
                ...     firstname=Eqfirstname    lastname=Eqlastname    telnumber=021120011     email=equalbotusr2_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

                service-usermgt.Request Service Add New User Data Test
                ...     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}               headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
                ...     companyname=${cname_equal}    groupname=${gname_equal}
                ...     username=${usrname_equal03}   password=${VAR_DEFAULTPASSWORD}           newpassword=${VAR_CHGPASSWORD}
                ...     firstname=Eqfirstname    lastname=Eqlastname    telnumber=021120011     email=equalbotusr3_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

    ELSE IF  '${username}'=='${usrname_greater}'

                service-usermgt.Request Service Add New User Data Test
                ...     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}               headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
                ...     companyname=${cname_greater}      groupname=${gname_greater}
                ...     username=${usrname_greater02}     password=${VAR_DEFAULTPASSWORD}         newpassword=${VAR_CHGPASSWORD}
                ...     firstname=Gtfirstname    lastname=Gtlastname    telnumber=021120011       email=greater2botusr_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

                service-usermgt.Request Service Add New User Data Test
                ...     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}               headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
                ...     companyname=${cname_greater}      groupname=${gname_greater}
                ...     username=${usrname_greater03}     password=${VAR_DEFAULTPASSWORD}         newpassword=${VAR_CHGPASSWORD}
                ...     firstname=Gtfirstname    lastname=Gtlastname    telnumber=021120011     email=greater3botusr_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

    ELSE IF  '${username}'=='${usrname_less}'
                service-usermgt.Request Service Add New User Data Test
                ...     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}               headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
                ...     companyname=${cname_less}      groupname=${gname_less}
                ...     username=${usrname_less02}     password=${VAR_DEFAULTPASSWORD}            newpassword=${VAR_CHGPASSWORD}
                ...     firstname=Lsfirstname    lastname=Lslastname    telnumber=021120011       email=less2botusr_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

    ELSE IF  '${username}'=='${usrname21_contain}'

                service-usermgt.Request Service Add New User Data Test
                ...       headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}               headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
                ...       companyname=${cname_contain}      groupname=${gname02_contain}
                ...       username=${usrname22_contain}     password=${VAR_DEFAULTPASSWORD}       newpassword=${VAR_CHGPASSWORD}
                ...       firstname=Ctfirstname    lastname=Ctlastname    telnumber=021120011     email=ct22botusr_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

    ELSE
        Fail    Please Check condition.
    END


      commonkeywords.Click button on list page      ${LOCATOR_ADDUSER_BTN}
      commonkeywords.Verify Page Name is correct    Add User
      commonkeywords.Wait Loading progress
      commonkeywords.Fill in data form              ${LOCATOR_USERCOMPANY_SEL}          ${companyname}
      commonkeywords.Wait Loading progress
      commonkeywords.Fill in data form              ${LOCATOR_USERGROUP_SEL}            ${groupname}
      commonkeywords.Fill in data form              ${LOCATOR_USERUSRNAME_FIELD}        limitusrerr${GLOBAL_RANDOMNO}
      commonkeywords.Fill in data form              ${LOCATOR_USERPWD_FIELD}            ${VAR_DEFAULTPASSWORD}
      commonkeywords.Fill in data form              ${LOCATOR_USERCFPWD_FIELD}          ${VAR_DEFAULTPASSWORD}

      pageUserMgt.Fill in user profile info
      ...     firstname=limitfirstname
      ...     lastname=limitlastname
      ...     phone=0123303900
      ...     email=limitemail99_${GLOBAL_RANDOMNO}@mail.com

      commonkeywords.Click button on detail page      ${LOCATOR_USERSAVE_BTN}
      commonkeywords.Verify Modal Title message       Error
      commonkeywords.Verify Modal Content message     ${expmsg}
      commonkeywords.Click OK Button

      #Change Group for case Company CONTAIN Group > 1
      IF  '${username}'=='${usrname21_contain}'
          commonkeywords.Fill in data form              ${LOCATOR_USERGROUP_SEL}            ${gname03_contain}
          commonkeywords.Click button on detail page    ${LOCATOR_USERSAVE_BTN}
          commonkeywords.Verify Modal Title message       Error
          commonkeywords.Verify Modal Content message     ${expmsg}
          commonkeywords.Click OK Button
          Log To Console      Case Change Group: ${expmsg} VERIFIED.
      END


      commonkeywords.Click xClose button    ${LOCATOR_XCLOSEUSER_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Verify Page Name is correct    User Management
      Log To Console      TEST CASE ${expmsg} VERIFIED.

Set Default Variable Test Cases 
    IF    '${GLOBAL_USERMGT_FUNCTEST}'=='False'  
        Set Suite Variable         ${usrname_equal}          ${EMPTY}      
        Set Suite Variable         ${cname_equal}            ${EMPTY}           
        Set Suite Variable         ${gname_equal}            ${EMPTY}  
        Set Suite Variable         ${usrname_greater}        ${EMPTY}                
        Set Suite Variable         ${cname_greater}          ${EMPTY}                
        Set Suite Variable         ${gname_greater}          ${EMPTY}  
        Set Suite Variable         ${usrname_less}           ${EMPTY}                
        Set Suite Variable         ${cname_less}             ${EMPTY}            
        Set Suite Variable         ${gname_less}             ${EMPTY}     
        Set Suite Variable         ${usrname21_contain}      ${EMPTY}               
        Set Suite Variable         ${cname_contain}          ${EMPTY}            
        Set Suite Variable         ${gname03_contain}        ${EMPTY}   
    END