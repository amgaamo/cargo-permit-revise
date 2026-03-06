*** Settings ***
Resource       ../resources/commonkeywords.resource

*** Variables ***
${LOCATOR_USRNAME_USRPF_TXT}       //*[contains(@class,'profile-data')]
${LOCATOR_FIRSTNAME_USRPF_TXT}     //*[@id="umpf-firstname"]
${LOCATOR_LASTNAME_USRPF_TXT}      //*[@id="umpf-lastname"]
${LOCATOR_PHONENUM_USRPF_TXT}      //*[@id="umpf-phone"]
${LOCATOR_EMAIL_USRPF_TXT}         //*[@id="umpf-email"]
${LOCATOR_EDITPF_BTN}              //*[@id="umpf-save-btn" and contains(text(), 'Edit')]
${LOCATOR_SAVEPF_BTN}              //*[@id="umpf-save-btn" and contains(text(), 'Update')]

${LOCATOR_WARN_PFFIRSTNAME}         //div[contains(@class,'profile-content')]/div[4]/div/div/span
${LOCATOR_WARN_PFLASTNAME}          //div[contains(@class,'profile-content')]/div[5]/div/div/span
${LOCATOR_WARN_PFPHONE}             //div[contains(@class,'profile-content')]/div[6]/div/div/span
${LOCATOR_WARN_PFEMAIL}             //div[contains(@class,'profile-content')]/div[7]/div/div/span

&{WARNMSG_PROFILE}    emptyfirstname=Firstname is required    emptylastname=Lastname is required    emptyEmail=Email is required
...                   invemail=Invalid email pattern          invphone=Phone should be only numbers

*** Keywords ***
Click View Profile Menu
      Click          ${LOCATOR_HEADERMENU}
      Click          ${LOCATOR_MENUPROFILE}

Click Edit Profile Button
      Wait For Elements State       ${LOCATOR_EDITPF_BTN}      visible       timeout=30s
      Click     ${LOCATOR_EDITPF_BTN}

Click Save Profile Button
      Wait For Elements State       ${LOCATOR_SAVEPF_BTN}      visible       timeout=30s
      Click     ${LOCATOR_SAVEPF_BTN}

Template Edit Profile Validation Field
    [Arguments]   ${firstname}    ${lastname}   ${email}    ${phone}    &{warnmsg}
      Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
      commonkeywords.Verify Field State     ${LOCATOR_FIRSTNAME_USRPF_TXT}   enabled
      commonkeywords.Verify Field State     ${LOCATOR_LASTNAME_USRPF_TXT}    enabled
      commonkeywords.Verify Field State     ${LOCATOR_PHONENUM_USRPF_TXT}    enabled
      commonkeywords.Verify Field State     ${LOCATOR_EMAIL_USRPF_TXT}       enabled

      commonkeywords.Fill in data form      ${LOCATOR_FIRSTNAME_USRPF_TXT}    ${firstname}
      commonkeywords.Fill in data form      ${LOCATOR_LASTNAME_USRPF_TXT}     ${lastname}
      commonkeywords.Fill in data form      ${LOCATOR_PHONENUM_USRPF_TXT}     ${phone}
      commonkeywords.Fill in data form      ${LOCATOR_EMAIL_USRPF_TXT}        ${email}
      commonkeywords.Verify Button State    ${LOCATOR_SAVEPF_BTN}             disabled

      IF  '${firstname}'=='' or '${lastname}'=='' or '${email}'=='' or '${email}'!='testmail@mail.com' or '${phone}'!=''
          IF    '${firstname}'==''
              commonkeywords.Verify Warning message field    ${LOCATOR_WARN_PFFIRSTNAME}     contains    ${warnmsg}[expwarnfirstname]
              Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[expwarnfirstname]
          END
          IF   '${lastname}'==''
              commonkeywords.Verify Warning message field    ${LOCATOR_WARN_PFLASTNAME}     contains    ${warnmsg}[expwarnlastname]
              Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[expwarnlastname]
          END
          IF   '${email}'=='' or '${email}'!='testmail@mail.com'
              commonkeywords.Verify Warning message field    ${LOCATOR_WARN_PFEMAIL}     contains    ${warnmsg}[expwarnemail]
              Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[expwarnemail]
          END
          IF   '${phone}'!=''
              commonkeywords.Verify Warning message field    ${LOCATOR_WARN_PFPHONE}     contains    ${warnmsg}[expwarnphone]
              Log To Console    \nTEST CASE VERIFIED: ${warnmsg}[expwarnphone]
          END
      END
