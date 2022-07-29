if [ $# -eq 0 ]
  then
    echo "Include number from FQDN of new TA instance (XX from illumio-pce-XX.talabs.net)"
    exit 1
fi

export PCE_FQDN=illumio-pce-$1.talabs.net

echo "PCE FQDN = "$PCE_FQDN

export PCE_NAME=ta-ext
export PCE_PORT=8443
export PCE_USER=your.email+talab@illumio.com
export PCE_PWD=YourFavoriteThrowawayPassword
export PCE_DISABLE_TLS=false

workloader pce-remove $PCE_NAME
workloader pce-add
workloader set-default $PCE_NAME
