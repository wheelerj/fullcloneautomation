#Variable Section

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
$DOMAIN="vmbucket.com" # Domain Name

# OU Path
$UATOU = "OU=Full Clones,OU=Persistent,OU=Workloads,OU=View,DC=vmbucket,DC=com" 

# Credentials needed when launching

$User = "vmbucket\iclone" # User Account
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
