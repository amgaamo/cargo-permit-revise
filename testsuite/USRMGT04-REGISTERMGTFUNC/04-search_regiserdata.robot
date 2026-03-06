*** Settings ***
Resource        ../../resources/commonkeywords.resource

Suite setup       Run Keywords      dataSources.Import DataSource USER LOGIN
...               AND               datasources.Import DataSource REGISTER INFO DATA
...               AND               datasources.Import DataSource DEFAULT DATA
...               AND               datasources.Import DataSource ADDRESS DATA
...               AND               commonkeywords.Set Data for Run Automated Test 
...               AND               commonkeywords.Get Data Current Date
...               AND               commonkeywords.Generate Random Number    lengthno=8
...               AND               commonkeywords.Generate Random Values    lengthno=3    lenghtletter=3

...               AND               Set Suite Variable    ${regis_comname1}          ${DS_REGIS['searchdata1'][${reg_col.companyName}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${regis_comtaxid1}             ${DS_REGIS['searchdata1'][${reg_col.taxid}]}${GLOBAL_GENNUMBER}
...               AND               Set Suite Variable    ${regis_companyemail1}         ${DS_REGIS['searchdata1'][${reg_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Set Suite Variable    ${regis_comcontactmail1}       ${DS_REGIS['searchdata1'][${reg_col.contactemail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Set Suite Variable    ${regis_comusername1}          ${DS_REGIS['searchdata1'][${reg_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${regis_comuseremail1}         ${DS_REGIS['searchdata1'][${reg_col.useremail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com

...               AND               Set Suite Variable    ${regis_comname2}          ${DS_REGIS['searchdata2'][${reg_col.companyName}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${regis_comtaxid2}             ${DS_REGIS['searchdata2'][${reg_col.taxid}]}${GLOBAL_GENNUMBER}
...               AND               Set Suite Variable    ${regis_companyemail2}         ${DS_REGIS['searchdata2'][${reg_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Set Suite Variable    ${regis_comcontactmail2}       ${DS_REGIS['searchdata2'][${reg_col.contactemail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Set Suite Variable    ${regis_comusername2}          ${DS_REGIS['searchdata2'][${reg_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${regis_comuseremail2}         ${DS_REGIS['searchdata2'][${reg_col.useremail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com

...               AND               Set Suite Variable    ${regis_comname3}          ${DS_REGIS['searchdata3'][${reg_col.companyName}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${regis_comtaxid3}             ${DS_REGIS['searchdata3'][${reg_col.taxid}]}${GLOBAL_GENNUMBER}
...               AND               Set Suite Variable    ${regis_companyemail3}         ${DS_REGIS['searchdata3'][${reg_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Set Suite Variable    ${regis_comcontactmail3}       ${DS_REGIS['searchdata3'][${reg_col.contactemail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Set Suite Variable    ${regis_comusername3}          ${DS_REGIS['searchdata3'][${reg_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${regis_comuseremail3}         ${DS_REGIS['searchdata3'][${reg_col.useremail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com

...               AND               Set Suite Variable    ${regis_comname4}          ${DS_REGIS['searchdata4'][${reg_col.companyName}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${regis_comtaxid4}             ${DS_REGIS['searchdata4'][${reg_col.taxid}]}${GLOBAL_GENNUMBER}
...               AND               Set Suite Variable    ${regis_companyemail4}         ${DS_REGIS['searchdata4'][${reg_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Set Suite Variable    ${regis_comcontactmail4}       ${DS_REGIS['searchdata4'][${reg_col.contactemail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Set Suite Variable    ${regis_comusername4}          ${DS_REGIS['searchdata4'][${reg_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${regis_comuseremail4}         ${DS_REGIS['searchdata4'][${reg_col.useremail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com

...               AND               Set Suite Variable    ${regis_comname5}          ${DS_REGIS['searchdata5'][${reg_col.companyName}]}${SPACE}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${regis_comtaxid5}             ${DS_REGIS['searchdata5'][${reg_col.taxid}]}${GLOBAL_GENNUMBER}
...               AND               Set Suite Variable    ${regis_companyemail5}         ${DS_REGIS['searchdata5'][${reg_col.email}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Set Suite Variable    ${regis_comcontactmail5}       ${DS_REGIS['searchdata5'][${reg_col.contactemail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Set Suite Variable    ${regis_comusername5}          ${DS_REGIS['searchdata5'][${reg_col.username}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}
...               AND               Set Suite Variable    ${regis_comuseremail5}         ${DS_REGIS['searchdata5'][${reg_col.useremail}]}${GLOBAL_RANDOMLETTER}${GLOBAL_RANDOMNO}@botmail.com
...               AND               Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}. 
...               AND               Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version

...               AND               commonkeywords.Initialize System and Go to Login Page
...               AND               commonkeywords.Login System     ${DS_LOGIN['robotadmin1'][${login_col.username}]}   ${DS_LOGIN['robotadmin1'][${login_col.password}]}
...               AND               commonkeywords.Go to MENU name                ${mainmenu}[registerMgt]
...               AND               commonkeywords.Verify Page Name is correct    ${menuname}[regMgt]

...               AND               Log To Console    \nAdd Register Data Test: Processing ...
...               AND               commonkeywords.Verify Button State            ${LOCATOR_ADDREGISTER_BTN}    visible
...               AND               commonkeywords.Click button on list page      ${LOCATOR_ADDREGISTER_BTN}
...               AND               pageRegister.Create Register Data Test
...                                   registerType=${REGISTYPE}[${DS_REGIS['searchdata1'][${reg_col.regisType}]}]
...                                   taxid=${regis_comtaxid1}
...                                   comtype=${REGISCOMTYPE}[${DS_REGIS['searchdata1'][${reg_col.companyType}]}]
...                                   comname=${regis_comname1}
...                                   companyBranch=${DS_REGIS['searchdata1'][${reg_col.companyBranch}]}
...                                   houseNum=${ADDR_PATHUMWAN_BKK}[housenum]          moo=${ADDR_PATHUMWAN_BKK}[moo]              building=${ADDR_PATHUMWAN_BKK}[building]    soi=${ADDR_PATHUMWAN_BKK}[soi]              street=${ADDR_PATHUMWAN_BKK}[street]
...                                   subDistrict=${ADDR_PATHUMWAN_BKK}[subdistrict]    district=${ADDR_PATHUMWAN_BKK}[district]    province=${ADDR_PATHUMWAN_BKK}[province]    postcode=${ADDR_PATHUMWAN_BKK}[postcode]
...                                   phone=${DS_REGIS['searchdata1'][${reg_col.phone}]}
...                                   email=${regis_companyemail1}
...                                   contactname=${DS_REGIS['searchdata1'][${reg_col.contactname}]}    contactlastname=${DS_REGIS['searchdata1'][${reg_col.contactlastname}]}    contactemail=${regis_comcontactmail1}    contactphone=${DS_REGIS['searchdata1'][${reg_col.contactphone}]}
...                                   uploadpath=${IDCARD_JPGDATATEST}
...                                   userfirstname=${DS_REGIS['searchdata1'][${reg_col.firstname}]}    userlastname=${DS_REGIS['searchdata1'][${reg_col.lastname}]}
...                                   userphone=${DS_REGIS['searchdata1'][${reg_col.userphone}]}        useremail=${regis_comuseremail1}
...                                   username=${regis_comusername1}
...                                   userpwd=${VAR_DEFAULT_PASSWORD}

...               AND               commonkeywords.Verify Button State            ${LOCATOR_ADDREGISTER_BTN}    visible
...               AND               commonkeywords.Click button on list page      ${LOCATOR_ADDREGISTER_BTN}
...               AND               pageRegister.Create Register Data Test
...                                   registerType=${REGISTYPE}[${DS_REGIS['searchdata2'][${reg_col.regisType}]}]
...                                   taxid=${regis_comtaxid2}
...                                   comtype=${REGISCOMTYPE}[${DS_REGIS['searchdata2'][${reg_col.companyType}]}]
...                                   comname=${regis_comname2}
...                                   companyBranch=${DS_REGIS['searchdata2'][${reg_col.companyBranch}]}
...                                   houseNum=${ADDR_PATHUMWAN_BKK}[housenum]          moo=${ADDR_PATHUMWAN_BKK}[moo]              building=${ADDR_PATHUMWAN_BKK}[building]    soi=${ADDR_PATHUMWAN_BKK}[soi]              street=${ADDR_PATHUMWAN_BKK}[street]
...                                   subDistrict=${ADDR_PATHUMWAN_BKK}[subdistrict]    district=${ADDR_PATHUMWAN_BKK}[district]    province=${ADDR_PATHUMWAN_BKK}[province]    postcode=${ADDR_PATHUMWAN_BKK}[postcode]
...                                   phone=${DS_REGIS['searchdata2'][${reg_col.phone}]}
...                                   email=${regis_companyemail2}
...                                   contactname=${DS_REGIS['searchdata2'][${reg_col.contactname}]}    contactlastname=${DS_REGIS['searchdata2'][${reg_col.contactlastname}]}    contactemail=${regis_comcontactmail2}    contactphone=${DS_REGIS['searchdata2'][${reg_col.contactphone}]}
...                                   uploadpath=${IDCARD_JPGDATATEST}
...                                   userfirstname=${DS_REGIS['searchdata2'][${reg_col.firstname}]}    userlastname=${DS_REGIS['searchdata2'][${reg_col.lastname}]}
...                                   userphone=${DS_REGIS['searchdata2'][${reg_col.userphone}]}        useremail=${regis_comuseremail2}
...                                   username=${regis_comusername2}
...                                   userpwd=${VAR_DEFAULT_PASSWORD}

...               AND               commonkeywords.Verify Button State            ${LOCATOR_ADDREGISTER_BTN}    visible
...               AND               commonkeywords.Click button on list page      ${LOCATOR_ADDREGISTER_BTN}
...               AND               pageRegister.Create Register Data Test
...                                   registerType=${REGISTYPE}[${DS_REGIS['searchdata3'][${reg_col.regisType}]}]
...                                   taxid=${regis_comtaxid3}
...                                   comtype=${REGISCOMTYPE}[${DS_REGIS['searchdata3'][${reg_col.companyType}]}]
...                                   comname=${regis_comname3}
...                                   companyBranch=${DS_REGIS['searchdata3'][${reg_col.companyBranch}]}
...                                   houseNum=${ADDR_PATHUMWAN_BKK}[housenum]          moo=${ADDR_PATHUMWAN_BKK}[moo]              building=${ADDR_PATHUMWAN_BKK}[building]    soi=${ADDR_PATHUMWAN_BKK}[soi]              street=${ADDR_PATHUMWAN_BKK}[street]
...                                   subDistrict=${ADDR_PATHUMWAN_BKK}[subdistrict]    district=${ADDR_PATHUMWAN_BKK}[district]    province=${ADDR_PATHUMWAN_BKK}[province]    postcode=${ADDR_PATHUMWAN_BKK}[postcode]
...                                   phone=${DS_REGIS['searchdata3'][${reg_col.phone}]}
...                                   email=${regis_companyemail3}
...                                   contactname=${DS_REGIS['searchdata3'][${reg_col.contactname}]}    contactlastname=${DS_REGIS['searchdata3'][${reg_col.contactlastname}]}    contactemail=${regis_comcontactmail3}    contactphone=${DS_REGIS['searchdata3'][${reg_col.contactphone}]}
...                                   uploadpath=${IDCARD_JPGDATATEST}
...                                   userfirstname=${DS_REGIS['searchdata3'][${reg_col.firstname}]}    userlastname=${DS_REGIS['searchdata3'][${reg_col.lastname}]}
...                                   userphone=${DS_REGIS['searchdata3'][${reg_col.userphone}]}        useremail=${regis_comuseremail3}
...                                   username=${regis_comusername3}
...                                   userpwd=${VAR_DEFAULT_PASSWORD}

...               AND               commonkeywords.Verify Button State            ${LOCATOR_ADDREGISTER_BTN}    visible
...               AND               commonkeywords.Click button on list page      ${LOCATOR_ADDREGISTER_BTN}
...               AND               pageRegister.Create Register Data Test
...                                   registerType=${REGISTYPE}[${DS_REGIS['searchdata4'][${reg_col.regisType}]}]
...                                   taxid=${regis_comtaxid4}
...                                   comtype=${REGISCOMTYPE}[${DS_REGIS['searchdata4'][${reg_col.companyType}]}]
...                                   comname=${regis_comname4}
...                                   companyBranch=${DS_REGIS['searchdata4'][${reg_col.companyBranch}]}
...                                   houseNum=${ADDR_PATHUMWAN_BKK}[housenum]          moo=${ADDR_PATHUMWAN_BKK}[moo]              building=${ADDR_PATHUMWAN_BKK}[building]    soi=${ADDR_PATHUMWAN_BKK}[soi]              street=${ADDR_PATHUMWAN_BKK}[street]
...                                   subDistrict=${ADDR_PATHUMWAN_BKK}[subdistrict]    district=${ADDR_PATHUMWAN_BKK}[district]    province=${ADDR_PATHUMWAN_BKK}[province]    postcode=${ADDR_PATHUMWAN_BKK}[postcode]
...                                   phone=${DS_REGIS['searchdata4'][${reg_col.phone}]}
...                                   email=${regis_companyemail4}
...                                   contactname=${DS_REGIS['searchdata4'][${reg_col.contactname}]}    contactlastname=${DS_REGIS['searchdata4'][${reg_col.contactlastname}]}    contactemail=${regis_comcontactmail4}    contactphone=${DS_REGIS['searchdata4'][${reg_col.contactphone}]}
...                                   uploadpath=${IDCARD_JPGDATATEST}
...                                   userfirstname=${DS_REGIS['searchdata4'][${reg_col.firstname}]}    userlastname=${DS_REGIS['searchdata4'][${reg_col.lastname}]}
...                                   userphone=${DS_REGIS['searchdata4'][${reg_col.userphone}]}        useremail=${regis_comuseremail4}
...                                   username=${regis_comusername4}
...                                   userpwd=${VAR_DEFAULT_PASSWORD}

...               AND               commonkeywords.Verify Button State            ${LOCATOR_ADDREGISTER_BTN}    visible
...               AND               commonkeywords.Click button on list page      ${LOCATOR_ADDREGISTER_BTN}
...               AND               pageRegister.Create Register Data Test
...                                   registerType=${REGISTYPE}[${DS_REGIS['searchdata5'][${reg_col.regisType}]}]
...                                   taxid=${regis_comtaxid5}
...                                   comtype=${REGISCOMTYPE}[${DS_REGIS['searchdata5'][${reg_col.companyType}]}]
...                                   comname=${regis_comname5}
...                                   companyBranch=${DS_REGIS['searchdata5'][${reg_col.companyBranch}]}
...                                   houseNum=${ADDR_PATHUMWAN_BKK}[housenum]          moo=${ADDR_PATHUMWAN_BKK}[moo]              building=${ADDR_PATHUMWAN_BKK}[building]    soi=${ADDR_PATHUMWAN_BKK}[soi]              street=${ADDR_PATHUMWAN_BKK}[street]
...                                   subDistrict=${ADDR_PATHUMWAN_BKK}[subdistrict]    district=${ADDR_PATHUMWAN_BKK}[district]    province=${ADDR_PATHUMWAN_BKK}[province]    postcode=${ADDR_PATHUMWAN_BKK}[postcode]
...                                   phone=${DS_REGIS['searchdata5'][${reg_col.phone}]}
...                                   email=${regis_companyemail5}
...                                   contactname=${DS_REGIS['searchdata5'][${reg_col.contactname}]}    contactlastname=${DS_REGIS['searchdata5'][${reg_col.contactlastname}]}    contactemail=${regis_comcontactmail5}    contactphone=${DS_REGIS['searchdata5'][${reg_col.contactphone}]}
...                                   uploadpath=${IDCARD_JPGDATATEST}
...                                   userfirstname=${DS_REGIS['searchdata5'][${reg_col.firstname}]}    userlastname=${DS_REGIS['searchdata5'][${reg_col.lastname}]}
...                                   userphone=${DS_REGIS['searchdata5'][${reg_col.userphone}]}        useremail=${regis_comuseremail5}
...                                   username=${regis_comusername5}
...                                   userpwd=${VAR_DEFAULT_PASSWORD}

...               AND               Log To Console    \nAdd Register Data Test 5 Success

...               AND               Prepare Register Data for status case
...               AND               Log To Console    \nCreate Data Test for search is success!

...               AND               commonkeywords.Wait Loading progress
...               AND               commonkeywords.Click Expand Search Criteria
...               AND               commonkeywords.Click button on list page    ${LOCATOR_CLEARSEARCHREGIS_BTN}
...               AND               commonkeywords.Wait Loading progress

Test Template     Template Search Register Management

Test Teardown     Run Keywords      Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version
...               AND               Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}. 
...               AND               commonkeywords.Click button on list page    ${LOCATOR_CLEARSEARCHREGIS_BTN}
...               AND               Sleep   500ms
...               AND               commonkeywords.Wait Loading progress

Suite Teardown    Run Keywords    Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
...                                   \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}.   
...               AND             commonkeywords.Release user lock and close all browser

*** Test Cases ***
# Case Type P: Positive Case, X=Special Case for Auto Aprrove Register is False, E=Negative Case
#------------------------------------------------------------------------------------------------------------------------------------#
#   CASE NAME   | Case Type |   Type    |   TaxID   |   Name    |   Branch    |   Status    |   Register Date   |   Approve Date     #
#------------------------------------------------------------------------------------------------------------------------------------#

CASE-Search all condition
...       P
...       ${REGISTYPE}[${DS_REGIS['searchdata5'][${reg_col.regisType}]}]
...       ${regis_comtaxid5}
...       ${regis_comname5}
...       ${DS_REGIS['searchdata5'][${reg_col.companyBranch}]}
...       ${REGISSTATUS}[appv]
...       Today
...       Today

CASE-Search by Type
...       P
...       ${REGISTYPE}[legal]
...       ${EMPTY}
...       ${EMPTY}
...       ${EMPTY}
...       Please Select
...       ${EMPTY}
...       ${EMPTY}

CASE-Search by Taxid
...       P
...       Please Select
...       ${regis_comtaxid3}
...       ${EMPTY}
...       ${EMPTY}
...       Please Select
...       ${EMPTY}
...       ${EMPTY}


CASE-Search by Name
...       P
...       Please Select
...       ${EMPTY}
...       ${regis_comname2}
...       ${EMPTY}
...       Please Select
...       ${EMPTY}
...       ${EMPTY}


CASE-Search by Branch
...       P
...       Please Select
...       ${EMPTY}
...       ${EMPTY}
...       ${DS_REGIS['searchdata2'][${reg_col.companyBranch}]}
...       Please Select
...       ${EMPTY}
...       ${EMPTY}


CASE-Search by Status
...       P
...       Please Select
...       ${EMPTY}
...       ${EMPTY}
...       ${EMPTY}
...       ${REGISSTATUS}[appv]
...       ${EMPTY}
...       ${EMPTY}

CASE-Search by Register Date
...       P
...       Please Select
...       ${EMPTY}
...       ${EMPTY}
...       ${EMPTY}
...       ${REGISSTATUS}[appv]
...       Today
...       ${EMPTY}

CASE-Search by Approve Date
...       P
...       Please Select
...       ${EMPTY}
...       ${EMPTY}
...       ${EMPTY}
...       ${REGISSTATUS}[appv]
...       ${EMPTY}
...       Today

CASE-Search by Type and Taxid
...       P
...       ${REGISTYPE}[${DS_REGIS['searchdata1'][${reg_col.regisType}]}]
...       ${regis_comtaxid1}
...       ${EMPTY}
...       ${EMPTY}
...       Please Select
...       ${EMPTY}
...       ${EMPTY}


CASE-Search by Type and Name
...       P
...       ${REGISTYPE}[${DS_REGIS['searchdata2'][${reg_col.regisType}]}]
...       ${EMPTY}
...       ${regis_comname2}
...       ${EMPTY}
...       Please Select
...       ${EMPTY}
...       ${EMPTY}


CASE-Search by Type and Branch
...       P
...       ${REGISTYPE}[${DS_REGIS['searchdata3'][${reg_col.regisType}]}]
...       ${EMPTY}
...       ${EMPTY}
...       ${DS_REGIS['searchdata3'][${reg_col.companyBranch}]}
...       Please Select
...       ${EMPTY}
...       ${EMPTY}

CASE-Search by Type and Status
...       X
...       ${REGISTYPE}[legal]
...       ${EMPTY}
...       ${EMPTY}
...       ${EMPTY}
...       ${REGISSTATUS}[waitappv]
...       ${EMPTY}
...       ${EMPTY}

CASE-Search by Type and Register Date
...       P
...       ${REGISTYPE}[legal]
...       ${EMPTY}
...       ${EMPTY}
...       ${EMPTY}
...       Please Select
...       Today
...       ${EMPTY}

CASE-Search by Type and Approve Date
...       X
...       ${REGISTYPE}[${DS_REGIS['searchdata5'][${reg_col.regisType}]}]
...       ${EMPTY}
...       ${EMPTY}
...       ${EMPTY}
...       Please Select
...       ${EMPTY}
...       Today

CASE-Search by Taxid and Name
...       P
...       Please Select
...       ${regis_comtaxid3}
...       ${regis_comname3}
...       ${EMPTY}
...       Please Select
...       ${EMPTY}
...       ${EMPTY}

CASE-Search by Taxid and Branch
...       P
...       Please Select
...       ${EMPTY}
...       ${regis_comname3}
...       ${DS_REGIS['searchdata3'][${reg_col.companyBranch}]}
...       Please Select
...       ${EMPTY}
...       ${EMPTY}


CASE-Search by Taxid and Status
...       P
...       Please Select
...       ${regis_comtaxid5}
...       ${EMPTY}
...       ${EMPTY}
...       ${REGISSTATUS}[appv]
...       ${EMPTY}
...       ${EMPTY}

CASE-Search by Taxid and Register Date
...       X
...       Please Select
...       ${regis_comtaxid5}
...       ${EMPTY}
...       ${EMPTY}
...       Please Select
...       Today
...       ${EMPTY}

CASE-Search by Taxid and Approve Date
...       P
...       Please Select
...       ${regis_comtaxid5}
...       ${EMPTY}
...       ${EMPTY}
...       ${EMPTY}
...       ${EMPTY}
...       Today

CASE-Search by Name and Branch
...       P
...       Please Select
...       ${EMPTY}
...       ${regis_comname1}
...       ${DS_REGIS['searchdata1'][${reg_col.companyBranch}]}
...       Please Select
...       ${EMPTY}
...       ${EMPTY}

CASE-Search by Name and Status
...       X
...       Please Select
...       ${EMPTY}
...       ${regis_comname4}
...       ${EMPTY}
...       ${REGISSTATUS}[rej]
...       ${EMPTY}
...       ${EMPTY}

CASE-Search by Name and Register Date
...       P
...       Please Select
...       ${EMPTY}
...       ${regis_comname4}
...       ${EMPTY}
...       Please Select
...       Today
...       ${EMPTY}

CASE-Search by Name and Approve Date
...       X
...       Please Select
...       ${EMPTY}
...       ${regis_comname5}
...       ${EMPTY}
...       Please Select
...       ${EMPTY}
...       Today

CASE-Search by Branch and Status
...       X
...       Please Select
...       ${EMPTY}
...       ${EMPTY}
...       ${DS_REGIS['searchdata4'][${reg_col.companyBranch}]}
...       ${REGISSTATUS}[rej]
...       ${EMPTY}
...       ${EMPTY}

CASE-Search by Status and Register Date
...       X
...       Please Select
...       ${EMPTY}
...       ${EMPTY}
...       ${EMPTY}
...       ${REGISSTATUS}[rej]
...       Today
...       ${EMPTY}

CASE-Search by Status and Approve Date
...       X
...       Please Select
...       ${EMPTY}
...       ${EMPTY}
...       ${EMPTY}
...       ${REGISSTATUS}[appv]
...       ${EMPTY}
...       Today

CASE-Search by Type, Taxid, Name
...       P
...       ${REGISTYPE}[${DS_REGIS['searchdata1'][${reg_col.regisType}]}]
...       ${regis_comtaxid1}
...       ${regis_comname1}
...       ${EMPTY}
...       Please Select
...       ${EMPTY}
...       ${EMPTY}


CASE-Search by Type, Taxid, Status
...       P
...       ${REGISTYPE}[${DS_REGIS['searchdata5'][${reg_col.regisType}]}]
...       ${regis_comtaxid5}
...       ${EMPTY}
...       ${EMPTY}
...       ${REGISSTATUS}[appv]
...       ${EMPTY}
...       ${EMPTY}

CASE-Search by Type, Taxid, Regisdate
...       P
...       ${REGISTYPE}[${DS_REGIS['searchdata2'][${reg_col.regisType}]}]
...       ${regis_comtaxid2}
...       ${EMPTY}
...       ${EMPTY}
...       Please Select
...       Today
...       ${EMPTY}

CASE-Search by Type, Taxid, ApproveDate
...       P
...       ${REGISTYPE}[${DS_REGIS['searchdata5'][${reg_col.regisType}]}]
...       ${regis_comtaxid5}
...       ${EMPTY}
...       ${EMPTY}
...       Please Select
...       ${EMPTY}
...       Today

CASE-Search by Type, Name, Status
...       X
...       ${REGISTYPE}[${DS_REGIS['searchdata4'][${reg_col.regisType}]}]
...       ${EMPTY}
...       ${regis_comname4}
...       ${EMPTY}
...       ${REGISSTATUS}[rej]
...       ${EMPTY}
...       ${EMPTY}

CASE-Search by Type, Taxid, Name,Status
...       X
...       ${REGISTYPE}[${DS_REGIS['searchdata5'][${reg_col.regisType}]}]
...       ${regis_comtaxid5}
...       ${regis_comname5}
...       ${EMPTY}
...       ${REGISSTATUS}[appv]
...       ${EMPTY}
...       ${EMPTY}

CASE-Search by Type, Taxid, Name,Status,Register Date
...       P
...       ${REGISTYPE}[${DS_REGIS['searchdata5'][${reg_col.regisType}]}]
...       ${regis_comtaxid5}
...       ${regis_comname5}
...       ${EMPTY}
...       ${REGISSTATUS}[appv]
...       Today
...       ${EMPTY}

CASE-Search by Type, Taxid, Name,Status,Approve Date
...       X
...       ${REGISTYPE}[${DS_REGIS['searchdata4'][${reg_col.regisType}]}]
...       ${regis_comtaxid4}
...       ${regis_comname4}
...       ${EMPTY}
...       ${REGISSTATUS}[rej]
...       ${EMPTY}
...       Today

CASE-Search Negative Case not found data
...       E
...       Please Select
...       0000000000
...       ${regis_comname1}
...       ${DS_REGIS['searchdata1'][${reg_col.companyBranch}]}
...       ${REGISSTATUS}[appv]
...       ${EMPTY}
...       ${EMPTY}

CASE-Search Negative Case not found data2
...       E
...       Please Select
...       ${EMPTY}
...       NOT FOUND COMPANY
...       ${EMPTY}
...       ${REGISSTATUS}[appv]
...       ${EMPTY}
...       ${EMPTY}

CASE-Search Negative Case not found data3
...       E
...       Please Select
...       ${EMPTY}
...       ${EMPTY}
...       99910
...       ${REGISSTATUS}[appv]
...       ${EMPTY}
...       ${EMPTY}


*** Keywords ***
Template Search Register Management
      [Arguments]     ${casetype}     ${registype}      ${taxid}      ${name}     ${branch}    ${status}   ${registerdate}     ${approvedate}

        Pass Execution If    '${GLOBAL_REGISTER_FUNCTEST}'=='False'             
        ...       \nNo Execute this function: GLOBAL_REGISTER_FUNCTEST is ${GLOBAL_REGISTER_FUNCTEST}. 
        Pass Execution If    '${GLOBAL_STANDARD_VERSION}'=='IE5DEV'       Execute Test Only Standard Version

        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYREGISTYPE_SEL}          ${registype}
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYREGISTAX_FILED}         ${taxid}
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYREGISNAME_FILED}        ${name}
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYREGISBRANCH_FILED}      ${branch}
        commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYREGISSTATUS_SEL}        ${status}

        IF   '${registerdate}'=='Today'
              commonkeywords.Click button on list page      ${LOCATOR_SEARCHBYREGISDATE_FROM}
              commonkeywords.Verify Field State             ${LOCATOR_SEARCHBYREGISDATE_TODAY}      visible
              commonkeywords.Click button on list page      ${LOCATOR_SEARCHBYREGISDATE_TODAY}

              commonkeywords.Click button on list page      ${LOCATOR_SEARCHBYREGISDATE_TO}
              commonkeywords.Verify Field State             ${LOCATOR_SEARCHBYREGISDATE_TODAY}      visible
              commonkeywords.Click button on list page      ${LOCATOR_SEARCHBYREGISDATE_TODAY}
        END
        IF   '${approvedate}'=='Today'
              commonkeywords.Click button on list page      ${LOCATOR_SEARCHBYAPPVDATE_FROM}
              commonkeywords.Verify Field State             ${LOCATOR_SEARCHBYAPPVDATE_TODAY}      visible
              commonkeywords.Click button on list page      ${LOCATOR_SEARCHBYAPPVDATE_TODAY}

              commonkeywords.Click button on list page      ${LOCATOR_SEARCHBYAPPVDATE_TO}
              commonkeywords.Verify Field State             ${LOCATOR_SEARCHBYAPPVDATE_TODAY}      visible
              commonkeywords.Click button on list page      ${LOCATOR_SEARCHBYAPPVDATE_TODAY}
        END

        commonkeywords.Click button on list page            ${LOCATOR_SEARCHREGIS_BTN}
        commonkeywords.Wait Loading progress
        Sleep    500ms
        pageRegister.Verify Regis Management Result Data Table for search function
        ...         ${casetype}     ${registype}      ${taxid}      ${name}     ${branch}    ${status}   ${registerdate}     ${approvedate}

Prepare Register Data for status case
      IF   '${GLOBAL_REGISTER_AUTO_APPRV}'=='False'

            #reject data test
            commonkeywords.Click Expand Search Criteria
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYREGISTYPE_SEL}        ${REGISTYPE}[${DS_REGIS['searchdata4'][${reg_col.regisType}]}]
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYREGISTAX_FILED}       ${regis_comtaxid4}
            commonkeywords.Click button on list page            ${LOCATOR_SEARCHREGIS_BTN}
            commonkeywords.Wait Loading progress
            commonkeywords.Click Hide Search Criteria

            pageRegister.Verify Regis Management Result Datatable    1    taxid           should be     ${regis_comtaxid4}
            pageRegister.Verify Regis Management Result Datatable    1    status          should be     ${REGISSTATUS}[waitappv]
            commonkeywords.Click button on list page    ${1ROW_REGIS_ACTION}[view]
            commonkeywords.Wait Loading progress
            Sleep   1s

            commonkeywords.Verify data form               ${LOCATOR_COMTAXID_FIELD}        should be    ${regis_comtaxid4}
            commonkeywords.Fill in data form              ${LOCATOR_REGISREJECT_REASON_FIELD}           Reject Register for Data Test
            commonkeywords.Click button on detail page    ${LOCATOR_REGISTER_REJECT_BTN}
            commonkeywords.Verify Modal Title message     Success
            commonkeywords.Verify Modal Content message   Reject completed
            commonkeywords.Click OK Button
            commonkeywords.Wait Loading progress
            commonkeywords.Click Expand Search Criteria
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYREGISTYPE_SEL}        ${REGISTYPE}[${DS_REGIS['searchdata4'][${reg_col.regisType}]}]
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYREGISTAX_FILED}       ${regis_comtaxid4}
            commonkeywords.Click button on list page            ${LOCATOR_SEARCHREGIS_BTN}
            commonkeywords.Wait Loading progress
            pageRegister.Verify Regis Management Result Datatable    1    taxid           should be     ${regis_comtaxid4}
            pageRegister.Verify Regis Management Result Datatable    1    status          should be     ${REGISSTATUS}[rej]

            #approve data test
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYREGISTYPE_SEL}        ${REGISTYPE}[${DS_REGIS['searchdata5'][${reg_col.regisType}]}]
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYREGISTAX_FILED}       ${regis_comtaxid5}
            commonkeywords.Click button on list page            ${LOCATOR_SEARCHREGIS_BTN}
            commonkeywords.Wait Loading progress
            commonkeywords.Click Hide Search Criteria
            pageRegister.Verify Regis Management Result Datatable    1    taxid           should be     ${regis_comtaxid5}
            pageRegister.Verify Regis Management Result Datatable    1    status          should be     ${REGISSTATUS}[waitappv]
            commonkeywords.Click button on list page    ${1ROW_REGIS_ACTION}[view]
            commonkeywords.Wait Loading progress

            commonkeywords.Click button on detail page      ${LOCATOR_REGISTER_APPROVE_BTN}
            commonkeywords.Verify Modal Title message       Success
            commonkeywords.Verify Modal Content message     Approved completed
            commonkeywords.Click OK Button
            commonkeywords.Wait Loading progress
            commonkeywords.Click Expand Search Criteria
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYREGISTYPE_SEL}        ${REGISTYPE}[${DS_REGIS['searchdata5'][${reg_col.regisType}]}]
            commonkeywords.Fill in search field on list page    ${LOCATOR_SEARCHBYREGISTAX_FILED}       ${regis_comtaxid5}
            commonkeywords.Click button on list page            ${LOCATOR_SEARCHREGIS_BTN}
            commonkeywords.Wait Loading progress
            pageRegister.Verify Regis Management Result Datatable    1    taxid           should be     ${regis_comtaxid5}
            pageRegister.Verify Regis Management Result Datatable    1    status          should be     ${REGISSTATUS}[appv]

      ELSE
          Log To Console    \nRegister Auto Aprove: True
      END
