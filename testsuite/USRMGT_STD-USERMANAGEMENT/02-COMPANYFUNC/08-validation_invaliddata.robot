*** Settings ***
Resource        ../../../resources/commonkeywords.resource

Suite setup       Run Keywords      commonkeywords.Set Data for Run Automated Test

...               AND               datasources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               datasources.Import DataSource USER PROFILE
...               AND               datasources.Import DataSource COMPANY INFO DATA

...               AND               commonkeywords.Generate Random Number    3
...               AND               Set Suite Variable    ${VAR_DEFAULTTAX_SYSTEM}      ${JS_DEFAULTDATA['companydata'][0]}[taxid]
...               AND               Set Suite Variable    ${VAR_DEFAULTCOMNAME_SYS}     ${JS_DEFAULTDATA['companydata'][0]}[companyname]
...               AND               Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.    

...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Login System          ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to SUBMENU name    ${mainmenu}[configuration]      ${submenu}[companyMgt]
...               AND               commonkeywords.Verify Page Name is correct    pagename=${menuname}[companyMgt]

...               AND               commonkeywords.Click button on list page    ${LOCATOR_ADDCOMP_BTN}
...               AND               commonkeywords.Fill in data form    ${LOCATOR_COMREGISTYPE_SEL}      ${COMREGISTYPE}[legal]
...               AND               commonkeywords.Fill in data form    ${LOCATOR_COMTAXID_FIELD}        0100100010010
...               AND               commonkeywords.Click button on detail page    ${LOCATOR_COMNEXT_BTN}
...               AND               commonkeywords.Wait Loading progress

Test Template     Template Validate Company field exception case

Suite teardown    Run Keywords      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
...                                       \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
...               AND               commonkeywords.Click xClose button     ${LOCATOR_XCLOSECOMPANY_BTN}
...               AND               commonkeywords.Logout System
...               AND               commonkeywords.Release user lock and close all browser


*** Test Cases ***
# EMPTY DATA #
CASE-EMPTY ALL Mandatory Field
...   Please Select     ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
...   expwarn_comtype=${COMPANY_REQUIREWARNMSG}[companyType]
...   expwarn_taxid=${COMPANY_REQUIREWARNMSG}[companyTax]
...   expwarn_comname=${COMPANY_REQUIREWARNMSG}[companyName]
...   expwarn_combranch=${COMPANY_REQUIREWARNMSG}[companyBranch]
...   expwarn_houseNum=${COMPANY_REQUIREWARNMSG}[houseNum]
...   expwarn_subDistrict=${COMPANY_REQUIREWARNMSG}[subDistrict]
...   expwarn_district=${COMPANY_REQUIREWARNMSG}[district]
...   expwarn_province=${COMPANY_REQUIREWARNMSG}[province]
...   expwarn_postcode=${COMPANY_REQUIREWARNMSG}[postCode]
...   expwarn_email=${COMPANY_REQUIREWARNMSG}[eMail]
...   expwarn_limituser=${COMPANY_REQUIREWARNMSG}[limitUser]
...   expwarn_limitloginattm=${COMPANY_REQUIREWARNMSG}[limitLoginAttm]
...   expwarn_limitrepeatpwd=${COMPANY_REQUIREWARNMSG}[limitRepeatPwd]
...   expwarn_limitpwdexpired=${COMPANY_REQUIREWARNMSG}[pwdExpired]
...   expwarn_limitlogin=${COMPANY_REQUIREWARNMSG}[limitLogin]
...   expwarn_sessionexpired=${COMPANY_REQUIREWARNMSG}[sessionExpired]

CASE-EMPTY Company Type
...   Please Select     01001100101010    Test    00000    11/1    รองเมือง     10330      test@mail.com    1    1    1    1    1    1    ${EMPTY}    ${EMPTY}
...   expwarn_comtype=${COMPANY_REQUIREWARNMSG}[companyType]

CASE-EMPTY TaxID field
...   ${COMTYPE}[netbay]       ${EMPTY}    Test    00000    11/1    รองเมือง     10330      test@mail.com    1    1    1    1    1    1   ${EMPTY}    ${EMPTY}
...   expwarn_taxid=${COMPANY_REQUIREWARNMSG}[companyTax]

CASE-EMPTY Company name field
...   ${COMTYPE}[netbay]     01001100101010    ${EMPTY}    00000    11/1    รองเมือง     10330      test@mail.com    1    1    1    1    1    1   ${EMPTY}    ${EMPTY}
...   expwarn_comname=${COMPANY_REQUIREWARNMSG}[companyName]

CASE-EMPTY Company branch field
...   ${COMTYPE}[netbay]     01001100101010    test   ${EMPTY}    11/1    รองเมือง     10330      test@mail.com    1    1    1    1    1    1  ${EMPTY}    ${EMPTY}
...   expwarn_combranch=${COMPANY_REQUIREWARNMSG}[companyBranch]

CASE-EMPTY House number field
...   ${COMTYPE}[netbay]     01001100101010    test   00000    ${EMPTY}   รองเมือง     10330      test@mail.com    1    1    1    1    1    1  ${EMPTY}    ${EMPTY}
...   expwarn_houseNum=${COMPANY_REQUIREWARNMSG}[houseNum]

CASE-EMPTY Subdistrict field
...   ${COMTYPE}[netbay]     01001100101010    test   00000    11/2   ${EMPTY}     10330      test@mail.com    1    1    1    1    1    1   ${EMPTY}    ${EMPTY}
...   expwarn_subDistrict=${COMPANY_REQUIREWARNMSG}[subDistrict]
...   expwarn_district=${COMPANY_REQUIREWARNMSG}[district]
...   expwarn_province=${COMPANY_REQUIREWARNMSG}[province]

CASE-EMPTY Postcode field
...   ${COMTYPE}[netbay]     01001100101010    test   00000    11/2   รองเมือง     ${EMPTY}      test@mail.com    1    1    1    1    1    1   ${EMPTY}    ${EMPTY}
...   expwarn_postcode=${COMPANY_REQUIREWARNMSG}[postCode]

CASE-EMPTY Email field
...   ${COMTYPE}[netbay]     01001100101010    test   00000    11/2   รองเมือง     10330      ${EMPTY}   1    1    1    1    1    1  ${EMPTY}    ${EMPTY}
...   expwarn_email=${COMPANY_REQUIREWARNMSG}[eMail]

CASE-EMPTY Limit Users field
...   ${COMTYPE}[netbay]     01001100101010    test   00000    11/2   รองเมือง     10330      test@mail.com    ${EMPTY}    1    1    1    1    1   ${EMPTY}    ${EMPTY}
...   expwarn_limituser=${COMPANY_REQUIREWARNMSG}[limitUser]

CASE-EMPTY Limit Login Attempts
...   ${COMTYPE}[netbay]     01001100101010    test   00000    11/2   รองเมือง     10330      test@mail.com    1    ${EMPTY}    1    1    1    1  ${EMPTY}    ${EMPTY}
...   expwarn_limitloginattm=${COMPANY_REQUIREWARNMSG}[limitLoginAttm]

CASE-EMPTY Limit Repeat Password
...   ${COMTYPE}[netbay]     01001100101010    test   00000    11/2   รองเมือง     10330      test@mail.com    1    1   ${EMPTY}     1    1    1  ${EMPTY}    ${EMPTY}
...   expwarn_limitrepeatpwd=${COMPANY_REQUIREWARNMSG}[limitRepeatPwd]

CASE-EMPTY Password Expire Days
...   ${COMTYPE}[netbay]     01001100101010    test   00000    11/2   รองเมือง     10330      test@mail.com    1    1   1     ${EMPTY}    1    1   ${EMPTY}    ${EMPTY}
...   expwarn_limitpwdexpired=${COMPANY_REQUIREWARNMSG}[pwdExpired]

CASE-EMPTY Limit Login Session
...   ${COMTYPE}[netbay]     01001100101010    test   00000    11/2   รองเมือง     10330      test@mail.com    1    1   1     1     ${EMPTY}    1   ${EMPTY}    ${EMPTY}
...   expwarn_limitlogin=${COMPANY_REQUIREWARNMSG}[limitLogin]

CASE-EMPTY Session Expire
...   ${COMTYPE}[netbay]     01001100101010    test   00000    11/2   รองเมือง     10330      test@mail.com    1    1   1     1      1    ${EMPTY}   ${EMPTY}    ${EMPTY}
...   expwarn_sessionexpired=${COMPANY_REQUIREWARNMSG}[sessionExpired]

#Company Policy Information#
CASE-Limit Users field equal 0
...   ${COMTYPE}[netbay]     01001100101010    test   00000    11/2   รองเมือง     10330      test@mail.com    0   1    1    1    1    1   ${EMPTY}    ${EMPTY}
...   expwarn_limituser=${COMPANY_OTHERWARNMSG}[limitusr0]

CASE-Limit Login Attempts equal 0
...   ${COMTYPE}[netbay]     01001100101010    test   00000    11/2   รองเมือง     10330      test@mail.com    1    0   1    1    1    1   ${EMPTY}    ${EMPTY}
...   expwarn_limitloginattm=${COMPANY_OTHERWARNMSG}[limitattm0]

CASE-Limit Repeat Password equal 0
...   ${COMTYPE}[netbay]     01001100101010    test   00000    11/2   รองเมือง     10330      test@mail.com    1    1   0   1    1    1   ${EMPTY}    ${EMPTY}
...   expwarn_limitrepeatpwd=${COMPANY_OTHERWARNMSG}[repeatpwd0]

CASE-Password Expire Days equal 0
...   ${COMTYPE}[netbay]     01001100101010    test   00000    11/2   รองเมือง     10330      test@mail.com    1    1   1    0  1    1   ${EMPTY}    ${EMPTY}
...   expwarn_limitpwdexpired=${COMPANY_OTHERWARNMSG}[pwdexpired0]

CASE-Limit Login Session equal 0
...   ${COMTYPE}[netbay]     01001100101010    test   00000    11/2   รองเมือง     10330      test@mail.com    1    1   1     1    0   1  ${EMPTY}    ${EMPTY}
...   expwarn_limitlogin=${COMPANY_OTHERWARNMSG}[loginsession0]

CASE-Session Expire equal 0
...   ${COMTYPE}[netbay]     01001100101010    test   00000    11/2   รองเมือง     10330      test@mail.com    1    1   1     1      1    0  ${EMPTY}    ${EMPTY}
...   expwarn_sessionexpired=${COMPANY_OTHERWARNMSG}[sessionexpire0]

CASE-Limit Users field less than -1
...   ${COMTYPE}[netbay]     01001100101010    test   00000    11/2   รองเมือง     10330      test@mail.com    -10   1    1    1    1    1   ${EMPTY}    ${EMPTY}
...   expwarn_limituser=${COMPANY_OTHERWARNMSG}[limitusrless-1]

CASE-Limit Login Attempts less than -1
...   ${COMTYPE}[netbay]     01001100101010    test   00000    11/2   รองเมือง     10330      test@mail.com    1    -10   1    1    1    1   ${EMPTY}    ${EMPTY}
...   expwarn_limitloginattm=${COMPANY_OTHERWARNMSG}[limitattmless-1]

CASE-Limit Repeat Password less than -1
...   ${COMTYPE}[netbay]     01001100101010    test   00000    11/2   รองเมือง     10330      test@mail.com    1    1   -10   1    1    1   ${EMPTY}    ${EMPTY}
...   expwarn_limitrepeatpwd=${COMPANY_OTHERWARNMSG}[repeatpwdless-1]

CASE-Password Expire Days less than -1
...   ${COMTYPE}[netbay]     01001100101010    test   00000    11/2   รองเมือง     10330      test@mail.com    1    1   1    -10  1    1   ${EMPTY}    ${EMPTY}
...   expwarn_limitpwdexpired=${COMPANY_OTHERWARNMSG}[pwdexpiredless-1]

CASE-Limit Login Session less than 0
...   ${COMTYPE}[netbay]     01001100101010    test   00000    11/2   รองเมือง     10330      test@mail.com    1    1   1     1    -10    1  ${EMPTY}    ${EMPTY}
...   expwarn_limitlogin=${COMPANY_OTHERWARNMSG}[loginsession0]

CASE-Session Expire equal less than 0
...   ${COMTYPE}[netbay]     01001100101010    test   00000    11/2   รองเมือง     10330      test@mail.com    1    1   1     1      1    -20   ${EMPTY}    ${EMPTY}
...   expwarn_sessionexpired=${COMPANY_OTHERWARNMSG}[sessionexpire0]

# Warning Email field
CASE-Email invalid not contain @
...   ${COMTYPE}[netbay]     01001100101010    test   00000    11/2   รองเมือง     10330      robotmail   1    1    1    1    1    1   ${EMPTY}    ${EMPTY}
...   expwarn_email=${COMPANY_OTHERWARNMSG}[emailInv]

CASE-Email invalid contain @ not contain @domain
...   ${COMTYPE}[netbay]     01001100101010    test   00000    11/2   รองเมือง     10330      robotmail@   1    1    1    1    1    1   ${EMPTY}    ${EMPTY}
...   expwarn_email=${COMPANY_OTHERWARNMSG}[emailInv]

#Company Information#
CASE-TaxID least 13 minlength
...   ${COMTYPE}[netbay]      01010    Test    00000    11/1    รองเมือง     10330      test@mail.com    1    1    1    1    1    1  ${EMPTY}    ${EMPTY}
...   expwarn_taxid=${COMPANY_OTHERWARNMSG}[tax13]

CASE-TaxID contains alphabet
...   ${COMTYPE}[netbay]       01AZ0   Test    00000    11/1    รองเมือง     10330      test@mail.com    1    1    1    1    1    1   ${EMPTY}    ${EMPTY}
...   expwarn_taxid=${COMPANY_OTHERWARNMSG}[taxInvalid]

CASE-TaxID contains alphabet length 13
...   ${COMTYPE}[netbay]       0100190009XX0    Test    00000    11/1    รองเมือง     10330      test@mail.com    1    1    1    1    1    1  ${EMPTY}    ${EMPTY}
...   expwarn_taxid=${COMPANY_OTHERWARNMSG}[taxInvalid]

CASE-Duplicate Company Name
...   ${COMTYPE}[netbay]     01001100101010    ${VAR_DEFAULTCOMNAME_SYS}   00000    11/2   รองเมือง     10330      test@mail.com   1    1    1    1    1    1  ${EMPTY}    ${EMPTY}
...   expwarn_comname=${COMPANY_OTHERWARNMSG}[dupcompanyname]

CASE-Duplicate TaxID
...   ${COMTYPE}[netbay]     ${VAR_DEFAULTTAX_SYSTEM}     testcompany${GLOBAL_GENNUMBER}   00000    11/2   รองเมือง     10330      test@mail.com  1    1    1    1    1    1  ${EMPTY}    ${EMPTY}
...   expwarn_taxid=${COMPANY_OTHERWARNMSG}[duptaxid]

CASE-Company Phone Number contains alphabet and symbol
...   ${COMTYPE}[netbay]     01001100101010    test   00000    11/2   รองเมือง     10330      test@mail.com   1    1    1    1    1    1   02xx2001-2    ${EMPTY}
...   expwarn_phonenum=${COMPANY_OTHERWARNMSG}[invphonnum]

CASE-Contact Phone Number contains alphabet and symbol
...   ${COMTYPE}[netbay]     01001100101010    test   00000    11/2   รองเมือง     10330      test@mail.com   1    1    1    1    1    1   ${EMPTY}   02xx2001-2
...   expwarn_phonenum=${COMPANY_OTHERWARNMSG}[invphonnum]

*** Keywords ***
Template Validate Company field exception case
      [Arguments]    ${comtype}      ${taxid}     ${comname}     ${combranch}      ${houseNum}      ${subDistrict}    ${postcode}    ${email}   ${limituser}      ${limitloginattm}    ${limitrepeatpwd}   ${limitpwdexpired}  ${limitlogin}    ${sessionexpired}   ${comphone}    ${contactphone}   &{warnmsg}

      Pass Execution If    '${GLOBAL_USERMGT_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_USERMGT_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.

      commonkeywords.Clear field data form    ${LOCATOR_COMTAXID_FIELD}
      commonkeywords.Fill in data form        ${LOCATOR_COMPANYTYPE_SEL}              ${comtype}
      commonkeywords.Fill in data form        ${LOCATOR_COMTAXID_FIELD}               ${taxid}
      commonkeywords.Fill in data form        ${LOCATOR_COMNAME_FIELD}                ${comname}
      commonkeywords.Fill in data form        ${LOCATOR_COMBRANCH_FIELD}              ${comBranch}

      commonkeywords.Fill in data form        ${LOCATOR_COMHOUSENUM_FIELD}             ${houseNum}
      commonkeywords.Fill in data form        ${LOCATOR_COMSUBDISTRICT_FIELD}          ${subDistrict}
      IF    '${subDistrict}'!=''
            pageCompanyMgt.Choose subdictrict autocomplete for first row      ${subDistrict}
      END
      commonkeywords.Fill in data form        ${LOCATOR_COMPOSTCODE_FIELD}            ${postcode}
      commonkeywords.Fill in data form        ${LOCATOR_COMEMAIL_FIELD}               ${email}
      commonkeywords.Fill in data form        ${LOCATOR_COMPHONE_FIELD}               ${comphone}
      commonkeywords.Fill in data form        ${LOCATOR_COMCONTACTPHONE_FIELD}        ${contactphone}

      commonkeywords.Fill in data form        ${LOCATOR_COMLIMITUSR_FIELD}            ${limituser}
      commonkeywords.Fill in data form        ${LOCATOR_COMLIMITLOGINATTM_FIELD}      ${limitloginattm}
      commonkeywords.Fill in data form        ${LOCATOR_COMLIMITREPEATPWD_FIELD}      ${limitrepeatpwd}
      commonkeywords.Fill in data form        ${LOCATOR_COMPWDEXPIRED_FIELD}          ${limitpwdexpired}
      commonkeywords.Fill in data form        ${LOCATOR_COMSESSIONEX_FIELD}           ${sessionexpired}
      commonkeywords.Fill in data form        ${LOCATOR_COMLIMITLOGIN_FIELD}          ${limitlogin}
      commonkeywords.Click button on detail page    ${LOCATOR_COMSAVE_BTN}

      IF    '${comtype}'=='Please Select'
          commonkeywords.Verify Warning message field    ${LOCATOR_WARN_COMPANYTYPE}   contains    ${warnmsg}[expwarn_comtype]
          Log To Console      \nTEST CASE VERIFIED:Empty Company Type
      END

      IF     '${taxid}'=='' or '${taxid}'=='${VAR_DEFAULTTAX_SYSTEM}' or '${taxid}'!='01001100101010'
          IF    '${taxid}'=='' or ('${taxid}'!='' and '${taxid}'!='01001100101010' and '${taxid}'!='${VAR_DEFAULTTAX_SYSTEM}')
              commonkeywords.Verify Warning message field    ${LOCATOR_WARN_COMTAXID}   contains    ${warnmsg}[expwarn_taxid]
              Run Keyword If    '${taxid}'==''
              ...               Log To Console      \nTEST CASE VERIFIED:Empty Tax ID
              Run Keyword If    '${taxid}'!='' and '${taxid}'!='01001100101010' and '${taxid}'!='${VAR_DEFAULTTAX_SYSTEM}'
              ...               Log To Console      \nTEST CASE VERIFIED:Invalid Tax ID
          ELSE IF   '${taxid}'=='${VAR_DEFAULTTAX_SYSTEM}'
              commonkeywords.Verify Modal Content message    ${warnmsg}[expwarn_taxid]
              commonkeywords.Click OK Button
              Log To Console      \nTEST CASE VERIFIED:Duplicate Tax ID
          END
      END

      IF    '${comname}'=='' or '${comname}'=='${VAR_DEFAULTCOMNAME_SYS}'
          IF  '${comname}'==''
              commonkeywords.Verify Warning message field    ${LOCATOR_WARN_COMNAME}   contains   ${warnmsg}[expwarn_comname]
              Log To Console      \nTEST CASE VERIFIED:Empty Company name
          ELSE IF   '${comname}'=='${VAR_DEFAULTCOMNAME_SYS}'
              commonkeywords.Verify Modal Content message    ${warnmsg}[expwarn_comname]
              commonkeywords.Click OK Button
              Log To Console      \nTEST CASE VERIFIED:Duplicate Company Name
          END
      END

      IF    '${combranch}'==''
          commonkeywords.Verify Warning message field    ${LOCATOR_WARN_COMBRANCH}   contains   ${warnmsg}[expwarn_combranch]
          Log To Console      \nTEST CASE VERIFIED:Empty Company Branch
      END

      IF    '${houseNum}'==''
          commonkeywords.Verify Warning message field    ${LOCATOR_WARN_COMHOUSENUM}   contains   ${warnmsg}[expwarn_houseNum]
          Log To Console      \nTEST CASE VERIFIED:Empty House No.
      END

      IF    '${subDistrict}'==''

          commonkeywords.Verify Warning message field    ${LOCATOR_WARN_COMSUBDISTRICT}     contains    ${warnmsg}[expwarn_subDistrict]
          commonkeywords.Verify Warning message field    ${LOCATOR_WARN_COMDISTRICT}        contains    ${warnmsg}[expwarn_district]
          commonkeywords.Verify Warning message field    ${LOCATOR_WARN_COMPROVINCE}        contains    ${warnmsg}[expwarn_province]
          Log To Console      \nTEST CASE VERIFIED:Empty Sub District
      END

      IF    '${postcode}'==''
          commonkeywords.Verify Warning message field    ${LOCATOR_WARN_COMPOSTCODE}        contains    ${warnmsg}[expwarn_postcode]
          Log To Console      \nTEST CASE VERIFIED:Empty Postcode
      END

      IF    '${email}'=='' or '${email}'!='test@mail.com'
          commonkeywords.Verify Warning message field    ${LOCATOR_WARN_COMEMAIL}        contains    ${warnmsg}[expwarn_email]
          Log To Console      \nTEST CASE VERIFIED:Empty Email
      END

      IF    '${limituser}'=='' or '${limituser}'=='0' or '${limituser}'=='-10'
          IF    '${limituser}'==''
              commonkeywords.Verify Warning message field    ${LOCATOR_WARN_COMLIMITUSR}        contains    ${warnmsg}[expwarn_limituser]
              Log To Console      \nTEST CASE VERIFIED:Empty Limit User
          ELSE IF   '${limituser}'=='0' or '${limituser}'=='-10'
              commonkeywords.Verify Modal Content message    ${warnmsg}[expwarn_limituser]
              commonkeywords.Click OK Button
              Log To Console      \nTEST CASE VERIFIED:Limit User equal 0 or less than -1
          END
      END

      IF    '${limitloginattm}'=='' or '${limitloginattm}'=='0' or '${limitloginattm}'=='-10'
          IF    '${limitloginattm}'==''
            commonkeywords.Verify Warning message field    ${LOCATOR_WARN_COMLIMITLOGINATTM}        contains    ${warnmsg}[expwarn_limitloginattm]
            Log To Console      \nTEST CASE VERIFIED:Empty Limit Login Attempts
          ELSE IF   '${limitloginattm}'=='0' or '${limitloginattm}'=='-10'
            commonkeywords.Verify Modal Content message    ${warnmsg}[expwarn_limitloginattm]
            commonkeywords.Click OK Button
            Log To Console      \nTEST CASE VERIFIED:Limit Login Attempts equal 0 or less than -1
          END
      END

      IF    '${limitrepeatpwd}'=='' or '${limitrepeatpwd}'=='0' or '${limitrepeatpwd}'=='-10'
          IF    '${limitrepeatpwd}'==''
              commonkeywords.Verify Warning message field    ${LOCATOR_WARN_COMLIMITREPEATPWD}        contains    ${warnmsg}[expwarn_limitrepeatpwd]
              Log To Console      \nTEST CASE VERIFIED:Empty Repeat Password
          ELSE IF   '${limitrepeatpwd}'=='0' or '${limitrepeatpwd}'=='-10'
              commonkeywords.Verify Modal Content message    ${warnmsg}[expwarn_limitrepeatpwd]
              commonkeywords.Click OK Button
              Log To Console      \nTEST CASE VERIFIED:Limit Repeat Password equal 0 or less than -1
          END
      END

      IF    '${limitpwdexpired}'=='' or '${limitpwdexpired}'=='0' or '${limitpwdexpired}'=='-10'
          IF    '${limitpwdexpired}'==''
              commonkeywords.Verify Warning message field    ${LOCATOR_WARN_COMPWDEXPIRED}        contains    ${warnmsg}[expwarn_limitpwdexpired]
              Log To Console      \nTEST CASE VERIFIED:Empty Password Expire Days
          ELSE IF   '${limitpwdexpired}'=='0' or '${limitpwdexpired}'=='-10'
              commonkeywords.Verify Modal Content message    ${warnmsg}[expwarn_limitpwdexpired]
              commonkeywords.Click OK Button
              Log To Console      \nTEST CASE VERIFIED:Limit Password Expire Days=0
          END
      END

      IF    '${limitlogin}'=='' or '${limitlogin}'=='0' or '${limitlogin}'=='-10'
          IF    '${limitlogin}'==''
              commonkeywords.Verify Warning message field    ${LOCATOR_WARN_COMLIMITLOGIN}        contains    ${warnmsg}[expwarn_limitlogin]
              Log To Console      \nTEST CASE VERIFIED:Empty Limit Login Session
          ELSE IF   '${limitlogin}'=='0' or '${limitlogin}'=='-10'
              commonkeywords.Verify Modal Content message    ${warnmsg}[expwarn_limitlogin]
              commonkeywords.Click OK Button
              Log To Console      \nTEST CASE VERIFIED:Limit Login Session equal 0 or less than -0
          END
      END

      IF    '${sessionexpired}'=='' or '${sessionexpired}'=='0' or '${sessionexpired}'=='-20'
          IF  '${sessionexpired}'==''
              commonkeywords.Verify Warning message field    ${LOCATOR_WARN_COMSESSIONEX}        contains    ${warnmsg}[expwarn_sessionexpired]
              Log To Console      \nTEST CASE VERIFIED:Empty Session Expire
          ELSE IF   '${sessionexpired}'=='0' or '${sessionexpired}'=='-20'
              commonkeywords.Verify Modal Content message    ${warnmsg}[expwarn_sessionexpired]
              commonkeywords.Click OK Button
              Log To Console      \nTEST CASE VERIFIED:Session Expire equal 0 or less than -0
          END
      END

      IF    '${comphone}'!='' or '${contactphone}'!=''
          IF   '${comphone}'!=''
              commonkeywords.Verify Warning message field    ${LOCATOR_WARN_COMPHONE}         contains    ${warnmsg}[expwarn_phonenum]
              Log To Console      \nTEST CASE VERIFIED:Phone Number invalid
          ELSE IF   '${contactphone}'!=''
              commonkeywords.Verify Warning message field    ${LOCATOR_WARN_CONTACTPHONE}     contains    ${warnmsg}[expwarn_phonenum]
              Log To Console      \nTEST CASE VERIFIED:Contact Phone Number invalid
          END
      END

      commonkeywords.Click button on detail page    ${LOCATOR_COMBACK_BTN}
      commonkeywords.Fill in data form              ${LOCATOR_COMTAXID_FIELD}        0100100010010
      commonkeywords.Click button on detail page    ${LOCATOR_COMNEXT_BTN}
