#########################################################################
#####                                                               #####
##### PLEASE READ THE FOLLOWING COMMENTS BEFORE RUNNING THIS SCRIPT #####
#####                                                               #####
#########################################################################


This script was created by Larsen Orchard. 
Please reach out to him for questions/change requests

This script will install driver updates using the Dell | Command Update Application

The Dell Command Update Application should be installed prior to running this script

###############
## Arguments ##
###############

THREE arguments are REQUIRED for this script to run
If Arguments are left blank, updates will be NOT be applied
If you want the script to run right away, enter, 
"NoRestart 00:00:00 none" (without quotes)

If Arg1 says "restart" then the program will restart once the updates have completed

Arg2 should be the time you want the script to run (HH:MM:SS)
Arg3 should be the time you want to close the deployment window (HH:MM:SS) -- 
updates will not be deployed after this time; the script will exit with exit code 1
