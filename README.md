
# Full Clone Provisioning Script

## Description

This PowerShell script automates the provisioning of full clones in a VMware Horizon environment. It was created by Jeremy Wheeler from VMware EUC-PSO in 2022 and is free to use. Users should adjust the variables within the script to match their specific environment needs.

## Variables

- **$GoldImageName**: The name of the gold image computer used as a template for full clones.
- **$DOMAIN**: The domain name where the full clones will be joined.
- **$UATOU**: The Organizational Unit (OU) path where the full clones will reside in Active Directory.
- **$User**: The domain\username with permissions to join/remove machines to the domain.
- **$PasswordFile**: Path to the AES encrypted password file.
- **$KeyFile**: Path to the AES key file.

## Functionality

1. **Logging**: The script includes a function to log events and messages for tracking and troubleshooting purposes.
2. **Credential Management**: Utilizes encrypted credentials to securely join machines to the domain.
3. **Cleanup**: Ensures no remnants from previous executions by cleaning up temporary files.
4. **Domain Join Process**: Automates the joining of new clones to the specified domain and OU, followed by a machine restart.

## Usage

Adjust the following variables in the script to fit your environment:
- `$GoldImageName`
- `$DOMAIN`
- `$UATOU`
- `$User`
- `$PasswordFile`
- `$KeyFile`

### Example

```powershell
$GoldImageName = "WIN10FULLC1"
$DOMAIN = "acme.com"
$UATOU = "OU=Full Clones,OU=Persistent,OU=Workloads,OU=View,DC=acme,DC=com"
$User = "acme\myaccount"
$PasswordFile = "C:\Temp\AESDomain.txt"
$KeyFile = "C:\Temp\AESDomainJoin.key"
```

## Author

Jeremy Wheeler from VMware EUC-PSO (2022)

## License

This script is free to use under the [MIT License](LICENSE).
