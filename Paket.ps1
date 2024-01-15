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

    cls
    Write-Host $asciiart
    Write-Host ""
    Write-Host "==========Valgte informationer============"
    Write-Host "Adresse: $addressev"
    Write-Host "By: $valgtebyv"
    Write-Host "Dato: $datov"

    $godkendelsev = $null

    while ($godkendelsev -notin @("Ja", "No")) {
        $godkendelsev = Read-Host "Godkend om du vil gemme disse oplysninger (Ja/Nej)"

        if ($godkendelsev -eq "Ja") {
            $filePathv = "[System.IO.Path]::Combine($env:USERPROFILE, 'Desktop')"

            $filNavnv = "${valgtebyv}_${addressev}_${datov}.txt"
            $fullPathv = Join-Path -Path $filePathv -ChildPath $filNavnv

            $indholdv = @"
Addresse: $addressev
By: $valgtebyv
Dato: $datov
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

    cls
    Write-Host $asciiart
    Write-Host ""
    Write-Host "==========Valgte informationer============"
    Write-Host "Addresse: $addresseh"
    Write-Host "By: $valgtebyh"
    Write-Host "Dato: $datoh"
    
    $godkendelseh = $null
    
    while ($godkendelseh -notin @("Ja", "No")) {
        $godkendelseh = Read-Host "Godkend om du vil gemme disse oplysninger (Ja/Nej)"

        if ($godkendelseh -eq "Ja") {
            $filePathh = "[System.IO.Path]::Combine($env:USERPROFILE, 'Desktop')"

            $filNavnh = "${valgtebyh}_${addresseh}_${datoh}.txt"
            $fullPathh = Join-Path -Path $filePathh -ChildPath $filNavnh

            $indholdh = @"
Addresse: $addresseh
By: $valgtebyh
Dato: $datoh
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
    Write-Host "Q: Quit"
}

do {
    Menu
    $input = Read-Host "Vaelge en rute"
    switch ($input) {
        '1' { Vejle }
        '2' { Herning }
        'q' { return }
    }
    Pause
}until ($input -eq 'q')