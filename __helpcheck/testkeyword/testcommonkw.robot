*** Settings ***
Resource          ../../resources/commonkeywords.resource

*** Test Cases ***
Test Using Keywords
    # Using keywords on webpage
    # Using keywords Handle for table
    # Using keywords upload and Download

*** Keywords ***
Using keywords on webpage
      commonkeywords.Open Browser and Go to website    https://courses.letskodeit.com/practice

      ####  Using Keyword for Open New Tab or New Windows #####
      #----------- Get Main pageids ---------------#
      commonkeywords.Get MAIN pageids for switch page
      commonkeywords.Click button on list page    //*[@id="openwindow"]

      #----------- Get New pageids ---------------#
      commonkeywords.Get Information new Page Open

      #----- Switch to new page -------#
      commonkeywords.Switch another open page     ${GLOBAL_NEWPAGE}
      Get Url    should be    https://courses.letskodeit.com/courses

      #----- Switch to main page -------#
      commonkeywords.Switch another open page     ${GLOBAL_MAINPAGE}
      Get Url    should be    https://courses.letskodeit.com/practice

      commonkeywords.Click button on detail page    //a[@href="https://twitter.com/letskodeit"]
      commonkeywords.Get Information new Page Open
      commonkeywords.Switch another open page     ${GLOBAL_NEWPAGE}
      Get Url    should be    https://twitter.com/letskodeit
      commonkeywords.Switch another open page     ${GLOBAL_MAINPAGE}
      Get Url    should be    https://courses.letskodeit.com/practice


      ####  Using Keyword for various type of field #####
      #----- For Radio Type -------#
      commonkeywords.Fill in data form    //*[@id="benzradio"]     ${EMPTY}
      commonkeywords.Verify data form     //*[@id="benzradio"]     should be    True
      Log To Console    ${GLOBAL_RETURNDATA_VALUE}

      commonkeywords.Fill in data form    //*[@id="hondaradio"]    ${EMPTY}
      commonkeywords.Verify data form     //*[@id="hondaradio"]    should be    True
      Log To Console    ${GLOBAL_RETURNDATA_VALUE}
      commonkeywords.Verify data form     //*[@id="benzradio"]     should be    unchecked
      Log To Console    ${GLOBAL_RETURNDATA_VALUE}

      #----- For Checkbox Type -------#
      commonkeywords.Fill in data form    //*[@id="benzcheck"]    True
      commonkeywords.Verify data form     //*[@id="benzcheck"]    should be    True
      Log To Console    ${GLOBAL_RETURNDATA_VALUE}
      commonkeywords.Fill in data form    //*[@id="bmwcheck"]     True
      commonkeywords.Verify data form     //*[@id="bmwcheck"]     should be    True
      Log To Console    ${GLOBAL_RETURNDATA_VALUE}

      #----- For Select Type (Dropdown list) -------#
      commonkeywords.Fill in data form    //*[@id="carselect"]      BMW
      commonkeywords.Verify data form     //*[@id="carselect"]      should be    BMW
      Log To Console    ${GLOBAL_RETURNDATA_VALUE}
      commonkeywords.Fill in data form    //*[@id="carselect"]      benz         sel_attr=value
      commonkeywords.Verify data form     //*[@id="carselect"]      should be    Benz
      Log To Console    ${GLOBAL_RETURNDATA_VALUE}
      commonkeywords.Fill in data form    //*[@id="carselect"]      honda        sel_attr=value
      commonkeywords.Verify data form     //*[@id="carselect"]      should be    honda   sel_attr=value
      Log To Console    ${GLOBAL_RETURNDATA_VALUE}

      ####  Using Keyword for Handle Javascript Alert #####
      commonkeywords.Fill in data form    //*[@id="name" and @name="enter-name"]            Test Robot
      commonkeywords.Click Button and Handle confirmation alert    //*[@id="alertbtn"]      OK
      Reload

      commonkeywords.Fill in data form    //*[@id="name" and @name="enter-name"]            Robot
      commonkeywords.Click Button and Get message alert dialog     //*[@id="alertbtn"]
      Should Contain    ${GLOBAL_ALERTMSG}      Robot
      Reload

      commonkeywords.Fill in data form    //*[@id="name" and @name="enter-name"]              My Robot
      commonkeywords.Click button and Handle confirmation alert    //*[@id="confirmbtn"]      Cancel
      Reload

      commonkeywords.Fill in data form    //*[@id="name" and @name="enter-name"]              Robot101
      commonkeywords.Click Button and Verify message alert dialog    //*[@id="confirmbtn"]    Hello Robot101, Are you sure you want to confirm?
      Reload

Using keywords Handle for table
      #### Using for Handle table ####
      Open Browser and Go to website    https://letcode.in/advancedtable

      commonkeywords.Verify column of data table result       //*[@id="advancedtable"]/tbody/tr[2]/td[2]    contains    Aberystwyth
      Log To Console    ${GLOBAL_RETURNDATA_COLUMN}

      commonkeywords.Get Column of Data Table                 //*[@id="advancedtable"]/thead
      Log Many          ${col_datatable}

      commonkeywords.verify result data table on list page    //*[@id="advancedtable"]/tbody    ${col_datatable}[universityname]    contains       University
      commonkeywords.verify result data table on list page    //*[@id="advancedtable"]/tbody    ${col_datatable}[country]    should be      United Kingdom

      commonkeywords.Fill in search field on list page        //*[@id="advancedtable_filter"]/label/input           London
      commonkeywords.verify result data table on list page    //*[@id="advancedtable"]/tbody    ${col_datatable}[universityname]    contains       London
      Log Many    @{GLOBAL_RETURNDATA_RESULT}

      commonkeywords.Fill in search field on list page        //*[@id="advancedtable_filter"]/label/input           American
      commonkeywords.verify result data table on list page    //*[@id="advancedtable"]/tbody    ${col_datatable}[universityname]     contains       American
      Log Many    @{GLOBAL_RETURNDATA_RESULT}

      commonkeywords.Fill in search field on list page              //*[@id="advancedtable_filter"]/label/input     Not found
      commonkeywords.Verify data table result is No Record Found    //*[@id="advancedtable"]/tbody       No matching records found


      Open Browser and Go to website    https://letcode.in/table
      commonkeywords.Get Column of Data Table     //*[@id="shopping"]/thead
      commonkeywords.verify result data table on list page    //*[@id="shopping"]/tbody         ${col_datatable}[items]           should be     Chocolate    1

      commonkeywords.Get Column of Data Table     //*[@id="simpletable"]/thead
      commonkeywords.verify result data table on list page      //*[@id="simpletable"]/tbody    ${col_datatable}[firstname]       should be     Koushik       1
      commonkeywords.verify result data table on list page      //*[@id="simpletable"]/tbody    ${col_datatable}[emailaddress]    contains      yashwanth     2

      Scroll To Element     //*[@class="card-conetnt"]
      commonkeywords.Get Index Row for data table           //*[@id="simpletable"]/tbody    ${col_datatable}[firstname]            Yashwanth
      commonkeywords.Fill in data form                      //*[@id="simpletable"]/tbody/tr[${GLOBAL_INDEXROWITEM}]/td[4]/input    check
      commonkeywords.Verify column of data table result     //*[@id="simpletable"]/tbody/tr[${GLOBAL_INDEXROWITEM}]/td[4]/input    should be    True


Using keywords upload and Download
      commonkeywords.Open Browser and Go to website      https://demo.guru99.com/test/upload/
      commonkeywords.Choose file to upload    //*[@id="uploadfile_0"]     ${CURDIR}${/}_testupload.txt
      commonkeywords.Click Upload Button      //*[@id="submitbutton"]
      commonkeywords.Verify Button State      //button[@name="send" and contains(@class, 'active')]    hidden
      commonkeywords.Verify data form         //*[@id="res"]    contains    successfully

      commonkeywords.Open Browser and Go to website      https://eternallybored.org/misc/wget/
      commonkeywords.Download data and save file to download folder     //*[@id="content"]/table/tbody/tr[5]/td[4]/a
      commonkeywords.Clear Directory download file    ${GLOBAL_PATHDIR}
