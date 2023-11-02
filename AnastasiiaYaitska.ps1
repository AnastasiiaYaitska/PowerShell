$asciiBear = @"
KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK000KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKddxldxOXKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK0c;::clOXKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKOOOOOO0XKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK0kxdddddk0KKKKKKKXKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKOdllcc:ccldOKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK0xlll:;;;:clkKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKXK0OxdollllcclcclldO0KXKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKOdlllllllllllllllllox0KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK0xlllllllllllllllllllllokKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKOkxxxdllllllllllllllllllllllloOKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
KKKKKKKKKKKKKKKKKKKKKKKKKKXKK0xollcccllllllllllllll:.,cllllllx0KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
KKKKKKKKKKKKKKKKKKKKKKKKKKKKKOollc:;:cllllllllllllcc::looollld0KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
KKKKKKKKKKKKKKKKKKKKKKKKKKKKK0dllc:::clllllllllc,.';;;llllllldO0KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
KKKKKKKKKKKKKKKKKKKKKKKKKKKKKK0kdolcllllllc;,;cc;'.';cllllllllloxOKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK0Oxollllcc::ccc::ccllllllllllllllx0XKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKkollllllllllllllllodddddddddxdxO000000KK00KKKKKKKKKKKKKKKKKKKKKK
KKKKKKKKKKKKKKKKKKKKKK000000000000000Okxdddddddddxxxkk00KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKXKKKKKKKKKKKKKKKKKKXKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
"@

function handlerFileGrate500MB {
    Get-ChildItem C:\Users -recurse | where-object { $_.length -gt 524288000 } | Sort-Object length | ft fullname, length -auto
    # Get-ChildItem -Path C:\Users -Recurse | Where-Object -FilterScript { $_.length -gt 500MB }
}



function handlerInstalledApplication { 
    # Registry Hives 
    $Object = @() 
    $excludeArray = (
        "Security Update for Windows",
        "Update for Windows",
        "Update for Microsoft .NET",
        "Security Update for Microsoft",
        "Hotfix for Windows",
        "Hotfix for Microsoft .NET Framework",
        "Hotfix for Microsoft Visual Studio 2007 Tools",
        "Hotfix"
    )
    [long]$HIVE_HKROOT = 2147483648 
    [long]$HIVE_HKCU = 2147483649 
    [long]$HIVE_HKLM = 2147483650 
    [long]$HIVE_HKU = 2147483651 
    [long]$HIVE_HKCC = 2147483653 
    [long]$HIVE_HKDD = 2147483654 

    $Query = Get-WmiObject -query "Select AddressWidth, DataWidth,Architecture from Win32_Processor"
    
    foreach ($i in $Query) { 
        If ($i.AddressWidth -eq 64) {             
            $OSArch = '64-bit' 
        }             
        Else {             
            $OSArch = '32-bit'             
        } 
    } 

    Switch ($OSArch) { 
        "64-bit" {
            $RegProv = Get-WmiObject -Namespace "root\default" -List | where { $_.Name -eq "StdRegProv" }
            $Hive = $HIVE_HKLM 
            $RegKey_64BitApps_64BitOS = "Software\Microsoft\Windows\CurrentVersion\Uninstall" 
            $RegKey_32BitApps_64BitOS = "Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" 
            $RegKey_32BitApps_32BitOS = "Software\Microsoft\Windows\CurrentVersion\Uninstall" 

            $SubKeys = $RegProv.EnumKey($HIVE, $RegKey_64BitApps_64BitOS) 

            # Make Sure No Error when Reading Registry 

            if ($SubKeys.ReturnValue -eq 0) {
                # Loop Trhough All Returned SubKEys 
                ForEach ($Name in $SubKeys.sNames) { 
                    $SubKey = "$RegKey_64BitApps_64BitOS\$Name" 
                    $ValueName = "DisplayName" 
                    $ValuesReturned = $RegProv.GetStringValue($Hive, $SubKey, $ValueName) 
                    $AppName = $ValuesReturned.sValue 
                    $Version = ($RegProv.GetStringValue($Hive, $SubKey, "DisplayVersion")).sValue  
                    $Publisher = ($RegProv.GetStringValue($Hive, $SubKey, "Publisher")).sValue  
                    $donotwrite = $false 

                    if ($AppName.length -gt "0") { 

                        Foreach ($exclude in $excludeArray) { 
                            if ($AppName.StartsWith($exclude) -eq $TRUE) { 
                                $donotwrite = $true 
                                break 
                            } 
                        } 
                        if ($donotwrite -eq $false) {                         
                            $Object += New-Object PSObject -Property @{ 
                                Appication   = $AppName; 
                                Architecture = "64-BIT"; 
                                ServerName   = $EachServer; 
                                Version      = $Version; 
                                Publisher    = $Publisher; 
                            } 
                        } 

                    } 

                }
            } 

            ############################################################################# 

            $SubKeys = $RegProv.EnumKey($HIVE, $RegKey_32BitApps_64BitOS) 

            # Make Sure No Error when Reading Registry 

            if ($SubKeys.ReturnValue -eq 0) { 

                # Loop Through All Returned SubKEys 

                ForEach ($Name in $SubKeys.sNames) { 

                    $SubKey = "$RegKey_32BitApps_64BitOS\$Name" 

                    $ValueName = "DisplayName" 
                    $ValuesReturned = $RegProv.GetStringValue($Hive, $SubKey, $ValueName) 
                    $AppName = $ValuesReturned.sValue 
                    $Version = ($RegProv.GetStringValue($Hive, $SubKey, "DisplayVersion")).sValue  
                    $Publisher = ($RegProv.GetStringValue($Hive, $SubKey, "Publisher")).sValue  
                    $donotwrite = $false 

                    if ($AppName.length -gt "0") { 
                        Foreach ($exclude in $excludeArray) { 
                            if ($AppName.StartsWith($exclude) -eq $TRUE) { 
                                $donotwrite = $true 
                                break 
                            } 
                        } 
                        if ($donotwrite -eq $false) {                         
                            $Object += New-Object PSObject -Property @{ 
                                Appication   = $AppName; 
                                Architecture = "32-BIT"; 
                                ServerName   = $EachServer; 
                                Version      = $Version; 
                                Publisher    = $Publisher; 
                            } 
                        } 
                    } 

                } 

            } 

        }
        "32-bit" {
            $RegProv = Get-WmiObject -Namespace "root\default" -List | where { $_.Name -eq "StdRegProv" }
            $Hive = $HIVE_HKLM 
            $RegKey_32BitApps_32BitOS = "Software\Microsoft\Windows\CurrentVersion\Uninstall" 

            # Get SubKey names 

            $SubKeys = $RegProv.EnumKey($HIVE, $RegKey_32BitApps_32BitOS) 

            # Make Sure No Error when Reading Registry 

            if ($SubKeys.ReturnValue -eq 0) {
                # Loop Through All Returned SubKEys 

                ForEach ($Name in $SubKeys.sNames) { 
                    $SubKey = "$RegKey_32BitApps_32BitOS\$Name" 
                    $ValueName = "DisplayName" 
                    $ValuesReturned = $RegProv.GetStringValue($Hive, $SubKey, $ValueName) 
                    $AppName = $ValuesReturned.sValue 
                    $Version = ($RegProv.GetStringValue($Hive, $SubKey, "DisplayVersion")).sValue  
                    $Publisher = ($RegProv.GetStringValue($Hive, $SubKey, "Publisher")).sValue  

                    if ($AppName.length -gt "0") { 

                        $Object += New-Object PSObject -Property @{ 
                            Appication   = $AppName; 
                            Architecture = "32-BIT"; 
                            ServerName   = $EachServer; 
                            Version      = $Version; 
                            Publisher    = $Publisher; 
                        } 
                    } 

                }
            } 

        }
    }

    $column1 = @{expression = "ServerName"; width = 15; label = "Name"; alignment = "left" } 
    $column2 = @{expression = "Architecture"; width = 10; label = "32/64 Bit"; alignment = "left" } 
    $column3 = @{expression = "Appication"; width = 80; label = "Appication"; alignment = "left" } 
    $column4 = @{expression = "Version"; width = 15; label = "Version"; alignment = "left" } 
    $column5 = @{expression = "Publisher"; width = 30; label = "Publisher"; alignment = "left" } 

    "#" * 80 
    "Installed Software Application Report" 
    "Numner of Installed Application count : $($object.count)" 
    "Generated $(get-date)" 
    "Generated from $(gc env:computername)" 
    "#" * 80 

    $object | Format-Table $column1, $column2, $column3 , $column4, $column5 
    $object | Out-GridView  

}



# Kør funktionen for at få loggen for logins for de seneste 14 dage med unikke brugernavne
function handlerLogonEventsLast14days {
    $startDate = (Get-Date).AddDays(-14)
    $endDate = Get-Date

    $usernames = @()  # Opretter en tom liste til at gemme brugernavne

    $logs = Get-WinEvent -FilterHashtable @{
        LogName   = 'Security'
        StartTime = $startDate
        EndTime   = $endDate
        ID        = 4624
    } | ForEach-Object {
        $username = $_.Properties[5].Value  # Gemmer brugernavnet fra den 6. egenskab
        if ($username -notin $usernames) {
            # Kontrollerer om brugernavnet allerede er til stede i listen
            $usernames += $username  # Tilføjer brugernavnet til listen, hvis det ikke allerede er til stede
        }
        $properties = @{
            TimeCreated = $_.TimeCreated
            Username    = $username
        }
        New-Object PSObject -Property $properties
    }

    $logs  # Returnerer resultatet, der indeholder tidspunkt, unikke brugernavne og meddelelser for hver hændelse.
}

function handlerHarddiskState {
    # Få vist harddisk health/status for maskinen
    Get-PhysicalDisk | Select-Object DeviceId, MediaType, OperationalStatus, Size, HealthStatus
}

function handlerHarddiskFileSystem {
    # Get-PSDrive
    Get-WmiObject -Class win32_logicaldisk | Format-Table DeviceId, MediaType, @{n = "Size"; e = { [math]::Round($_.Size / 1GB, 2) } }, @{n = "FreeSpace"; e = { [math]::Round($_.FreeSpace / 1GB, 2) } }
    
}

function handlerTEMPAndSoftwareDescription {

    $tempPath = "$env:TEMP"  # Stien til TEMP-mappen
    $softwareDistributionPath = "$env:SystemRoot\SoftwareDistribution"  # Stien til SoftwareDistribution-mappen

    $tempSize = Get-ChildItem -Path $tempPath -Recurse | Measure-Object -Property Length -Sum | Select-Object -ExpandProperty Sum
    $tempSizeGB = [math]::Round($tempSize / 1GB, 2)

    $softwareDistributionSize = Get-ChildItem -Path $softwareDistributionPath -Recurse | Measure-Object -Property Length -Sum | Select-Object -ExpandProperty Sum
    $softwareDistributionSizeGB = [math]::Round($softwareDistributionSize / 1GB, 2)

    [PSCustomObject]@{
        TempFolderSizeGB                 = $tempSizeGB
        SoftwareDistributionFolderSizeGB = $softwareDistributionSizeGB
    }
}


function handlerTestInternetConnectionAndSpeed {

    $url = "http://www.google.com"
    $pingResult = Test-Connection -ComputerName "www.google.com" -Count 4 | Measure-Object ResponseTime -Average | Select-Object -ExpandProperty Average
    $downloadSpeed = ((Invoke-WebRequest -Uri "http://speedtest.wdc01.softlayer.com/downloads/test10.zip").Headers.'Content-Length') / 1MB

    $internetStatus = "Not Available"
    if ($pingResult) {
        $internetStatus = "Available"
    }

    [PSCustomObject]@{
        InternetStatus   = $internetStatus
        GooglePingTimeMs = $pingResult
        DownloadSpeedMB  = $downloadSpeed
    }
}


function handlerShowDataButton {
    Add-Type -AssemblyName System.Windows.Forms
    $NewForm = New-Object Windows.Forms.Form
    $NewForm.Size = New-Object Drawing.Size @(250, 150)
    $NewForm.StartPosition = "CenterScreen"
    $Button = New-Object System.Windows.Forms.Button
    $Button.add_click({ Get-Date | Out-Host })
    $Button.Text = "Click here"
    $NewForm.Controls.Add($Button)
    $Dialouge = $NewForm.ShowDialog()
    
}


function Show-Menu {
    param (
        [string]$Title = 'Anastasiias Menu'
    )
    cls
    Write-Host $asciiBear
    Write-Host ""
    Write-Host "================ $Title ================"

    Write-Host "1: Filer større end 500mb"
    Write-Host "2: Installeret programmer 32 og 64 bit"
    Write-Host "3: Fejl log fra de seneste 14 dage"
    Write-Host "4: Login de seneste 14 dage"
    Write-Host "5: Harddisk state"
    Write-Host "6: Harddisk filesystem i GB"
    Write-Host "7: Size of Temp and SoftwareDistribution folders"
    Write-Host "8: Internet hastighed"
    Write-Host "9: Show date after clicking on button"
    Write-Host "Q: Quit"
}

do {
    Show-Menu
    $input = Read-Host "Venligst lav et valg"
    switch ($input) {
        '1' { handlerFileGrate500MB }
        '2' { handlerInstalledApplication }
        '3' { FejlLogSeneste14Dage }
        '4' { handlerLogonEventsLast14days }
        '5' { handlerHarddiskState }
        '6' { handlerHarddiskFileSystem }
        '7' { handlerTEMPAndSoftwareDescription }
        '8' { handlerTestInternetConnectionAndSpeed }
        '9' { handlerShowDataButton }
        'q' { return }
    }
    pause
} until ($input -eq 'q')
    


