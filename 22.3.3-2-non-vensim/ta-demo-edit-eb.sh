# Need both jq and yq installed for this script to work. Both can be installed via Brew on a Mac
# brew install jq
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

# Get the HREF of the Containment Switch Boundary Rule
EB_HREF=$(curl -s -X GET -u $ILO_API_KEY:$ILO_API_TOKEN "$ILO_SERVER/api/v2/orgs/$ILO_ORG/sec_policy/draft/enforcement_boundaries" -H 'Accept: application/json' \
| jq -r '.[]| { href: .href, name: .name} | select(.name == "Workloader-Containment-Switch-3389-tcp") | [.href] | @tsv')

#echo $EB_HREF

# Add All Workloads to Consumers of Containment Switch Boundary Rule
curl -s -X PUT -u $ILO_API_KEY:$ILO_API_TOKEN "$ILO_SERVER/api/v2/$EB_HREF" -H 'Content-Type: application/json' -d '{"consumers":[{"ip_list":{"href":"/orgs/1/sec_policy/draft/ip_lists/1"}},{"actors":"ams"}]}'
# Provision
curl -s -o /dev/null -X POST -u $ILO_API_KEY:$ILO_API_TOKEN "$ILO_SERVER/api/v2/orgs/$ILO_ORG/sec_policy" -H 'Content-Type: application/json' -d '{"update_description":"make active"}'
