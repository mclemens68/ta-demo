
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


# create the Business Unit Label:
curl -X POST $ILO_SERVER/api/v2/orgs/$ILO_ORG/label_dimensions -u $ILO_API_KEY:$ILO_API_TOKEN -H "Content-Type: application/json" -d "{\"key\":\"bu\",\"display_name\":\"Business Unit\",\"display_info\":{\"background_color\":\"#ebbb0f\",\"icon\":\"org\",\"foreground_color\":\"#000000\",\"initial\":\"BU\",\"display_name_plural\":\"Business Units\"}}"
echo "\n"

# create the Operating System Label:

curl -X POST $ILO_SERVER/api/v2/orgs/$ILO_ORG/label_dimensions -u $ILO_API_KEY:$ILO_API_TOKEN -H "Content-Type: application/json" -d "{\"key\":\"os\",\"display_name\":\"Operating System\",\"display_info\":{\"background_color\":\"#2f5cca\",\"icon\":\"dashboard\",\"foreground_color\":\"#ffffff\",\"initial\":\"OS\",\"display_name_plural\":\"Operating Systems\"}}"
echo "\n"

# create the Operating System Label:

curl -X POST $ILO_SERVER/api/v2/orgs/$ILO_ORG/label_dimensions -u $ILO_API_KEY:$ILO_API_TOKEN -H "Content-Type: application/json" -d "{\"key\":\"risk\",\"display_name\":\"Risk Level\",\"display_info\":{\"background_color\":\"#ff0000\",\"icon\":\"critical\",\"foreground_color\":\"#ffffff\",\"initial\":\"RL\",\"display_name_plural\":\"Risk Levels\"}}"
echo "\n"
