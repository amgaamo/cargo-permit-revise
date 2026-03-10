*** Settings ***
Library       Browser         retry_assertions_for=0:00:05     run_on_failure=Take Screenshot \ fail-screenshot-{index} \ fileType=jpeg \ quality=25
Library       Collections
Library       String
Library       OperatingSystem
Library       RequestsLibrary
Library       CSVLib
Library       DateTime
Library       JSONLibrary
Library       RPA.Tables
Library       RPA.JSON

Resource      config-properties.resource
Resource      datasources.resource
Resource      datatest/defaultdatalist.resource
Resource      services/main-service.resource

Resource      ../pages/pageLogin.robot
Resource      ../pages/pageChangePwd.robot
Resource      ../pages/pageProfile.robot
Resource      ../pages/pageUserMgt.robot
Resource      ../pages/pageCompanyMgt.robot
Resource      ../pages/pageGroupMgt.robot
Resource      ../pages/pagePermMgt.robot
Resource      ../pages/pageRoleMgt.robot
Resource      ../pages/pageMenuMgt.robot
Resource      ../pages/pageRegister.robot
Resource      ../pages/pageComTypeMgt.robot

*** Variables ***
##### Default Values #####
${VAR_DEFAULT_PAGING}           10
${VAR_DEFAULT_PASSWORD}         Robot@123
${VAR_DEFAULT_NORECORDFOUND}    No records found

# -----------------------------------------------------------------

${LOCATOR_TITLE_MODAL}          //*[@id="swal2-title"]
${LOCATOR_CONTENT_MODAL}        //*[@id="swal2-content"]

##### Modal Dialog Button #####
${LOCATOR_YES_MODAL}            //button[contains(text(),'Yes')]
${LOCATOR_NO_MODAL}             //button[contains(text(),'No')]
${LOCATOR_CLOSE_MODAL}          //button[contains(text(),'Close')]
${LOCATOR_OK_MODAL}             //button[contains(text(),'OK')]
${LOCATOR_CONFIRM_MODAL}        //button[contains(text(),'Confirm')]
${LOCATOR_CANCEL_MODAL}         //button[contains(text(),'Cancel')]

#------------------------------------------------------------------

${LOCATOR_LOADING_BTN}                //*[contains(text(),'Loading')]
${LOCATOR_LOADING}                    //div[contains(@class,"spinner-border")]

${LOCATOR_USERNAME_FIELD}             //*[@id="login-username"]
${LOCATOR_PASSWORD_FIELD}             //*[@id="login-password"]
${LOCATOR_LOGIN_BTN}                  //*[contains(@class, "btn-login")]

${LOCATOR_WELCOME_TITLE}              //div[contains(@class,'user-profile')]
${LOCATOR_USRNAME_WELCOME_BAR}        //button[contains(@class, user-profile)]/div/span
${LOCATOR_HEADER_MENU}                //button[contains(@class,'user-profile-btn')]
${LOCATOR_MENULOGOUT}                 //*[contains(text(),'Logout')]
${LOCATOR_MENUCHANGPWD}               //*[@title="Change Password"]

### VAR MESSAGE LOGIN PAGE ###
${VAR_MSGEMPTYUSERNAME}          Please enter a username.
${VAR_MSGEMPTYPASSWORD}          Please enter a password.
${VAR_MSGLOGINFAIL}              Not Found Username or Password.
${VAR_MSGLOGIN_INACTIVE}         Inactive User
${VAR_MSGLOGIN_USERLOCK}         User is locked

## ---- MENU LOCATOR ----- ##
${LOCATOR_MENUPROFILE}                //header[@class="header header-bottom border-bottom"]/nav/div/div[2]/div/div/a[1]/i

${LOCATOR_ISEXPAND_SUBMENU}           //*[contains(@class,"ng-star-inserted show")]
${LOCATOR_SIDEBAR_TOGGLE}             //*[@id="sidebar-toggle-btn"]
${LOCATOR_SIDEBARPANEL}               //*[contains(@class,"menuleft-open")]

${LOCATOR_CURRENT_PAGENAME}           //*[@aria-current="page"]

${LOCATOR_SEARCH_CRITERIA_VISIBLE}    //*[@class="collapse in show"]
${LOCATOR_SERACH_CRITERIA_BTN}        //button[@title="Search"]
${LOCATOR_SEARCH_EXPAND}              //*[contains(@id, "expand")]

${LOCATOR_NOTIFY_WARN}                //div[@aria-label="Warning"]
${LOCATOR_NOTIFY_SUCCESS}             //div[@aria-label="Success"]
${LOCATOR_NOTIFY_MSG}                 //div[@role="alertdialog"]

&{mainmenu}       configuration=css=a[title="Configuration"]
...               registerMgt=//*[contains(@href, 'mainmenu/register/approve')]


&{submenu}        usermgt=css=a[title="User Management"]
...               groupMgt=css=a[title="Group Management"]
...               companyMgt=//a[contains(@title, 'Company Management')]
...               permMgt=//a[contains(@title, 'Permission Management')]
...               roleMgt=css=a[title="Role Management"]
...               menuMgt=css=a[title="Menu Management"]
...               ctypeMgt=//a[contains(@title, 'Company Type Management')]

&{menuname}       usermgt=User Management
...               companyMgt=Company Management
...               groupMgt=Group Management
...               permMgt=Permission Management
...               roleMgt=Role Management
...               menuMgt=Menu Management
...               regMgt=Register Management
...               ctypeMgt=Company Type Management

${homemenu}       //*[contains(@href, '/mainmenu/home') and contains(@class,'brand')]

### Config Var. Fix Data
${REGISTER_AUTO_APPRV}      True
${COMPANY_AUTO_APPRV}       True

### PAGING FUNCTION ###
${LOCATOR_PAGING}               //div[contains(@class, 'pagination-total')]/div/div[contains(text(), 'Showing')]
${LOCATOR_PAGINGNUM_ACTIVE}     //*[contains(@class, 'page-item active')]
${LOCATOR_SHOWINGPAGE_SEL}      //*[contains(@class,'content')]/app-showing-page/form/select
${LOCATOR_SHOWINGPAGE_LINK}     //a[@class="page-link" and contains(text(), '::PAGENUM::')]

*** Keywords ***
Get Value Environment
      ${PROTOCOL}=                    Get Environment Variable         PROTOCOL_USERMANAGEMENT
      ${DOMAIN}=                      Get Environment Variable         DOMAIN_USERMANAGEMENT
      ${URLPATH}=                     Get Environment Variable         URLPATH_USERMANAGEMENT
      ${APISUBPATH}=                  Get Environment Variable         APIPATH_USERMANAGEMENT
      ${ENV_REGIS_AUTO_APPRV}=        Get Environment Variable         TEST_REGISTER_APPROVEAUTO
      ${ENV_COMPANY_AUTO_APPRV}=      Get Environment Variable         TEST_COMPANY_APPROVEAUTO
      ${ENV_USERMGTSTD_VERSION}=      Get Environment Variable         TEST_USERMGTSTD_VERSION

      ${ENV_DEFAULTDATA_FUNCTEST}=    Get Environment Variable         FUNCTION_CREATE_DEFAULTDATA
      ${ENV_USERMGT_FUNCTEST}=        Get Environment Variable         FUNCTION_TEST_USERMANAGEMENT
      ${ENV_PROFILE_FUNCTEST}=        Get Environment Variable         FUNCTION_TEST_PROFILE 
      ${ENV_REGISTER_FUNCTEST}=       Get Environment Variable         FUNCTION_TEST_REGISTER           
      ${ENV_PAGING_FUNCTEST}=         Get Environment Variable         FUNCTION_TEST_PAGING

      Set Global Variable      ${PROTOCOL}
      Set Global Variable      ${DOMAIN}
      Set Global Variable      ${URLPATH}
      Set Global Variable      ${APISUBPATH}
      Set Global Variable      ${ENV_REGIS_AUTO_APPRV}
      Set Global Variable      ${ENV_COMPANY_AUTO_APPRV}
      
      Set Global Variable      ${ENV_DEFAULTDATA_FUNCTEST}
      Set Global Variable      ${ENV_USERMGTSTD_VERSION}
      Set Global Variable      ${ENV_USERMGT_FUNCTEST}
      Set Global Variable      ${ENV_PROFILE_FUNCTEST}
      Set Global Variable      ${ENV_REGISTER_FUNCTEST}
      Set Global Variable      ${ENV_PAGING_FUNCTEST}

Set Data for Run Automated Test
      IF  '${_fixdata_}'=='true'
          Set Global Variable     ${URLTEST}                          ${VAR_PROTOCOL}://${VAR_IPSERV}
          Set Global Variable     ${APIPATHTEST}                      ${VAR_API_SUBDIRECTORY}
          Set Global Variable     ${GLOBAL_REGISTER_AUTO_APPRV}       ${REGISTER_AUTO_APPRV}
          Set Global Variable     ${GLOBAL_COMPANY_AUTO_APPRV}        ${COMPANY_AUTO_APPRV}
          Set Global Variable     ${GLOBAL_STANDARD_VERSION}          ${VAR_USERMGTSTD_VERSION}

          Set Global Variable     ${GLOBAL_DEFAULTDATA_FUNCTEST}      ${DEFAULTDATA_FUNCTEST} 
          Set Global Variable     ${GLOBAL_USERMGT_FUNCTEST}          ${USERMGT_FUNCTEST}   
          Set Global Variable     ${GLOBAL_PROFILE_FUNCTEST}          ${PROFILE_FUNCTEST} 
          Set Global Variable     ${GLOBAL_REGISTER_FUNCTEST}         ${REGISTER_FUNCTEST}    
          Set Global Variable     ${GLOBAL_PAGING_FUNCTEST}           ${PAGING_FUNCTEST}  

      ELSE IF   '${_fixdata_}'=='false'
          Get Value Environment
          Set Global Variable     ${URLTEST}                          ${PROTOCOL}://${DOMAIN}
          Set Global Variable     ${APIPATHTEST}                      ${APISUBPATH}
          Set Global Variable     ${GLOBAL_REGISTER_AUTO_APPRV}       ${ENV_REGIS_AUTO_APPRV}
          Set Global Variable     ${GLOBAL_COMPANY_AUTO_APPRV}        ${ENV_COMPANY_AUTO_APPRV}
          Set Global Variable     ${GLOBAL_STANDARD_VERSION}          ${ENV_USERMGTSTD_VERSION}

          Set Global Variable     ${GLOBAL_DEFAULTDATA_FUNCTEST}      ${ENV_DEFAULTDATA_FUNCTEST} 
          Set Global Variable     ${GLOBAL_USERMGT_FUNCTEST}          ${ENV_USERMGT_FUNCTEST}   
          Set Global Variable     ${GLOBAL_PROFILE_FUNCTEST}          ${ENV_PROFILE_FUNCTEST} 
          Set Global Variable     ${GLOBAL_REGISTER_FUNCTEST}         ${ENV_REGISTER_FUNCTEST}    
          Set Global Variable     ${GLOBAL_PAGING_FUNCTEST}           ${ENV_PAGING_FUNCTEST}  
      ELSE
          Fail    \nPlease Check '{_fixdata_} Variable' should be any 'true' or 'false'.
      END

Initialize System and Go to Login Page
    [Arguments]    ${is_newpage}=False
      Set Data for Run Automated Test
      
      IF  '${is_newpage}'=='False'
            Run Keyword If   '${VAR_BROWSER}'=='chrome'     New Browser     browser=chromium    headless=${_headlessmode_}    channel=chrome
            ...    ELSE IF   '${VAR_BROWSER}'=='msedge'     New Browser     browser=chromium    headless=${_headlessmode_}    channel=msedge
            ...    ELSE IF   '${VAR_BROWSER}'=='chromium'   New Browser     browser=chromium    headless=${_headlessmode_}
            ...    ELSE IF   '${VAR_BROWSER}'=='firefox'    New Browser     browser=firefox     headless=${_headlessmode_}

            New Context     ignoreHTTPSErrors=True    acceptDownloads=True
            New Page
      ELSE
            New Context     ignoreHTTPSErrors=True    acceptDownloads=True
            New Page
      END

      Run Keyword If    '${_fixdata_}'=='true'
      ...                Go To        ${URLTEST}/${VAR_PATHLOGIN_URL}/          timeout=00:02:00
      ...       ELSE     Go To        ${URLTEST}/${URLPATH}/                    timeout=00:02:00

      Set Viewport Size     1280    760

Open Browser and Go to website
    [Arguments]     ${url}
      Close Browser     ALL
      Run Keyword If   '${VAR_BROWSER}'=='chrome'     New Browser     browser=chromium    headless=${_headlessmode_}    channel=chrome
      ...    ELSE IF   '${VAR_BROWSER}'=='msedge'     New Browser     browser=chromium    headless=${_headlessmode_}    channel=msedge
      ...    ELSE IF   '${VAR_BROWSER}'=='chromium'   New Browser     browser=chromium    headless=${_headlessmode_}
      ...    ELSE IF   '${VAR_BROWSER}'=='firefox'    New Browser     browser=firefox     headless=${_headlessmode_}

      New Context     ignoreHTTPSErrors=True    acceptDownloads=True
      New Page
      Go To           ${url}       timeout=00:01:00

      Set Viewport Size     1280    760


Extract Value from JSON data
   [Arguments]    ${jsondata}    ${jsonpath}
         ${GLOBAL_JSONVALUE}=       JSONLibrary.Get Value From Json         ${jsondata}       ${jsonpath}
         Set Global Variable        ${GLOBAL_JSONVALUE}

Convert Data to lower or upper case
    [Arguments]   ${convertto}    ${data}
    IF    '${convertto}'=='lower'
          ${GLOBAL_DATACONVERT}=        Convert To Lower Case       ${data}
    ELSE IF   '${convertto}'=='upper'
          ${GLOBAL_DATACONVERT}=        Convert To Upper Case       ${data}
    ELSE
          Fail   \nPlease check argument convert to should equeal 'lower' or 'upper'
    END

    Set Global Variable     ${GLOBAL_DATACONVERT}

#------------------------- Using for new tab or new windows --------------------------------#
Get MAIN pageids for switch page
    ${idpage}=       Get Page Ids          ALL
    ${idcontext}=    Get Context Ids      ALL
    ${GLOBAL_MAINPAGE}=        Set Variable          ${idpage}[0]
    ${GLOBAL_MAINCONTEXT}=     Set Variable          ${idcontext}[0]
    Set Global Variable     ${GLOBAL_MAINPAGE}
    Set Global Variable     ${GLOBAL_MAINCONTEXT}

Get Information New Page Open
    Sleep   1500ms
    ${idpages}=           Get Page Ids          ALL
    ${NEWPAGEID0}=        Set Variable          ${idpages}[0]
    ${NEWPAGEID-1}=       Set Variable          ${idpages}[-1]

    ${_pageidisactive_}=       Run Keyword And Return Status      Switch Page       ${NEWPAGEID0}

    Run Keyword If    '${_pageidisactive_}'=='True'
    ...               Set Global Variable     ${GLOBAL_NEWPAGE}        ${NEWPAGEID0}
    ...       ELSE     Set Global Variable    ${GLOBAL_NEWPAGE}        ${NEWPAGEID-1}

Switch Another Open Page
    [Arguments]      ${idpage}
      Sleep  1500ms
      Switch Page       ${idpage}

#--------------------- Using for Modal Yes/No/OK/Close Button ----------------------------------#

Click Yes Button for confirm
      Wait For Elements State     ${LOCATOR_YES_MODAL}      visible     timeout=40s
      Click   ${LOCATOR_YES_MODAL}

Click No Button for Cancel
      Wait For Elements State     ${LOCATOR_NO_MODAL}       visible     timeout=40s
      Click   ${LOCATOR_NO_MODAL}

Click OK Button
      Wait For Elements State     ${LOCATOR_OK_MODAL}       visible     timeout=40s
      Click   ${LOCATOR_OK_MODAL}

Click Close Button
      Wait For Elements State      ${LOCATOR_CLOSE_MODAL}   visible     timeout=40s
      Click   ${LOCATOR_CLOSE_MODAL}

Click Cancel Button
      Wait For Elements State     ${LOCATOR_OK_MODAL}       visible     timeout=40s
      Click   ${LOCATOR_CANCEL_MODAL}

Click Confirm Button
      Wait For Elements State      ${LOCATOR_CLOSE_MODAL}   visible     timeout=40s
      Click   ${LOCATOR_CONFIRM_MODAL}

Verify Modal Title message
      [Arguments]    ${exp_titlemsg}
         Sleep   500ms
         Wait For Elements State      ${LOCATOR_TITLE_MODAL}      visible         timeout=40s
         Get Text    ${LOCATOR_TITLE_MODAL}        contains          ${exp_titlemsg}

Verify Modal Content message
      [Arguments]    ${exp_contentmsg}
         Sleep   500ms
         Wait For Elements State      ${LOCATOR_CONTENT_MODAL}     visible      timeout=40s
         Get Text     ${LOCATOR_CONTENT_MODAL}     contains          ${exp_contentmsg}

Verify Modal should Hidden
         Sleep   500ms
         Wait For Elements State           ${LOCATOR_TITLE_MODAL}        hidden         timeout=30
         Wait For Elements State           ${LOCATOR_CONTENT_MODAL}      hidden         timeout=60


#------------------------------- Keywords : Login/Logout System -------------------------------------------------#
# Login user system
#    [Arguments]   ${userset}     ${username}=${EMPTY}     ${passsword}=${EMPTY}
#       Get User for login system    ${userset}
#       datasources.Import DataSource USER LOGIN
#       Run Keyword If    '${userset}'=='masteruser'     Login System    ${username}         ${passsword}
      # Run Keyword If    '${userset}'=='user1'          Login System    ${GLOBAL_USER1}     ${GLOBAL_PWD1}
      # Run Keyword If    '${userset}'=='user2'          Login System    ${GLOBAL_USER2}     ${GLOBAL_PWD2}
      # Run Keyword If    '${userset}'=='user3'          Login System    ${GLOBAL_USER3}     ${GLOBAL_PWD3}
      # Run Keyword If    '${userset}'=='user4'          Login System    ${GLOBAL_USER4}     ${GLOBAL_PWD4}
      # Run Keyword If    '${userset}'=='user5'          Login System    ${GLOBAL_USER5}     ${GLOBAL_PWD5}

# Get User for login system
#    [Arguments]    ${userset}
#       Run Keyword If    '${_concurrentmode_}'=='true'     Get data LOGIN USER for concurrent   ${userset}

# Get data LOGIN USER for concurrent
#    [Arguments]    ${userset}
#     Acquire Lock     ${userset}
#     Log   This part is critical section
#     ${valuesetname}=       Acquire Value Set      ${userset}
#     Run Keyword If    '${userset}'=='user1'     SET USER DATA1 for concurrent
#     Run Keyword If    '${userset}'=='user2'     SET USER DATA2 for concurrent
#     Run Keyword If    '${userset}'=='user3'     SET USER DATA3 for concurrent
#     Run Keyword If    '${userset}'=='user4'     SET USER DATA4 for concurrent
#     Run Keyword If    '${userset}'=='user5'     SET USER DATA5 for concurrent
#     Log   After value set release others can obtain the variable values

#+++++++++++ SET DATA CONCURRENT FOR RUN 5 USERS +++++++++++#
# SET USER DATA1 for concurrent
#     ${GLOBAL_USER1}=        Get Value From Set     username
#     ${GLOBAL_PWD1}=         Get Value From Set     password
#     Set Global Variable     ${GLOBAL_USER1}
#     Set Global Variable     ${GLOBAL_PWD1}

# SET USER DATA2 for concurrent
#     ${GLOBAL_USER2}=        Get Value From Set     username
#     ${GLOBAL_PWD2}=         Get Value From Set     password
#     Set Global Variable     ${GLOBAL_USER2}
#     Set Global Variable     ${GLOBAL_PWD2}

# SET USER DATA3 for concurrent
#     ${GLOBAL_USER3}=       Get Value From Set     username
#     ${GLOBAL_PWD3}=        Get Value From Set     password
#     Set Global Variable    ${GLOBAL_USER3}
#     Set Global Variable    ${GLOBAL_PWD3}

# SET USER DATA4 for concurrent
#     ${GLOBAL_USER4}=       Get Value From Set     username
#     ${GLOBAL_PWD4}=        Get Value From Set     password
#     Set Global Variable    ${GLOBAL_USER4}
#     Set Global Variable    ${GLOBAL_PWD4}

# SET USER DATA5 for concurrent
#     ${GLOBAL_USER5}=       Get Value From Set     username
#     ${GLOBAL_PWD5}=        Get Value From Set     password
#     Set Global Variable    ${GLOBAL_USER5}
#     Set Global Variable    ${GLOBAL_PWD5}

#+++++++++++ END:SET DATA CONCURRENT FOR RUN 5 USERS +++++++++++#

Release user lock and close all browser
#    [Arguments]    ${userset}=${EMPTY}
#       Run Keyword If    '${_concurrentmode_}'=='true'
#       ...                Run Keywords      Release Lock         ${userset}
#       ...                AND               Release Value Set
#       ...                AND               Close Browser        ALL
#       ...       ELSE     Close Browser     ALL
        Close Browser     ALL

Login System
   [Arguments]    ${username}    ${password}
      Fill in Username Field         ${username}
      Fill in Password Field         ${password}
      Click Login Button
      Ignore warning Login
      Verify Welcome page

Logout System
      Click       ${LOCATOR_HEADER_MENU}
      Click       ${LOCATOR_MENULOGOUT}
      Click Yes Button for confirm

Login Waiting Loading
      Wait For Elements State         ${LOCATOR_LOADING_BTN}       hidden        timeout=30

#+++++++++++ Generate Data Test +++++++++++#
Get Data Current Date
  # ${GLOBAL_CURDATE_YMD} >> ex. 2021-11-12    /   ${GLOBAL_CURDATE_DMY} >> ex. 12/11/2021  /  ${GLOBAL_CURDATE_DDMMMYYYY} >> ex.12-NOV-2021  /  ${GLOBAL_CURDATE_DDMMMYY} >> ex.12-NOV-21
    ${currdate}=        Get Current Date
    ${GLOBAL_CURDATE_YMD}=          Convert Date        ${currdate}          result_format=%Y-%m-%d
    ${GLOBAL_CURDATE_DMY}=          Convert Date        ${currdate}          result_format=%d/%m/%Y
    ${GLOBAL_CURDATE_DDMMMYYYY}=    Convert Date        ${currdate}          result_format=%d-%b-%Y
    ${GLOBAL_CURDATE_DDMMMYY}=      Convert Date        ${currdate}          result_format=%d-%b-%y

    Set Global Variable     ${GLOBAL_CURDATE_YMD}
    Set Global Variable     ${GLOBAL_CURDATE_DMY}
    Set Global Variable     ${GLOBAL_CURDATE_DDMMMYYYY}
    Set Global Variable     ${GLOBAL_CURDATE_DDMMMYY}

Generate Random Values
    [Arguments]     ${lengthno}     ${lenghtletter}
      ${GLOBAL_RANDOMNO}=        Generate Random String      ${lengthno}            [NUMBERS]
      ${GLOBAL_RANDOMLETTER}=    Generate Random String      ${lenghtletter}        [LOWER]

      Set Global Variable       ${GLOBAL_RANDOMNO}
      Set Global Variable       ${GLOBAL_RANDOMLETTER}



Generate Random Number
    [Arguments]     ${lengthno}
      ${GLOBAL_GENNUMBER}=        Generate Random String      ${lengthno}            [NUMBERS]

      Set Global Variable       ${GLOBAL_GENNUMBER}

#+++++++++++ Keywords : First Page (Login Page)  +++++++++++#
Fill in Username Field
   [Arguments]    ${username}
      Fill Text       ${LOCATOR_USERNAME_FIELD}      ${username}

Fill in Password Field
   [Arguments]   ${password}
      Fill Secret     ${LOCATOR_PASSWORD_FIELD}      $password

Click Login Button
      Click     ${LOCATOR_LOGIN_BTN}
      Login Waiting Loading

Ignore warning Login
      Wait For Elements State         ${LOCATOR_LOADING_BTN}        hidden         timeout=60
      Sleep    500ms
      ${modal_is_show}=     Get Element States        ${LOCATOR_YES_MODAL}     then      bool(value & visible)
      IF  '${modal_is_show}'=='True'
          Wait For Elements State         ${LOCATOR_YES_MODAL}          visible       timeout=5s
          Click Yes Button for confirm
      END

Verify Welcome page
      Wait For Elements State           ${LOCATOR_WELCOME_TITLE}           visible       timeout=20

Verify Login Page
      Wait For Elements State           ${LOCATOR_USERNAME_FIELD}          visible       timeout=20
      Wait For Elements State           ${LOCATOR_PASSWORD_FIELD}          visible       timeout=20
      Wait For Elements State           ${LOCATOR_LOGIN_BTN}               visible       timeout=20

Verify Profile Detail data
    [Arguments]    ${locator_profile}       ${expval}
      Get Text     ${locator_profile}       should be      ${expval}

Verify Menu State
    [Arguments]   ${locator_menu}     ${state}
      Wait Until Keyword Succeeds    50s   200ms   Wait For Elements State           ${locator_menu}           ${state}       timeout=20

#------------------- Keywords : Common functional keyword  -----------------------#
Wait Loading progress
      Sleep    500ms
      Wait For Elements State           ${LOCATOR_LOADING}          hidden        timeout=60
      Wait For Elements State           ${LOCATOR_LOADING_BTN}      hidden        timeout=60
      # Wait Until Network Is Idle        timeout=5s

Wait Loading state
    [Arguments]   ${locator_field}      ${state}
      # Wait Until Network Is Idle        timeout=10s
      Wait For Elements State           ${locator_field}      ${state}        timeout=30


Show Menu Side Parnel
    [Arguments]   ${menuname}
      ${sidebar_is_visible}=     Get Element States        ${LOCATOR_SIDEBARPANEL}     then    bool(value & visible)
      ${menu_is_visible}=        Get Element States        ${menuname}     then    bool(value & visible)

      IF   '${sidebar_is_visible}'=='False' and '${menu_is_visible}'=='False'
            Click       ${LOCATOR_SIDEBAR_TOGGLE}
            Wait For Elements State       ${LOCATOR_SIDEBARPANEL}       visible     timeout=2s

      ELSE IF   '${sidebar_is_visible}'=='False' and '${menu_is_visible}'=='True'
            Click       ${LOCATOR_SIDEBAR_TOGGLE}
            Wait For Elements State       ${LOCATOR_SIDEBARPANEL}       visible     timeout=2s

      ELSE IF   '${sidebar_is_visible}'=='True' and '${menu_is_visible}'=='True'
            Wait For Elements State       ${LOCATOR_SIDEBARPANEL}       visible     timeout=2s

      ELSE IF   '${sidebar_is_visible}'=='True' and '${menu_is_visible}'=='False'
            Click     ${LOCATOR_SIDEBAR_TOGGLE}
            Wait For Elements State       ${LOCATOR_SIDEBARPANEL}       visible     timeout=2s
      ELSE
            Fail    Check Condition Keyword 'Show Menu Side Parnel'
      END

Hide Menu Side Parnel
      Sleep   500ms
      # ${sidebar_is_visible}=    Get Element States        ${LOCATOR_SIDEBARPANEL}     then    bool(value & visible)
      ${sidebar_is_visible}=      Run Keyword And Return Status    Wait For Elements State          ${LOCATOR_SIDEBARPANEL}         visible      timeout=2500ms

      IF   '${sidebar_is_visible}'=='True'
            Click       ${LOCATOR_SIDEBAR_TOGGLE}
      ELSE IF  '${sidebar_is_visible}'=='False'
            Log To Console    \nMenu Side Parnel already hide.
      ELSE
            Fail    Check Condition Keyword 'Hide Menu Side Parnel'
      END
      Sleep   500ms
      Wait For Elements State          ${LOCATOR_SIDEBARPANEL}         hidden      timeout=3s

Go to MENU name
    [Arguments]       ${menu_locator}
      Show Menu Side Parnel      ${menu_locator}
      Click       ${menu_locator}
      Sleep   500ms
      Hide Menu Side Parnel

Go to SUBMENU name
      [Arguments]       ${main_menu}       ${submenu_locator}
      Wait For Elements State    ${homemenu}   visible         timeout=500ms
      Click      ${homemenu}
      Sleep   500ms
      Show Menu Side Parnel     ${main_menu}

      ${is_expand_submenu}=      Get Element States        ${LOCATOR_ISEXPAND_SUBMENU}                 then    bool(value & visible)
      ${submenu_is_visible}=     Get Element States        ${submenu_locator}    then    bool(value & visible)

      IF   '${is_expand_submenu}'=='True' and '${submenu_is_visible}'=='True'
            Wait For Elements State       ${submenu_locator}     visible       timeout=10s
            Click    ${submenu_locator}

      ELSE IF   '${is_expand_submenu}'=='True' and '${submenu_is_visible}'=='False'
            Click   ${main_menu}
            Wait For Elements State       ${submenu_locator}     visible       timeout=10s
            Click    ${submenu_locator}

      ELSE IF   '${is_expand_submenu}'=='False' and '${submenu_is_visible}'=='False'
            Click   ${main_menu}
            Wait For Elements State       ${submenu_locator}      visible       timeout=10s
            Click    ${submenu_locator}

      ELSE IF   '${is_expand_submenu}'=='False' and '${submenu_is_visible}'=='True'
            Wait For Elements State       ${submenu_locator}     visible       timeout=10s
            Click    ${submenu_locator}
      ELSE
          Fail    Check Condition Keyword 'Go to SUBMENU name'
      END

      Sleep   500ms
      Hide Menu Side Parnel

Verify Page Name is correct
      [Arguments]   ${pagename}
      Wait For Elements State       ${LOCATOR_CURRENT_PAGENAME}       visible    timeout=10s
      Get Text      ${LOCATOR_CURRENT_PAGENAME}     contains      ${pagename}


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

Alert Warning Notify state should be
      [Arguments]     ${state}    ${locator_notify}
      Wait For Elements State          ${locator_notify}         ${state}        timeout=20

Warning Notify should contain message
   [Arguments]    ${locator_notify}      ${expvalue}
      Wait For Elements State           ${locator_notify}        visible        timeout=20
      Get Text      ${locator_notify}    contains       ${expvalue}

#--------------------- Keywords : Fill data or form ---------------------#
Fill in search field on list page
    [Arguments]    ${locator_field}     ${keyword}     ${sel_attr}=label
      ${TAGNAME}=       Get Property        ${locator_field}        tagName

      Run Keyword If    '${TAGNAME}'=='INPUT'
      ...                Fill Text          ${locator_field}        ${keyword}
      ...    ELSE IF    '${TAGNAME}'=='SELECT'
      ...                Select Options By          ${locator_field}         ${sel_attr}         ${keyword}
      ...       ELSE     Fail     Check condition keyword 'Fill in search field in list page' !!

Fill in data form
    [Arguments]    ${locator_field}     ${value}      ${sel_attr}=label
      ${TAGNAME}=     Get Property               ${locator_field}          tagName
      ${TYPE_VAL}=    Get Property               ${locator_field}          type

      IF    '${TAGNAME}' in ['INPUT','TEXTAREA'] and '${TYPE_VAL}' not in ['checkbox','radio']
          Fill Text     ${locator_field}      ${value}

      ELSE IF   '${TAGNAME}'=='SELECT'
          # Wait Until Network Is Idle    timeout=20s
          # Wait For Elements State       ${locator_field}      stable        timeout=10
          Sleep   500ms
          Click   ${locator_field}
          # Get Select Options            ${locator_field}      validate  any(v["${sel_attr}"] == "${value}" for v in value)
          Wait Until Keyword Succeeds    10s   500ms      Select Options By      ${locator_field}      ${sel_attr}     ${value}

      ELSE IF   '${TYPE_VAL}'=='checkbox' and '${value}'=='check' or '${value}'=='True'
          Click       ${locator_field}
          Get Checkbox State     ${locator_field}    should be      True

      ELSE IF   '${TYPE_VAL}'=='checkbox' and '${value}'=='uncheck' or '${value}'=='False'
          Get Checkbox State     ${locator_field}    should be      False

      ELSE IF   '${TYPE_VAL}'=='radio'
          Click    ${locator_field}
          Get Checkbox State     ${locator_field}    should be      True

      ELSE
          Fail    Check condition keyword 'Fill in data form' !!
      END

Fill in autocomplete data form
    [Arguments]    ${locator_field}     ${value}
      Type Text    ${locator_field}     ${value}
      Sleep    2s
      Keyboard Key     press      Enter

Clear field data form
    [Arguments]    ${locator_field}
      ${TAGNAME}=     Get Property               ${locator_field}          tagName
      ${TYPE_VAL}=    Get Property               ${locator_field}          type

      IF    '${TAGNAME}' in ['INPUT','TEXTAREA'] and '${TYPE_VAL}' not in ['checkbox','radio']
          Clear Text      ${locator_field}
          Get Text    ${locator_field}   should be     ${EMPTY}

      ELSE IF   '${TAGNAME}'=='SELECT'
          Get default value select type    ${locator_field}
          Select Options By      ${locator_field}      value     ${EMPTY}
          ${select_none}=    Get Selected Options   ${locator_field}      value     
          Should Be True    '${select_none}'=='[]'


      ELSE IF   '${TYPE_VAL}'=='checkbox'
          # Get locator for attribute checkbox field     ${locator_field}
          Uncheck Checkbox       ${locator_field}
          Get Checkbox State     ${locator_field}    should be      False

      ELSE
          Fail    Check condition keyword 'Fill in data form' !!
      END

Get locator for attribute checkbox field
    [Arguments]   ${locator_field}
      ${checkbox_for_attr}=       Get Attribute         ${locator_field}      value
      Set Suite Variable          ${checkbox_for_attr}

Get default value select type
    [Arguments]     ${locator_field}
      @{all_values}=                Get Select Options    ${locator_field}
      ${default_selectedvalue}=     Set Variable          ${all_values}[0][label]
      Set Suite Variable            ${default_selectedvalue}

#--------------------- Keywords : Assertion and Get Data ---------------------#
Verify data form
    [Arguments]    ${locator_field}     ${assertion}    ${exp_value}    ${sel_attr}=label
      ${TAGNAME}=     Get Property    ${locator_field}    tagName

      Run Keyword If    '${TAGNAME}'=='INPUT'
      ...                Check Type data field    ${locator_field}
      ...       ELSE     Set Suite Variable       ${TYPE_VAL}         text

      IF  '${TAGNAME}' in ['INPUT','SPAN','H1','H2','H3','H4','H5','H6','DIV','TEXTAREA'] and '${TYPE_VAL}' not in ['radio','checkbox']
            ${GLOBAL_RETURNDATA_VALUE}=     Get Text    ${locator_field}    ${assertion}    ${exp_value}

      ELSE IF   '${TAGNAME}'=='SELECT'
            wait until keyword succeeds   40 seconds  2 seconds    Get Select Options      ${locator_field}      validate  any(v["${sel_attr}"] == "${exp_value}" for v in value)
            ${GLOBAL_RETURNDATA_VALUE}=   Get Selected Options             ${locator_field}    ${sel_attr}     ${assertion}       ${exp_value}

      ELSE IF   '${TYPE_VAL}' in ['radio','checkbox']
          IF  '${TYPE_VAL}'=='checkbox' and '${exp_value}' in ['check','True']
              ${GLOBAL_RETURNDATA_VALUE}=     Get Checkbox State     ${locator_field}    ${assertion}    True
          ELSE IF  '${TYPE_VAL}'=='checkbox' and '${exp_value}' in ['uncheck','False']
              ${GLOBAL_RETURNDATA_VALUE}=     Get Checkbox State     ${locator_field}    ${assertion}    False
          END

      ELSE
          Fail    Check condition keyword 'Verify data form is correct' !!
      END

      Set Global Variable      ${GLOBAL_RETURNDATA_VALUE}


Verify Warning message field
      [Arguments]    ${locator_field}    ${assertion}      ${expectedmsg}
         Get Text    ${locator_field}     ${assertion}     ${expectedmsg}

Verify Warning message modal
      [Arguments]   ${exp_warnmessage}
        Verify Modal Title message      Error
        Verify Modal Content message    ${exp_warnmessage}
        Click OK Button

Verify Field State
   [Arguments]    ${locator_field}    ${state}    ${timeout}=5s
      Wait For Elements State         ${locator_field}        ${state}        timeout=${timeout}

Verify Button State
   [Arguments]    ${locator_field}     ${state}
      Wait For Elements State          ${locator_field}       ${state}        timeout=5s

#--------------------- Handle Data Table ----------------------#

#--------------------------------------------------------------------------------------------------------------------------------------------------#
#  Get row entries of Data Table   >> Keyword for get row of table >> using locator tbody ex. //*[@id="gmnl-items-list"]/tbody"                    #
#--------------------------------------------------------------------------------------------------------------------------------------------------#

Get row entries of Data Table
    [Arguments]     ${locator_tbody}      ${msg_norecord}=${VAR_DEFAULT_NORECORDFOUND}

      Wait For Elements State    ${locator_tbody}/tr[1]       visible       timeout=3s
      ${IS_NORECORD}=       Run Keyword And Return Status       Get Text      ${locator_tbody}/tr[1]/td[1]       inequal      ${msg_norecord}

      IF  '${IS_NORECORD}'=='True'
            ${GLOBAL_ROWRESULT_DATA_TABLE}=       Get Element Count       ${locator_tbody}/tr
            Set Global Variable     ${GLOBAL_ROWRESULT_DATA_TABLE}

            ${GLOBAL_ENTRIES_RESULTOFPAGE}=       Set Variable If    ${GLOBAL_ROWRESULT_DATA_TABLE} > ${VAR_DEFAULTPAGING}    ${VAR_DEFAULTPAGING}     ${GLOBAL_ROWRESULT_DATA_TABLE}
            Set Global Variable     ${GLOBAL_ENTRIES_RESULTOFPAGE}
      ELSE
            Set Global Variable     ${GLOBAL_ENTRIES_RESULTOFPAGE}          0
            Log To Console    \nCannot get row entries: ${msg_norecord}
      END


Get Column of Data Table
    [Arguments]    ${locator_thead}

      ${column_datatable}=      Get Element Count        ${locator_thead}/tr/th

      Set local Variable     &{col_datatable}      &{EMPTY}
      FOR   ${key}    IN RANGE    ${column_datatable}

            ${key}=           Evaluate                 ${key}+1
            ${columnname}=    Get Text                 ${locator_thead}/tr/th[${key}]
            ${columnname}=    Remove String            ${columnname}        ${EMPTY}      ${SPACE}
            ${columnname}=    Convert To Lower Case    ${columnname}
            Set To Dictionary     ${col_datatable}     ${columnname}=${key}
      END

      Set Global Variable     ${col_datatable}


Verify column of data table result
    [Arguments]     ${locator_field}   ${assertion}      ${expresult}

      ${TAGNAME}=     Get Property    ${locator_field}    tagName

      Run Keyword If    '${TAGNAME}'=='INPUT'     Check Type data field    ${locator_field}
      ...       ELSE     Set Suite Variable       ${TYPE_VAL}       text

      Wait For Elements State           ${locator_field}      visible          timeout=5s

      IF   '${TYPE_VAL}' in ['radio','checkbox']
            ${GLOBAL_RETURNDATA_COLUMN}=    Get Checkbox State     ${locator_field}    ${assertion}      ${expresult}
      ELSE
            ${GLOBAL_RETURNDATA_COLUMN}=    Get Text               ${locator_field}    ${assertion}      ${expresult}
      END

      Set Global Variable      ${GLOBAL_RETURNDATA_COLUMN}


verify result data table on list page
    [Arguments]      ${locator_tbody}      ${column_index}     ${assertion}      ${expected_data}    ${rowdata}=all     ${ignore_case}=false
      Sleep   500ms
      ${is_record_no_data}=        Run Keyword And Return Status    Get Text    ${locator_tbody}/tr[1]/td[1]      inequal       ${VAR_DEFAULT_NORECORDFOUND}

      Run Keyword If    '${is_record_no_data}'=='True'    Get row entries of Data Table     ${locator_tbody}
      ...       ELSE    Fail    No records found, please check data table.
      ...                       \nIf you want to verify no record found.
      ...                       Use Keyword : 'Verify data table result is No Record Found'

      @{GLOBAL_RETURNDATA_RESULT}=    Create List
      FOR     ${index}    IN RANGE      1         ${GLOBAL_ENTRIES_RESULTOFPAGE}+1
          IF   '${ignore_case}'=='false'
              IF   '${rowdata}'=='all'
                    ${return_val}=      Get Text      ${locator_tbody}/tr[${index}]/td[${column_index}]       ${assertion}         ${expected_data}
              ELSE
                    ${return_val}=      Get Text      ${locator_tbody}/tr[${rowdata}]/td[${column_index}]     ${assertion}         ${expected_data}
              END
                Insert Into List    ${GLOBAL_RETURNDATA_RESULT}    ${index}     ${return_val}

          ELSE IF   '${ignore_case}'=='true'
                IF   '${rowdata}'=='all'
                    ${return_val}=      Get Text      ${locator_tbody}/tr[${index}]/td[${column_index}]
                ELSE
                    ${return_val}=      Get Text      ${locator_tbody}/tr[${rowdata}]/td[${column_index}]
                END
                Insert Into List    ${GLOBAL_RETURNDATA_RESULT}    ${index}     ${return_val}

                Convert Data to lower or upper case       lower                   ${expected_data}
                Set Local Variable    ${expected_val}     ${GLOBAL_DATACONVERT}
                Convert Data to lower or upper case       lower                   ${return_val}
                Set Local Variable    ${actual_val}       ${GLOBAL_DATACONVERT}
                Should Contain        ${actual_val}       ${expected_val}         ignore_case=True
          ELSE
                Fail    \nPlease check ignore case should be any 'true' or 'false'.
          END
      END

      Set Global Variable      @{GLOBAL_RETURNDATA_RESULT}


Verify data table result is No Record Found
    [Arguments]     ${locator_tbody}      ${msg_norecord}=No records found
      Wait For Elements State    ${locator_tbody}/tr[1]/td[1]       visible       timeout=5s
      Wait Until Keyword Succeeds    30s   500ms       Get Text     ${locator_tbody}/tr[1]/td[1]       contains      ${msg_norecord}


Get Index Row for data table
    [Arguments]   ${locator_tbody}    ${column_index}     ${data_compare}

      Sleep   500ms
      ${is_record_no_data}=        Run Keyword And Return Status    Get Text    ${locator_tbody}/tr[1]/td[1]      should be       ${VAR_DEFAULT_NORECORDFOUND}

      Run Keyword If    '${is_record_no_data}'=='False'    Get row entries of Data Table     ${locator_tbody}
      ...       ELSE    Fail    No records found, please check data table.
      ...                       \nIf you want to verify no record found.
      ...                       Use Keyword : 'Verify data table result is No Record Found'

      FOR    ${index}     IN RANGE    1      ${GLOBAL_ENTRIES_RESULTOFPAGE}+1
         ${INDEXITEM}=          Set Variable    ${index}
         Set Suite Variable     ${INDEXITEM}
         ${getdata}=          Get Text    ${locator_tbody}/tr[${index}]/td[${column_index}]
         ${data_is_true}=     Should Be True     '${getdata}'=='${data_compare}'
         Exit For Loop If     '${data_is_true}'=='True'
      END

      Set Global Variable     ${GLOBAL_INDEXROWITEM}       ${INDEXITEM}

Check Type data field
    [Arguments]   ${locator_field}
      ${TYPE_VAL}=          Get Property           ${locator_field}          type
      Set Suite Variable     ${TYPE_VAL}


#--------------------- Keywords : Action ---------------------#
Click Expand Search Criteria
      ${criteria_is_hidden}=        Run Keyword And Return Status     Wait For Elements State     ${LOCATOR_SEARCH_CRITERIA_VISIBLE}       hidden       timeout=5s
      IF    '${criteria_is_hidden}'=='True'
           ${button_notfound}=    Run Keyword And Return Status       Wait For Elements State      ${LOCATOR_SERACH_CRITERIA_BTN}       hidden       timeout=2s   
           IF  '${button_notfound}'=='True' 
               Click    ${LOCATOR_SEARCH_EXPAND}  
           ELSE
               Log      Not Found Show/Hide Search Criteria.
           END
      ELSE    
            Log      Search criteria is already expand!
      END

Click Hide Search Criteria
      ${criteria_is_visible}=        Run Keyword And Return Status       Wait For Elements State      ${LOCATOR_SEARCH_CRITERIA_VISIBLE}       visible       timeout=5s
      IF    '${criteria_is_visible}'=='True'
              ${button_found}=    Run Keyword And Return Status       Wait For Elements State      ${LOCATOR_SERACH_CRITERIA_BTN}       visible       timeout=2s
              IF  '${button_found}'=='True' 
                  Click    ${LOCATOR_SERACH_CRITERIA_BTN}
              ELSE
                  Log      Not Found Show/Hide Search Criteria.
              END
      ELSE    
              Log      Search criteria already hidden!
      END
Click button on list page
     [Arguments]    ${locator_field}
      Click     ${locator_field}

Click button on detail page
     [Arguments]    ${locator_field}
      Click     ${locator_field}

Click xClose button
     [Arguments]    ${locator_field}
      Click     ${locator_field}

Click Upload Button
    [Arguments]   ${locator_uploadfile}
      Click     ${locator_uploadfile}

Choose file to upload
   [Arguments]       ${locator_choosefile}    ${pathfile}
      Wait For Elements State    ${locator_choosefile}       attached       timeout=60s
      Upload File By Selector    ${locator_choosefile}       ${pathfile}

Download data and save file to download folder
    [Arguments]     ${locator_download_btn}
         ${dl_promise}        Promise To Wait For Download
         Click    ${locator_download_btn}

         ${file_obj}=           Wait For    ${dl_promise}
         File Should Exist      ${file_obj}[saveAs]

         Create Directory       ${EXECDIR}${/}testsuite${/}_download_file
         Empty Directory        ${EXECDIR}${/}testsuite${/}_download_file
         Move File              ${file_obj}[saveAs]      ${EXECDIR}${/}testsuite${/}_download_file

         ${filename}=           List Files In Directory    ${EXECDIR}${/}testsuite${/}_download_file

         Move File              ${EXECDIR}${/}testsuite${/}_download_file${/}${filename}[0]      ${EXECDIR}${/}testsuite${/}_download_file${/}${file_obj.suggestedFilename}

         Set Global Variable    ${GLOBAL_PATHFILE}      ${EXECDIR}${/}testsuite${/}_download_file${/}${file_obj.suggestedFilename}
         Set Global Variable    ${GLOBAL_PATHDIR}       ${EXECDIR}${/}testsuite${/}_download_file

Clear Directory download file
    [Arguments]     ${pathdir}
         Empty Directory      ${pathdir}
         Remove Directory     ${pathdir}


#--------------------- Keywords : Handle javascript alert dialog ---------------------#
Click Button and Handle confirmation alert
    [Arguments]     ${locator}        ${action}
      Run Keyword If    '${action}'=='OK'
      ...                Handle Future Dialogs      action=accept
      ...    ELSE IF    '${action}'=='Cancel'
      ...                Handle Future Dialogs      action=dismiss
      ...       ELSE    Fail    Check Argument action should be 'OK' or 'Cancel'

      Click             ${locator}

Click Button and Verify message alert dialog
    [Arguments]   ${locator}      ${text}

      ${promise} =       Promise To    Wait For Alert    action=accept    text=${text}
      Click              ${locator}
      ${text} =          Wait For      ${promise}

Click Button and Get message alert dialog
    [Arguments]   ${locator}
      ${promise}=       Promise To    Wait For Alert    action=accept
      Click             ${locator}
      ${GLOBAL_ALERTMSG}=          Wait For      ${promise}

      Set Global Variable     ${GLOBAL_ALERTMSG}

#--------------------- Keywords : Paging Function ---------------------#
Get data paging entries of Data Table
   [Arguments]    ${locator}
      ${get_entriespage}=     Get Text             ${locator}
      ${pattern} =            Set Variable          \\d+   # Regular expression pattern to match numbers
      ${matches_entries} =    Get Regexp Matches    ${get_entriespage}    ${pattern}
      
      Set Global Variable     ${GLOBAL_SHOWING_PAGE}                ${matches_entries[0]} 
      Set Global Variable     ${GLOBAL_SHOWINGPAGE_OF_ENTRIES}      ${matches_entries[1]} 
      Set Global Variable     ${GLOBAL_TOTALENTRIES}                ${matches_entries[2]} 


Page Link of Data Table is visible
    [Arguments]   ${totalpage}
      FOR  ${index}  IN RANGE  1    ${totalpage}+1
           ${indexpage}=    Convert To String    ${index}
           ${LOCATOR_SHOWINGPAGE_LINK}=    Replace String    ${LOCATOR_SHOWINGPAGE_LINK}    ::PAGENUM::    ${indexpage}
           Wait For Elements State         ${LOCATOR_SHOWINGPAGE_LINK}      visible        timeout=20
      END

Page Link of Data Table is Active
      [Arguments]   ${pagenum}
        Wait For Elements State          ${LOCATOR_PAGINGNUM_ACTIVE}       visible        timeout=20
        ${pageactive}=     Get Text      ${LOCATOR_PAGINGNUM_ACTIVE}
        Should Be True   '${pageactive}'=='${pagenum}'

Click page number link
      [Arguments]   ${pagenum}
        ${LOCATOR_SHOWINGPAGE_LINK}=    Replace String    ${LOCATOR_SHOWINGPAGE_LINK}    ::PAGENUM::    ${pagenum}
        Click     ${LOCATOR_SHOWINGPAGE_LINK}
        Wait For Elements State          ${LOCATOR_PAGINGNUM_ACTIVE}       visible        timeout=20
        ${pageactive}=     Get Text      ${LOCATOR_PAGINGNUM_ACTIVE}
        Should Be True   '${pageactive}'=='${pagenum}'

Choose Showing Page
      [Arguments]   ${locator}    ${amount}
        Select Options By        ${locator}     value            ${amount}

Verify default showing page
      [Arguments]   ${locator}    ${amount}
        Get Selected Options     ${locator}    value   ==    ${amount}
        