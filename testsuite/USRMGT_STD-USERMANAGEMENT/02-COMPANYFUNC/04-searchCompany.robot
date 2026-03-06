*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource COMPANY INFO DATA
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               Set Suite Variable    ${companytypestd}             ${COMTYPE}[netbay]
...               AND               Set Suite Variable    ${companytypenew}             ${JS_DEFAULTDATA['ctypedata'][0]}[ctypename]
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[companyMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[companyMgt]

...               AND               pageCompanyMgt.Service Create New Company Data Test
...                                        headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}    amountdata=5
...               AND               commonkeywords.Click Expand Search Criteria

Test Template     Template Company Search Function

Test Teardown     Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Click button on list page     ${LOCATOR_CLEARSEARCHCOM_BTN}

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
#--------------------------------------------------------------------------------------------------------------------------------------------#
#                             CASE NAME                         |  Type   |        Search By        |            Search Keyword              #
#--------------------------------------------------------------------------------------------------------------------------------------------#

CASE-Search by company type (STD)                                    P         ${COMSEARCHBY}[comtype]            ${companytypestd}
CASE-Search by company type (IE5DEV)                                 P         ${COMSEARCHBY}[comtype]            ${companytypenew}
CASE-Search by company name > Full Search                            P         ${COMSEARCHBY}[comname]            ${DS_COMPANY['data2'][${company_col.companyName}]}
CASE-Search by company name > Partail Search (Start wording)         P         ${COMSEARCHBY}[comname]            บริษัทดับเบิลเอ็กซ์
CASE-Search by company name > Partail Search (Middle wording)        E         ${COMSEARCHBY}[comname]            เอ็กซ์เอ็กซ์ซีโร่
CASE-Search by company name > Partail Search (Last wording)          E         ${COMSEARCHBY}[comname]            XBOT AUTO COMPANY

*** Keywords ***
Template Company Search Function
      [Arguments]    ${casetype}      ${searchby}    ${searchkeyword}
      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
      
      IF  '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
          IF  '${searchkeyword}'=='${companytypenew}'
            Pass Execution    \nTest Cases for User Standard Version IE5DEV Version
          ELSE
              commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYCOM_SEL}          ${searchby}
              commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHCOM_KEYWORD}        ${searchkeyword}
              commonkeywords.Click button on list page            ${LOCATOR_SEARCHCOM_BTN}
              commonkeywords.Wait Loading progress
              Sleep    750ms
              commonkeywords.Wait Loading progress
              pageCompanyMgt.Verify Company Result Data Table for search function     ${casetype}    ${searchby}     ${searchkeyword}
          END
      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
          IF  '${searchkeyword}'=='${companytypestd}'
            Pass Execution    \nTest Cases for User Standard Version STANDARD Version
          ELSE
              commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYCOM_SEL}          ${searchby}
              commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHCOM_KEYWORD}        ${searchkeyword}
              commonkeywords.Click button on list page            ${LOCATOR_SEARCHCOM_BTN}
              commonkeywords.Wait Loading progress
              Sleep    750ms
              commonkeywords.Wait Loading progress
              pageCompanyMgt.Verify Company Result Data Table for search function     ${casetype}    ${searchby}     ${searchkeyword}
          END
      ELSE
          Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'STANDARD' or 'IE5DEV'
      END
