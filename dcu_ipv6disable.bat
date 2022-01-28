@echo off

rem #########################################################################
rem #####                                                               #####
rem ##### PLEASE READ THE FOLLOWING COMMENTS BEFORE RUNNING THIS SCRIPT #####
rem #####                                                               #####
rem #########################################################################


rem This script was created by Larsen Orchard. 
rem Please reach out to him for questions/change requests

rem This script will install driver updates using the Dell | Command Update Application

rem The Dell Command Update Application should be installed prior to running this script

rem ###############
rem ## Arguments ##
rem ###############

rem THREE arguments are REQUIRED for this script to run
rem If Arguments are left blank, updates will be NOT be applied
rem If you want the script to run right away, enter, 
rem "NoRestart 00:00:00 none" (without quotes)

rem If Arg1 says "restart" then the program will restart once the updates have completed

rem Arg2 should be the time you want the script to run (HH:MM:SS)

rem Arg3 should be the time you want to close the deployment window (HH:MM:SS) -- 
rem updates will not be deployed after this time; the script will exit with exit code 1


rem #########################
rem Continuing with script...
rem #########################

rem checking for delayed start
if %TIME% LSS %2 (

    echo Delaying start until %2
    
    :loop
    if %TIME% LSS %2 goto loop
    
    echo Arrived at %TIME%
)

rem checking if we've reached the end of the deployment window
if "%3" NEQ "none" (
    if %TIME% GTR %3 (
        echo Missed Deployment Window
        exit 1
    )
    echo We are in Deployment Window. Continuing with updates.
)

rem installing updates for 64-bit DCU application
if exist "C:\Program Files\Dell\CommandUpdate\dcu-cli.exe" (
    "C:\Program Files\Dell\CommandUpdate\dcu-cli.exe" /configure -autoSuspendBitLocker=enable -silent
	"C:\Program Files\Dell\CommandUpdate\dcu-cli.exe" /scan -silent

    rem check if restart is required	
	if "%1" EQU "restart" (
        "C:\Program Files\Dell\CommandUpdate\dcu-cli.exe" /configure -scheduledReboot=5	-silent
	    "C:\Program Files\Dell\CommandUpdate\dcu-cli.exe" /applyUpdates -reboot=enable
    ) else (
	    "C:\Program Files\Dell\CommandUpdate\dcu-cli.exe" /applyUpdates -reboot=disable
    )
    rem Disabling IPv6
	powershell -command "Disable-NetAdapterBinding -Name 'Ethernet 2' -ComponentID ms_tcpip6"
	powershell -command "Disable-NetAdapterBinding -Name 'Ethernet' -ComponentID ms_tcpip6"
	powershell -command "Disable-NetAdapterBinding -Name 'Wi-Fi' -ComponentID ms_tcpip6"
	powershell -command "Disable-NetAdapterBinding -Name 'Wi-Fi 2' -ComponentID ms_tcpip6"

    rem Checking if restart is requested
    rem if "%1" NEQ "" (
    rem     if "%1"=="restart" (
    rem         echo Shutdown Initiated
    rem         shutdown -r -f -t 600
    rem         exit 0
    rem     ) else (
    rem         echo NoRestart
    rem     )
    rem )
	exit 0
) 

rem installing updates for 32-bit DCU application
if exist "C:\Program Files (x86)\Dell\CommandUpdate\dcu-cli.exe" (
    "C:\Program Files (x86)\Dell\CommandUpdate\dcu-cli.exe" /configure -autoSuspendBitLocker=enable -silent
	"C:\Program Files (x86)\Dell\CommandUpdate\dcu-cli.exe" /scan -silent

    rem check if restart is required
    if "%1" EQU "restart" (
        "C:\Program Files (x86)\Dell\CommandUpdate\dcu-cli.exe" /configure -scheduledReboot=5 -silent
	    "C:\Program Files (x86)\Dell\CommandUpdate\dcu-cli.exe" /applyUpdates -reboot=enable
    ) else (
        "C:\Program Files (x86)\Dell\CommandUpdate\dcu-cli.exe" /applyUpdates -reboot=disable
    )

    rem Disabling IPv6
	powershell -command "Disable-NetAdapterBinding -Name 'Ethernet 2' -ComponentID ms_tcpip6"
	powershell -command "Disable-NetAdapterBinding -Name 'Ethernet' -ComponentID ms_tcpip6"
	powershell -command "Disable-NetAdapterBinding -Name 'Wi-Fi' -ComponentID ms_tcpip6"
	powershell -command "Disable-NetAdapterBinding -Name 'Wi-Fi 2' -ComponentID ms_tcpip6"

    rem Checking if restart is requested
    rem if "%1" NEQ "" (
    rem     if "%1"=="restart" (
    rem         echo Sutdown Initiated
    rem         shutdown -r -f -t 600
    rem         exit 0
    rem     ) else (
    rem         echo NoRestart
    rem     )
    rem )
	exit 0
)

rem DCU application is probably not installed or is installed incorrectly
echo Please check your Dell Command Update Application has been installed properly
exit 1
