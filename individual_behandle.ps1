$asciiart = @"
██╗      ██████╗  ██████╗ ██╗████████╗██████╗  █████╗ ███╗   ██╗███████╗
██║     ██╔═══██╗██╔════╝ ██║╚══██╔══╝██╔══██╗██╔══██╗████╗  ██║██╔════╝
██║     ██║   ██║██║  ███╗██║   ██║   ██████╔╝███████║██╔██╗ ██║███████╗
██║     ██║   ██║██║   ██║██║   ██║   ██╔══██╗██╔══██║██║╚██╗██║╚════██║
███████╗╚██████╔╝╚██████╔╝██║   ██║   ██║  ██║██║  ██║██║ ╚████║███████║
╚══════╝ ╚═════╝  ╚═════╝ ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝

     ██╗██╗   ██╗██╗     ██╗      █████╗ ███╗   ██╗██████╗ 
     ██║╚██╗ ██╔╝██║     ██║     ██╔══██╗████╗  ██║██╔══██╗
     ██║ ╚████╔╝ ██║     ██║     ███████║██╔██╗ ██║██║  ██║
██   ██║  ╚██╔╝  ██║     ██║     ██╔══██║██║╚██╗██║██║  ██║
╚█████╔╝   ██║   ███████╗███████╗██║  ██║██║ ╚████║██████╔╝
 ╚════╝    ╚═╝   ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝
"@
function Vejle {
    $afsendAddress = Read-Host "Skriv afsender adressen"
    $addressev = Read-Host "Skriv adressen paa modtageren"

    cls
    $byerv = @("Vejle", "Kolding", "Esbjerg", "Ribe", "Toender", "Soenderborg", "Aabenraa", "Haderslev")
    Write-Host $asciiart
    Write-Host ""
    Write-Host "===========Vaelge en by==============="

    for ($i = 0; $i -lt $byerv.Count; $i++) {
        Write-Host "$($i + 1). $($byerv[$i])"
    }

    $byvalgv = Read-Host "Vaelge byen paa ruten hvor pakken bliver afleveret (1-$($byerv.Count))"
    $valgtebyv = $byerv[([int]$byvalgv - 1)]

    $datov = Get-Date -Format "yyyy-MM-dd"
    $vaegt = Read-Host "Skriv vaegt af pakke"
    $pakkeStoarelse = Read-Host "Skriv Hoajde x Brede x Dybbe"
    $medarbejderId = Read-Host "Skriv medarbejder ID der har oprettet filen"
    $bemaerkning = Read-Host "Skriv bemaerkning omkring forsendelsen"

    cls
    Write-Host $asciiart
    Write-Host ""
    Write-Host "==========Valgte informationer============"
    Write-Host "Afsender adressen: $afsendAddress"
    Write-Host "Modtager adresse: $addressev"
    Write-Host "By: $valgtebyv"
    Write-Host "Dato: $datov"
    Write-Host "Vaegt: $vaegt"
    Write-Host "Pakken stoaredse Hoajde x Brede x Dybbe: $pakkeStoarelse"
    Write-Host "Medarbejder ID: $medarbejderId"
    Write-Host "Bemaerkning: $bemaerkning"

    $godkendelsev = $null

    while ($godkendelsev -notin @("Ja", "No")) {
        $godkendelsev = Read-Host "Godkend om du vil gemme disse oplysninger (Ja/Nej)"

        if ($godkendelsev -eq "Ja") {
            $filePathv = "/Users/hackyourfuturedk/Desktop/Vejle"

            $filNavnv = "${valgtebyv}_${addressev}_${datov}.txt"
            $fullPathv = Join-Path -Path $filePathv -ChildPath $filNavnv

            $indholdv = @"
     Afsender adressen: $afsendAddress
     Modtager adresse: $addressev
     By: $valgtebyv
     Dato: $datov
     Vaegt i kg: $vaegt
     Pakken stoaredse Hoajde x Brede x Dybbe: $pakkeStoarelse
     Medarbejder ID: $medarbejderId
     Bemaerkning: $bemaerkning
"@

            $indholdv | Out-File -FilePath $fullPathv

            Write-Host "Informationer er blevet gemt i $fullPathv"
        }
        elseif ($godkendelsev -eq "Nej") {
            Write-Host "Informationer er ikke blevet gemt"
            return
        }
        else {
            Write-Host "Vaelge enten ja eller Nej"
        }
    }
}

function Herning {
    $afsendAddress = Read-Host "Skriv afsender adressen"
    $addresseh = Read-Host "Skriv adressen paa modtageren"

    cls
    $byerh = @("Herning", "Silkeborg", "Horsens", "Skanderborg", "Aarhus", "Randers", "Viborg")
    Write-Host $asciiart
    Write-Host ""
    Write-Host "===========Vaelge en by==============="

    for ($i = 0; $i -lt $byerh.Count; $i++) {
        Write-Host "$($i + 1). $($byerh[$i])"
    }

    $byvalgh = Read-Host "Vaelge byen paa ruten hvor pakken bliver afleveret (1-$($byerh.Count))"
    $valgtebyh = $byerh[([int]$byvalgh - 1)]


    $datoh = Get-Date -Format "yyyy-MM-dd"
    $vaegt = Read-Host "Skriv vaegt af pakke"
    $pakkeStoarelse = Read-Host "Skriv Hoajde x Brede x Dybbe"
    $medarbejderId = Read-Host "Skriv medarbejder ID der har oprettet filen"
    $bemaerkning = Read-Host "Skriv bemaerkning omkring forsendelsen"

    cls
    Write-Host $asciiart
    Write-Host ""
    Write-Host "==========Valgte informationer============"
    Write-Host "Afsender adressen: $afsendAddress"
    Write-Host "Modtager adresse: $addressev"
    Write-Host "By: $valgtebyv"
    Write-Host "Dato: $datov"
    Write-Host "Vaegt i kg: $vaegt"
    Write-Host "Pakken stoaredse Hoajde x Brede x Dybbe: $pakkeStoarelse"
    Write-Host "Medarbejder ID: $medarbejderId"
    Write-Host "Bemaerkning: $bemaerkning"
    
    $godkendelseh = $null
    
    while ($godkendelseh -notin @("Ja", "No")) {
        $godkendelseh = Read-Host "Godkend om du vil gemme disse oplysninger (Ja/Nej)"

        if ($godkendelseh -eq "Ja") {
            $filePathh = "/Users/hackyourfuturedk/Desktop/Vejle/Herning"

            $filNavnh = "${valgtebyh}_${addresseh}_${datoh}.txt"
            $fullPathh = Join-Path -Path $filePathh -ChildPath $filNavnh

            $indholdh = @"
     Afsender adressen: $afsendAddress
     Modtager adresse: $addressev
     By: $valgtebyv
     Dato: $datov
     Vaegt: $vaegt
     Pakken stoaredse Hoajde x Brede x Dybbe: $pakkeStoarelse
     Medarbejder ID: $medarbejderId
     Bemaerkning: $bemaerkning
"@

            $indholdh | Out-File -FilePath $fullPathh

            Write-Host "Informationer er blevet gemt i $fullPathh"
        }
        elseif ($godkendelseh -eq "Nej") {
            Write-Host "Informationer er ikke blevet gemt"
            return
        }
        else {
            Write-Host "Vaelge enten ja eller Nej"
        }
    }
    
}


function PrintPackageList {
    $mappeStiVejle = "/Users/hackyourfuturedk/Desktop/Vejle"
    $mappeStiHerning = "/Users/hackyourfuturedk/Desktop/Herning"
    $datoh = Get-Date -Format "yyyy-MM-dd"
    $efterfolgendeDato = $datoh.AddDays(1)

    $filListeVejle = Get-ChildItem -Path $mappeStiVejle | Where-Object { $_.CreationTime -ge $datoh -and $_.CreationTime -lt $efterfolgendeDato }
    $filListeHerning = Get-ChildItem -Path $mappeStiHerning | Where-Object { $_.CreationTime -ge $datoh -and $_.CreationTime -lt $efterfolgendeDato }

    cls
    Write-Host $asciiart
    Write-Host ""
    Write-Host "============Pakkeliste for dagen og den efterfølgende dag============="

    Write-Host "Pakker i Vejle:"
    foreach ($fil in $filListeVejle) {
        Write-Host $fil.Name
    }

    Write-Host "Pakker i Herning:"
    foreach ($fil in $filListeHerning) {
        Write-Host $fil.Name
    }

    $antalFilerVejle = $filListeVejle.Count
    Write-Host "Antal pakker i Vejle: $antalFilerVejle"
    $antalFilerHerning = $filListeHerning.Count
    Write-Host "Antal pakker i Herning: $antalFilerHerning"
}

function PrintCityPackageCount {
    $mappeStiVejle = "/Users/hackyourfuturedk/Desktop/Vejle"
    $mappeStiHerning = "/Users/hackyourfuturedk/Desktop/Herning"
    $datoh = Get-Date -Format "yyyy-MM-dd"
    $efterfolgendeDato = $datoh.AddDays(1)

    $filListeVejle = Get-ChildItem -Path $mappeStiVejle | Where-Object { $_.CreationTime -ge $datoh -and $_.CreationTime -lt $efterfolgendeDato }
    $filListeHerning = Get-ChildItem -Path $mappeStiHerning | Where-Object { $_.CreationTime -ge $datoh -and $_.CreationTime -lt $efterfolgendeDato }

    cls
    Write-Host $asciiart
    Write-Host ""
    Write-Host "============Antal pakker i hver by for dagen og den efterfølgende dag============="

    $cityPackageCountVejle = @{}
    foreach ($fil in $filListeVejle) {
        $city = ($fil.Name -split "_")[0]
        if ($cityPackageCountVejle.ContainsKey($city)) {
            $cityPackageCountVejle[$city]++
        }
        else {
            $cityPackageCountVejle[$city] = 1
        }
    }

    $cityPackageCountHerning = @{}
    foreach ($fil in $filListeHerning) {
        $city = ($fil.Name -split "_")[0]
        if ($cityPackageCountHerning.ContainsKey($city)) {
            $cityPackageCountHerning[$city]++
        }
        else {
            $cityPackageCountHerning[$city] = 1
        }
    }

    Write-Host "Antal pakker i Vejle:"
    foreach ($city in $cityPackageCountVejle.Keys) {
        Write-Host "$city : $($cityPackageCountVejle[$city])"
    }

    Write-Host "Antal pakker i Herning:"
    foreach ($city in $cityPackageCountHerning.Keys) {
        Write-Host "$city : $($cityPackageCountHerning[$city])"
    }
}

function Menu {
    param (
        [string]$Titel = 'Rute valg'
    )
    cls
    Write-Host $asciiart
    Write-Host ""
    Write-Host "============$Titel============="

    Write-Host "1: Vejle ruten"
    Write-Host "2: Herning ruten"
    # Write-Host "3 Pakkeliste der skal leveres på en tur"
    Write-Host "3: Print Package List for the Day and Following Day"
    Write-Host "4: Print City Package Count for the Day and Following Day"
    Write-Host "Q: Quit"
}

do {
    Menu
    $input = Read-Host "Vaelge en rute"
    switch ($input) {
        '1' { Vejle }
        '2' { Herning }
        # '3' { LeveresListenAfEnTur }
        '3' {
            $routeChoice = Read-Host "Choose a route (Vejle/Herning)"
            $dateChoice = Read-Host "Enter date (yyyy-MM-dd)"
            PrintPackageListForRoute -route $routeChoice -date $dateChoice
        }
        '4' {
            $routeChoice = Read-Host "Choose a route (Vejle/Herning)"
            $dateChoice = Read-Host "Enter date (yyyy-MM-dd)"
            PrintParcelListInCities -route $routeChoice -date $dateChoice
        }
        'q' { return }
    }
    Pause
}until ($input -eq 'q')



# Continue with the existing menu and loop logic
# do {
#     Menu
#     $input = Read-Host "Vaelge en rute"
#     switch ($input) {
#         '1' { Vejle }
#         '2' { Herning }
#         '3' { LeveresListenAfEnTur }
#         '4' { PrintPackageList }
#         '5' { PrintCityPackageCount }
#         'q' { return }
#     }
#     Pause
# } until ($input -eq 'q')
