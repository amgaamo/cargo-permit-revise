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
...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               defaultdatalist.Create List Data Test Default Role Value
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[groupMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[groupMgt]

Test Setup        Run Keywords      commonkeywords.Generate Random Values    lengthno=3    lenghtletter=3
...               AND               Set suite Variable    ${default_companygroup}         ${JS_DEFAULTDATA['companydata'][1]}[companyname]
...               AND               Set suite Variable    ${default_companygroup2}        ${JS_DEFAULTDATA['companydata'][2]}[companyname]
...               AND               Set suite Variable    ${groupnewname}                 ${DS_GROUP['createnew'][${group_col.groupname}]}${GLOBAL_RANDOMLETTER}${SPACE}${GLOBAL_RANDOMNO}

...               AND               Set suite Variable    ${default_companygroup}         ${JS_DEFAULTDATA['companydata'][1]}[companyname]
...               AND               Set suite Variable    ${default_adminrole01}          ${JS_DEFAULTDATA['roledata'][0]}[rolename]
...               AND               Set suite Variable    ${default_adminrole02}          ${JS_DEFAULTDATA['roledata'][1]}[rolename]
...               AND               Set suite Variable    ${default_supportrole}          ${JS_DEFAULTDATA['roledata'][2]}[rolename]
...               AND               Set suite Variable    ${default_custrole}             ${JS_DEFAULTDATA['roledata'][3]}[rolename]
...               AND               Set suite Variable    ${custadmin_robotrole}          ${JS_DEFAULTDATA['roledata'][5]}[rolename]
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               service-groupmgt.Request Service Create New Group
...                                             ${DS_LOGIN['robotapi'][${login_col.username}]}        ${DS_LOGIN['robotapi'][${login_col.password}]}
...                                             ${default_companygroup}
...                                             ${groupnewname}
...                                             ${DS_GROUP['createnew'][${group_col.limituser}]}
...                                             true    false     ${EMPTY}
...                                             ${default_adminrole01}   ${default_adminrole02}   ${default_custrole}

Test template     Template Edit Group is success

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser

*** Test Cases ***
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ #
#                CASE NAME                 | CASE TYPE |                GROUP COMPANY               |         GROUP NAME    |                   State Check Limit user                       |                Role Group                          #
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------#

CASE-Edit Group Info Data                  caseField        ${default_companygroup2}                      ${groupnewname}         uncheck     ${DS_GROUP['editgroup'][${group_col.limituser}]}           ${custadmin_robotrole}
CASE-Edit Check more Role Group            caseChecked      ${default_companygroup}                       ${groupnewname}         uncheck     ${DS_GROUP['editgroup'][${group_col.limituser}]}           ${default_supportrole}
CASE-Edit Uncheck Role Group               caseUnchecked    ${default_companygroup}                       ${groupnewname}         uncheck     ${DS_GROUP['editgroup'][${group_col.limituser}]}           ${default_adminrole01}
CASE-Edit Check Unlimit user               caseField        ${default_companygroup2}                      ${groupnewname}         check       -1                                                         ${custadmin_robotrole}


*** Keywords ***
Template Edit Group is success
   [Arguments]    ${caseType}    ${groupcomvalue}           ${groupnamevalue}        ${stateunlimituser}      ${limituser}     ${rolegroup}

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
      
      commonkeywords.Wait Loading progress
      commonkeywords.Verify Page Name is correct    Group Management
      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYGROUP_SEL}         ${GROUPSEARCHBY}[groupname]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHGROUP_KEYWORD}       ${groupnamevalue}
      commonkeywords.Click button on list page    ${LOCATOR_SEARCHGROUP_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Click Hide Search Criteria
      pageGroupMgt.Verify Group Result Datatable    1    groupname      contains      ${groupnamevalue}

      commonkeywords.Click button on list page      ${1ROW_GROUP_ACTION}[edit]
      commonkeywords.Verify Page Name is correct    Edit Group
      commonkeywords.Wait Loading progress

      IF  '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
            Log To Console    \nTest User Management Standard Version

      ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
          Log To Console    \nTest User Management IE5DEV Version
          pageGroupMgt.Verify checkbox role group state    ${default_adminrole01}    True
          pageGroupMgt.Verify checkbox role group state    ${default_adminrole02}    True
          pageGroupMgt.Verify checkbox role group state    ${default_supportrole}    False
          pageGroupMgt.Verify checkbox role group state    ${default_custrole}       True
      ELSE
          Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'STANDARD' or 'IE5DEV'
      END

      commonkeywords.Fill in data form    ${LOCATOR_GROUPCOMPANY_SEL}             ${groupcomvalue}

      IF  '${caseType}'=='caseField'
          IF  '${GLOBAL_STANDARD_VERSION}'=='STANDARD'
                Log To Console    \nTest User Management Standard Version

          ELSE IF   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'
              Log To Console    \nTest User Management IE5DEV Version
              pageGroupMgt.Verify checkbox role group not found    ${default_adminrole01}
              pageGroupMgt.Verify checkbox role group not found    ${default_adminrole02}
              pageGroupMgt.Verify checkbox role group not found    ${default_supportrole}
              pageGroupMgt.Verify checkbox role group not found    ${default_custrole}
              pageGroupMgt.Verify checkbox role group state        ${custadmin_robotrole}    False

          ELSE
              Fail    \nPlease Check '{GLOBAL_STANDARD_VERSION}' should any 'STANDARD' or 'IE5DEV'
          END
      END

      commonkeywords.Fill in data form    ${LOCATOR_GROUPUNLIMITUSER_CHK}         ${stateunlimituser}

      IF   '${stateunlimituser}'=='check'
          commonkeywords.Verify data form    ${LOCATOR_GROUPLIMITUSER_FIELD}    should be     ${limituser}
      ELSE IF  '${stateunlimituser}'=='uncheck'
          commonkeywords.Fill in data form   ${LOCATOR_GROUPLIMITUSER_FIELD}    ${limituser}
      ELSE
          Fail    \nPlease check 'stateunlimituser' should any check or uncheck.
      END

      IF   '${caseType}'=='caseChecked'
            pageGroupMgt.Check checkbox role group       ${rolegroup}

      ELSE IF   '${caseType}'=='caseUnchecked'
            pageGroupMgt.Uncheck checkbox role group     ${rolegroup}

      ELSE IF   '${caseType}'=='caseField'
            pageGroupMgt.Check checkbox role group       ${rolegroup}
      ELSE
          Log     Another Case!
      END

      commonkeywords.Verify Field State     ${LOCATOR_GROUPNAME_FIELD}            disabled
      # commonkeywords.Verify data form       ${LOCATOR_GROUPAPPROVAL_FIELD}        should be    No
      # commonkeywords.Verify data form       ${LOCATOR_GROUP_GROUPAPPV_FIELD}      should be    Please Select

      commonkeywords.Click button on detail page    ${LOCATOR_GROUPSAVE_BTN}
      commonkeywords.Verify Modal Title message    Success
      commonkeywords.Click OK Button

      # ASSERTION
      # verify record in company list
      commonkeywords.Wait Loading progress
      commonkeywords.Verify Page Name is correct    Group Management
      commonkeywords.Click Expand Search Criteria
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYGROUP_SEL}         ${GROUPSEARCHBY}[groupname]
      commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHGROUP_KEYWORD}       ${groupnamevalue}
      commonkeywords.Click button on list page    ${LOCATOR_SEARCHGROUP_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Click Hide Search Criteria

      pageGroupMgt.Verify Group Result Datatable    1    companyname    contains      ${groupcomvalue}
      pageGroupMgt.Verify Group Result Datatable    1    groupname      contains      ${groupnamevalue}
      pageGroupMgt.Verify Group Result Datatable    1    status         should be     ${GROUPSTATUS}[active]


      #verify group data info
      commonkeywords.Click button on list page      ${1ROW_GROUP_ACTION}[edit]
      commonkeywords.Verify Page Name is correct    Edit Group
      commonkeywords.Wait Loading progress

      commonkeywords.Verify data form         ${LOCATOR_GROUPCOMPANY_SEL}         should be     ${groupcomvalue}
      commonkeywords.Verify data form         ${LOCATOR_GROUPNAME_FIELD}          should be     ${groupnamevalue}
      commonkeywords.Verify data form         ${LOCATOR_GROUPLIMITUSER_FIELD}     should be     ${limituser}
      # commonkeywords.Verify data form         ${LOCATOR_GROUPAPPROVAL_FIELD}      should be     No
      # commonkeywords.Verify data form         ${LOCATOR_GROUP_GROUPAPPV_FIELD}    should be     Please Select

      IF   '${limituser}'=='-1'
            commonkeywords.Verify data form    ${LOCATOR_GROUPUNLIMITUSER_CHK}    should be    check
      ELSE IF   '${limituser}'!='-1'
            commonkeywords.Verify data form    ${LOCATOR_GROUPUNLIMITUSER_CHK}    should be    uncheck
      ELSE
            Fail    \nPlease check verify group unlimit user check or uncheck
      END


      IF   '${caseType}'=='caseChecked'
            PageGroupMgt.Verify checkbox role group state    ${rolegroup}     True

            pageGroupMgt.Verify checkbox role group state    ${default_adminrole01}    True
            pageGroupMgt.Verify checkbox role group state    ${default_adminrole02}    True
            pageGroupMgt.Verify checkbox role group state    ${default_supportrole}    True
            pageGroupMgt.Verify checkbox role group state    ${default_custrole}       True

      ELSE IF   '${caseType}'=='caseUnchecked'
            PageGroupMgt.Verify checkbox role group state       ${rolegroup}     False

            pageGroupMgt.Verify checkbox role group state    ${default_adminrole01}    False
            pageGroupMgt.Verify checkbox role group state    ${default_adminrole02}    True
            pageGroupMgt.Verify checkbox role group state    ${default_supportrole}    False
            pageGroupMgt.Verify checkbox role group state    ${default_custrole}       True

      ELSE IF   '${caseType}'=='caseField'
            PageGroupMgt.Verify checkbox role group state    ${rolegroup}     True
      ELSE
          Log     Another Case!
      END

      commonkeywords.Verify Field State    ${LOCATOR_GROUPNAME_FIELD}     disabled
      Log To Console      TEST CASE VERIFIED.
      commonkeywords.Click xClose button    ${LOCATOR_XCLOSEGROUP_BTN}
      commonkeywords.Wait Loading progress
      commonkeywords.Verify Page Name is correct    Group Management 
