*** Settings ***
Resource        ../../resources/commonkeywords.resource

Suite setup       Run Keywords      datasources.Import DataSource DEFAULT DATA
...               AND               dataSources.Import DataSource USER LOGIN
...               AND               commonkeywords.Set Data for Run Automated Test 
...               AND               Generate Random Number    31
...               AND               Set Suite Variable    ${defaultadmin_email}          ${JS_DEFAULTDATA['userdata'][0]}[email]
...               AND               Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}. 
...               AND               Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version
...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Login System     ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to MENU name                ${mainmenu}[registerMgt]
...               AND               commonkeywords.Verify Page Name is correct    ${menuname}[regMgt]
...               AND               commonkeywords.Wait Loading progress
...               AND               commonkeywords.Click button on list page    ${LOCATOR_ADDREGISTER_BTN}

...               AND               commonkeywords.Verify Field State    ${LOCATOR_VERIFYREGISTYPE_SEL}    visible
...               AND               commonkeywords.Verify Field State     ${LOCATOR_VERIFYREGISTYPE_SEL}               visible
...               AND               commonkeywords.Fill in data form      ${LOCATOR_VERIFYREGISTYPE_SEL}               ${REGISTYPE}[legal]
...               AND               commonkeywords.Fill in data form      ${LOCATOR_VERIFYREGISCOMTAXID_FIELD}        1000000100010
...               AND               commonkeywords.Click button on detail page    ${LOCATOR_REGISNEXT_BTN}
...               AND               commonkeywords.Wait Loading progress

...               AND               commonkeywords.Fill in data form    ${LOCATOR_REGISCOMNAME_FIELD}                 Test Companay
...               AND               commonkeywords.Fill in data form    ${LOCATOR_REGISCOMPANYTYPE_SEL}               ${REGISCOMTYPE}[officer]
...               AND               commonkeywords.Fill in data form    ${LOCATOR_REGISCOMBRANCH_FIELD}               00000

#Company Address Information data
...               AND               commonkeywords.Fill in data form    ${LOCATOR_REGISCOMHOUSENUM_FIELD}      11/11
...               AND               commonkeywords.Fill in data form    ${LOCATOR_REGISCOMSUBDISTRICT_FIELD}   หัวหมาก
...               AND               pageCompanyMgt.Choose subdictrict autocomplete for first row    หัวหมาก
...               AND               commonkeywords.Fill in data form    ${LOCATOR_REGISCOMPOSTCODE_FIELD}      13330
...               AND               commonkeywords.Fill in data form    ${LOCATOR_REGISCOMEMAIL_FIELD}         testmail@mail.com
...               AND               Sleep    1s
...               AND               commonkeywords.Click button on detail page    ${LOCATOR_REGISNEXT_BTN}
...               AND               Sleep    1s
...               AND               commonkeywords.Wait Loading progress


Test Setup        Run Keywords      Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version
...               AND               Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}. 
...               AND               Sleep   1500ms
...               AND               commonkeywords.Choose file to upload    ${LOCATOR_REGIS_ATTACHMENT}      ${IDCARD_JPGDATATEST}
...               AND               commonkeywords.Click button on detail page    ${LOCATOR_REGISNEXT_BTN}

Test Template     Template User Information

Test Teardown     Run Keywords    Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version
...               AND               Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}. 
...               AND             commonkeywords.Click button on detail page      ${LOCATOR_REGISBACK_BTN}
...               AND             commonkeywords.Wait Loading progress

Suite Teardown    Run Keywords    Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.   
...               AND             commonkeywords.Release user lock and close all browser

*** Test Cases ***
CASE4-1_Empty All Mandatory Field                      ${EMPTY}       ${EMPTY}       ${EMPTY}        ${EMPTY}        ${EMPTY}     ${EMPTY}    ${EMPTY}
...                                                    warnusername=${REGISTER_REQUIREWARNMSG}[username]      warnpwd=${REGISTER_REQUIREWARNMSG}[password]       warncfpwd=${REGISTER_REQUIREWARNMSG}[cfpwd]        warnfirstname=${REGISTER_REQUIREWARNMSG}[firstname]      warnlastname=${REGISTER_REQUIREWARNMSG}[lastname]     warnemail=${REGISTER_REQUIREWARNMSG}[useremail]
CASE4-2_Empty Firstname                                ${EMPTY}       testlast       robottest       ${VAR_DEFAULTPASSWORD}     ${VAR_DEFAULTPASSWORD}    test@robot.com          ${EMPTY}    warnfirstname=${REGISTER_REQUIREWARNMSG}[firstname]
CASE4-3_Empty lastName                                 testfirst      ${EMPTY}       robottest       ${VAR_DEFAULTPASSWORD}     ${VAR_DEFAULTPASSWORD}    test@robot.com          ${EMPTY}    warnlastname=${REGISTER_REQUIREWARNMSG}[lastname]
CASE4-4_Empty User Email                               testfirst      testlast       robottest       ${VAR_DEFAULTPASSWORD}     ${VAR_DEFAULTPASSWORD}    ${EMPTY}                ${EMPTY}    warnemail=${REGISTER_REQUIREWARNMSG}[useremail]
CASE4-5_Empty Username                                 testfirst      testlast       ${EMPTY}        ${VAR_DEFAULTPASSWORD}     ${VAR_DEFAULTPASSWORD}    test@robot.com          ${EMPTY}    warnusername=${REGISTER_REQUIREWARNMSG}[username]
CASE4-6_Empty Password                                 testfirst      testlast       robottest       ${EMPTY}                   ${VAR_DEFAULTPASSWORD}    test@robot.com          ${EMPTY}    warnpwd=${REGISTER_REQUIREWARNMSG}[password]
CASE4-7_Empty Confirm Password                         testfirst      testlast       robottest       ${VAR_DEFAULTPASSWORD}     ${EMPTY}                  test@robot.com          ${EMPTY}    warncfpwd=${REGISTER_REQUIREWARNMSG}[cfpwd]
CASE4-8_Email not contain @                            testfirst      testlast       robottest       ${VAR_DEFAULTPASSWORD}     ${VAR_DEFAULTPASSWORD}    test                    ${EMPTY}    warnemail=${REGISTER_OTHERWARNMSG}[useremailInv]
CASE4-9_Email not contain domain                       testfirst      testlast       robottest       ${VAR_DEFAULTPASSWORD}     ${VAR_DEFAULTPASSWORD}    test@                   ${EMPTY}    warnemail=${REGISTER_OTHERWARNMSG}[useremailInv]
CASE4-10_Username less than 4                          testfirst      testlast       usr             ${VAR_DEFAULTPASSWORD}     ${VAR_DEFAULTPASSWORD}    test@robot.com          ${EMPTY}     warnusername=${REGISTER_OTHERWARNMSG}[condUsername]
CASE4-11_Username is duplicate                         testfirst      testlast       admin           ${VAR_DEFAULTPASSWORD}     ${VAR_DEFAULTPASSWORD}    test@robot.com          ${EMPTY}    duplicateuser=${REGISTER_OTHERWARNMSG}[duplicate]
CASE4-12_CONFIRM Password not match                    testfirst      testlast       robottest       ${VAR_DEFAULTPASSWORD}     TestNB@123                test@robot.com          ${EMPTY}    warncfpwd=${REGISTER_OTHERWARNMSG}[CFPwdnotMatch]
CASE4-13_PASSWORD less than 8                          testfirst      testlast       robottest       pwd                        pwd                       test@robot.com          ${EMPTY}    warnpwd=${REGISTER_OTHERWARNMSG}[condPWD]
CASE4-14_PASSWORD more than 30                         testfirst      testlast       robottest       ${GLOBAL_GENNUMBER}        ${GLOBAL_GENNUMBER}       test@robot.com          ${EMPTY}    warnpwd=${REGISTER_OTHERWARNMSG}[condPWD]
CASE4-15_PASSWORD not contain lowercase                testfirst      testlast       robottest       ROBOTXX@123                ROBOTXX@123               test@robot.com          ${EMPTY}    warnpwd=${REGISTER_OTHERWARNMSG}[condPWD]
CASE4-16_PASSWORD not contain uppercase                testfirst      testlast       robottest       robotxx@123                robotxx@123               test@robot.com          ${EMPTY}    warnpwd=${REGISTER_OTHERWARNMSG}[condPWD]
CASE4-17_PASSWORD not contain number                   testfirst      testlast       robottest       Robotxx@xxx                robotxx@xxx               test@robot.com          ${EMPTY}    warnpwd=${REGISTER_OTHERWARNMSG}[condPWD]
CASE4-18_PASSWORD not contain Special char             testfirst      testlast       robottest       Robot123xx                 Robot123xx                test@robot.com          ${EMPTY}    warnpwd=${REGISTER_OTHERWARNMSG}[condPWD]
CASE4-19_Duplicate User Email                          testfirst      testlast       robottest       ${VAR_DEFAULTPASSWORD}     ${VAR_DEFAULTPASSWORD}    ${defaultadmin_email}   ${EMPTY}   duplicateemail=${REGISTER_OTHERWARNMSG}[dupemail]
CASE4-20_User Phone Number contain letter              testfirst      testlast       robottest       ${VAR_DEFAULTPASSWORD}     ${VAR_DEFAULTPASSWORD}    test@robot.com          02xx0-1     warnuserphone=${REGISTER_OTHERWARNMSG}[invuserphone]


*** Keywords ***
Template User Information
    [Arguments]     ${userfirstname}    ${userlastname}   ${username}   ${password}   ${cfpassword}   ${useremail}   ${userphone}  &{warnmsg}

      Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
      ...       \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}. 
      Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version
      #User Information
      commonkeywords.Fill in data form              ${LOCATOR_REGIS_USERFIRSTNAME_FIELD}       ${userfirstname}
      commonkeywords.Fill in data form              ${LOCATOR_REGIS_USERLASTNAME_FIELD}        ${userlastname}
      commonkeywords.Fill in data form              ${LOCATOR_REGIS_USEREMAIL_FIELD}           ${useremail}
      commonkeywords.Fill in data form              ${LOCATOR_REGIS_USERPHONE_FIELD}           ${userphone}

      #Login Information
      commonkeywords.Fill in data form              ${LOCATOR_REGIS_USERNAME_FIELD}            ${username}
      commonkeywords.Fill in data form              ${LOCATOR_REGIS_USERPWD_FIELD}             ${password}
      commonkeywords.Fill in data form              ${LOCATOR_REGIS_USERCFPWD_FIELD}           ${cfpassword}

      commonkeywords.Click button on detail page    ${LOCATOR_SUBMITREGIS_BTN}

      IF   '${username}'=='' or '${username}'=='usr'
            commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGIS_USERNAME}     contains       ${warnmsg}[warnusername]
            Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[warnusername]
      END

      IF   '${password}'==''
            commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGIS_USERPWD}     contains       ${warnmsg}[warnpwd]
            Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[warnpwd]
      ELSE IF  '${password}'!='${VAR_DEFAULTPASSWORD}'
              commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGIS_USERPWD}     contains       ${warnmsg}[warnpwd]
              Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[warnpwd]
      END

      IF    '${cfpassword}'=='' or '${cfpassword}'=='TestNB@123'
              commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGIS_USERCFPWD}     contains       ${warnmsg}[warncfpwd]
              Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[warncfpwd]
      END

      IF   '${userfirstname}'==''
              commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGIS_USERFIRSTNAME}     contains       ${warnmsg}[warnfirstname]
              Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[warnfirstname]
      END

      IF   '${userlastname}'==''
              commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGIS_USERLASTNAME}     contains       ${warnmsg}[warnlastname]
              Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[warnlastname]
      END

      IF   '${useremail}'=='' or '${useremail}'=='test' or '${useremail}'=='test@'
              commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGIS_USEREMAIL}     contains       ${warnmsg}[warnemail]
              Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[warnemail]
      END

      IF   '${username}'=='admin'
            commonkeywords.Verify Warning message modal    ${warnmsg}[duplicateuser]
            Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[duplicateuser]
      END

      IF   '${useremail}'=='${defaultadmin_email}'
            commonkeywords.Verify Warning message modal    ${warnmsg}[duplicateemail]
            Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[duplicateemail]
      END

      IF   '${userphone}'!=''
            commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGIS_USERPHONE}     contains       ${warnmsg}[warnuserphone]
            Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[warnuserphone]
      END
