*** Settings ***
Resource    commonkeywords.resource
Resource    datatest/defaultdatalist.resource

*** Variable ***
####### CSV PATH #######
${CSVPATH_LOGINDATA}                 ${CURDIR}${/}datatest${/}login_data.csv
${CSVPATH_PROFILEDATA}               ${CURDIR}${/}datatest${/}userdata.csv
${CSVPATH_COMPANYDATA}               ${CURDIR}${/}datatest${/}companydata.csv
${CSVPATH_GROUPDATA}                 ${CURDIR}${/}datatest${/}groupdata.csv
${CSVPATH_ROLEDATA}                  ${CURDIR}${/}datatest${/}roledata.csv
${CSVPATH_PERMDATA}                  ${CURDIR}${/}datatest${/}permdata.csv
${CSVPATH_MENUDATA}                  ${CURDIR}${/}datatest${/}menudata.csv
${CSVPATH_REGISDATA}                 ${CURDIR}${/}datatest${/}regisdata.csv
${CSVPATH_CTYPEDATA}                 ${CURDIR}${/}datatest${/}ctypedata.csv

####### JSON PATH #######
${JSONPATH_DEFAULTDATA}              ${CURDIR}${/}datatest${/}defaultdata.json
${JSONPATH_ADDRESSDATA}              ${CURDIR}${/}datatest${/}addressdata.json

####### OTHER PATH #######
${IDCARD_JPGDATATEST}                 ${CURDIR}${/}datatest${/}attached_idcard${/}JPEG_idcard.jpg
${IDCARD_PDFDATATEST}                 ${CURDIR}${/}datatest${/}attached_idcard${/}PDF_idcard.pdf


*** Keywords ***
Import datasource file
    [Arguments]     ${pathfile}
      ${htable}=             Read Table From CSV    path=${pathfile}   header=${FALSE}     columns=None      delimiters=,     encoding=UTF-8
      ${header_row}=         Pop Table Row     ${htable}         as_list=${TRUE}
      ${name_key_col}=       Get From List     ${header_row}     0
      Remove Values From List         ${header_row}     ${name_key_col}
      ${length_col}=    Get Length    ${header_row}

      Set local Variable     &{value_col}     &{EMPTY}
      FOR   ${key}    IN RANGE    ${length_col}
            Set To Dictionary     ${value_col}    ${header_row}[${key}]=${key}
            ${key}=   Evaluate   ${key}+1
      END

      ${datasource_val}=     read csv as dictionary    ${pathfile}     ${name_key_col}     ${header_row}     ,

      Set Suite Variable    ${value_col}
      Set Suite Variable    ${datasource_val}

Import datasource json file
    [Arguments]     ${pathfile}
      ${jsondata}=        RPA.JSON.Load JSON From File     ${pathfile}     utf-8
      Set Suite Variable    ${jsondata}

#++++++++++++ Keyword: Import JSON Data +++++++++++++++++#
Import DataSource DEFAULT DATA
      Import datasource json file     ${JSONPATH_DEFAULTDATA}
      Set Global Variable             ${JS_DEFAULTDATA}        ${jsondata}

Import DataSource ADDRESS DATA
      Import datasource json file     ${JSONPATH_ADDRESSDATA}
      Set Local Variable              ${JS_ADDRDATA}           ${jsondata}

      Set Global Variable             ${ADDR_PATHUMWAN_BKK}     ${JS_ADDRDATA['addressdata'][0]}
      Set Global Variable             ${ADDR_MUANG_KKN}         ${JS_ADDRDATA['addressdata'][1]}
      Set Global Variable             ${ADDR_ARAN_SKW}          ${JS_ADDRDATA['addressdata'][2]}
      Set Global Variable             ${ADDR_JOMTHONG_BKK}      ${JS_ADDRDATA['addressdata'][3]}

#++++++++++++ Keyword: Import CSV Data +++++++++++++++++#
Import DataSource USER LOGIN
      Import datasource file    ${CSVPATH_LOGINDATA}
      Set Global Variable       ${login_col}      ${value_col}
      Set Global Variable       ${DS_LOGIN}       ${datasource_val}

Import DataSource USER PROFILE
      Import datasource file    ${CSVPATH_PROFILEDATA}
      Set Global Variable       ${usrdata_col}          ${value_col}
      Set Global Variable       ${DS_USERPROFILE}       ${datasource_val}

Import DataSource COMPANY INFO DATA
      Import datasource file    ${CSVPATH_COMPANYDATA}
      Set Global Variable       ${company_col}      ${value_col}
      Set Global Variable       ${DS_COMPANY}       ${datasource_val}

Import DataSource GROUP INFO DATA
      Import datasource file    ${CSVPATH_GROUPDATA}
      Set Global Variable       ${group_col}      ${value_col}
      Set Global Variable       ${DS_GROUP}       ${datasource_val}

Import DataSource ROLE INFO DATA
      Import datasource file    ${CSVPATH_ROLEDATA}
      Set Global Variable       ${role_col}      ${value_col}
      Set Global Variable       ${DS_ROLE}       ${datasource_val}

Import DataSource PERMISSION INFO DATA
      Import datasource file    ${CSVPATH_PERMDATA}
      Set Global Variable       ${perm_col}      ${value_col}
      Set Global Variable       ${DS_PERM}       ${datasource_val}

Import DataSource MENU INFO DATA
      Import datasource file    ${CSVPATH_MENUDATA}
      Set Global Variable       ${menu_col}      ${value_col}
      Set Global Variable       ${DS_MENU}       ${datasource_val}

Import DataSource REGISTER INFO DATA
      Import datasource file    ${CSVPATH_REGISDATA}
      Set Global Variable       ${reg_col}      ${value_col}
      Set Global Variable       ${DS_REGIS}     ${datasource_val}

Import DataSource COMPANY TYPE INFO DATA
      Import datasource file    ${CSVPATH_CTYPEDATA}
      Set Global Variable       ${ctype_col}      ${value_col}
      Set Global Variable       ${DS_CTYPE}       ${datasource_val}
