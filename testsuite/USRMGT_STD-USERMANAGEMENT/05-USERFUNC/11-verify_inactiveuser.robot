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

#----------- Create Company Data Test -----------#
...               AND               Set Suite Variable    ${cname_cominactive}            ${DS_COMPANY['createnewcom1'][${company_col.companyName}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}${SPACE}CINACT
...               AND               Set Suite Variable    ${ctaxid_cominactive}           ${DS_COMPANY['createnewcom1'][${company_col.taxid}]}${GLOBAL_GENNUMBER}111
...               AND               Set Suite Variable    ${cemail_cominactive}           cinact${DS_COMPANY['createnewcom1'][${company_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

...               AND               Set Suite Variable    ${cname_groupinactive}          ${DS_COMPANY['createnewcom1'][${company_col.companyName}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}${SPACE}GINACT
...               AND               Set Suite Variable    ${ctaxid_groupinactive}         ${DS_COMPANY['createnewcom1'][${company_col.taxid}]}${GLOBAL_GENNUMBER}222
...               AND               Set Suite Variable    ${cemail_groupinactive}         ginact${DS_COMPANY['createnewcom1'][${company_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

...               AND               Set Suite Variable    ${cname_userinactive}           ${DS_COMPANY['createnewcom1'][${company_col.companyName}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}${SPACE}UINACT
...               AND               Set Suite Variable    ${ctaxid_userinactive}          ${DS_COMPANY['createnewcom1'][${company_col.taxid}]}${GLOBAL_GENNUMBER}333
...               AND               Set Suite Variable    ${cemail_userinactive}          uinact${DS_COMPANY['createnewcom1'][${company_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

...               AND               service-companymgt.Request Service Create New Company
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     registype=${COMREGISTYPE_ID}[legal]     ctypeid=${COMTYPE_ID}[officer]
...                                     cname=${cname_cominactive}              ctaxid=${ctaxid_cominactive}     cbranch=00000    cemail=${cemail_cominactive}
...                                     limittrypwd=5     limitusr=10     pwdexpire=10      limitrepeatpwd=5      idlesession=120     limitsession=180

...               AND               service-companymgt.Request Service Create New Company
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     registype=${COMREGISTYPE_ID}[legal]     ctypeid=${COMTYPE_ID}[officer]
...                                     cname=${cname_groupinactive}              ctaxid=${ctaxid_groupinactive}     cbranch=00000    cemail=${cemail_groupinactive}
...                                     limittrypwd=5     limitusr=10     pwdexpire=10      limitrepeatpwd=5      idlesession=120     limitsession=180

...               AND               service-companymgt.Request Service Create New Company
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     registype=${COMREGISTYPE_ID}[legal]     ctypeid=${COMTYPE_ID}[officer]
...                                     cname=${cname_userinactive}              ctaxid=${ctaxid_userinactive}     cbranch=00000    cemail=${cemail_userinactive}
...                                     limittrypwd=5     limitusr=10     pwdexpire=10      limitrepeatpwd=5      idlesession=120     limitsession=180
...               AND               Log To Console    Add Company Data Test Success !

#----------- Create Group Data Test -----------#
...               AND               Set Suite Variable    ${gname_cominactive}            cinact${SPACE}${DS_GROUP['createnew'][${group_col.groupname}]}${GLOBAL_RANDOMLETTER}${SPACE}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${gname_groupinactive}          ginact${SPACE}${DS_GROUP['createnew'][${group_col.groupname}]}${GLOBAL_RANDOMLETTER}${SPACE}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${gname_userinactive}           uinact${SPACE}${DS_GROUP['createnew'][${group_col.groupname}]}${GLOBAL_RANDOMLETTER}${SPACE}${GLOBAL_RANDOMNO}

...               AND               service-groupmgt.Request Service Create New Group
...                                             ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                             ${cname_cominactive}
...                                             ${gname_cominactive}
...                                             ${DS_GROUP['createnew'][${group_col.limituser}]}
...                                             true    false     ${EMPTY}
...                                             ${GLOBAL_DEFAULTROLE_LIST}[0]   ${GLOBAL_DEFAULTROLE_LIST}[1]   ${GLOBAL_DEFAULTROLE_LIST}[3]

...               AND               service-groupmgt.Request Service Create New Group
...                                             ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                             ${cname_groupinactive}
...                                             ${gname_groupinactive}
...                                             ${DS_GROUP['createnew'][${group_col.limituser}]}
...                                             true    false     ${EMPTY}
...                                             ${GLOBAL_DEFAULTROLE_LIST}[0]   ${GLOBAL_DEFAULTROLE_LIST}[1]   ${GLOBAL_DEFAULTROLE_LIST}[3]

...               AND               service-groupmgt.Request Service Create New Group
...                                             ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                             ${cname_userinactive}
...                                             ${gname_userinactive}
...                                             ${DS_GROUP['createnew'][${group_col.limituser}]}
...                                             true    false     ${EMPTY}
...                                             ${GLOBAL_DEFAULTROLE_LIST}[0]   ${GLOBAL_DEFAULTROLE_LIST}[1]   ${GLOBAL_DEFAULTROLE_LIST}[3]
...               AND               Log To Console    Add Group Data Test Success !

#----------- Create User Data Test -----------#
...               AND               Set Suite Variable    ${usrname_cominactive}               cinact${DS_USERPROFILE['adduserdata'][${usrdata_col.username}]}${GLOBAL_RANDOMNO}${GLOBAL_RANDOMLETTER}
...               AND               Set Suite Variable    ${usrname_groupinactive}             ginact${DS_USERPROFILE['adduserdata'][${usrdata_col.username}]}${GLOBAL_RANDOMNO}${GLOBAL_RANDOMLETTER}
...               AND               Set Suite Variable    ${usrname_userinactive}              uinact${DS_USERPROFILE['adduserdata'][${usrdata_col.username}]}${GLOBAL_RANDOMNO}${GLOBAL_RANDOMLETTER}

...               AND               service-usermgt.Request Service Add New User Data Test
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     companyname=${cname_cominactive}
...                                     groupname=${gname_cominactive}
...                                     username=${usrname_cominactive}     password=${VAR_DEFAULTPASSWORD}    newpassword=${VAR_CHGPASSWORD}
...                                     firstname=${DS_USERPROFILE['adduserdata'][${usrdata_col.firstname}]}
...                                     lastname=${DS_USERPROFILE['adduserdata'][${usrdata_col.lastname}]}
...                                     telnumber=${DS_USERPROFILE['adduserdata'][${usrdata_col.phone}]}
...                                     email=cinact${DS_USERPROFILE['adduserdata'][${usrdata_col.email}]}_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

...               AND               service-usermgt.Request Service Add New User Data Test
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     companyname=${cname_groupinactive}
...                                     groupname=${gname_groupinactive}
...                                     username=${usrname_groupinactive}     password=${VAR_DEFAULTPASSWORD}    newpassword=${VAR_CHGPASSWORD}
...                                     firstname=${DS_USERPROFILE['adduserdata'][${usrdata_col.firstname}]}
...                                     lastname=${DS_USERPROFILE['adduserdata'][${usrdata_col.lastname}]}
...                                     telnumber=${DS_USERPROFILE['adduserdata'][${usrdata_col.phone}]}
...                                     email=ginact${DS_USERPROFILE['adduserdata'][${usrdata_col.email}]}_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

...               AND               service-usermgt.Request Service Add New User Data Test
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     companyname=${cname_userinactive}
...                                     groupname=${gname_userinactive}
...                                     username=${usrname_userinactive}     password=${VAR_DEFAULTPASSWORD}    newpassword=${VAR_CHGPASSWORD}
...                                     firstname=${DS_USERPROFILE['adduserdata'][${usrdata_col.firstname}]}
...                                     lastname=${DS_USERPROFILE['adduserdata'][${usrdata_col.lastname}]}
...                                     telnumber=${DS_USERPROFILE['adduserdata'][${usrdata_col.phone}]}
...                                     email=uinact${DS_USERPROFILE['adduserdata'][${usrdata_col.email}]}_${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com
...               AND               Log To Console    Add User Data Test Success !


#----- Inactive Company: cname_cominactive -----#
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[companyMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[companyMgt]
...               AND               commonkeywords.Wait Loading progress
...               AND               commonkeywords.Click Expand Search Criteria
...               AND               commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYCOM_SEL}        ${COMSEARCHBY}[comname]
...               AND               commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHCOM_KEYWORD}      ${cname_cominactive}
...               AND               commonkeywords.Click button on list page            ${LOCATOR_SEARCHCOM_BTN}
...               AND               commonkeywords.Click Hide Search Criteria
...               AND               commonkeywords.Wait Loading progress
...               AND               pageCompanyMgt.Verify Company Result Datatable    1    companyname    contains      ${cname_cominactive}
...               AND               pageCompanyMgt.Verify Company Result Datatable    1    status         should be     Active

...               AND               commonkeywords.Click button on list page    ${1ROW_COMPANY_ACTION}[changeStatus]
...               AND               commonkeywords.Click Yes Button for confirm
...               AND               commonkeywords.Click OK Button

...               AND               commonkeywords.Click Expand Search Criteria
...               AND               commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYCOM_SEL}        ${COMSEARCHBY}[comname]
...               AND               commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHCOM_KEYWORD}      ${cname_cominactive}
...               AND               commonkeywords.Click button on list page            ${LOCATOR_SEARCHCOM_BTN}
...               AND               commonkeywords.Click Hide Search Criteria
...               AND               commonkeywords.Wait Loading progress
...               AND               pageCompanyMgt.Verify Company Result Datatable    1    status    should be    Inactive
...               AND               Log To Console    \n'${cname_cominactive}'is Inactive!

#----- Inactive Group: gname_groupinactive -----#
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[groupMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[groupMgt]
...               AND               commonkeywords.Wait Loading progress
...               AND               commonkeywords.Click Expand Search Criteria
...               AND               commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYGROUP_SEL}         ${GROUPSEARCHBY}[groupname]
...               AND               commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHGROUP_KEYWORD}       ${gname_groupinactive}
...               AND               commonkeywords.Click button on list page    ${LOCATOR_SEARCHGROUP_BTN}
...               AND               commonkeywords.Wait Loading progress
...               AND               commonkeywords.Click Hide Search Criteria
...               AND               pageGroupMgt.Verify Group Result Datatable    1    groupname      contains      ${gname_groupinactive}
...               AND               pageGroupMgt.Verify Group Result Datatable    1    status         should be     Active
...               AND               commonkeywords.Click button on list page    ${1ROW_GROUP_ACTION}[changeStatus]
...               AND               commonkeywords.Verify Modal Title message    Warning
...               AND               commonkeywords.Click Yes Button for confirm
...               AND               commonkeywords.Click OK Button

...               AND               commonkeywords.Wait Loading progress
...               AND               commonkeywords.Verify Page Name is correct    Group Management
...               AND               commonkeywords.Click Expand Search Criteria
...               AND               commonkeywords.Click button on list page     ${LOCATOR_CLEARSEARCHGROUP_BTN}
...               AND               commonkeywords.Wait Loading progress
...               AND               commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYGROUP_SEL}         ${GROUPSEARCHBY}[groupname]
...               AND               commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHGROUP_KEYWORD}       ${gname_groupinactive}
...               AND               commonkeywords.Click button on list page    ${LOCATOR_SEARCHGROUP_BTN}
...               AND               commonkeywords.Wait Loading progress
...               AND               commonkeywords.Click Hide Search Criteria
...               AND               pageGroupMgt.Verify Group Result Datatable    1    groupname      contains      ${gname_groupinactive}
...               AND               pageGroupMgt.Verify Group Result Datatable    1    status         should be     Inactive
...               AND               Log To Console    \n'${gname_groupinactive}'is Inactive!

#----- Inactive User: usrname_userinactive -----#

...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[usermgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[usermgt]
...               AND               commonkeywords.Wait Loading progress
...               AND               commonkeywords.Click Expand Search Criteria
...               AND               commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYUSER_SEL}          ${USERSEARCHBY}[username]
...               AND               commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHUSER_KEYWORD}        ${usrname_userinactive}
...               AND               commonkeywords.Click button on list page      ${LOCATOR_SEARCHUSER_BTN}
...               AND               commonkeywords.Wait Loading progress
...               AND               commonkeywords.Click Hide Search Criteria
...               AND               commonkeywords.Wait Loading progress
...               AND               pageUserMgt.Verify User Result Datatable    1    username    should be     ${usrname_userinactive}
...               AND               pageUserMgt.Verify User Result Datatable    1    status      should be     Active

...               AND               commonkeywords.Click button on list page    ${1ROW_USER_ACTION}[changeStatus]
...               AND               commonkeywords.Verify Modal Title message    Warning
...               AND               commonkeywords.Click Yes Button for confirm
...               AND               commonkeywords.Verify Modal Title message      Success
...               AND               commonkeywords.Verify Modal Content message    ${USERMGT_WARNMSG}[changestatus]
...               AND               commonkeywords.Click OK Button
...               AND               commonkeywords.Click Expand Search Criteria
...               AND               commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYUSER_SEL}          ${USERSEARCHBY}[username]
...               AND               commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHUSER_KEYWORD}        ${usrname_userinactive}
...               AND               commonkeywords.Click button on list page      ${LOCATOR_SEARCHUSER_BTN}
...               AND               commonkeywords.Wait Loading progress
...               AND               commonkeywords.Click Hide Search Criteria
...               AND               commonkeywords.Wait Loading progress
...               AND               pageUserMgt.Verify User Result Datatable    1    username    should be     ${usrname_userinactive}
...               AND               pageUserMgt.Verify User Result Datatable    1    status      should be     Inactive
...               AND               Log To Console    \n'${usrname_userinactive}'is Inactive!

...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Verify Login Page

Test Template     Template Inactive functional

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
#----------------------------------------------------------------------------------------------------------------------------------------------------------------#
#                    CASE NAME                       |         username               |                          Login Error Message                             #
#----------------------------------------------------------------------------------------------------------------------------------------------------------------#

CASE-User in Company is INACTIVE                           ${usrname_cominactive}               Company is inactive
CASE-User in Group is INACTIVE                             ${usrname_groupinactive}             Group is inactive
CASE-USER INACTIVE                                         ${usrname_userinactive}              Inactive User


*** Keywords ***
Template Inactive functional
      [Arguments]       ${userid}       ${verifyMSG}

        Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
        ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
      
        pageLogin.Fill in Login Field          ${userid}     ${VAR_CHGPASSWORD}
        commonkeywords.Click Login Button
        commonkeywords.Login Waiting Loading
        commonkeywords.Verify Modal Title message       Login Failed
        commonkeywords.Verify Modal Content message     ${verifyMSG}
        commonkeywords.Click Close Button
        commonkeywords.Verify Login Page
        Log To Console    TEST CASE ${verifyMSG} VERIFIED.

Set Default Variable Test Cases 
    IF    '${GLOBAL_USERMGT_FUNCTEST}'=='False'  
        Set Suite Variable         ${usrname_cominactive}          ${EMPTY}      
        Set Suite Variable         ${usrname_groupinactive}            ${EMPTY}           
        Set Suite Variable         ${usrname_userinactive}            ${EMPTY}  
    END