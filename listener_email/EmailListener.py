import os
import math
import datetime
import platform
import time
import sys
import shutil

from zipfile import ZipFile
from os import path
from shutil import make_archive
from robot.libraries.BuiltIn import BuiltIn
from RPA.Email.ImapSmtp import ImapSmtp

class EmailListener:

    ROBOT_LISTENER_API_VERSION = 2

    def __init__(self):
        self.total_tests = 0
        self.passed_tests = 0
        self.failed_tests = 0
        self.PRE_RUNNER = 0
        self.start_time = datetime.datetime.now().time().strftime('%H:%M:%S')

    def start_suite(self, name, attrs):

        # Fetch email details only once
        if self.PRE_RUNNER == 0:
            self.SEND_EMAIL = BuiltIn().get_variable_value("${SEND_EMAIL}")
            self.SMPT = BuiltIn().get_variable_value("${SMPT}")
            self.SMPTPORT = BuiltIn().get_variable_value("${SMPTPORT}")
            self.IMAP = BuiltIn().get_variable_value("${IMAP}")
            self.IMAPPORT = BuiltIn().get_variable_value("${IMAPPORT}")
            self.SUBJECT = BuiltIn().get_variable_value("${SUBJECT}")
            self.FROM = BuiltIn().get_variable_value("${FROM}")
            self.PASSWORD = BuiltIn().get_variable_value("${PASSWORD}")
            self.TO = BuiltIn().get_variable_value("${TO}")
            self.HEADER_NAME = BuiltIn().get_variable_value("${HEADER_NAME}")
            self.OTHERINFO = BuiltIn().get_variable_value("${OTHERINFO}")            
            self.PRE_RUNNER = 1

            self.date_now = datetime.datetime.now().strftime("%Y-%m-%d")

        self.test_count = len(attrs['tests'])

    def end_test(self, name, attrs):
        if self.test_count != 0:
            self.total_tests += 1

        if attrs['status'] == 'PASS':
            self.passed_tests += 1
        else:
            self.failed_tests += 1

    def close(self):
        self.end_time = datetime.datetime.now().time().strftime('%H:%M:%S')
        self.total_time=(datetime.datetime.strptime(self.end_time,'%H:%M:%S') - datetime.datetime.strptime(self.start_time,'%H:%M:%S'))

        # send_email(self.SEND_EMAIL, self.SUBJECT, self.SMPT,self.SMPTPORT, self.IMAP, self.IMAPPORT, self.FROM, self.PASSWORD, self.TO,
        #  self.total_tests, self.passed_tests, self.failed_tests, math.floor(self.passed_tests * 100.0 / self.total_tests),
        #  self.date_now, self.total_time, self.HEADER_NAME, self.OTHERINFO)

        send_email(self.SEND_EMAIL, self.SUBJECT, self.SMPT,self.SMPTPORT, self.FROM, self.PASSWORD, self.TO,
         self.total_tests, self.passed_tests, self.failed_tests, math.floor(self.passed_tests * 100.0 / self.total_tests),
         self.date_now, self.total_time, self.HEADER_NAME, self.OTHERINFO)

        if self.failed_tests != 0:
            print("*** TESTS FAILED ***")
            print(" >>> Email Sent successfully")
            sys.exit(1)
        else:
            print("*** TESTS PASSED ***")
            print(" >>> Email Sent successfully")

# def send_email(send_email, subject, smtp, smtpport, imap, imapport, from_user, pwd, to, total, passed, failed, percentage, exe_date, elapsed_time, header_name, otherinfo):
def send_email(send_email, subject, smtp, smtpport, from_user, pwd, to, total, passed, failed, percentage, exe_date, elapsed_time, header_name, otherinfo):
    if send_email:
        email_content = """
        <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
        <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
        <title>Automation Status</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0 " />
            <style>
                .rf-box {
                    max-width: 60%%;
                    margin: auto;
                    padding: 30px;
                    border: 3px solid #eee;
                    box-shadow: 0 0 10px rgba(0, 0, 0, .15);
                    font-size: 16px;
                    line-height: 28px;
                    font-family: 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
                    color: #555;
                }

                .rf-box table {
                    width: 100%%;
                    line-height: inherit;
                    text-align: left;
                }

                .rf-box table td {
                    padding: 5px;
                    vertical-align: top;
                    width: 50%%;
                    text-align: center;
                }

                .rf-box table tr.heading td {
                    background: #eee;
                    border-bottom: 1px solid #ddd;
                    font-weight: bold;
                    text-align: left;
                }

                .rf-box table tr.item td {
                    border-bottom: 1px solid #eee;
                }
            </style>
        </head>
        <body>

            <div class="rf-box">
                <table cellpadding="0" cellspacing="0">
                    <tr class="top">
                        <td colspan="2">
                            <table>
                                <tr>
                                    <td></td>
                                    <td style="text-align:middle">
										<h1>%s</h1>
									</td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>

                <p style="padding-left:20px">
                    Hi Team,<br>
                    Following are the last build execution result. Please refer attachment for more info
                </p>

                <table style="width:80%%;padding-left:20px">
                    <tr class="heading">
                        <td>Test Status:</td>
                        <td></td>
                    </tr>
                    <tr class="item">
                        <td>Total</td>
                        <td>%s</td>
                    </tr>
                    <tr class="item">
                        <td>Pass</td>
                        <td style="color:green">%s</td>
                    </tr>
                    <tr class="item">
                        <td>Fail</td>
                        <td style="color:red">%s</td>
                    </tr>
                </table>

                <br>

                <table style="width:80%%;padding-left:20px">
                    <tr class="heading">
                        <td>Other Info:</td>
                        <td></td>
                    </tr>
                    <tr class="item">
                        <td>Pass Percentage (%%)</td>
                        <td>%s</td>
                    </tr>
                    <tr class="item">
                        <td>Executed Date</td>
                        <td>%s</td>
                    </tr>
                    <tr class="item">
                        <td>Machine</td>
                        <td>%s</td>
                    </tr>
                    <tr class="item">
                        <td>OS</td>
                        <td>%s</td>
                    </tr>
                    <tr class="item">
                        <td>Duration</td>
                        <td>%s</td>
                    </tr>
                    <tr class="item">
                        <td>Other Info.</td>
                        <td>%s</td>
                    </tr>
                </table>
            </div>
        </body>

        </html>
        """ % (header_name, total, passed, failed, percentage, exe_date, platform.uname()[1], platform.uname()[0], elapsed_time, otherinfo)

        # os.chdir('output')
        # shutil.copy2('log.html', 'report_test')
        # shutil.copy2('report.html', 'report_test')
        # directory = 'browser/screenshot'
        # if not os.path.exists(directory):
        #     os.makedirs(directory)
        # shutil.copytree('browser/screenshot', 'report_test/browser/screenshot')
        # shutil.make_archive("report", "zip", "report_test")

        os.chdir('output')
        shutil.copy2('log.html', 'report_test')
        shutil.copy2('report.html', 'report_test')
        directory = 'browser/screenshot'
        if not os.path.exists(directory):
            os.makedirs(directory)
        for file_name in os.listdir('browser/screenshot'):
            source = os.path.join('browser/screenshot', file_name)
            destination = os.path.join('report_test/browser/screenshot', file_name)
            shutil.copy2(source, destination)
        shutil.make_archive("report", "zip", "report_test")

        #file to be sent
        filename = "report.zip"
        mail = ImapSmtp()
        # mail.authorize(account=from_user, password=pwd, smtp_server=smtp, imap_server=imap, smtp_port=smtpport, imap_port=imapport)
        mail.authorize(account=from_user, password=pwd, smtp_server=smtp, smtp_port=smtpport)
        mail.send_message(
            sender=from_user,
            recipients=to,
            subject=subject,
            body=email_content,
            attachments=filename,
            html=True,
        )
    else:
        sys.exit(1)
