try {([adsi]"WinNT://./Administrators,group").Add("WinNT://domain1/Desktop Admins,group")} catch {"Failed to change Local Admin Group"}
Enable-PSRemoting -Force
sc.exe config winrm start= auto
shutdown.exe -r -t 0 -f