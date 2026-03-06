import os

# condition to send email if 'True' email will be sent
SEND_EMAIL = True

# email smtp (smpt of yahoo, gmail, msn, outlook etc.,)
# SMPT = "smtp.mail.yahoo.com"
# SMPTPORT = 587
# IMAP = "imap.mail.yahoo.com"
# IMAPPORT = 993
SMPT = "mail.nbgwhosting.com"
SMPTPORT = 587

# email subject
SUBJECT = "User Management Standard - Automation Execution Status"

# credentials
# FROM = "qualityassurance.nb@yahoo.com"
# PASSWORD = "frjatiqnwgseghnb"
FROM = "test002@mail.nbgwhosting.com"
PASSWORD = "Netbay@123"


# receivers
TO = os.getenv('EMAIL_RECEIVERS')

# Get the values from environment variables
VERSION = os.getenv('TEST_USERMGTSTD_VERSION')
PROTOCOL = os.getenv('PROTOCOL_USERMANAGEMENT')
DOMAIN = os.getenv('DOMAIN_USERMANAGEMENT')
URLPATH = os.getenv('URLPATH_USERMANAGEMENT')

HEADER_NAME = "Summary Result Report"
# OTHERINFO = "USER MANAGEMENT VERSION: "+VERSION+"<br>Domain: "+PROTOCOL+"://"+DOMAIN+"/"+URLPATH

OTHERINFO = "USER MANAGEMENT VERSION: "

if VERSION is not None:
    OTHERINFO += VERSION
else:
    OTHERINFO += "FIXDATA"

OTHERINFO += "<br>Domain: "

if PROTOCOL is not None and DOMAIN is not None and URLPATH is not None:
    OTHERINFO += PROTOCOL + "://" + DOMAIN + "/" + URLPATH
else:
    OTHERINFO += "FIXDATA"
