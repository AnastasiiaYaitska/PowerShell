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
            $filePathh = "/Users/hackyourfuturedk/Desktop/Herning"

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
function Get-PackageCount {
    param (
        [string]$route,
        [string]$date
    )

    $folderPath = "/Users/hackyourfuturedk/Desktop/$route"
    $files = Get-ChildItem -Path $folderPath -Filter "*_$date.*.txt"

    return $files.Count
}

function Print-PackageList {
    param (
        [string]$route,
        [string]$date
    )

    $folderPath = "/Users/hackyourfuturedk/Desktop/$route"
    $files = Get-ChildItem -Path $folderPath -Filter "*_$date.*.txt"

    if ($files.Count -eq 0) {
        Write-Host "No packages found for $date on the $route route."
    }
    else {
        Write-Host "Package list for $date on the $route route:"
        foreach ($file in $files) {
            Write-Host "$file"
        }
        Write-Host "Total packages: $($files.Count)"
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
    Write-Host "3: Pakkeliste der skal leveres på en tur"
    Write-Host "Q: Quit"
}

do {
    Menu
    $input = Read-Host "Vaelge en rute"
    switch ($input) {
        '1' { Vejle }
        '2' { Herning }
        '3' {
            $selectedRoute = Read-Host "Enter the route (Vejle/Herning)"
            $selectedDate = Get-Date -Format "yyyy-MM-dd"

            $packageCount = Get-PackageCount -route $selectedRoute -date $selectedDate
            Write-Host "Number of packages for $selectedDate on the $selectedRoute route: $packageCount"
            Print-PackageList -route $selectedRoute -date $selectedDate
        }
        'q' { return }
    }
    Pause
} until ($input -eq 'q')