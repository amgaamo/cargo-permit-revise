*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource ROLE INFO DATA
...               AND               datasources.Import DataSource GROUP INFO DATA
...               AND               datasources.Import DataSource DEFAULT DATA

...               AND               commonkeywords.Generate Random Values    3    3
...               AND               Set Suite Variable    ${defaultcompany_cust}      ${JS_DEFAULTDATA['companydata'][3]}[companyname]
...               AND               Set Suite Variable    ${roleadmmgt}               gmnt${DS_ROLE['addnew'][${role_col.rolename}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${roleusermgt}              umnt${DS_ROLE['addnew'][${role_col.rolename}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${group01admuser}           adm${DS_GROUP['createnew'][${group_col.groupname}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${group02user}              usr${DS_GROUP['createnew'][${group_col.groupname}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${user_cust1}               mn1${DS_USERPROFILE['adduserdata'][${usrdata_col.username}]}${GLOBAL_RANDOMLETTER}
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.

...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               service-menumgt.Create Data List of Menu
...                                     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     ${VAR_MENUNAME_MAINCONF}     ${VAR_MENUNAME_GROUPMGT}     ${VAR_MENUNAME_COMPANYMGT}
...               AND               service-permmgt.Create Data List of Permission
...                                     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     ${VAR_PERM_GROUPMGT}[0]      ${VAR_PERM_GROUPMGT}[1]     ${VAR_PERM_GROUPMGT}[2]   ${VAR_PERM_COMPANYMGT}[0]   ${VAR_PERM_COMPANYMGT}[1]


...              AND               Run Keyword If   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
...                                  service-rolemgt.Request Service Create Role Data Test
...                                     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     ${roleadmmgt}     ${GLOBAL_MENUDATALIST}    ${GLOBAL_PERMDATALIST}     ${defaultcompany_cust}

...              AND                 Run Keyword If   '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
...                                   service-rolemgt.Request Service Create Role Data Test
...                                     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     ${roleadmmgt}     ${GLOBAL_MENUDATALIST}    ${GLOBAL_PERMDATALIST}


...               AND               service-menumgt.Create Data List of Menu
...                                     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     ${VAR_MENUNAME_MAINCONF}      ${VAR_MENUNAME_USERMGT}
...               AND               service-permmgt.Create Data List of Permission
...                                     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     ${VAR_PERM_USERMGT}[0]      ${VAR_PERM_USERMGT}[1]     ${VAR_PERM_USERMGT}[2]

...               AND               Run Keyword If   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
...                                     service-rolemgt.Request Service Create Role Data Test
...                                     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     ${roleusermgt}    ${GLOBAL_MENUDATALIST}     ${GLOBAL_PERMDATALIST}     ${defaultcompany_cust}

...              AND                 Run Keyword If   '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
...                                     service-rolemgt.Request Service Create Role Data Test
...                                     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     ${roleusermgt}    ${GLOBAL_MENUDATALIST}     ${GLOBAL_PERMDATALIST}

...               AND               service-groupmgt.Request Service Create New Group
...                                     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     ${defaultcompany_cust}
...                                     ${group01admuser}
...                                     -1    true    false     ${EMPTY}
...                                     ${roleadmmgt}     ${roleusermgt}

...               AND               service-groupmgt.Request Service Create New Group
...                                     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     ${defaultcompany_cust}
...                                     ${group02user}
...                                     -1    true    false     ${EMPTY}
...                                     ${roleusermgt}

...               AND               service-usermgt.Request Service Add New User Data Test
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     companyname=${defaultcompany_cust}
...                                     groupname=${group01admuser}
...                                     username=${user_cust1}    password=${VAR_DEFAULTPASSWORD}     newpassword=${VAR_CHGPASSWORD}
...                                     firstname=Testname        lastname=Lasttest                   telnumber=021120011
...                                     email=testmail__${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@rbmail.com

...               AND               service-profile.Request Service Login System      ${user_cust1}      ${VAR_CHGPASSWORD}
...               AND               service-profile.Request Service Logout System     ${user_cust1}      ${VAR_CHGPASSWORD}

Test Setup        Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Verify Login Page

##### Reset Menu Role ####
...               AND               service-menumgt.Create Data List of Menu
...                                     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     ${VAR_MENUNAME_MAINCONF}    ${VAR_MENUNAME_GROUPMGT}     ${VAR_MENUNAME_COMPANYMGT}
...               AND               service-permmgt.Create Data List of Permission
...                                     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     ${VAR_PERM_GROUPMGT}[0]      ${VAR_PERM_GROUPMGT}[1]     ${VAR_PERM_GROUPMGT}[2]   ${VAR_PERM_COMPANYMGT}[0]   ${VAR_PERM_COMPANYMGT}[1]

...               AND               Run Keyword If   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
...                                     service-rolemgt.Request Service Update Role Data Test
...                                     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     ${roleadmmgt}     ${GLOBAL_MENUDATALIST}     ${GLOBAL_PERMDATALIST}     ${defaultcompany_cust}

...              AND                 Run Keyword If   '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
...                                     service-rolemgt.Request Service Update Role Data Test
...                                     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     ${roleadmmgt}     ${GLOBAL_MENUDATALIST}     ${GLOBAL_PERMDATALIST}

...               AND               service-menumgt.Create Data List of Menu
...                                     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     ${VAR_MENUNAME_MAINCONF}      ${VAR_MENUNAME_USERMGT}
...               AND               service-permmgt.Create Data List of Permission
...                                     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     ${VAR_PERM_USERMGT}[0]      ${VAR_PERM_USERMGT}[1]     ${VAR_PERM_USERMGT}[2]

...               AND               Run Keyword If   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
...                                     service-rolemgt.Request Service Update Role Data Test
...                                     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     ${roleusermgt}    ${GLOBAL_MENUDATALIST}     ${GLOBAL_PERMDATALIST}     ${defaultcompany_cust}

...              AND                 Run Keyword If   '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
...                                     service-rolemgt.Request Service Update Role Data Test
...                                     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     ${roleusermgt}    ${GLOBAL_MENUDATALIST}     ${GLOBAL_PERMDATALIST}


#### Reset Role Group ####
...               AND               service-groupmgt.Request Service Update Group
...                                       ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                       ${defaultcompany_cust}
...                                       ${group01admuser}
...                                       -1      true      ${EMPTY}
...                                       ${roleadmmgt}     ${roleusermgt}

...               AND               service-groupmgt.Request Service Update Group
...                                       ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                       ${defaultcompany_cust}
...                                       ${group02user}
...                                       -1      true      ${EMPTY}
...                                       ${roleusermgt}

#### Reset User ####
...               AND               service-usermgt.Request Service Update User
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     companyname=${defaultcompany_cust}
...                                     groupname=${group01admuser}
...                                     username=${user_cust1}
...                                     firstname=Testname        lastname=Lasttest     telnumber=021120011
...                                     email=testmail__${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@rbmail.com
...               AND              service-usermgt.Request Service Update User Status    ${DS_LOGIN['robotapi'][${login_col.username}]}    ${DS_LOGIN['robotapi'][${login_col.password}]}    ${user_cust1}    true

Test Teardown     Run Keywords    Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND             commonkeywords.Logout System
...               AND             commonkeywords.Verify Login Page

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
CASE1 Verify User Menu and Permission- User under Group Admin User
    [Documentation]    Veify Menu under role in Group Admin User --- Set Role User Management and Group Management

        Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
        ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
        
        commonkeywords.Login System         ${user_cust1}        ${VAR_CHGPASSWORD}
        commonkeywords.Show Menu Side Parnel      ${mainmenu}[configuration]
        Click       ${mainmenu}[configuration]

        commonkeywords.Verify Menu State          ${submenu}[usermgt]       visible
        commonkeywords.Verify Menu State          ${submenu}[groupMgt]      visible
        commonkeywords.Verify Menu State          ${submenu}[companyMgt]        visible

        commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]       ${submenu}[companyMgt]
        commonkeywords.Verify Page Name is correct    pagename=${menuname}[companyMgt]
        commonkeywords.Verify Button State   ${LOCATOR_ADDCOMP_BTN}            visible

        commonkeywords.Click Expand Search Criteria
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYCOM_SEL}        ${COMSEARCHBY}[comname]
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHCOM_KEYWORD}      ${defaultcompany_cust}
        commonkeywords.Click button on list page            ${LOCATOR_SEARCHCOM_BTN}
        commonkeywords.Click Hide Search Criteria
        commonkeywords.Wait Loading progress
        commonkeywords.Verify Button State   ${1ROW_COMPANY_ACTION}[edit]      visible

        commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]       ${submenu}[groupMgt]
        commonkeywords.Verify Page Name is correct    pagename=${menuname}[groupMgt]
        commonkeywords.Verify Button State   ${LOCATOR_ADDGROUP_BTN}           visible

        commonkeywords.Click Expand Search Criteria
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYGROUP_SEL}         ${GROUPSEARCHBY}[groupname]
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHGROUP_KEYWORD}       ${group01admuser}
        commonkeywords.Click button on list page    ${LOCATOR_SEARCHGROUP_BTN}
        commonkeywords.Wait Loading progress
        commonkeywords.Click Hide Search Criteria
        commonkeywords.Verify Button State   ${1ROW_GROUP_ACTION}[edit]        visible

        commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[usermgt]
        commonkeywords.Verify Page Name is correct    pagename=${menuname}[usermgt]
        commonkeywords.Verify Button State   ${LOCATOR_ADDUSER_BTN}            visible

        commonkeywords.Click Expand Search Criteria
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYUSER_SEL}          ${USERSEARCHBY}[username]
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHUSER_KEYWORD}        ${user_cust1}
        commonkeywords.Click button on list page      ${LOCATOR_SEARCHUSER_BTN}
        commonkeywords.Wait Loading progress
        commonkeywords.Click Hide Search Criteria
        commonkeywords.Wait Loading progress
        commonkeywords.Verify Button State   ${1ROW_USER_ACTION}[edit]         visible


CASE2 Verify User Menu-Change User under Group Normal User
    [Documentation]    Veify Menu under role in Group Normal User (Set Role User Management)

        Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
        ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
        service-usermgt.Request Service Update User
        ...       headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
        ...       companyname=${defaultcompany_cust}
        ...       groupname=${group02user}
        ...       username=${user_cust1}
        ...       firstname=Testname        lastname=Lasttest     telnumber=021120011
        ...       email=testmail__${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@rbmail.com
        service-usermgt.Request Service Update User Status    ${DS_LOGIN['robotapi'][${login_col.username}]}    ${DS_LOGIN['robotapi'][${login_col.password}]}    ${user_cust1}    true

        ### Assertion Menu ###
        commonkeywords.Verify Login Page
        commonkeywords.Login System         ${user_cust1}        ${VAR_CHGPASSWORD}
        commonkeywords.Show Menu Side Parnel      ${mainmenu}[configuration]
        Click       ${mainmenu}[configuration]
        commonkeywords.Verify Menu State          ${submenu}[usermgt]       visible
        commonkeywords.Verify Menu State          ${submenu}[groupMgt]      hidden
        commonkeywords.Verify Menu State          ${submenu}[companyMgt]        hidden

        commonkeywords.Go to SUBMENU name         ${mainmenu}[configuration]      ${submenu}[usermgt]
        commonkeywords.Verify Page Name is correct    pagename=${menuname}[usermgt]
        commonkeywords.Verify Button State        ${LOCATOR_ADDUSER_BTN}         visible

        commonkeywords.Click Expand Search Criteria
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYUSER_SEL}          ${USERSEARCHBY}[username]
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHUSER_KEYWORD}        ${user_cust1}
        commonkeywords.Click button on list page      ${LOCATOR_SEARCHUSER_BTN}
        commonkeywords.Wait Loading progress
        commonkeywords.Click Hide Search Criteria
        commonkeywords.Wait Loading progress
        commonkeywords.Verify Button State   ${1ROW_USER_ACTION}[edit]         visible


CASE3 Verify User Menu-Change Role under Group Admin User
    [Documentation]    Remove User Management Role

        Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
        ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
        service-groupmgt.Request Service Update Group
        ...     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
        ...     ${defaultcompany_cust}
        ...     ${group01admuser}
        ...     -1      true      ${EMPTY}
        ...     ${roleadmmgt}

        ### Assertion Menu ###
        commonkeywords.Verify Login Page
        commonkeywords.Login System         ${user_cust1}        ${VAR_CHGPASSWORD}
        commonkeywords.Show Menu Side Parnel      ${mainmenu}[configuration]
        Click       ${mainmenu}[configuration]
        commonkeywords.Verify Menu State          ${submenu}[usermgt]       hidden
        commonkeywords.Verify Menu State          ${submenu}[groupMgt]      visible
        commonkeywords.Verify Menu State          ${submenu}[companyMgt]        visible

        commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]       ${submenu}[companyMgt]
        commonkeywords.Verify Page Name is correct    pagename=${menuname}[companyMgt]
        commonkeywords.Verify Button State   ${LOCATOR_ADDCOMP_BTN}            visible

        commonkeywords.Click Expand Search Criteria
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYCOM_SEL}        ${COMSEARCHBY}[comname]
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHCOM_KEYWORD}      ${defaultcompany_cust}
        commonkeywords.Click button on list page            ${LOCATOR_SEARCHCOM_BTN}
        commonkeywords.Click Hide Search Criteria
        commonkeywords.Wait Loading progress
        commonkeywords.Verify Button State   ${1ROW_COMPANY_ACTION}[edit]      visible

        commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]       ${submenu}[groupMgt]
        commonkeywords.Verify Page Name is correct    pagename=${menuname}[groupMgt]
        commonkeywords.Verify Button State   ${LOCATOR_ADDGROUP_BTN}           visible

        commonkeywords.Click Expand Search Criteria
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYGROUP_SEL}         ${GROUPSEARCHBY}[groupname]
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHGROUP_KEYWORD}       ${group01admuser}
        commonkeywords.Click button on list page    ${LOCATOR_SEARCHGROUP_BTN}
        commonkeywords.Wait Loading progress
        commonkeywords.Click Hide Search Criteria
        commonkeywords.Verify Button State   ${1ROW_GROUP_ACTION}[edit]        visible


CASE4 Verify User Menu-Change Menu under User Management Role
    [Documentation]    Remove Company Management

        Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
        ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
      service-menumgt.Create Data List of Menu
      ...     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
      ...     ${VAR_MENUNAME_MAINCONF}       ${VAR_MENUNAME_GROUPMGT}
      service-permmgt.Create Data List of Permission
      ...     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
      ...     ${VAR_PERM_GROUPMGT}[0]      ${VAR_PERM_GROUPMGT}[1]     ${VAR_PERM_GROUPMGT}[2]   ${VAR_PERM_COMPANYMGT}[0]   ${VAR_PERM_COMPANYMGT}[1]


      IF  '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
            service-rolemgt.Request Service Update Role Data Test
            ...     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
            ...     ${roleadmmgt}    ${GLOBAL_MENUDATALIST}     ${GLOBAL_PERMDATALIST}     ${defaultcompany_cust}

      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
            service-rolemgt.Request Service Update Role Data Test
            ...     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
            ...     ${roleadmmgt}    ${GLOBAL_MENUDATALIST}     ${GLOBAL_PERMDATALIST}
      ELSE
          Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'IE5DEV' or STANDARD
      END



        ### Assertion Menu ###
        commonkeywords.Verify Login Page
        commonkeywords.Login System         ${user_cust1}        ${VAR_CHGPASSWORD}
        commonkeywords.Show Menu Side Parnel      ${mainmenu}[configuration]
        Click       ${mainmenu}[configuration]
        commonkeywords.Verify Menu State          ${submenu}[usermgt]       visible
        commonkeywords.Verify Menu State          ${submenu}[groupMgt]      visible
        commonkeywords.Verify Menu State          ${submenu}[companyMgt]        hidden

        commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]       ${submenu}[groupMgt]
        commonkeywords.Verify Page Name is correct    pagename=${menuname}[groupMgt]
        commonkeywords.Verify Button State   ${LOCATOR_ADDGROUP_BTN}           visible

        commonkeywords.Click Expand Search Criteria
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYGROUP_SEL}         ${GROUPSEARCHBY}[groupname]
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHGROUP_KEYWORD}       ${group01admuser}
        commonkeywords.Click button on list page    ${LOCATOR_SEARCHGROUP_BTN}
        commonkeywords.Wait Loading progress
        commonkeywords.Click Hide Search Criteria
        commonkeywords.Verify Button State   ${1ROW_GROUP_ACTION}[edit]        visible

        commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[usermgt]
        commonkeywords.Verify Page Name is correct    pagename=${menuname}[usermgt]
        commonkeywords.Verify Button State   ${LOCATOR_ADDUSER_BTN}            visible

        commonkeywords.Click Expand Search Criteria
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYUSER_SEL}          ${USERSEARCHBY}[username]
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHUSER_KEYWORD}        ${user_cust1}
        commonkeywords.Click button on list page      ${LOCATOR_SEARCHUSER_BTN}
        commonkeywords.Wait Loading progress
        commonkeywords.Click Hide Search Criteria
        commonkeywords.Wait Loading progress
        commonkeywords.Verify Button State   ${1ROW_USER_ACTION}[edit]         visible


CASE Verify Permission Action- Change Permisssion under User Management Role
    [Documentation]    Change Permisssion under User Management Role --- add Change status

        Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
        ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
        service-menumgt.Create Data List of Menu
        ...     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
        ...     ${VAR_MENUNAME_MAINCONF}      ${VAR_MENUNAME_USERMGT}
        service-permmgt.Create Data List of Permission
        ...     ${DS_LOGIN['robotapi'][${login_col.username}]}       ${DS_LOGIN['robotapi'][${login_col.password}]}
        ...     ${VAR_PERM_USERMGT}[0]     ${VAR_PERM_USERMGT}[1]    ${VAR_PERM_USERMGT}[2]     ${VAR_PERM_USERMGT}[3]


      IF  '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
          service-rolemgt.Request Service Update Role Data Test
          ...     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
          ...     ${roleusermgt}    ${GLOBAL_MENUDATALIST}     ${GLOBAL_PERMDATALIST}     ${defaultcompany_cust}

      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
          service-rolemgt.Request Service Update Role Data Test
          ...     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
          ...     ${roleusermgt}    ${GLOBAL_MENUDATALIST}     ${GLOBAL_PERMDATALIST}
      ELSE
          Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'IE5DEV' or STANDARD
      END



        ### Assertion Menu ###
        commonkeywords.Verify Login Page
        commonkeywords.Login System         ${user_cust1}        ${VAR_CHGPASSWORD}
        commonkeywords.Show Menu Side Parnel      ${mainmenu}[configuration]
        Click       ${mainmenu}[configuration]
        commonkeywords.Verify Menu State          ${submenu}[usermgt]       visible
        commonkeywords.Verify Menu State          ${submenu}[groupMgt]      visible
        commonkeywords.Verify Menu State          ${submenu}[companyMgt]        visible

        commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]       ${submenu}[companyMgt]
        commonkeywords.Verify Page Name is correct    pagename=${menuname}[companyMgt]
        commonkeywords.Verify Button State   ${LOCATOR_ADDCOMP_BTN}            visible

        commonkeywords.Click Expand Search Criteria
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYCOM_SEL}        ${COMSEARCHBY}[comname]
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHCOM_KEYWORD}      ${defaultcompany_cust}
        commonkeywords.Click button on list page            ${LOCATOR_SEARCHCOM_BTN}
        commonkeywords.Click Hide Search Criteria
        commonkeywords.Wait Loading progress
        commonkeywords.Verify Button State   ${1ROW_COMPANY_ACTION}[edit]      visible

        commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]       ${submenu}[groupMgt]
        commonkeywords.Verify Page Name is correct    pagename=${menuname}[groupMgt]
        commonkeywords.Verify Button State   ${LOCATOR_ADDGROUP_BTN}           visible

        commonkeywords.Click Expand Search Criteria
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYGROUP_SEL}         ${GROUPSEARCHBY}[groupname]
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHGROUP_KEYWORD}       ${group01admuser}
        commonkeywords.Click button on list page    ${LOCATOR_SEARCHGROUP_BTN}
        commonkeywords.Wait Loading progress
        commonkeywords.Click Hide Search Criteria
        commonkeywords.Verify Button State   ${1ROW_GROUP_ACTION}[edit]        visible

        commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[usermgt]
        commonkeywords.Verify Page Name is correct    pagename=${menuname}[usermgt]
        commonkeywords.Verify Button State   ${LOCATOR_ADDUSER_BTN}            visible

        commonkeywords.Click Expand Search Criteria
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYUSER_SEL}          ${USERSEARCHBY}[username]
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHUSER_KEYWORD}        ${user_cust1}
        commonkeywords.Click button on list page      ${LOCATOR_SEARCHUSER_BTN}
        commonkeywords.Wait Loading progress
        commonkeywords.Click Hide Search Criteria
        commonkeywords.Wait Loading progress
        commonkeywords.Verify Button State   ${1ROW_USER_ACTION}[edit]            visible
        commonkeywords.Verify Button State   ${1ROW_USER_ACTION}[changeStatus]    visible


CASE Verify Permission Action- Change Permisssion under Group Management Role
    [Documentation]    Change Permisssion under Group Management Role --- remove add group

        Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
        ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
        service-menumgt.Create Data List of Menu
        ...     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
        ...     ${VAR_MENUNAME_MAINCONF}    ${VAR_MENUNAME_GROUPMGT}     ${VAR_MENUNAME_COMPANYMGT}
        service-permmgt.Create Data List of Permission
        ...     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
        ...     ${VAR_PERM_GROUPMGT}[1]     ${VAR_PERM_GROUPMGT}[2]   ${VAR_PERM_COMPANYMGT}[0]   ${VAR_PERM_COMPANYMGT}[1]


        IF  '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
            service-rolemgt.Request Service Update Role Data Test
            ...     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
            ...     ${roleadmmgt}     ${GLOBAL_MENUDATALIST}     ${GLOBAL_PERMDATALIST}     ${defaultcompany_cust}

        ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
            service-rolemgt.Request Service Update Role Data Test
            ...     ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
            ...     ${roleadmmgt}     ${GLOBAL_MENUDATALIST}     ${GLOBAL_PERMDATALIST}
        ELSE
            Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'IE5DEV' or STANDARD
        END

        ### Assertion Menu ###
        commonkeywords.Verify Login Page
        commonkeywords.Login System         ${user_cust1}        ${VAR_CHGPASSWORD}
        commonkeywords.Show Menu Side Parnel      ${mainmenu}[configuration]
        Click       ${mainmenu}[configuration]
        commonkeywords.Verify Menu State          ${submenu}[usermgt]       visible
        commonkeywords.Verify Menu State          ${submenu}[groupMgt]      visible
        commonkeywords.Verify Menu State          ${submenu}[companyMgt]        visible

        commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]       ${submenu}[companyMgt]
        commonkeywords.Verify Page Name is correct    pagename=${menuname}[companyMgt]
        commonkeywords.Verify Button State   ${LOCATOR_ADDCOMP_BTN}            visible

        commonkeywords.Click Expand Search Criteria
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYCOM_SEL}        ${COMSEARCHBY}[comname]
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHCOM_KEYWORD}      ${defaultcompany_cust}
        commonkeywords.Click button on list page            ${LOCATOR_SEARCHCOM_BTN}
        commonkeywords.Click Hide Search Criteria
        commonkeywords.Wait Loading progress
        commonkeywords.Verify Button State   ${1ROW_COMPANY_ACTION}[edit]      visible

        commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]       ${submenu}[groupMgt]
        commonkeywords.Verify Page Name is correct    pagename=${menuname}[groupMgt]
        commonkeywords.Verify Button State   ${LOCATOR_ADDGROUP_BTN}           hidden

        commonkeywords.Click Expand Search Criteria
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYGROUP_SEL}         ${GROUPSEARCHBY}[groupname]
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHGROUP_KEYWORD}       ${group01admuser}
        commonkeywords.Click button on list page    ${LOCATOR_SEARCHGROUP_BTN}
        commonkeywords.Wait Loading progress
        commonkeywords.Click Hide Search Criteria
        commonkeywords.Verify Button State   ${1ROW_GROUP_ACTION}[edit]        visible

        commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[usermgt]
        commonkeywords.Verify Page Name is correct    pagename=${menuname}[usermgt]
        commonkeywords.Verify Button State   ${LOCATOR_ADDUSER_BTN}            visible

        commonkeywords.Click Expand Search Criteria
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYUSER_SEL}          ${USERSEARCHBY}[username]
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHUSER_KEYWORD}        ${user_cust1}
        commonkeywords.Click button on list page      ${LOCATOR_SEARCHUSER_BTN}
        commonkeywords.Wait Loading progress
        commonkeywords.Click Hide Search Criteria
        commonkeywords.Wait Loading progress
        commonkeywords.Verify Button State   ${1ROW_USER_ACTION}[edit]            visible
