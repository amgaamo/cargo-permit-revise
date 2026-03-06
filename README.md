## How to run script or use Images

#### Install Library

**1) robotframework-browser**

	Following step to install lib https://robotframework-browser.org/#installation
	(Browser lib V.15.0.1)

**2) Other Lib**

	pip install robotframework-csvlib==1.0.1
	pip install robotframework-jsonlibrary
	pip install robotframework-doesislibrary==0.1.0
	pip install robotframework-requests
	pip install rpaframework==20.0.0


------------

#### Set Environment

| Environment Name | Description |
| ------ | ------ |
| PROTOCOL_USERMANAGEMENT | Protocol ของระบบ ระบุ http หรือ https |
| DOMAIN_USERMANAGEMENT | Domain ของระบบ |
| URLPATH_USERMANAGEMENT | Url Path ของระบบ |
| APIPATH_USERMANAGEMENT | API Path ของระบบ กรณีที่ url ที่เรียก api คือ usermanagement-api/users ให้ระบุเป็น usermanagement-api |
| TEST_REGISTER_APPROVEAUTO | การ Set Auto Approve ฟังก์ชันงาน Register ระบุเป็น True หรือ False |
| TEST_COMPANY_APPROVEAUTO | การ Set Auto Approve ฟังก์ชันงาน Company ระบุเป็น True หรือ False |
| TEST_USERMGTSTD_VERSION | ระบุเวอร์ชันของตัว User Management ระบุเป็น STANDARD หรือ IE5DEV |
| FUNCTION_CREATE_DEFAULTDATA | Set True/False สำหรับการเซ็ท Default Data |
| FUNCTION_TEST_USERMANAGEMENT | Set True/False สำหรับการรันฟังก์ชันงาน User Management |
| FUNCTION_TEST_PROFILE | Set True/False สำหรับการรันฟังก์ชันงาน Profile (Login/Logout/Change pwd/View Profile) |
| FUNCTION_TEST_REGISTER | Set True/False สำหรับการรันฟังก์ชันงาน Register |
| FUNCTION_TEST_PAGING | Set True/False สำหรับการรันฟังก์ชันงานที่เกี่ยวกับ Paging ต่างๆ |

#### Pull Code and Run with robot framework
**ตรวจสอบต้องมี superadmin ที่ Login เข้าระบบก่อนรันเสมอ**
โดยระบุ username/password ที่เป็น superadmin ได้ที่
> **resources >> datatest >> login_data.csv**

**How to run script robot**
> robot -d output --listener listener_email/EmailListener.py -V listener_email/config.py testsuite

#### Using Images

1. Pull Image ตัวล่าสุด
2. ดาวน์โหลด env.list ไปวางไว้ในโฟลเดอร์ที่ต้องการรัน
3. ระบุข้อมูล env.list ให้เรียบร้อยตามไซต์ที่ทดสอบ
4. รันสคริปต์สองส่วน กรณีที่ไม่เคยรัน ครั้งแรกต้องรัน defaultdata เพื่อสร้างข้อมูลทดสอบตั้งต้นให้ระบบ โดยใช้คำสั่ง
> docker run --rm --env-file env.list {{imagename}} robot -d output --listener listener_email/EmailListener.py -V listener_email/config.py testsuite/defaultdata 
**(ต้องรัน defaultdata ให้ผ่านทั้งหมดเพื่อสร้างข้อมูลการทดสอบตั้งต้น)**

> docker run --rm --env-file env.list {{imagename}} robot -d output --listener listener_email/EmailListener.py -V listener_email/config.py testsuite

จะเป็นการรันสคริปต์ทั้งหมดที่อยู่ใน testsuite หากต้องการรันตามฟังก์ชันงานสามารถเพิ่มโฟลเดอร์หลัง testsuite ดังต่อไปนี้

    testsuite/{{FOLDER_FUNCTION_TEST}}
ใส่โฟลเดอร์ฟังก์ชันงานที่ต้องการรัน กรณีที่ต้องการรันบางฟังก์ชันงาน ดูแต่ละฟังก์ชันงานที่โฟลเดอร์ testsuite

#### Folder Function
1) USRMGT_STD-USERMANAGEMENT
	- 01-COMPANYTYPE
	- 02-COMPANYFUNC
	- 03-GROUPFUNC
	- 04-ROLEFUNC
	- 05-USERFUNC
	- 06-PERMISSIONFUNC
	- 07-MENUFUNC
2) USRMGT01-LOGINOUT_PROFILE
3) USRMGT02-CHANGEPWD
4) USRMGT03-REGISTER
5) USRMGT04-REGISTERMGTFUNC
ุ6) USRMGT05-PAGING

Ex. การรันแบบตามฟังก์ชัยงาน สามารถรันได้ตามนี้

    testsuite/USRMGT_STD-USERMANAGEMENT

    testsuite/USRMGT_STD-USERMANAGEMENT/01-COMPANYTYPE
	
    testsuite/USRMGT01-LOGINOUT_PROFILE