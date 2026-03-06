*** Settings ***
Resource    ../resources/commonkeywords.resource

*** Variables ***
${VAR_CHGPASSWORD}            Robot@989
${VAR_NEWPASSWORD}            Netbay@123
${VAR_PASSWORDNOTMATCH}       RobotNB@123
${VAR_OLDPASSWORD}            Oldpwd@123
${VAR_OLDNOTMATCH}            PWDOld@123

${VAR_ERREMPTYOLDPWD}            Old password is required.
${VAR_ERREMPTYNEWPWD}            New password is required.
${VAR_ERREMPTYCFPWD}             Confirm password is required.
${VAR_ERRNEWPWDCOND}             New password should be at least 8-30 characters, Lowercase letters, Uppercase letters, Numbers and Special characters.
${VAR_ERRCFPWDNOTMATCH}          Confirm password is not match with the new password.
${VAR_ERRINVALIDOLDPWD}          Old Password not match
${VAR_SUCCESSCHNPWD}             Password has been successfully changed
${VAR_ERRSAMEPREVPWD}            Current Password Cannot Be Same as Previous Password

${LOCATOR_MENUCHANGPWD}         //header[contains(@class,'header-bottom')]/nav/div/div[2]/div/div/a[2]/i
${LOCATOR_OLDPWD}               //*[@id="change-pwd-old"]
${LOCATOR_NEWPWD}               //*[@id="change-pwd-new"]
${LOCATOR_CFNEWPWD}             //*[@id="change-pwd-confirm"]
${LOCATOR_CHANGEPWDBUTTON}      //*[@id="change-pwd-change-btn"]

${LOCATOR_ERRMSGMODAL}          //*[@id="swal2-content"]
${LOCATOR_ERRMSGOLDPWD}         //div[contains(@class,'modal-content')]/app-user-change-pwd/div[2]/form/div[1]/div/div/div/span
${LOCATOR_ERRMSGNEWPWD}         //div[contains(@class,'modal-content')]/app-user-change-pwd/div[2]/form/div[2]/div/div/div/span
${LOCATOR_ERRMSGCFPWD}          //div[contains(@class,'modal-content')]/app-user-change-pwd/div[2]/form/div[3]/div/div/div/span

${LOCATOR_XCLOSECHGPWD_BTN}     //*[@id="change-pwd-x-btn"]/span

*** Keywords ***
Fill in Change Password Field
      [Arguments]   ${oldpwd}   ${newpwd}     ${confirmpwd}
      commonkeywords.Fill in data form    ${LOCATOR_OLDPWD}         ${oldpwd}
      commonkeywords.Fill in data form    ${LOCATOR_NEWPWD}         ${newpwd}
      commonkeywords.Fill in data form    ${LOCATOR_CFNEWPWD}       ${confirmpwd}

Generate Length Password Data test
      [Arguments]       ${length}
         ${LETTERS}=              Generate Random String      ${length}       [LETTERS][NUMBERS]
         Set Global Variable      ${GLOBAL_RDPWDDATA}      ${LETTERS}@123

Click Change Password Menu
      Click       ${LOCATOR_HEADER_MENU}
      Click       ${LOCATOR_MENUCHANGPWD}

Click Change Password Button
      Click     ${LOCATOR_CHANGEPWDBUTTON}

Check Change Password Error Message Alert
      [Arguments]       ${oldpwd}      ${newpwd}      ${cfpwd}      &{warnmsg}

         Set Local Variable     ${value_oldpwd}     ${oldpwd}
         Set Local Variable     ${value_newpwd}     ${newpwd}
         Set Local Variable     ${value_cfpwd}      ${cfpwd}

         IF   '${value_oldpwd}'=='${VAR_OLDNOTMATCH}'
              Get Text     ${LOCATOR_ERRMSGMODAL}      should be        ${warnmsg}[errmessage_modal]
              Log To Console      \nTEST CASE VERIFIED. >> ${warnmsg}[errmessage_modal]
         END

         IF   '${value_oldpwd}'==''
              Get Text     ${LOCATOR_ERRMSGOLDPWD}     should be        ${warnmsg}[errmessage_old]
              Log To Console      \nTEST CASE VERIFIED. >> ${warnmsg}[errmessage_old]
         END

         IF   '${value_newpwd}'=='' or '${value_newpwd}'!='${VAR_NEWPASSWORD}'
              Get Text     ${LOCATOR_ERRMSGNEWPWD}     should be        ${warnmsg}[errmessage_new]
              Log To Console      \nTEST CASE VERIFIED. >> ${warnmsg}[errmessage_new]
         END

         IF   '${value_cfpwd}'=='' or '${value_cfpwd}'=='${VAR_PASSWORDNOTMATCH}'
              Get Text     ${LOCATOR_ERRMSGCFPWD}      should be        ${warnmsg}[errmessage_cfpwd]
              Log To Console      TEST CASE VERIFIED. >> ${warnmsg}[errmessage_cfpwd]
         END

Close Change Password Modal
      # ${popupmsg}=        Run Keyword And Return Status        Wait For Elements State        ${LOCATOR_OKMODAL}        focused       timeout=0.5
      Sleep   500ms
      ${popupmsg}=     Get Element States        ${LOCATOR_OKMODAL}     then      bool(value & visible)
      IF   '${popupmsg}'=='True'
          commonkeywords.Click OK Button
      ELSE
          Click     ${LOCATOR_XCLOSECHGPWD_BTN}
      END

Template Change Password With Invalid data test
    [Arguments]    ${oldpwd}      ${newpwd}      ${cfpwd}    &{warnmsg}
      Pass Execution If    '${GLOBAL_PROFILE_FUNCTEST}'=='False'             
      ...    \nNo Execute this function: GLOBAL_PROFILE_FUNCTEST is ${GLOBAL_USERMGT_FUNCTEST}.
      Fill in Change Password Field    ${oldpwd}    ${newpwd}    ${cfpwd}
      pageChangePwd.Click Change Password Button
      PageChangePwd.Check Change Password Error Message Alert   ${oldpwd}      ${newpwd}      ${cfpwd}    &{warnmsg}
      PageChangePwd.Close Change Password Modal
