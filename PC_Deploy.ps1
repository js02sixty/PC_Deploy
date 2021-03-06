# PC Deploy 1.0
# New PC Deployment Script
# by JSaba

$console = (Get-Host).UI.RawUI
#$console.BackgroundColor = "darkblue"
$console.ForegroundColor = "white"
$console.WindowTitle = "PC Deploy 1.0"

$size = $console.WindowSize
$size.height = 50
$size.width = 80
$console.WindowSize = $size

Clear-Host

# Local Admin Credentials
$LocalADM = "administrator"
$LocalADMPW = "Janney_2012_ADM"

Function Join-PC($ThisPC) { # Uses PSEXEC to remotely run scripts
    Write-Host "Joining $ThisPC to the domain and running other tasks"
    Net Use \\$ThisPC\C$ $LocalADMPW /USER:$LocalADM
    Copy-Item .\system\Join_Domain.ps1 -Destination \\$ThisPC\C$\Admin -Force -PassThru
    .\system\PsExec.exe \\$ThisPC -u $LocalADM -p $LocalADMPW powershell.exe "Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force; c:\admin\Join_Domain.ps1"  2> $null
    Net Use /delete \\$ThisPC\C$
}

Function Prepare-PC($ThisPC) { # Uses PSEXEC to remotely run scripts
    Write-Host "Preparing $ThisPC"
    Copy-Item .\system\PS_Remote.ps1 -Destination \\$ThisPC\C$\Admin -Force -PassThru
    .\system\PsExec.exe \\$ThisPC powershell.exe "Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force; c:\admin\PS_Remote.ps1"  2> $null
}

Function Move-OU($Branch,$ThisPC) { # Move PC to Site OU
    # Branch OU's updated 6/19/2013 "dsquery ou "ou=Branches,ou=Workstations,ou=Computers,ou=Janney,dc=JMSOnline,dc=com" -limit 200"
    if (($Branch).ToLower() -eq 'ak') {$ThisOU="Aiken SC (AK)"}
    if (($Branch).ToLower() -eq 'ay') {$ThisOU="Albany NY (AY)"}
    if (($Branch).ToLower() -eq 'at') {$ThisOU="Allentown PA (AT)"}
    if (($Branch).ToLower() -eq 'bu') {$ThisOU="Atlanta GA (BU)"}
    if (($Branch).ToLower() -eq 'av') {$ThisOU="Aventura FL (AV)"}
    if (($Branch).ToLower() -eq 'be') {$ThisOU="Baltimore MD (BE)"}
    if (($Branch).ToLower() -eq 'bv') {$ThisOU="Beaver PA (BV)"}
    if (($Branch).ToLower() -eq 'cs') {$ThisOU="Bedminster NJ (CS)"}
    if (($Branch).ToLower() -eq 'bm') {$ThisOU="Bethlehem PA (BM)"}
    if (($Branch).ToLower() -eq 'bb') {$ThisOU="Blue Bell PA (BB)"}
    if (($Branch).ToLower() -eq 'bf') {$ThisOU="Boca Raton FL (BF)"}
    if (($Branch).ToLower() -eq 'bn') {$ThisOU="Boston MA (BN)"}
    if (($Branch).ToLower() -eq 'bk') {$ThisOU="Brooklyn NY (BK)"}
    if (($Branch).ToLower() -eq 'lm') {$ThisOU="Bryn Mawr PA (LM)"}
    if (($Branch).ToLower() -eq 'ka') {$ThisOU="Charleston WV (KA)"}
    if (($Branch).ToLower() -eq 'cl') {$ThisOU="Charlotte NC (CL)"}
    if (($Branch).ToLower() -eq 'ct') {$ThisOU="Chillicothe OH (CT)"}
    if (($Branch).ToLower() -eq 'kb') {$ThisOU="Clarion PA (KB)"}
    if (($Branch).ToLower() -eq 'kc') {$ThisOU="Cleveland OH (KC)"}
    if (($Branch).ToLower() -eq 'ns') {$ThisOU="Danvers MA (NS)"}
    if (($Branch).ToLower() -eq 'dn') {$ThisOU="Darien CT (DN)"}
    if (($Branch).ToLower() -eq 'dy') {$ThisOU="Doylestown PA (DY)"}
    if (($Branch).ToLower() -eq 'ke') {$ThisOU="Dubois PA (KE)"}
    if (($Branch).ToLower() -eq 'eh') {$ThisOU="East Hampton NY (EH)"}
    if (($Branch).ToLower() -eq 'en') {$ThisOU="Easton MD (EN)"}
    if (($Branch).ToLower() -eq 'mt') {$ThisOU="Edison NJ (MT)"}
    if (($Branch).ToLower() -eq 'kc') {$ThisOU="Elyria OH (KC)"}
    if (($Branch).ToLower() -eq 'bp') {$ThisOU="Fairfield CT (BP)"}
    if (($Branch).ToLower() -eq 'fh') {$ThisOU="Falmouth MA (FH)"}
    if (($Branch).ToLower() -eq 'ax') {$ThisOU="Frederick MD (AX)"}
    if (($Branch).ToLower() -eq 'fl') {$ThisOU="Ft Lauterdale FL (FL)"}
    if (($Branch).ToLower() -eq 'gc') {$ThisOU="Garden City NY (GC)"}
    if (($Branch).ToLower() -eq 'hf') {$ThisOU="Glastonbury Hartford CT (HF)"}
    if (($Branch).ToLower() -eq 'gr') {$ThisOU="Great Neck NY (GR)"}
    if (($Branch).ToLower() -eq 'wl') {$ThisOU="Blueville DE (WL)"}
    if (($Branch).ToLower() -eq 'hk') {$ThisOU="Hackensack NJ (HK)"}
    if (($Branch).ToLower() -eq 'hd') {$ThisOU="Haddonfield NJ (HD)"}
    if (($Branch).ToLower() -eq 'sm') {$ThisOU="Hauppauge NY (SM)"}
    if (($Branch).ToLower() -eq 'hn') {$ThisOU="Hazleton PA (HN)"}
    if (($Branch).ToLower() -eq 'jn') {$ThisOU="Johnstown NY (JN)"}
    if (($Branch).ToLower() -eq 'wb') {$ThisOU="Kingston PA (WB)"}
    if (($Branch).ToLower() -eq 'lp') {$ThisOU="Lake Placid NY (LP)"}
    if (($Branch).ToLower() -eq 'la') {$ThisOU="Lancaster PA (LA)"}
    if (($Branch).ToLower() -eq 'ht') {$ThisOU="Langen-McAlenney (HT)"}
    if (($Branch).ToLower() -eq 'hb') {$ThisOU="Lemoyne PA (HB)"}
    if (($Branch).ToLower() -eq 'li') {$ThisOU="Ligonier PA (LI)"}
    if (($Branch).ToLower() -eq 'ln') {$ThisOU="Linwood NJ (LN)"}
    if (($Branch).ToLower() -eq 'mn') {$ThisOU="Mansfield OH (MN)"}
    if (($Branch).ToLower() -eq 'mj') {$ThisOU="Margate NJ (MJ)"}
    if (($Branch).ToLower() -eq 'ki') {$ThisOU="Marietta OH (KI)"}
    if (($Branch).ToLower() -eq 'ch') {$ThisOU="Marlton NJ (CH)"}
    if (($Branch).ToLower() -eq 'wa') {$ThisOU="McMurray PA (WA)"}
    if (($Branch).ToLower() -eq 'kj') {$ThisOU="Meadville PA (KJ)"}
    if (($Branch).ToLower() -eq 'mm') {$ThisOU="Media PA (MM)"}
    if (($Branch).ToLower() -eq 'mv') {$ThisOU="Melville NY (MV)"}
    if (($Branch).ToLower() -eq 'tn') {$ThisOU="Memphis TN"}
    if (($Branch).ToLower() -eq 'mk') {$ThisOU="Midtown NY (MK)"}
    if (($Branch).ToLower() -eq 'ml') {$ThisOU="Mt Laurel NJ (ML)"}
    if (($Branch).ToLower() -eq 'km') {$ThisOU="New Castle PA (KM)"}
    if (($Branch).ToLower() -eq 'nd') {$ThisOU="New Haven Downtown CT (ND)"}
    if (($Branch).ToLower() -eq 'nu') {$ThisOU="New Haven CT (NU)"}
    if (($Branch).ToLower() -eq 'nh') {$ThisOU="New Hope PA (NH)"}
    if (($Branch).ToLower() -eq 'nl') {$ThisOU="New London CT (NL)"}
    if (($Branch).ToLower() -eq 'br') {$ThisOU="New York NY (BR)"}
    if (($Branch).ToLower() -eq 'nt') {$ThisOU="Newtown Yardley PA (NT)"}
    if (($Branch).ToLower() -eq 'nr') {$ThisOU="Norwell MA (NR)"}
    if (($Branch).ToLower() -eq 'kd') {$ThisOU="Oil City PA (KD)"}
    if (($Branch).ToLower() -eq 'cc') {$ThisOU="Osterville MA (CC)"}
    if (($Branch).ToLower() -eq 'pb') {$ThisOU="Palm Beach Gardens FL (PB)"}
    if (($Branch).ToLower() -eq 'kq') {$ThisOU="Pittsburgh PA (KQ)"}
    if (($Branch).ToLower() -eq 'jv') {$ThisOU="Ponte Verda Beach FL (JV)"}
    if (($Branch).ToLower() -eq 'pn') {$ThisOU="Pottstown PA (PN)"}
    if (($Branch).ToLower() -eq 'pv') {$ThisOU="Providence RI (PV)"}
    if (($Branch).ToLower() -eq 'by') {$ThisOU="Radnor PA (BY)"}
    if (($Branch).ToLower() -eq 'rl') {$ThisOU="Raleigh NC (RL)"}
    if (($Branch).ToLower() -eq 'at') {$ThisOU="Reading PA (AT)"}
    if (($Branch).ToLower() -eq 'rb') {$ThisOU="Red Bank NJ (RB)"}
    if (($Branch).ToLower() -eq 'rc') {$ThisOU="Richmond VA (RC)"}
    if (($Branch).ToLower() -eq 'kr') {$ThisOU="Salem OH (KR)"}
    if (($Branch).ToLower() -eq 'sf') {$ThisOU="San Francisco CA"}
    if (($Branch).ToLower() -eq 'ss') {$ThisOU="Sarasota FL (SS)"}
    if (($Branch).ToLower() -eq 'st') {$ThisOU="Saratoga Springs NY (ST)"}
    if (($Branch).ToLower() -eq 'sc') {$ThisOU="Scranton PA (SC)"}
    if (($Branch).ToLower() -eq 'sk') {$ThisOU="Skaneateles NK (SK)"}
    if (($Branch).ToLower() -eq 'sp') {$ThisOU="Spartenburg SC (SP)"}
    if (($Branch).ToLower() -eq 'sb') {$ThisOU="Stuart FL (SB)"}
    if (($Branch).ToLower() -eq 'su') {$ThisOU="Sunbury PA (SU)"}
    if (($Branch).ToLower() -eq 'sy') {$ThisOU="Syracuse NY (SY)"}
    if (($Branch).ToLower() -eq 'tt') {$ThisOU="Tarrytown NY (TT)"}
    if (($Branch).ToLower() -eq 'tr') {$ThisOU="Toms River NJ (TR)"}
    if (($Branch).ToLower() -eq 'tn') {$ThisOU="Towson MD (TN)"}
    if (($Branch).ToLower() -eq 'ku') {$ThisOU="Uniontown PA (KU)"}
    if (($Branch).ToLower() -eq 'sr') {$ThisOU="Upper Saddle River NJ (SR)"}
    if (($Branch).ToLower() -eq 'vf') {$ThisOU="Valley Forge PA (VF)"}
    if (($Branch).ToLower() -eq 'wc') {$ThisOU="Washington DC (WC)"}
    if (($Branch).ToLower() -eq 'wh') {$ThisOU="West Chester PA (WH)"}
    if (($Branch).ToLower() -eq 'hw') {$ThisOU="West Hartford CT (HW)"}
    if (($Branch).ToLower() -eq 'kn') {$ThisOU="Wexford PA (KN)"}
    if (($Branch).ToLower() -eq 'wp') {$ThisOU="Williamsport PA (WP)"}
    if (($Branch).ToLower() -eq 'bx') {$ThisOU="Williamsville Buffalo BY (BX)"}
    if (($Branch).ToLower() -eq 'is') {$ThisOU="Wyncote PA (IS)"}
    if (($Branch).ToLower() -eq 'rk') {$ThisOU="York PA (RK)"}
    if (($Branch).ToLower() -eq 'ds') {$ThisOU="Dallas TX (DS)"}
    if (($Branch).ToLower() -eq 'cu') {$ThisOU="Columbia SC (CU)"}
    if (($Branch).ToLower() -eq 'hh') {$ThisOU="Hilton Head SC (HH)"}
    if (($Branch).ToLower() -eq 'iv') {$ThisOU="Irvine CA (IV)"}
    if (($Branch).ToLower() -eq 'cg') {$ThisOU="Chicago IL"}
    if (($Branch).ToLower() -eq 'he') {$ThisOU="Hendersonville NC (HE)"}
    if (($Branch).ToLower() -eq 'nc') {$ThisOU="Ashville NC"}
    if (($Branch).ToLower() -eq 'pl') {$ThisOU="Yarmouth ME (PL)"}
    if (($Branch).ToLower() -eq 'we') {$ThisOU="Westminster MD (WE)"}

    Write-Host "Moving $ThisPC to $ThisOU"
    $search = [System.DirectoryServices.DirectorySearcher][System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().GetDirectoryEntry()
    $search.Filter = "(cn=$ThisPC)"
    $computerToMove = [ADSI]$search.FindOne().path
    try {$computerToMove.psbase.Moveto([ADSI]"LDAP://OU=$ThisOU,OU=Branches,OU=Workstations,OU=Computers,OU=Janney,DC=JMSOnline,DC=com")} catch {"Unable to move PC"}
}

Function Add-User($ThisPC, $ThisUser, $ThisGroup) { # Adds speciefied User to specified Group on specified PC
    Write-Host "Adding $ThisUser to $ThisGroup Group on $ThisPC"
    Invoke-Command -ComputerName $ThisPC -ArgumentList $ThisUser, $ThisGroup {
        $RemoteUser = $args[0]
        $RemoteGroup = $args[1]
        try{([adsi]"WinNT://./$RemoteGroup,group").Add("WinNT://domain1/$RemoteUser,user"); Write-Host "Added"} catch{"Failed to Add $RemoteUser to $RemoteGroup"}
    }
}

Function Remove-User($ThisPC, $ThisUser, $ThisGroup) { # Removes speciefied User to specified Group on specified PC
    Write-Host "Removing $ThisUser from $ThisGroup Group on $ThisPC"
    Invoke-Command -ComputerName $ThisPC -ArgumentList $ThisUser, $ThisGroup {
        $RemoteUser = $args[0]
        $RemoteGroup = $args[1]
        try{([adsi]"WinNT://./$RemoteGroup,group").Remove("WinNT://domain1/$RemoteUser,user"); Write-Host "Removed"} catch{"Failed to Remove $RemoteUser from $RemoteGroup"}
    }
}

Function Store-Cred($ThisPC, $ThisUser, $ThisPW) { # Store User's Credentials
    Write-Host "Storing $ThisUser's Credentials Locally"
    try {
        cmdkey.exe /add: $ThisPC /user: $ThisUser /pass: $ThisPW
    } catch {Write-Host "Failed to add credentials: $ThisUser"}
}

Function Remove-LN($ThisPC) { # Removes Legal caption notice until next gpupdate to allow quick login
    Write-Host "Removing Legal Notice: $ThisPC"
    Invoke-Command -ComputerName $ThisPC {
        $LegalNoticePath = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System'
        if (Get-ItemProperty -Path $LegalNoticePath -Name LegalNoticeCaption 2> $null) {
            write-host "removing LegalNoticeCaption"
            Remove-ItemProperty -Path $LegalNoticePath -Name LegalNoticeCaption -Force
        }
        if (Get-ItemProperty -Path $LegalNoticePath -Name LegalNoticeText 2> $null) {
            write-host "removing LegalNoticeCaption"
            Remove-ItemProperty -Path $LegalNoticePath -Name LegalNoticeText -Force
        }
    }
}

Function Update-Policy($ThisPC) {
    Invoke-Command -ComputerName $ThisPC {gpupdate /target:computer}
}

Function Start-RDP($ThisPC) { # Opens Remote Desktop for each new PC
    Write-Host "Starting RDP for $ThisPC"
    mstsc.exe /v $ThisPC /w:1024 /h:768
}

Function Copy-Files($BackUpLoc, $ThisPC, $ThisUser) { # Copying Backup Files to the new PCs
    Write-Host "Copying Backups for $ThisUser on $ThisPC"
    Start-Process robocopy.exe "$BackupLoc\BACKUP2013_$ThisUser \\$ThisPC\c$\BACKUP2013_$ThisUser /COPY:DAT /MIR /ZB /R:3 /w:1 /XO" -WindowStyle Normal
}

Function Choose-CSV { # Opens CSV file relative to this script
    Write-Host "What is the name of the CSV file you want to work with?"
    $csvList = Get-ChildItem .\* -Include *.csv
    for ($i = 0; $i -lt $csvList.count; $i++) {
        $csvListVal = $csvList[$i].Name
        Write-Host "[$i] $csvListVal"
    }
    $csvList[(Read-Host)]
}

Function Input-Mode {
    Write-Host "[1] Read from CSV?"
    Write-Host "[2] Manaual Input?"
    Read-Host
}

do {

    Write-Host "┌─────────────────────────────────────────────────────────────────────────────┐" -BackgroundColor Blue -ForegroundColor White
    Write-Host "│                               New PC Deployment                             │" -BackgroundColor Blue -ForegroundColor White
    Write-Host "│                                 for Windows 7                               │" -BackgroundColor Blue -ForegroundColor White
    Write-Host "└─────────────────────────────────────────────────────────────────────────────┘`n" -BackgroundColor Blue -ForegroundColor White
    Write-Host "DEPLOYMENT STEPS:" -ForegroundColor Blue
    Write-Host "───────────────────────────────────────────────────────────────────────────────" -ForegroundColor Blue
    Write-Host "[1]  STEP 1: Add PCs to the domain and enable WinRM"
    Write-Host "[2]  STEP 2: Move PC to branch OU and add make user an Admin"
    Write-Host "     (Wait about 5 min after running Step 1)"
    Write-Host "[3]  STEP 3: Auto open a RDP Session with user's credentials"
    Write-Host "     (Wait about 5 min after running Step 2)"
    Write-Host "[4]  STEP 4: Copies backup files from old server to new PC"
    Write-Host "     (Don't run this over WAN)`n"
    Write-Host "OTHER FUNCTIONS:" -ForegroundColor Blue
    Write-Host "───────────────────────────────────────────────────────────────────────────────" -ForegroundColor Blue
    Write-Host "[5]  Move PC to Site OU (WinRM not required)"
    Write-Host "[6]  Enable WinRM Only"
    Write-Host "[7]  Add User to Local Admin Group (WinRM is required)"
    Write-Host "[8]  Remove User from Local Admin Group (WinRM is required)"
    Write-Host "[9]  Add User to Remote Desktop Users Group (WinRM is required)"
    Write-Host "[10] Remove user from Remote Desktop Users Group (WinRM is required)"
    Write-Host "[11] Restart PCs (WinRM is required)"
    Write-Host "[12] Shutdown PCs (WinRM is required)"
    Write-Host "[13] Update Policy (WinRM is required)"
    write-host "[14] Print Contents of CSV"
    write-host "[15] READ ME"
    Write-Host "[X]  EXIT"
    $Menu = Read-Host

    switch ($Menu) {
        1 {
            $Mode = Input-Mode
            if ($Mode -eq 1) {Import-Csv(Choose-CSV) | ForEach-Object {Join-PC $_.PC}}
            if ($Mode -eq 2) {Join-PC (Read-Host "PC Name")}
        }

        2 {
            $Mode = Input-Mode
            if ($Mode -eq 1) {Import-Csv(Choose-CSV) | ForEach-Object {$PC = $_.PC; Move-OU $_.Branch $_.PC; Add-User $_.PC $_.User "Administrators"; Add-User $_.PC $_.User "Remote Desktop Users"; Update-Policy $_.PC; (shutdown -m \\$PC -r -t 0 -f)}}
            if ($Mode -eq 2) {
                $Branch = Read-Host "Branch Code?"
                $PC = Read-Host "PC?"
                $User = Read-Host "User?"
                Move-OU $Branch $PC
                Add-User $PC $User "Administrators"; Add-User $PC $User "Remote Desktop Users"
                Update-Policy $PC
                (shutdown -m \\$_.PC -r -t 0 -f)
            }
        }

        3 {
            $Mode = Input-Mode
            if ($Mode -eq 1) {Import-Csv(Choose-CSV) | ForEach-Object {Remove-LN $_.PC; Store-Cred $_.PC $_.User $_.PW; Start-RDP $_.PC}}
            if ($Mode -eq 2) {
                $PC = Read-Host "PC?"
                $User = Read-Host "User?"
                $PW = Read-Host "Password?"
                Remove-LN $PC; Store-Cred $PC $User $PW; Start-RDP $PC
            }
        }

        4 {
            $Mode = Input-Mode
            $BackUpLoc = Read-Host "Enter remote file server location (ex: \\aaserver\e$\SSERVER_userbkp)"
            if ($Mode -eq 1) {Import-Csv(Choose-CSV) | ForEach-Object {Copy-Files $BackUpLoc $_.PC $_.User}}
            if ($Mode -eq 2) {
                $PC = Read-Host "PC?"
                $User = Read-Host "User?"
                Copy-Files $BackUpLoc $PC $User
            }
        }

        5 {
            $Mode = Input-Mode
            if ($Mode -eq 1) {Import-Csv(Choose-CSV) | ForEach-Object {Move-OU $_.Branch $_.PC}}
            if ($Mode -eq 2) {
                $PC = Read-Host "PC?"
                $Branch = Read-Host "Branch Code?"
                Move-OU $Branch $PC
            }
        }

        6 {
            $Mode = Input-Mode
            if ($Mode -eq 1) {Import-Csv(Choose-CSV) | ForEach-Object {Prepare-PC $_.PC}}
            if ($Mode -eq 2) {Prepare-PC (Read-Host "PC Name")}
        }
        
        7 {
            $Mode = Input-Mode
            if ($Mode -eq 1) {Import-Csv(Choose-CSV) | ForEach-Object {Add-User $_.PC $_.User "Administrators"}}
            if ($Mode -eq 2) {
                $PC = Read-Host "PC?"
                $User = Read-Host "User?"
                Add-User $PC $User "Administrators"
            }
        }

        8 {
            $Mode = Input-Mode
            if ($Mode -eq 1) {Import-Csv(Choose-CSV) | ForEach-Object {Remove-User $_.PC $_.User "Administrators"}}
            if ($Mode -eq 2) {
                $PC = Read-Host "PC?"
                $User = Read-Host "User?"
                Remove-User $PC $User "Administrators"
            }
        }

        9 {
            $Mode = Input-Mode
            if ($Mode -eq 1) {Import-Csv(Choose-CSV) | ForEach-Object {Add-User $_.PC $_.User "Remote Desktop Users"}}
            if ($Mode -eq 2) {
                $PC = Read-Host "PC?"
                $User = Read-Host "User?"
                Add-User $PC $User "Remote Desktop Users"
            }
        }

        10 {
            $Mode = Input-Mode
            if ($Mode -eq 1) {Import-Csv(Choose-CSV) | ForEach-Object {Remove-User $_.PC $_.User "Remote Desktop Users"}}
            if ($Mode -eq 2) {
                $PC = Read-Host "PC?"
                $User = Read-Host "User?"
                Remove-User $PC $User "Remote Desktop Users"
            }
        }

        11 {
            $Mode = Input-Mode
            if ($Mode -eq 1) {Import-Csv(Choose-CSV) | ForEach-Object {$PC = $_.PC; Update-Policy $_.PC; Start-Process shutdown "-m \\$PC -r -t 0 -f"}}
            if ($Mode -eq 2) {
                $PC = Read-Host "PC?"
                Update-Policy $PC
                (shutdown -m \\$PC -r -t 0 -f)
            }
        }

        12 {
            $Mode = Input-Mode
            if ($Mode -eq 1) {Import-Csv(Choose-CSV) | ForEach-Object {shutdown -m \\$_.PC -s -t 0 -f}}
            if ($Mode -eq 2) {
            $PC = Read-Host "PC?"
                (shutdown -m \\$PC -s -t 0 -f)
            }
        }

        13 {
            $Mode = Input-Mode
            if ($Mode -eq 1) {Import-Csv(Choose-CSV) | ForEach-Object {Update-Policy $_.PC}}
            if ($Mode -eq 2) {
                $PC = Read-Host "PC?"
                Update-Policy $PC
            }
        }

        14 {Import-Csv(Choose-CSV)}

        15 {Get-Content .\system\readme.txt; }
    }
    write-host "Press Any Key to Continue"
    $x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    Clear-Host
} While ($Menu -ne 'x' -or $Menu -ne 'X')