*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource COMPANY INFO DATA
...               AND               datasources.Import DataSource ADDRESS DATA
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.  
...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[companyMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[companyMgt]

Test Setup        Run Keywords      commonkeywords.Generate Random Values    3    3
...               AND               commonkeywords.Generate Random Number    8
...               AND               Set Suite Variable    ${companyname}                ${DS_COMPANY['createnewcom1'][${company_col.companyName}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${companytaxid}               ${DS_COMPANY['createnewcom1'][${company_col.taxid}]}${GLOBAL_GENNUMBER}
...               AND               Set Suite Variable    ${companyemail}               ${DS_COMPANY['createnewcom1'][${company_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@mail.com
...               AND               Set Suite Variable    ${companytypestd}             ${COMTYPE_ID}[officer]
...               AND               Set Suite Variable    ${companytypenew}             ${JS_DEFAULTDATA['ctypedata'][0]}[ctypename]
...               AND               Set Company Type Value Data
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.  
...               AND               service-companymgt.Request Service Create New Company
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     registype=${COMREGISTYPE_ID}[legal]     ctypeid=${companytype_val}
...                                     cname=${companyname}      ctaxid=${companytaxid}     cbranch=00000    cemail=${companyemail}
...                                     limittrypwd=5             limitusr=10                pwdexpire=10     limitrepeatpwd=5          idlesession=120     limitsession=180
...               AND              service-companymgt.Request Service Update Company Status
...                                     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                     comname=${companyname}
...                                     status=true

Test Template     Template Change Status Company is success

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
#-----------------------------------------------------------------------------------------------------#
#                 CASE                  |   Company Name  |     Confirm?     |     Expected Status    #
#-----------------------------------------------------------------------------------------------------#
CASE1-Change status ACTIVE to INACTIVE    ${companyname}         Yes                 Inactive
CASE2-Change status INACTIVE to ACTIVE    ${companyname}         Yes                 Active
CASE3-Cancel to change status             ${companyname}         No                  Active

*** Keywords ***
Set Company Type Value Data
      IF  '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
            Set Suite Variable    ${companytype_val}      ${companytypestd}
      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
            service-ctypemgt.Request Service Get Company Type Info    ${DS_LOGIN['robotapi'][${login_col.username}]}    ${DS_LOGIN['robotapi'][${login_col.password}]}    ${companytypenew}
            Set Suite Variable    ${companytype_val}      ${GLOBAL_CTYPEID_DATA}
      ELSE
          Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'STANDARD' or 'IE5DEV'
      END

Template Change Status Company is success
    [Arguments]       ${comname}      ${is_confirm}       ${expectedstatus}

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.

      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYCOM_SEL}        ${COMSEARCHBY}[comname]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHCOM_KEYWORD}      ${comname}
      commonkeywords.Click button on list page            ${LOCATOR_SEARCHCOM_BTN}
      commonkeywords.Click Hide Search Criteria
      commonkeywords.Wait Loading progress

      pageCompanyMgt.Verify Company Result Datatable    1    companyname    contains    ${comname}

      IF  '${expectedstatus}'=='Active' and '${is_confirm}'=='Yes'
            commonkeywords.Click button on list page    ${1ROW_COMPANY_ACTION}[changeStatus]
            commonkeywords.Click Yes Button for confirm
            commonkeywords.Click OK Button
            commonkeywords.Click Expand Search Criteria
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYCOM_SEL}        ${COMSEARCHBY}[comname]
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHCOM_KEYWORD}      ${comname}
            commonkeywords.Click button on list page            ${LOCATOR_SEARCHCOM_BTN}
            commonkeywords.Click Hide Search Criteria
            commonkeywords.Wait Loading progress
            pageCompanyMgt.Verify Company Result Datatable    1    status    should be    Inactive
      END

      commonkeywords.Click button on list page       ${1ROW_COMPANY_ACTION}[changeStatus]
      commonkeywords.Verify Modal Title message      Warning
      commonkeywords.Verify Modal Content message    Are you sure you want to change this company status?

      IF   '${is_confirm}'=='Yes'
          commonkeywords.Click Yes Button for confirm
          commonkeywords.Click OK Button
          commonkeywords.Click Expand Search Criteria
          commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYCOM_SEL}        ${COMSEARCHBY}[comname]
          commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHCOM_KEYWORD}      ${comname}
          commonkeywords.Click button on list page            ${LOCATOR_SEARCHCOM_BTN}
          commonkeywords.Click Hide Search Criteria
          commonkeywords.Wait Loading progress
          pageCompanyMgt.Verify Company Result Datatable    1    status    should be    ${expectedstatus}
          Log To Console      \nTEST CASE VERIFIED. - Confirm to change status
      ELSE
          commonkeywords.Click No Button for Cancel
          commonkeywords.Click Expand Search Criteria
          commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYCOM_SEL}        ${COMSEARCHBY}[comname]
          commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHCOM_KEYWORD}      ${comname}
          commonkeywords.Click button on list page            ${LOCATOR_SEARCHCOM_BTN}
          commonkeywords.Click Hide Search Criteria
          commonkeywords.Wait Loading progress
          pageCompanyMgt.Verify Company Result Datatable    1    status    should be    ${expectedstatus}
          Log To Console      \nTEST CASE VERIFIED. - Cancel to change status
      END
