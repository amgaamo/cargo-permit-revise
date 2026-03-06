*** Variables ***
### [VARIABLE URL] ###
#---------------------------------------------------------------------------------------------------------------------------#
# ${VAR_BROWSER} >> (chromium,chrome/msedge/firefox)                                                                        #
# ${VAR_BOTVERSION} >> VX.Y.Z -- X=Major / Y=Minor / Z=Patch                                                                #     
# ${VAR_USERMGTSTD_VERSION} = IE5DEV (Version manage Company Type - Add/Edit ), STANDARD = First Version of User Management #
#---------------------------------------------------------------------------------------------------------------------------#
${VAR_BOTVERSION}           V2.3.00
${VAR_BROWSER}              chromium
${VAR_PROTOCOL}             https

${VAR_IPSERV}               uatcargopermit.netbay.co.th
${VAR_API_SUBDIRECTORY}     cargopermitapp
${VAR_PATHLOGIN_URL}        auth/login
${VAR_USERMGTSTD_VERSION}   STANDARD

### [MODE FOR TEST] ###
#-------------------------------------------------------------------------------------------------#
#  ${_fixdata_}         >>  true = Fix data value       /   false = Get environment value         #
#  ${_headlessmode_}    >>  true = Run headless mode    /   false = Open browser to run script    #
#  ${_concurrentmode_}  >>  true = Run concurrent mode  /   false = Run single mode               #
#-------------------------------------------------------------------------------------------------#
${_headlessmode_}           true
${_fixdata_}                true
${_concurrentmode_}         false

### [Function For Test] ###
${DEFAULTDATA_FUNCTEST}     True
${USERMGT_FUNCTEST}         True
${PROFILE_FUNCTEST}         True
${REGISTER_FUNCTEST}        True
${PAGING_FUNCTEST}          True
