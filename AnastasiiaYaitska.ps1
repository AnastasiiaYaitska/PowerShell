# Køre din PowerShell as Administrator. Tak. 

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
    try {
        # henter en liste over filer og mapper. -Recurse -returnerer en liste over objekter som representerer filer og mapper
        Get-ChildItem C:\Users -Recurse | 
        # where-object - en filterfunksjon. { $_.length -gt 524288000 }- statemant. returnere elementer > 500MB
        where-object { $_.length -gt 524288000 } | 
        #  resultatene basert på filstørrelse i stigende rekkefølge
        Sort-Object length | 
        # Alias  ft -> Format-Table. Vise fullstendige navn og størrelse på filene i tabellen.
        ft fullname, length -auto
    } 
    catch {
        #udskriver en fejlmeddelelse, hvis der opstår en undtagelse under udførelsen af ​​koden i prøveblokken
        Write-Host "An error occurred: $_"
    }


    # mulige script
    # Get-ChildItem -Path C:\Users -Recurse | Where-Object -FilterScript { $_.length -gt 500MB }
}


#tog fra nettet
function handlerInstalledApplication { 
    # Registry Hives 
    #$Object = @() - tom array. Senere vi tilføje data fra installed addlications
    $Object = @() 

    #liste over streger som skal ekskluderes fra rapporten.
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

    #definerer numeriske værdier for forskellige registernøkler. [lang] som repræsenterer forskellige typer registernøkler (bistader). Disse numbe bruges senere i scriptet til at få adgang til forskellige dele af Windows-registret.
    [long]$HIVE_HKROOT = 2147483648 
    [long]$HIVE_HKCU = 2147483649 
    [long]$HIVE_HKLM = 2147483650 
    [long]$HIVE_HKU = 2147483651 
    [long]$HIVE_HKCC = 2147483653 
    [long]$HIVE_HKDD = 2147483654 

    #Get-WmiObject-hente information om processorer i systemet.  Den spesifiserer at den skal hente AddressWidth, DataWidth og Architecture fra Win32_Processor-klassen.
    $Query = Get-WmiObject -query "Select AddressWidth, DataWidth,Architecture from Win32_Processor"
    
    #foreach ($i in $Query) { ... }: Dette er en løkke som itererer gjennom hvert element i resultatet fra WMI-spørringen. Den sjekker om AddressWidth-verdien er lik 64. Hvis den er det, blir variabelen $OSArch satt til '64-bit'. Hvis ikke, blir den satt til '32-bit'.
    foreach ($i in $Query) { 
        If ($i.AddressWidth -eq 64) {             
            $OSArch = '64-bit' 
        }             
        Else {             
            $OSArch = '32-bit'             
        } 
    } 


    # Switch-sætning, den kontrollerer værdien af ​​$OSArch-variablen. Afhængigt af værdien udføres forskellige handlinger for henholdsvis 64-bit og 32-bit arkitekturer. 
    Switch ($OSArch) { 
        "64-bit" {
            #Get-WmiObject bruges til at hente et WMI-objekt repræsenteret af "StdRegProv" fra registreringsdatabasen.
            #Forskellige registreringsnøglestier er defineret baseret på hvilke installationssteder, der skal inspiceres.
            $RegProv = Get-WmiObject -Namespace "root\default" -List | where { $_.Name -eq "StdRegProv" }
            $Hive = $HIVE_HKLM 
            $RegKey_64BitApps_64BitOS = "Software\Microsoft\Windows\CurrentVersion\Uninstall" 
            $RegKey_32BitApps_64BitOS = "Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" 
            $RegKey_32BitApps_32BitOS = "Software\Microsoft\Windows\CurrentVersion\Uninstall" 

            #Brug EnumKey-metoden til at hente en liste over undernøgler til de angivne registreringsnøgler.
            $SubKeys = $RegProv.EnumKey($HIVE, $RegKey_64BitApps_64BitOS) 

            #Sørg for, at der ikke opstår fejl, når du læser registreringsdatabasen

            if ($SubKeys.ReturnValue -eq 0) {
                #En foreach loop køres gennem hver undernøgle, hvor information som navn, version og udgiver hentes fra registreringsdatabasen.
                #Der foretages en kontrol for at se, om applikationsnavnet starter med nogen af ​​de ekskluderede strenge i excludeArray'en.
                #Hvis applikationen ikke er udelukket, tilføjes oplysningerne til $Object-arrayet.
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

            # Sørg for, at der ikke opstår fejl, når du læser registreringsdatabasen 

            if ($SubKeys.ReturnValue -eq 0) { 

                # Loop gennem alle returnerede undernøgler

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
        #På samme måde som i 64-bit-delen
        "32-bit" {
            $RegProv = Get-WmiObject -Namespace "root\default" -List | where { $_.Name -eq "StdRegProv" }
            $Hive = $HIVE_HKLM 
            $RegKey_32BitApps_32BitOS = "Software\Microsoft\Windows\CurrentVersion\Uninstall" 

            # Hent SubKey navner 

            $SubKeys = $RegProv.EnumKey($HIVE, $RegKey_32BitApps_32BitOS) 

            # Sørg for, at der ikke opstår fejl, når du læser registreringsdatabasen 

            if ($SubKeys.ReturnValue -eq 0) {
                # Loop gennem alle returnerede SubKEys 

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

    #$column1 ... $column5: Disse linjer definerer forskellige kolonner for printformatet. Hver kolonne er defineret med specifikke egenskaber såsom udtryk, bredde, etiket og justering. Dette hjælper med at formatere og strukturere dataene til præsentation.
    $column1 = @{expression = "ServerName"; width = 15; label = "Name"; alignment = "left" } 
    $column2 = @{expression = "Architecture"; width = 10; label = "32/64 Bit"; alignment = "left" } 
    $column3 = @{expression = "Appication"; width = 80; label = "Appication"; alignment = "left" } 
    $column4 = @{expression = "Version"; width = 15; label = "Version"; alignment = "left" } 
    $column5 = @{expression = "Publisher"; width = 30; label = "Publisher"; alignment = "left" } 

    #"#" * 80: Denne kommando repræsenterer en streng med 80 # tegn. Dette bruges til at oprette en linje af disse tegn og fungerer som en separator i outputtet.
    "#" * 80 
    #beskrivende oplysninger, der skal inkluderes i rapporten. Disse linjer giver oplysninger om, hvad rapporten viser, og antallet af installerede applikationer.
    "Installed Software Application Report" 
    "Numner of Installed Application count : $($object.count)" 
    #$(get-date) og $(gc env:computernavn) er PowerShell-kommandoer, der henter henholdsvis den aktuelle dato og computernavnet.
    "Generated $(get-date)" 
    # gc -> Get-Content  
    "Generated from $(gc env:computername)" 
    "#" * 80 

    #formaterer dataene i tabelformat ved hjælp af de definerede kolonner og viser oplysningerne i konsollen.
    $object | Format-Table $column1, $column2, $column3 , $column4, $column5 
    #$objekt | Out-GridView: Denne kommando åbner et grafisk visningsvindue (GridView), der viser dataene i et brugervenligt format, så brugeren nemt kan gennemse og udforske informationen.
    $object | Out-GridView  

}

function handlerSystemErrorsLast14Days {
    try {
        # Get-EventLog hente begivenhedslogposter
        Get-EventLog 
        #-LogName System angiver navnet på loggen
        -LogName System 
        # filtrerer begivenhedslogposterne baseret på typen af begivenhed
        -EntryType Error 
        #angiver et tidsfilter
        -After (Get-Date).AddDays(-14) 
    }
    catch {
        #udskriver en fejlmeddelelse, hvis der opstår en undtagelse under udførelsen af ​​koden i prøveblokken
        Write-Host "An error occurred: $_"

    
    }
}

function handlerLogonEventsLast14days {
    try {
        #start- og slutdatoer, der bruges til at begrænse søgningen til sikkerhedslogfiler i en bestemt tidsperiode (her de sidste 14 dage).
        $startDate = (Get-Date).AddDays(-14)
        $endDate = Get-Date

        $usernames = @()  # Opretter en tom liste til at gemme brugernavne

        #henter hændelser fra Windows-sikkerhedsloggen med specifikke egenskaber, herunder LogName, StartTime, EndTime og ID. Den leder specifikt efter begivenheder med ID 4624, som repræsenterer et vellykket login.
        $logs = Get-WinEvent -FilterHashtable @{
            LogName   = 'Security'
            StartTime = $startDate
            EndTime   = $endDate
            ID        = 4624
        } | 
        #For hver modtaget hændelse gemmes brugernavnet fra den sjette egenskab i $username-variablen. Den kontrollerer derefter, om brugernavnet allerede er på listen over brugernavne. Hvis ikke, tidføjes det til listen.
        ForEach-Object {
            $username = $_.Properties[5].Value  # Gemmer brugernavnet fra den 6. egenskab
            if ($username -notin $usernames) {
                # Kontrollerer om brugernavnet allerede er til stede i listen
                $usernames += $username  # Tilføjer brugernavnet til listen, hvis det ikke allerede er til stede
            }
            $properties = @{
                TimeCreated = $_.TimeCreated
                Username    = $username
            }

            #opretter et PowerShell-objekt med egenskaberne TimeCreated og Brugernavn, der repræsenterer hændelsestidspunktet og brugernavnet.
            New-Object PSObject -Property $properties
        }

        $logs  # Returnerer resultatet, der indeholder tidspunkt, unikke brugernavne og meddelelser for hver hændelse.
    }
    catch {
        #udskriver en fejlmeddelelse, hvis der opstår en undtagelse under udførelsen af ​​koden i prøveblokken
        Write-Host "An error occurred: $_"
    }
  
}

function handlerHarddiskState {
    try {
        #  Get-PhysicalDisk-henter en liste over fysiske diske, der er tilsluttet computeren, inklusive interne og eksterne diske.
        # | - operator, der bruges til at videregive resultatet (Pipeline-operator)
        # Select-Object- specifikke egenskaber fra et objekt eller en liste over objekter.
        # DeviceId, MediaType, OperationalStatus, Size, HealthStatus - vælgerne resultater
        Get-PhysicalDisk | Select-Object DeviceId, MediaType, OperationalStatus, Size, HealthStatus
    }
    catch {
        #udskriver en fejlmeddelelse, hvis der opstår en undtagelse under udførelsen af ​​koden i prøveblokken
        Write-Host "An error occurred: $_"
    }
 
}

function handlerHarddiskFileSystem {
    # 1 .Get-PSDrive .Mulige variant. At hente en liste over de logiske drev på computeren
    try {
        #2. WMI (Windows Management Instrumentation) til å hente informasjon om logiske disker på datamaskinen. Den spesifikke klasse som brukes her er win32_logicaldisk, som gir informasjon om logiske disker på datamaskinen.
        Get-WmiObject -Class win32_logicaldisk | 
        #formaterer informasjonen som er hentet fra win32_logicaldisk
        Format-Table DeviceId, MediaType, @{n = "Size"; e = { 
                #[math]::Round($_.Size / 1GB, 2): Dette udtryk tager diskens samlede størrelse (størrelse) i bytes, som normalt er givet af $_.Size, og dividerer det med antallet af bytes i en gigabyte (1 GB ) for at konvertere den til gigabyte. Derefter bruges Round-metoden fra System.Math-klassen til at afrunde resultatet til to decimaler. Dette giver diskens størrelse i gigabyte (GB) til to decimaler.
                [math]::Round($_.Size / 1GB, 2) } 
            #ledig ledig plads på disken (FreeSpace) i bytes, normalt givet af $_.FreeSpace
        }, @{n = "FreeSpace"; e = { [math]::Round($_.FreeSpace / 1GB, 2) } }
    }
    catch {
        #udskriver en fejlmeddelelse, hvis der opstår en undtagelse under udførelsen af ​​koden i prøveblokken
        Write-Host "An error occurred: $_"
    }
  
    
}

function handlerTEMPAndSoftwareDescription {
    try {
        $tempPath = "$env:TEMP"  # Stien til TEMP-mappen
        $softwareDistributionPath = "$env:SystemRoot\SoftwareDistribution"  # Stien til SoftwareDistribution-mappen

        #Get-ChildItem -at hente filer i både TEMP-mappen og SoftwareDistribution-mappen
        #Measure-Object bruges til at måle summen af ​​længderne af filerne (størrelsen) i hver mappe
        $tempSize = Get-ChildItem -Path $tempPath -Recurse | Measure-Object -Property Length -Sum | Select-Object -ExpandProperty Sum
        $tempSizeGB = [math]::Round($tempSize / 1GB, 2)

        $softwareDistributionSize = Get-ChildItem -Path $softwareDistributionPath -Recurse | Measure-Object -Property Length -Sum | 
        #Select-Object -ExpandProperty Sum bruges til at vælge og udvide summen af ​​størrelsen af ​​de fundne filer
        Select-Object -ExpandProperty Sum
        $softwareDistributionSizeGB = [math]::Round($softwareDistributionSize / 1GB, 2)

        #formere table
        [PSCustomObject]@{
            TempFolderSizeGB                 = $tempSizeGB
            SoftwareDistributionFolderSizeGB = $softwareDistributionSizeGB
        }
    }
    catch {
        #udskriver en fejlmeddelelse, hvis der opstår en undtagelse under udførelsen af ​​koden i prøveblokken
        Write-Host "An error occurred: $_"
    }
    
}


function handlerTestInternetConnectionAndSpeed {
    try {
        $url = "http://www.google.com"
        # Test-Connection tester forbindelsen til webstedet "www.google.com" ved at sende fire ping-anmodninger
        $pingResult = Test-Connection -ComputerName "www.google.com" -Count 4 |
        # Measure-Object ResponseTime -Average | Select-Object -ExpandProperty Average: Dette beregner den gennemsnitlige responstid for ping-anmodninger sendt i Test-Connection-kommandoen.
        Measure-Object ResponseTime -Average | Select-Object -ExpandProperty Average
        #beregner downloadhastigheden ved at dividere indholdslængden af ​​filen med 1MB.
        $downloadSpeed = ((Invoke-WebRequest -Uri "http://speedtest.wdc01.softlayer.com/downloads/test10.zip").Headers.'Content-Length') / 1MB

        # hvis ping ok, vi skriv det i variabl, hvis ikke- det bliv "Not Available"
        $internetStatus = "Not Available"
        if ($pingResult) {
            $internetStatus = "Available"
        }

        # #formere table
        [PSCustomObject]@{
            InternetStatus   = $internetStatus
            GooglePingTimeMs = $pingResult
            DownloadSpeedMB  = $downloadSpeed
        }
    }
    catch {
        #Variablen $_, som kan bruges til at udskrive detaljerede oplysninger om fejlen.
        Write-Host "An error occurred: $_" 
    }
   
}


function handlerShowDataButton {
    try {
        #giver dig mulighed for at oprette Windows-baserede formularer og kontrolelementer
        Add-Type -AssemblyName System.Windows.Forms 
        #et nyt Windows-formularobjekt.
        $NewForm = New-Object Windows.Forms.Form 
        #indstiller størrelsen på det nye vindue til at være 250x150 pixels.
        $NewForm.Size = New-Object Drawing.Size @(250, 150)
        #indstiller startpositionen for det nye vindue til midten af ​​skærmen.
        $NewForm.StartPosition = "CenterScreen"
        #opretter en ny knap, der skal tilføjes til vinduet.
        $Button = New-Object System.Windows.Forms.Button
        #tilføjer en hændelseshandler til knappen, som i dette tilfælde udskriver den aktuelle dato til konsollen, når der klikkes på knappen.
        $Button.add_click({ Get-Date | Out-Host })
        #indstiller teksten vist på knappen til "Klik her".
        $Button.Text = "Click here"
        #tilføjer knappen til kontrollerne i det nye vindue.
        $NewForm.Controls.Add($Button)
        #viser det nye vinduet som en dialogboks.
        $Dialouge = $NewForm.ShowDialog()
    }
    catch {
        #udskriver en fejlmeddelelse, hvis der opstår en undtagelse under udførelsen af ​​koden i prøveblokken
        Write-Host "An error occurred: $_"
    }
  
    
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
        '3' { handlerSystemErrorsLast14Days }
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
    


