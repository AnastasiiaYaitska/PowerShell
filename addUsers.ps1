# Script til at oprette bruger i AD
Import-Module ActiveDirectory

# Bruges til at scriptet ved hvad hvor den csv fil den skal bruge er henne
$ADUsers = Import-Csv "C:\users.csv" -Delimiter ";"

# UPN staar for UserPrincipalName og det er her felt er lavet saa det nemere at redigere udfra behov
$UPN = "corp.LTJ.local"

foreach ($User in $ADUsers) {

    $username = $User.brugernavn
    $password = $User.password
    $firstname = $User.fornavn
    $lastname = $User.efternavn
    $initials = $User.initialer
    $OU = $User.ou # bruges til at registerer fra csv filen hvor den bestemte bruger skal opretes
    $email = $User.email
    $descrition = $User.beskrivelse
    $homedrive = "C:\"
    $homepath = "C:\Shares\$username"

    # Bruges til at tjekke efter om de eller den bruger man er ved at oprette allerede exsistere
    if (Get-ADUser -F { SamAccountName -eq $username }) {

        # Hvis den exsistere skal den skrive en advarsel om at den bruger allerede exsistere i AD
        Write-Warning "Brugeren ved navn $username exsiter allerede i Active Directory."
    }
    else {
        # Hvis den ikke exsistere skal den gaa igang med at oprette brugeren
        New-ADUser `
            -SamAccountName $username `
            -UserPrincipalName "$username@$UPN" `
            -Name "$firstname $lastname" `
            -GivenName $firstname `
            -Surname $lastname `
            -Initials $initials `
            -Enabled $true `
            -DisplayName "$firstname $lastname" `
            -Path $OU `
            -EmailAddress $email `
            -Description $descrition `
            -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -ChangePasswordAtLogon $False
        
        # Naar brugeren er oprettet skal den skrive en besked omkring at den er blevet oprettet
        Write-Host "Bruger ved navn $username er blevet oprettet i Active Directory."


    }
    # Opretter en ny mappe
    if (-not (Test-Path -Path $homepath)) {
        # Create the directory if it doesn't exist
        New-Item -Path $homepath -ItemType Directory
    }

    # Tildelder mappen til den givende bruger
    Set-ADUser -Identity $username -HomeDrive $homedrive -HomeDirectory $homepath
}

Read-Host -Prompt "Tryk Enter for at Exit"