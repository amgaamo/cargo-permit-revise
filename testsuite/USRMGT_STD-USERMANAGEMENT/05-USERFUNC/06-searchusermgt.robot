*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource COMPANY INFO DATA
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               commonkeywords.Generate Random Values    3    3

...               AND               Set Suite Variable    ${defaultcompany_cust}       ${JS_DEFAULTDATA['companydata'][2]}[companyname]
...               AND               Set Suite Variable    ${defaultgroup_cust}         ${JS_DEFAULTDATA['groupdata'][3]}[groupname]
...               AND               Set Suite Variable    ${user_data1}                ${DS_USERPROFILE['searchdata1'][${usrdata_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${user_data2}                ${DS_USERPROFILE['searchdata2'][${usrdata_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${user_data3}                ${DS_USERPROFILE['searchdata3'][${usrdata_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${usermail_data1}            ${DS_USERPROFILE['searchdata1'][${usrdata_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com
...               AND               Set Suite Variable    ${usermail_data2}            ${DS_USERPROFILE['searchdata2'][${usrdata_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com
...               AND               Set Suite Variable    ${usermail_data3}            ${DS_USERPROFILE['searchdata3'][${usrdata_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.

...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Verify Login Page
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[usermgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[usermgt]

...               AND               service-usermgt.Request Service Add New User Data Test
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     companyname=${defaultcompany_cust}
...                                     groupname=${defaultgroup_cust}
...                                     username=${user_data1}     password=${VAR_DEFAULTPASSWORD}    newpassword=${VAR_CHGPASSWORD}
...                                     firstname=${DS_USERPROFILE['searchdata1'][${usrdata_col.firstname}]}
...                                     lastname=${DS_USERPROFILE['searchdata1'][${usrdata_col.lastname}]}
...                                     telnumber=${DS_USERPROFILE['searchdata1'][${usrdata_col.phone}]}
...                                     email=${usermail_data1}

...               AND               service-usermgt.Request Service Add New User Data Test
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     companyname=${defaultcompany_cust}
...                                     groupname=${defaultgroup_cust}
...                                     username=${user_data2}     password=${VAR_DEFAULTPASSWORD}    newpassword=${VAR_CHGPASSWORD}
...                                     firstname=${DS_USERPROFILE['searchdata2'][${usrdata_col.firstname}]}
...                                     lastname=${DS_USERPROFILE['searchdata2'][${usrdata_col.lastname}]}
...                                     telnumber=${DS_USERPROFILE['searchdata2'][${usrdata_col.phone}]}
...                                     email=${usermail_data2}

...               AND               service-usermgt.Request Service Add New User Data Test
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     companyname=${defaultcompany_cust}
...                                     groupname=${defaultgroup_cust}
...                                     username=${user_data3}     password=${VAR_DEFAULTPASSWORD}    newpassword=${VAR_CHGPASSWORD}
...                                     firstname=${DS_USERPROFILE['searchdata3'][${usrdata_col.firstname}]}
...                                     lastname=${DS_USERPROFILE['searchdata3'][${usrdata_col.lastname}]}
...                                     telnumber=${DS_USERPROFILE['searchdata3'][${usrdata_col.phone}]}
...                                     email=${usermail_data3}

...               AND               Log To Console    Create User Data Test: ${user_data1} ,${user_data2},${user_data3})  Success!

Test Template     Template User Search Function

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
#-------------------------------------------------------------------------------------------------------------------------------------------#
#                             CASE NAME                      |   Type     |        Search By        |            Search Keyword             #
#-------------------------------------------------------------------------------------------------------------------------------------------#

CASE-Search by company name                                     P           ${USERSEARCHBY}[companyname]       ${defaultcompany_cust}

CASE-Search by Username > Full Search                           P           ${USERSEARCHBY}[username]          ${user_data3}
CASE-Search by Username > Partail Search (Start wording)        P           ${USERSEARCHBY}[username]          ${DS_USERPROFILE['searchdata3'][${usrdata_col.username}]}
ExCASE-Search by Username > Partail Search (Middle wording)     E           ${USERSEARCHBY}[username]          otsrc
ExCASE-Search by Username > Partail Search (Last wording)       E           ${USERSEARCHBY}[username]          ${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}

CASE-Search by Email > Full Search                              P           ${USERSEARCHBY}[email]             ${usermail_data1}
CASE-Search by Email > Partail Search (Start wording)           P           ${USERSEARCHBY}[email]             ${DS_USERPROFILE['searchdata1'][${usrdata_col.email}]}
ExCASE-Search by Email > Partail Search (Middle wording)        E           ${USERSEARCHBY}[email]             @mail.com
ExCASE-Search by Email > Partail Search (Last wording)          E           ${USERSEARCHBY}[email]             ${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com

CASE-Search by firstname > Full Search                          P           ${USERSEARCHBY}[firstname]         ${DS_USERPROFILE['searchdata1'][${usrdata_col.firstname}]}
CASE-Search by firstname > Partail Search (Start wording)       P           ${USERSEARCHBY}[firstname]         Papawa
ExCASE-Search by firstname > Partail Search (Middle wording)    E           ${USERSEARCHBY}[firstname]         pawad
ExCASE-Search by firstname > Partail Search (Last wording)      E           ${USERSEARCHBY}[firstname]         avid

CASE-Search by lastname > Full Search                           P           ${USERSEARCHBY}[lastname]          ${DS_USERPROFILE['searchdata3'][${usrdata_col.lastname}]}
CASE-Search by lastname > Partail Search (Start wording)        P           ${USERSEARCHBY}[lastname]          Thana
ExCASE-Search by lastname > Partail Search (Middle wording)     E           ${USERSEARCHBY}[lastname]          watta
ExCASE-Search by lastname > Partail Search (Last wording)       E           ${USERSEARCHBY}[lastname]          wattana

*** Keywords ***
Template User Search Function
   [Arguments]    ${casetype}     ${searchby}    ${keyword}

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
    
      commonkeywords.Click Expand Search Criteria

      IF    '${searchby}'!='${USERSEARCHBY}[companyname]'
            commonkeywords.Wait Loading progress
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYUSER_SEL}          ${searchby}
      ELSE
            Sleep    1s
      END
      commonkeywords.Wait Loading progress
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHUSER_KEYWORD}        ${keyword}
      commonkeywords.Click button on list page    ${LOCATOR_SEARCHUSER_BTN}
      commonkeywords.Wait Loading progress
      pageUserMgt.Verify User Result Data Table for search function     ${casetype}       ${searchby}      ${keyword}
      commonkeywords.Click button on list page    ${LOCATOR_CLEARSEARCHUSER_BTN}
      commonkeywords.Wait Loading progress
