*** Settings ***
Resource        ../../resources/commonkeywords.resource

Suite setup      Run Keywords      Pass Execution If   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'    \nTest Cases for User Management Version Standard Version
...              AND               commonkeywords.Set Data for Run Automated Test 
...              AND               Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.
...              AND               commonkeywords.Initialize System and Go to Login Page

Test Setup        Run Keywords      Pass Execution If   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'    \nTest Cases for User Management Version Standard Version
...               AND               Pass Execution If   '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.
...               AND               pageRegister.Click Register Link
...               AND               commonkeywords.Verify Field State    ${LOCATOR_VERIFYREGISTYPE_SEL}    visible

Test Template     Template Company or Person Information

Test Teardown     Run Keywords    Pass Execution If   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'    \nTest Cases for User Management Version Standard Version
...               AND             Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.
...               AND             commonkeywords.Click button on detail page      ${LOCATOR_REGISBACK_BTN}
...               AND             commonkeywords.Wait Loading progress
...               AND             commonkeywords.Click button on detail page      ${LOCATOR_REGISBACK_BTN}
...               AND             commonkeywords.Wait Loading progress

Suite Teardown    Run Keywords      Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.
...               AND               commonkeywords.Release user lock and close all browser


*** Test Cases ***
All Empty Field-Company
...         ${REGISTYPE}[legal]     Please Select    ${EMPTY}    ${EMPTY}      ${EMPTY}    ${EMPTY}    ${EMPTY}
...         ${EMPTY}     ${EMPTY}   emptycomtype=${REGISTER_REQUIREWARNMSG}[companyType]        emptycomname=${REGISTER_REQUIREWARNMSG}[companyName]
...         emptyCombranch=${REGISTER_REQUIREWARNMSG}[companyBranch]                 emptyHousenum=${REGISTER_REQUIREWARNMSG}[houseNum]
...         emptySubdistrict=${REGISTER_REQUIREWARNMSG}[subDistrict]                 emptyPostcode=${REGISTER_REQUIREWARNMSG}[postCode]
...         emptyEmail=${REGISTER_REQUIREWARNMSG}[eMail]

Company-Empty Company Type              ${REGISTYPE}[legal]    Please Select               testcompany    00000       33/2       -        10110       test@mail.com        ${EMPTY}   emptycomtype=${REGISTER_REQUIREWARNMSG}[companyType]
Company-Empty Company Name              ${REGISTYPE}[legal]    ${REGISCOMTYPE}[officer]    ${EMPTY}       00000       33/2       -        10110       test@mail.com        ${EMPTY}   emptycomname=${REGISTER_REQUIREWARNMSG}[companyName]
Company-Empty Company Branch            ${REGISTYPE}[legal]    ${REGISCOMTYPE}[officer]    testcompany    ${EMPTY}    33/2       -        10110       test@mail.com        ${EMPTY}   emptyCombranch=${REGISTER_REQUIREWARNMSG}[companyBranch]
Company-Empty House Number              ${REGISTYPE}[legal]    ${REGISCOMTYPE}[officer]    testcompany    00000       ${EMPTY}   -        10110       test@mail.com        ${EMPTY}   emptyHousenum=${REGISTER_REQUIREWARNMSG}[houseNum]
Company-Empty SubDistrict               ${REGISTYPE}[legal]    ${REGISCOMTYPE}[officer]    testcompany    00000       33/2    ${EMPTY}    10110       test@mail.com        ${EMPTY}   emptySubdistrict=${REGISTER_REQUIREWARNMSG}[subDistrict]
Company-Empty Postcode                  ${REGISTYPE}[legal]    ${REGISCOMTYPE}[officer]    testcompany    00000       33/2       -        ${EMPTY}    test@mail.com        ${EMPTY}   emptyPostcode=${REGISTER_REQUIREWARNMSG}[postCode]
Company-Empty Email                     ${REGISTYPE}[legal]    ${REGISCOMTYPE}[officer]    testcompany    00000       33/2       -        10110       ${EMPTY}             ${EMPTY}   emptyEmail=${REGISTER_REQUIREWARNMSG}[eMail]

All Empty Field-Person
...          ${REGISTYPE}[person]   -   ${EMPTY}    -      ${EMPTY}    ${EMPTY}    ${EMPTY}
...          ${EMPTY}     ${EMPTY}     emptypersonname=${REGISTER_REQUIREWARNMSG}[personName]    emptyHousenum=${REGISTER_REQUIREWARNMSG}[houseNum]
...          emptySubdistrict=${REGISTER_REQUIREWARNMSG}[subDistrict]                emptyPostcode=${REGISTER_REQUIREWARNMSG}[postCode]
...          emptyEmail=${REGISTER_REQUIREWARNMSG}[eMail]

Person-Empty Person Name         ${REGISTYPE}[person]    -    ${EMPTY}    -    33/2       -        10110       test@mail.com        ${EMPTY}    emptypersonname=${REGISTER_REQUIREWARNMSG}[personName]
Person-Empty House Number        ${REGISTYPE}[person]    -    testname    -    ${EMPTY}   -        10110       test@mail.com        ${EMPTY}    emptyHousenum=${REGISTER_REQUIREWARNMSG}[houseNum]
Person-Empty SubDistrict         ${REGISTYPE}[person]    -    testname    -    33/2    ${EMPTY}    10110       test@mail.com        ${EMPTY}    emptySubdistrict=${REGISTER_REQUIREWARNMSG}[subDistrict]
Person-Empty Postcode            ${REGISTYPE}[person]    -    testname    -    33/2       -        ${EMPTY}    test@mail.com        ${EMPTY}    emptyPostcode=${REGISTER_REQUIREWARNMSG}[postCode]
Person-Empty Email               ${REGISTYPE}[person]    -    testname    -    33/2       -        10110       ${EMPTY}             ${EMPTY}    emptyEmail=${REGISTER_REQUIREWARNMSG}[eMail]

Email invalid not contain @                           ${REGISTYPE}[person]    -    testname    -    33/2       -        10110       test             ${EMPTY}   invEmail=${REGISTER_OTHERWARNMSG}[emailInv]
Email invalid contain @ not contain @domainl          ${REGISTYPE}[person]    -    testname    -    33/2       -        10110       test@            ${EMPTY}   invEmail=${REGISTER_OTHERWARNMSG}[emailInv]
Contact Phone contain letter                          ${REGISTYPE}[legal]    ${REGISCOMTYPE}[officer]    testcompany    00000       33/2       -        10110       test@mail.com        02xx20-1   invcontactphone=${REGISTER_OTHERWARNMSG}[invphonnum]


*** Keywords ***
Template Company or Person Information
    [Arguments]      ${registertype}   ${comtype}    ${comname}    ${combranch}    ${houseNum}   ${subDistrict}    ${postCode}   ${eMail}   ${contactphone}    &{warnmsg}

      Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
      ...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.
      Pass Execution If   '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'    \nTest Cases for User Management Version Standard Version
      commonkeywords.Verify Field State     ${LOCATOR_VERIFYREGISTYPE_SEL}              visible
      commonkeywords.Fill in data form      ${LOCATOR_VERIFYREGISTYPE_SEL}              ${registertype}
      commonkeywords.Fill in data form      ${LOCATOR_VERIFYREGISCOMTAXID_FIELD}        1000000100010
      commonkeywords.Click button on detail page    ${LOCATOR_REGISNEXT_BTN}
      commonkeywords.Wait Loading progress
      Sleep   1s

      commonkeywords.Fill in data form      ${LOCATOR_REGISCOMNAME_FIELD}       ${comname}

      IF  '${registertype}'=='${REGISTYPE}[legal]'
            commonkeywords.Fill in data form    ${LOCATOR_REGISCOMPANYTYPE_SEL}            ${comtype}
            commonkeywords.Fill in data form    ${LOCATOR_REGISCOMBRANCH_FIELD}            ${combranch}
      ELSE
          commonkeywords.Verify Field State     ${LOCATOR_REGISCOMPANYTYPE_SEL}            hidden
          commonkeywords.Verify Field State     ${LOCATOR_REGISCOMBRANCH_FIELD}            hidden
      END


      #Company Address Information data
      commonkeywords.Fill in data form    ${LOCATOR_REGISCOMHOUSENUM_FIELD}        ${houseNum}
      commonkeywords.Fill in data form    ${LOCATOR_REGISCOMSUBDISTRICT_FIELD}     ${subDistrict}
      commonkeywords.Fill in data form    ${LOCATOR_REGISCOMPOSTCODE_FIELD}        ${postcode}
      Press Keys    ${LOCATOR_REGISCOMPOSTCODE_FIELD}   Tab
      commonkeywords.Fill in data form    ${LOCATOR_REGISCOMEMAIL_FIELD}           ${email}
      commonkeywords.Fill in data form    ${LOCATOR_REGISCOMCONTACTPHONE_FIELD}    ${contactphone}
      commonkeywords.Click button on detail page    ${LOCATOR_REGISNEXT_BTN}


      IF   '${comtype}'=='Please Select' and '${registertype}'=='${REGISTYPE}[legal]'
            commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGISCOMTYPE}     contains      ${warnmsg}[emptycomtype]
            Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[emptycomtype]
      END

      IF   '${comname}'=='' and '${registertype}'=='${REGISTYPE}[legal]'
            commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGISCOMNAME}     contains      ${warnmsg}[emptycomname]
            Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[emptycomname]
      END

      IF   '${comname}'=='' and '${registertype}'=='${REGISTYPE}[person]'
            commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGISPERSONNAME}     contains      ${warnmsg}[emptypersonname]
            Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[emptypersonname]
      END

      IF   '${combranch}'=='' and '${registertype}'=='${REGISTYPE}[legal]'
            commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGISCOMBRANCH}     contains      ${warnmsg}[emptyCombranch]
            Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[emptyCombranch]
      END

      IF   '${houseNum}'==''
            commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGISHOUSENUM}     contains      ${warnmsg}[emptyHousenum]
            Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[emptyHousenum]
      END

      IF   '${subDistrict}'==''
            commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGISUBDISTRICT}     contains      ${warnmsg}[emptySubdistrict]
            Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[emptySubdistrict]
      END

      IF   '${postCode}'==''
            commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGISPOSTCODE}     contains      ${warnmsg}[emptyPostcode]
            Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[emptyPostcode]
      END

      IF   '${eMail}'==''
            commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGISEMAIL}     contains      ${warnmsg}[emptyEmail]
            Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[emptyEmail]
      END

      IF   '${eMail}'!='test@mail.com' and '${eMail}'!=''
            commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGISEMAIL}     contains      ${warnmsg}[invEmail]
            Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[invEmail]
      END

      IF   '${contactphone}'!=''
            commonkeywords.Verify Warning message field    ${LOCATOR_WARN_REGISCONTACTPHONE}     contains      ${warnmsg}[invcontactphone]
            Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[invcontactphone]
      END
