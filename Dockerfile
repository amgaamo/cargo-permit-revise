# Copyright © Netbay.co.th
# ROBOT For Test

FROM mobydick.netbay.co.th/qa/standard-robot/rf5std-browserlib:browserlib17
# FROM rf5std-browserlib:latest
RUN ["mkdir","/USERMGT_NEW"]
WORKDIR "/USERMGT_NEW"

ADD ./__helpcheck  ./__helpcheck 
ADD ./testsuite ./testsuite
ADD ./pages ./pages
ADD ./resources ./resources
ADD ./output ./output
ADD ./listener_email ./listener_email