#!/bin/bash
number=$(<../number.txt)
pairing_key_server=$(<../pairing_key_server.txt)
pairing_key_endpoint=$(<../pairing_key_endpoint.txt)
echo $number
echo $pairing_key_server
echo $pairing_key_endpoint

date=$(date -v -2d '+%Y-%m-%d')
echo $date

# Remove prior agents and flows directories
rm -rf agents flows

# Remove prior crontab
crontab -r

# Import IP Lists
workloader ipl-import manu-ipls.csv --update-pce --no-prompt --provision

# Import Services
workloader svc-import manu-svcs.csv --update-pce --no-prompt --provision

# Activate VENs
vensim activate -c manu-vens.csv -p manu-processes.csv -m illumio-pce-$number.talabs.net:8443 -a $pairing_key_server -e $pairing_key_endpoint

# Label the workloads
workloader wkld-import manu-wklds.csv --umwl --update-pce --no-prompt

# Import Rulesets
workloader ruleset-import manu-rulesets.csv --update-pce --no-prompt --provision

# Import Rules
workloader rule-import manu-rules.csv --update-pce --no-prompt --provision

# Import Flows
workloader flow-import manu-flows.csv --update-pce --no-prompt
workloader increase-ven-rate --update-pce --no-prompt

# Simulate Traffic
vensim post-traffic -c manu-vens.csv -t manu-traffic.csv -d "$date"

# Intall crontab for heartbeats, etc...
crontab crontab.txt
