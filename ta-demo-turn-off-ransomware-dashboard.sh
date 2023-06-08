
# Need both python3 and yq installed for this script to work. Both can be installed via Brew on a Mac
# brew install python3
# brew install yq

# If ILLUMIO_CONFIG is not set assume pce.yaml is in current working directory
CONFIG="${ILLUMIO_CONFIG:=./pce.yaml}"

#echo $CONFIG

ILO_API_TOKEN=$(cat $CONFIG | yq -r '.ta-ext | [.key] | @tsv')
#echo $ILO_API_TOKEN
ILO_API_KEY=$(cat $CONFIG | yq -r '.ta-ext | [.user] | @tsv')
#echo $ILO_API_KEY
ILO_ORG=$(cat $CONFIG | yq -r '.ta-ext | [.org] | @tsv')
#echo $ILO_ORG
ILO_FQDN=$(cat $CONFIG | yq -r '.ta-ext | [.fqdn] | @tsv')
#echo $ILO_FQDN
ILO_PORT=$(cat $CONFIG | yq -r '.ta-ext | [.port] | @tsv')
#echo $ILO_PORT
ILO_SERVER=https://$ILO_FQDN:$ILO_PORT
#echo $ILO_SERVER

# turn on ransomware dashboard
curl -u $ILO_API_KEY:$ILO_API_TOKEN -H "Content-Type: application/json" -X PUT -d '[{"name":"ransomware_readiness_dashboard","enabled":false}]' $ILO_SERVER/api/v2/orgs/1/optional_features

echo "\n"
