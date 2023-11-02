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