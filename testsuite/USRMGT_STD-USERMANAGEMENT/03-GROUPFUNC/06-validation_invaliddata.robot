*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               datasources.Import DataSource COMPANY INFO DATA
...               AND               datasources.Import DataSource GROUP INFO DATA
...               AND               datasources.Import DataSource ROLE INFO DATA
...               AND               commonkeywords.Generate Random Values    lengthno=3    lenghtletter=3
...               AND               Set Suite Variable    ${default_companygroup}         ${JS_DEFAULTDATA['companydata'][1]}[companyname]    
...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               defaultdatalist.Create List Data Test Default Role Value
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[groupMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[groupMgt]
...               AND               Set Data Company for Role Not Found Case
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
    
Test Setup        Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Click button on list page    ${LOCATOR_ADDGROUP_BTN}
...               AND               commonkeywords.Verify Page Name is correct    Add Group
...               AND               commonkeywords.Wait Loading progress
...               AND               Sleep    500ms

Test template     Template Validate Group field exception case

Test Teardown     Run Keywords       Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND                commonkeywords.Click xClose button    ${LOCATOR_XCLOSEGROUP_BTN}

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser


*** Test Cases ***
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
#                    CASE                       |              Group company          |     Group name     | State Unlimit user |     Limit User    |           Role name         |    Approval    |          Group APPROVAL       |                                                         Expected Warning                                                                    #
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

CASE-EMPTY ALL FIELD                               Please Select                          ${EMPTY}                 uncheck              ${EMPTY}         ${EMPTY}                        No               Please Select               groupcom=${GROUP_REQUIREWARNMSG}[company]     groupname=${GROUP_REQUIREWARNMSG}[groupName]     groupusrlimit=${GROUP_REQUIREWARNMSG}[limitUser]                                                                                                                                                                                                                                  appv=${GROUP_REQUIREWARNMSG}[approval]        groupapproval=${GROUP_REQUIREWARNMSG}[groupappv]
CASE-EMPTY GROUP COMPANY                           Please Select                          XXXXGROUPXXXX            uncheck              10               ${EMPTY}                        No               Please Select               groupcom=${GROUP_REQUIREWARNMSG}[company]
CASE-EMPTY GROUP NAME                              ${default_companygroup}                ${EMPTY}                 uncheck              10               ${GLOBAL_DEFAULTROLE_LIST}[0]   No               Please Select               groupname=${GROUP_REQUIREWARNMSG}[groupName]
CASE-EMPTY LIMIT USER                              ${default_companygroup}                XXXXGROUPXXXX            uncheck              ${EMPTY}         ${GLOBAL_DEFAULTROLE_LIST}[0]   No               Please Select               groupusrlimit=${GROUP_REQUIREWARNMSG}[limitUser]
CASE-EMPTY ROLE GROUP                              ${default_companygroup}                XXXXGROUPXXXX            uncheck              10               ${EMPTY}                        No               Please Select               grouprole=${GROUP_REQUIREWARNMSG}[role]
CASE-EMPTY APPROVAL                                ${default_companygroup}                XXXXGROUPXXXX            uncheck              10               ${GLOBAL_DEFAULTROLE_LIST}[0]   Please Select    Please Select               appv=${GROUP_REQUIREWARNMSG}[approval]
CASE-EMPTY GROUP APPROVAL                          ${default_companygroup}                XXXXGROUPXXXX            uncheck              10               ${GLOBAL_DEFAULTROLE_LIST}[0]   Yes              Please Select               groupapproval=${GROUP_REQUIREWARNMSG}[groupappv]
CASE-ROLE NOT FOUND (IE5DEV CASE)                  xxxrole01 company Limited              XXXXGROUPXXXX            uncheck              10               ${EMPTY}                        No               Please Select               grouprole=${GROUP_ROLENOTFOUND_WARNMSG}

*** Keywords ***
Template Validate Group field exception case
   [Arguments]    ${groupcomvalue}     ${groupnamevalue}    ${stateunlimituser}     ${limituser}     ${rolename}    ${appoval}    ${groupappv}    &{warnmsg}

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
      Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='STANDARD' and '${groupcomvalue}'=='xxxrole01 company Limited'      \nExecute Test For User Management IE5DEV Version
    
      commonkeywords.Fill in data form    ${LOCATOR_GROUPCOMPANY_SEL}             ${groupcomvalue}
      commonkeywords.Fill in data form    ${LOCATOR_GROUPNAME_FIELD}              ${groupnamevalue}

      IF   '${stateunlimituser}'=='check'
          commonkeywords.Verify data form    ${LOCATOR_GROUPLIMITUSER_FIELD}    should be     ${limituser}
      ELSE IF  '${stateunlimituser}'=='uncheck'
          commonkeywords.Fill in data form   ${LOCATOR_GROUPLIMITUSER_FIELD}    ${limituser}
      ELSE
          Fail    \nPlease check 'stateunlimituser' should any check or uncheck.
      END

    #   commonkeywords.Fill in data form    ${LOCATOR_GROUPAPPROVAL_FIELD}         ${appoval}
    #   commonkeywords.Fill in data form    ${LOCATOR_GROUP_GROUPAPPV_FIELD}       ${groupappv}

      IF  '${rolename}'!='' and '${groupcomvalue}'!='Please Select'
          PageGroupMgt.Check checkbox role group    ${rolename}
      END

      commonkeywords.Click button on detail page    ${LOCATOR_GROUPSAVE_BTN}


      IF   '${groupcomvalue}'=='Please Select'
              commonkeywords.Verify Warning message field     ${LOCATOR_WARN_GROUPCOMPANY}      contains    ${warnmsg}[groupcom]
              Log To Console      \nTEST CASE VERIFIED.
      END
      IF   '${groupnamevalue}'==''
              commonkeywords.Verify Warning message field     ${LOCATOR_WARN_GROUPNAME}         contains    ${warnmsg}[groupname]
              Log To Console      \nTEST CASE VERIFIED.
      END
      IF   '${limituser}'==''
              commonkeywords.Verify Warning message field     ${LOCATOR_WARN_GROUPLIMITUSER}    contains    ${warnmsg}[groupusrlimit]
              Log To Console      \nTEST CASE VERIFIED.
      END
      IF   '${appoval}'=='Please Select'
              commonkeywords.Verify Warning message field     ${LOCATOR_WARN_GROUPAPPVAL}       contains    ${warnmsg}[appv]
              Log To Console      \nTEST CASE VERIFIED.
      END
      IF   '${appoval}'=='Yes' and '${groupappv}'=='Please Select'
              commonkeywords.Verify Warning message field    ${LOCATOR_WARN_GROUP_GROUPAPPV}    contains    ${warnmsg}[groupapproval]
              Log To Console      \nTEST CASE VERIFIED.
      END

      IF   '${rolename}'=='' or '${groupcomvalue}'=='xxxrole01 company Limited'
          IF  '${groupcomvalue}'!='Please Select'
              commonkeywords.Verify Warning message field    ${LOCATOR_WARN_GROUPROLE}    contains    ${warnmsg}[grouprole]
          END
              Log To Console      \nTEST CASE VERIFIED.
      END

Set Data Company for Role Not Found Case
        IF   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
            service-ctypemgt.Request Service Get Company Type Info    ${DS_LOGIN['robotapi'][${login_col.username}]}    ${DS_LOGIN['robotapi'][${login_col.password}]}    ${JS_DEFAULTDATA['ctypedata'][0]}[ctypename]
            service-companymgt.Request Service Add Default Company data test
            ...     headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}    headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
            ...     registype=1
            ...     ctypeid=${GLOBAL_CTYPEID_DATA}
            ...     cname=xxxrole01 company Limited    ctaxid=0980001977110    cbranch=00000    cemail=ctypenotfoundrole01@robot.com
            ...     limittrypwd=-1    limitusr=-1    pwdexpire=-1    limitrepeatpwd=-1   idlesession=60    limitsession=60
        END
