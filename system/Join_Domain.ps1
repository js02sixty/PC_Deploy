$ADPW = ConvertTo-SecureString -String "J01nT0Th3D0m@1n" -asPlainText -Force
$ADUser = "domain1\camaa"
$ADCred = New-Object System.Management.Automation.PSCredential($ADUser,$ADPW)
try {Add-Computer -DomainName JMSOnline.com -Credential $ADCred -ErrorAction Stop} catch {"Unable to Join PC to Domain";break}
try {([adsi]"WinNT://./Administrators,group").Add("WinNT://domain1/Desktop Admins,group")} catch {"Failed to change Local Admin Group"}
Enable-PSRemoting -Force
if ((Get-Service MpsSvc).Status -eq "Running") { (Get-Service MpsSvc).Stop() }
if ((Get-Service RemoteRegistry).Status -ne "Running" ) { (Get-Service RemoteRegistry).Start() }
sc.exe config winrm start= auto
shutdown -r -t 0 -f
