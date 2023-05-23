This will create the Manufacturing demo on a TA external instance.

workloader and vensim need to be in your path.

First setup the standard TA demo, run at least the ta-demo-workloader-refresh script.

The standard core or endpoint inits are not required (but can be run if desired).

Run mfg-demo-setup.sh. This will pair new managed and unmanaged workloads with a new 
"Manufacturing" sector label which can be used to filter the Map and Traffic searches,
and then install a crontab for heartbeats, etc...

Run "mfg-demo-armis-labels.sh" during the demo (off screen) to show additional context
on UMWL's that Armis can add.

When done don't forget to clear the crontab (crontab -r).
