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
    $afsendDatov = Read-Host "Skriv afsend date"

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

    $datov = Get-Date -Format "yyyyMMdd"
    $vaegt = Read-Host "Skriv vaegt af pakke i kg"
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
    Write-Host "Afsend dato: $afsendDatov"
    Write-Host "Vaegt i kg: $vaegt"
    Write-Host "Pakken stoaredse Hoajde x Brede x Dybbe: $pakkeStoarelse"
    Write-Host "Medarbejder ID: $medarbejderId"
    Write-Host "Bemaerkning: $bemaerkning"

    $godkendelsev = $null

    while ($godkendelsev -notin @("Ja", "No")) {
        $godkendelsev = Read-Host "Godkend om du vil gemme disse oplysninger (Ja/Nej)"

        if ($godkendelsev -eq "Ja") {
            $filePathv = "/Users/hackyourfuturedk/Desktop/Vejle"

            $filNavnv = "${valgtebyv}_${addressev}_${afsendDatov}.txt"
            $fullPathv = "$filePathv\$filNavnv"

            $indholdv = @"
     Afsender adressen: $afsendAddress
     Modtager adresse: $addressev
     By: $valgtebyv
     Dato: $datov
     Afsend dato: $afsendDatov
     Vaegt i kg: $vaegt
     Pakken stoaredse Hoajde x Brede x Dybbe: $pakkeStoarelse
     Medarbejder ID: $medarbejderId
     Bemaerkning: $bemaerkning
"@

            $indholdv | Out-File -FilePath $fullPathv

            Write-Host "Informationer er blevet gemt i $fullPathv "
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
    $afsendDatoh = Read-Host "Skriv afsend date"


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


    $datoh = Get-Date -Format "yyyyMMdd"
    $vaegt = Read-Host "Skriv vaegt af pakke i kg"
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
    Write-Host "Afsend dato: $afsendDatoh"
    Write-Host "Vaegt i kg: $vaegt"
    Write-Host "Pakken stoaredse Hoajde x Brede x Dybbe: $pakkeStoarelse"
    Write-Host "Medarbejder ID: $medarbejderId"
    Write-Host "Bemaerkning: $bemaerkning"
    
    $godkendelseh = $null
    
    while ($godkendelseh -notin @("Ja", "No")) {
        $godkendelseh = Read-Host "Godkend om du vil gemme disse oplysninger (Ja/Nej)"

        if ($godkendelseh -eq "Ja") {
            $filePathh = "/Users/hackyourfuturedk/Desktop/Herning"

            $filNavnh = "${valgtebyh}_${addresseh}_${afsendDatoh}.txt"
            $fullPathh = "$filePathh\$filNavnh"

            $indholdh = @"
     Afsender adressen: $afsendAddress
     Modtager adresse: $addressev
     By: $valgtebyv
     Dato: $datov
     Afsend dato: $afsendDatoh
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

function LeveresListenAfEnTur {
    param (
        [string]$ruten
    )
    
    $mappeSti = "/Users/hackyourfuturedk/Desktop/$ruten"
    $filListe = Get-ChildItem -Path $mappeSti  
    Write-Host "Filer i mappen $ruten :"  $filListe
    $antalFiler = $filListe.Length
    Write-Host "Antal filer i mappen $ruten : $antalFiler"
}

function PrintPakkelisteICities {
    param (
        [string]$rute,
        [string]$dato,
        [string]$by
    )

    $stiftpath = "/Users/hackyourfuturedk/Desktop/$rute"

    $næsteDato = (Get-Date).AddDays(1).ToString("yyyyMMdd")

    $filNavn = "${by}_*_${dato}.txt"
    $iMorgenFilNavn = "${by}_*_${næsteDato}.txt"

    cls
    Write-Host $asciiart
    Write-Host ""
    Write-Host "============Pakkeliste i $by den $dato og $næsteDato============="

    # Få en liste over filer der matcher mønsteret i den angivne mappe
    $filerIdag = Get-ChildItem -Path $stiftpath -Filter $filNavn
    $filerImorgen = Get-ChildItem -Path $stiftpath -Filter $iMorgenFilNavn

    # Kombiner resultaterne til en enkelt liste
    $alleFiler = @()

    foreach ($fil in $filerIdag) {
        $alleFiler += $fil
    }

    foreach ($fil in $filerImorgen) {
        $alleFiler += $fil
    }

    # Vis de filtrerede filer
    if ($alleFiler.Count -gt 0) {
        Write-Host "Filer fundet for by '$by' og send dato '$dato' og '$næsteDato':"
        $alleFiler | ForEach-Object { Write-Host $_.FullName }
    }
    else {
        Write-Host "Ingen filer fundet for by '$by' og send dato '$dato' og '$næsteDato'."
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
    Write-Host "4: Print pakke list i en by"
    Write-Host "Q: Quit"
}

do {
    Menu
    $input = Read-Host "Vaelge en rute"
    switch ($input) {
        '1' { Vejle }
        '2' { Herning }
        '3' { 
            $vælgteRuten = Read-Host "Vælg ruten (Vejle/Herning)"
            LeveresListenAfEnTur -ruten $vælgteRuten 
        }
        '4' {
            $vælgteRuten = Read-Host "Vælg ruten (Vejle/Herning)"
            $vælgteBy = Read-Host "Vælg en by"
            $vælgteDato = Read-Host "Indtast dato (yyyyMMdd)"
            PrintParcelListInCities -rute $vælgteRuten -dato $vælgteDato -by $vælgteBy
        }
        'q' { return }
    }
    Pause
}until ($input -eq 'q')