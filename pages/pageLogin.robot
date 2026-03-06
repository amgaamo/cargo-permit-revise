*** Settings ***
Resource    ../resources/commonkeywords.resource

*** Variables ***
${LOCATOR_ICONWARNING}          //div[contains(@class,'swal2-animate-warning-icon')]

#LOCATOR invalid tooltip
${LOCATOR_INVALIDMSGUSRNAME}      //div[contains(@class,'container')]/div/div/form/div[1]/div/span
${LOCATOR_INVALIDMSGPASSWORD}     //div[contains(@class,'container')]/div/div/form/div[2]/div/span

${VAR_MSGEMPTYUSERNAME}          Please enter a username.
${VAR_MSGEMPTYPASSWORD}          Please enter a password.
# ${VAR_MSGPASSWORDCOND}           Please enter a password with at least 6 - 16 alphanumeric characters.
${VAR_MSGLOGINFAIL}              Not Found Username or Password.
${VAR_MSGLOGIN_INACTIVE}         Inactive User
${VAR_MSGLOGIN_USERLOCK}         User is locked

*** Keywords ***
Fill in Login Field
    [Arguments]   ${username}    ${password}
      commonkeywords.Fill in Username Field       ${username}
      commonkeywords.Fill in Password Field       ${password}


Check Duplicate Message
   [Arguments]    ${errormsg}
      Wait For Elements State          ${LOCATOR_ICONWARNING}         visible       timeout=20
      Get Text       ${LOCATOR_TITLEMODAL}       equal    Authentication
      Get Text       ${LOCATOR_CONTENTMODAL}     contains    ${errormsg}

Check Login Message Alert
      [Arguments]    ${LOCATOR}       ${message}
         ${popupmsg}=         Get Element States            ${LOCATOR_LOGIN_BTN}      then    bool(value & focused)

         IF  '${popupmsg}'=='True'
              Get Text       ${LOCATOR}   contains    ${message}
              Log To Console      \n${message}: TEST CASE VERIFIED.
         ELSE
              Get Text       ${LOCATOR}   contains    ${message}
              commonkeywords.Click Close Button
              Log To Console      \n${message}: TEST CASE VERIFIED.
         END
