$users = Get-ChildItem "C:\Users" | Where-Object { 
    $_.PSIsContainer -and $_.Name -notin @("All Users", "Default", "Default User", "Public", "UpdatusUser") 
}
$machine = hostname
$IP = (Get-NetIPAddress | Where-Object { 
    $_.IPAddress -match '\d+\.\d+\.\d+\.\d+' -and 
    $_.IPAddress -ne '127.0.0.1' -and 
    $_.IPAddress -notlike '169.254.*' 
} | ForEach-Object { $_.IPAddress }) -join ', '

foreach ($user in $users) {
    $tempFolder = "C:\Users\$($user.Name)\AppData\Local\"

    if (Test-Path $tempFolder) {
        $tempFiles = Get-ChildItem $tempFolder | Where-Object { $_.Name -eq 'Temp' } | Sort-Object LastWriteTime -Descending
        if ($tempFiles.Count -gt 0) {
            $latestFile = $tempFiles[0]
            #$latestFile
            $loginDate = $latestFile.LastWriteTime.ToString('yyyy/MM/dd')
            Write-Output "Computer: $machine IP: $IP User: $($user.Name) - Expected Login Date: $loginDate"
        }
        else {
            Write-Output "Computer: $machine IP: $IP User: $($user.Name) - No Temp files found, cannot determine login date."
        }
    }
    else {
        Write-Output "Computer: $machine IP: $IP User: $($user.Name) - Temp folder does not exist or is inaccessible."
    }
}
