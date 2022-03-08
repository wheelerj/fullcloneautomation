#Variable Section

#
# This script was created by Jeremy Wheeler from VMware EUC-PSO (2022)
#
# This script is free to use. Please adjust the below fields to make it work in your environment.
#
# GoldImageName = What gold image name you are using as a template for full clones
# $DOMAIN="acme.com" = change to your domain name
# $UATOU = Change to the correct OU in your environment where you want the full clones to reside
# $User = Change to your domain\username that has an account with permissions to join/remove machines to the domain.
# $PasswordFile = This script assumes you are using an AES encrypted password file located in the temp folder location. 
#                 Please reference the following link for instructions for how to generate an AES encrypted password file.
#

$GoldImageName = "WIN10FULLC1" # Change this to match the Gold Image Computer Name
$ver = "v1"
$Logfile = "C:\temp\DomainJoin-$ver.log" # Log file location
$VDIHostname = "$env:COMPUTERNAME" # Grabs local computer name

Function LogWrite
{
	Param ([string]$logstring)
	$datentime = Get-Date -Format g
	$logstring = "$datentime" + ": " + "$logstring"
	Add-content $Logfile -value $logstring
}

# Domain Join OU & Account Details
$DOMAIN="acme.com" # Domain Name

# OU Path
$UATOU = "OU=Full Clones,OU=Persistent,OU=Workloads,OU=View,DC=acme,DC=com" 

# Credentials needed when launching

$User = "acme\myaccount" # User Account
$PasswordFile = "C:\Temp\AESDomain.txt" # Encrypted Password File
$KeyFile = "C:\Temp\AESDomainJoin.key" # AES Key File
$key = Get-Content $KeyFile
$VIcred= New-object System.Management.Automation.PSCredential -ArgumentList $User, (Get-Content $PasswordFile | ConvertTo-SecureString -Key $key)

# Cleanup

If($GoldImageName -eq $VDIHostname){
    # Script is being executed from Gold Image, skip cleanup.
}else {
    # Execute cleanup
    Get-ChildItem C:\temp -Include *.* -Recurse | ForEach  { $_.Delete()}
    Remove-Item C:\temp -Force -Recurse
}

# Joining the Device to PreDefined OU.

Add-Computer -DomainName $DOMAIN -OUPath $UATOU -credential $VIcred -Restart -Confirm:$false
