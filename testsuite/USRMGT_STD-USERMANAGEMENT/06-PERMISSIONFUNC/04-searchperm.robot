*** Settings ***
*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               datasources.Import DataSource PERMISSION INFO DATA
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               commonkeywords.Initialize System and Go to Login Page

...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[permMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[permMgt]

...               AND               service-permmgt.Request Service Delete by Permission Code
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   permcode=${DS_PERM['data_1'][${perm_col.permCode}]}
...               AND               service-permmgt.Request Service Delete by Permission Code
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   permcode=${DS_PERM['data_2'][${perm_col.permCode}]}
...               AND               service-permmgt.Request Service Delete by Permission Code
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   permcode=${DS_PERM['data_3'][${perm_col.permCode}]}

...               AND               service-permmgt.Request Service Create Permission
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   permcode=${DS_PERM['data_1'][${perm_col.permCode}]}
...               AND               service-permmgt.Request Service Create Permission
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   permcode=${DS_PERM['data_2'][${perm_col.permCode}]}
...               AND               service-permmgt.Request Service Create Permission
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   permcode=${DS_PERM['data_3'][${perm_col.permCode}]}
...               AND               commonkeywords.Click Expand Search Criteria

Test Template     Template Permission Search Function

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}. 
...               AND               service-permmgt.Request Service Delete by Permission Code
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   permcode=${DS_PERM['data_1'][${perm_col.permCode}]}
...               AND               service-permmgt.Request Service Delete by Permission Code
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   permcode=${DS_PERM['data_2'][${perm_col.permCode}]}
...               AND               service-permmgt.Request Service Delete by Permission Code
...                                   headeruser=${DS_LOGIN['robotapi'][${login_col.username}]}         headerpassword=${DS_LOGIN['robotapi'][${login_col.password}]}
...                                   permcode=${DS_PERM['data_3'][${perm_col.permCode}]}

...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser


*** Test Cases ***
#----------------------------------------------------------------------------------------------------------------------------------------------#
#                             CASE NAME                         Case Type    |        Search By        |            Search Keyword             #
#----------------------------------------------------------------------------------------------------------------------------------------------#

CASE-Search by Permission Code > Full Search                        P         ${PERMSEARCHBY}[permcode]     ${DS_PERM['data_2'][0]}
CASE-Search by Permission Code > Partail Search (Start wording)     P         ${PERMSEARCHBY}[permcode]     TXROBOT
CASE-Search by Permission Code > Partail Search (Middle wording)    E         ${PERMSEARCHBY}[permcode]     OAUTO_ED
CASE-Search by Permission Code > Partail Search (Last wording)      E         ${PERMSEARCHBY}[permcode]     TXXX_VIEW

*** Keywords ***
Template Permission Search Function
      [Arguments]    ${casetype}    ${searchby}    ${searchkeyword}

        Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
        ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
      
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYPERM_SEL}         ${PERMSEARCHBY}[permcode]
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHPERM_KEYWORD}       ${searchkeyword}
        commonkeywords.Click button on list page    ${LOCATOR_SEARCHPERM_BTN}
        commonkeywords.Wait Loading progress
        pagePermMgt.Verify Permission Result Data Table for search function    ${casetype}    ${searchby}      ${searchkeyword}
