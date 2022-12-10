:: This has yet to be tested on Windows and may still need some work
if [ %# -eq 0 ]
  then
    echo "Include number from FQDN of new TA instance (XX from illumio-pce-XX.talabs.net)"
    exit 1
fi

set PCE_FQDN=illumio-pce-%1.talabs.net

echo "PCE FQDN = "%PCE_FQDN%

set PCE_NAME=ta-ext
set PCE_PORT=8443
set PCE_USER=YourFavoritePlusAddress@illumio.com
set PCE_PWD=YourFavoriteTempPassword
set PCE_DISABLE_TLS=false

workloader pce-remove %PCE_NAME%
workloader pce-add
workloader set-default %PCE_NAME%
