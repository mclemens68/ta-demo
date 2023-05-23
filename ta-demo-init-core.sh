#./ta-demo-turn-on-ransomware-dashboard.sh
workloader ruleset-import workloader-ruleset-import-ta-demo.csv --update-pce --no-prompt --provision
workloader rule-import workloader-rule-import-ta-demo.csv --update-pce --no-prompt --provision
