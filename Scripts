Add-Type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

function gethostdetails {
    param (
        [string]$machine
    )

    try {
        # Loop until valid host is found
        while ($true) {
            # Construct the API URL with proper query parameter syntax
            $newurl = "https://"+$PM+":8501/lr-admin-api/hosts?count=1&name=$machine"

            # Send the GET request to fetch the data
            $result = Invoke-RestMethod -Uri $newurl -Headers $headers -Method Get

            # Check if the result has any items (host found)
            if ($result -ne $null -and $result.Count -gt 0) {
                # Assuming the result contains a 'name' field and 'id' field directly
                $hostid = $result.id  # Extract the id directly from the result
                $entityid= $result.entity.id
                # Return an object containing both hostid and result
                return [PSCustomObject]@{
                    hostid = $hostid
                    entityid= $entityid
                    result = $result
                }
            }
            else {
                # If no results are found, prompt for a new machine name
                Write-Host "Host '$machine' not found. Please try again."
                $machine = Read-Host "Please enter the correct Machine Name"
            }
        }
    }
    catch {
        # Handle errors, such as logging them
        Write-Error "An error occurred: $_"
        return $null
    }
}
function getCollectorID {
    $newurl = "https://"+$PM+":8501/lr-admin-api/agents?count=1000&orderBy=id&dir=ascending"
    
    try {
        # Send the GET request to fetch the data
        $result = Invoke-RestMethod -Uri $newurl -Headers $headers -Method Get
        
        # Check if the response is valid and contains the necessary fields
        if ($result -ne $null) {
            $collectorInfo = $result | Select-Object id, name
            return $collectorInfo
        } else {
            Write-Host "No collectors found."
            return $null
        }
    }
    catch {
        Write-Error "An error occurred while retrieving the collector ID: $($_.Exception.Message)"
        return $null
    }
}
function getlogsourcetypesecurity{
$newurl = "https://"+$PM+":8501/lr-admin-api/messagesourcetypes?offset=0&count=100&orderBy=name&dir=ascending&name=MS%20Windows%20Event%20Logging%20XML%20-%20Security"
$logsourcetypesecurity =Invoke-RestMethod -Uri $newurl -Headers $headers -Method Get
return $logsourcetypesecurity.id
}
function getlogsourcetypeapplication{
$newurl = "https://"+$PM+":8501/lr-admin-api/messagesourcetypes?offset=0&count=100&orderBy=name&dir=ascending&name=MS%20Windows%20Event%20Logging%20XML%20-%20Application"
$logsourcetypeapplication =Invoke-RestMethod -Uri $newurl -Headers $headers -Method Get
return $logsourcetypeapplication.id
}
function getlogsourcetypesystem{
$newurl = "https://"+$PM+":8501/lr-admin-api/messagesourcetypes?offset=0&count=100&orderBy=name&dir=ascending&name=MS%20Windows%20Event%20Logging%20XML%20-%20System"
$logsourcetypesystem =Invoke-RestMethod -Uri $newurl -Headers $headers -Method Get
return $logsourcetypesystem.id
}
function getlogsourcetypepowershell{
$newurl = "https://"+$PM+":8501/lr-admin-api/messagesourcetypes?offset=0&count=100&orderBy=name&dir=ascending&name=MS%20Windows%20Event%20Logging%20XML%20-%20PowerShell"
$logsourcetypepowershell =Invoke-RestMethod -Uri $newurl -Headers $headers -Method Get
return $logsourcetypepowershell.id
}
function getlogsourcetypesysmon{
$newurl = "https://"+$PM+":8501/lr-admin-api/messagesourcetypes?name=MS%20Windows%20Event%20Logging%20XML%20-%20Sysmon&count=1"
$logsourcetypesysmon =Invoke-RestMethod -Uri $newurl -Headers $headers -Method Get
return $logsourcetypesysmon.id
}
function getlogsourcetypesecuritympepolicyid{
$newurl = "https://"+$PM+":8501/lr-admin-api/mpepolicies?offset=0&count=100&orderBy=name&dir=ascending&name=LogRhythm%20Default%20v2.0&messageSourceTypeId=$securityLogsourceTypeID"
$logsourcetypesecuritympepolicyid =Invoke-RestMethod -Uri $newurl -Headers $headers -Method Get
return $logsourcetypesecuritympepolicyid.id
}
function getlogsourcetypeapplicationmpepolicyid{
$newurl = "https://"+$PM+":8501/lr-admin-api/mpepolicies?offset=0&count=100&orderBy=name&dir=ascending&name=LogRhythm%20Default&messageSourceTypeId=$applicationLogsourceTypeID"
$logsourcetypeapplicationmpepolicyid =Invoke-RestMethod -Uri $newurl -Headers $headers -Method Get
return $logsourcetypeapplicationmpepolicyid.id
}
function getlogsourcetypesystemmpepolicyid{
$newurl = "https://"+$PM+":8501/lr-admin-api/mpepolicies?offset=0&count=100&orderBy=name&dir=ascending&name=LogRhythm%20Default%20v2.0&messageSourceTypeId=$systemLogsourceTypeID"
$logsourcetypesystemmpepolicyid =Invoke-RestMethod -Uri $newurl -Headers $headers -Method Get
return $logsourcetypesystemmpepolicyid.id
}
function getlogsourcetypepowershellmpepolicyid{
$newurl = "https://"+$PM+":8501/lr-admin-api/mpepolicies?offset=0&count=100&orderBy=name&dir=ascending&name=LogRhythm%20Default%20v2.0&messageSourceTypeId=$powershellLogsourceTypeID"
$logsourcetypepowershellmpepolicyid =Invoke-RestMethod -Uri $newurl -Headers $headers -Method Get
return $logsourcetypepowershellmpepolicyid.id
}
function getlogsourcetypesysmonmpepolicyid{
$newurl = "https://"+$PM+":8501/lr-admin-api/mpepolicies?offset=0&count=100&orderBy=name&dir=ascending&name=LogRhythm%20Default%20v2.0&messageSourceTypeId=$sysmonLogsourceTypeID"
$logsourcetypesysmonmpepolicyid =Invoke-RestMethod -Uri $newurl -Headers $headers -Method Get
return $logsourcetypesysmonmpepolicyid.id
}

function Option1 {
   $Uri = "https://"+$PM+":8501/lr-admin-api/logsources/"
$body = @{
   "id"= -1
   "systemMonitorId" = [int]$collectorID;
   "name" = $machine+" WinEvtXML - sec "+$date;
   "host"=  @{
    "id" = [int]$hostid
  }
  "entity"=  @{
    "id" = [int]$entityid
  }
   "logSourceType" = @{
   "id"= [int]$securityLogsourceTypeID
    #"name" = "MS Windows Event Logging XML - Security"
  }
  "mpePolicy" =  @{
  "id"=[int]$securityLogsourceTypempeid
    #"name" = "LogRhythm Default v2.0"
  }
   "mpeProcessingMode" = "EventForwardingEnabled"
   "filePath"= $machine+":Security"
   "defMsgArchiveMode"= "Override_Archive"
   "isArchivingEnabled" = $true
   "collectionDepth"= [int]-1 # for collecting from begining
  "parameter1" = [int]0;
  "parameter2" = [int]0;
  "parameter3"= [int]0;
  "parameter4" = [int]0
} | ConvertTo-Json

Invoke-RestMethod -Uri $Uri -Headers $headers -Method Post   -Body $body
}
function Option2 {
    $Uri = "https://"+$PM+":8501/lr-admin-api/logsources/"
$body = @{
   "id"= -1
   "systemMonitorId" = [int]$collectorID;
   "name" = $machine+" WinEvtXML - APP "+$date;
   "host"=  @{
    "id" = [int]$hostid
  }
  "entity"=  @{
    "id" = [int]$entityid
  }
   "logSourceType" = @{
   "id"= [int]$applicationLogsourceTypeID
    #"name" = "MS Windows Event Logging XML - Security"
  }
  "mpePolicy" =  @{
  "id"=[int]$applicationLogsourceTypempeid
    #"name" = "LogRhythm Default v2.0"
  }
   "mpeProcessingMode" = "EventForwardingEnabled"
   "filePath"= $machine+":Application"
   "defMsgArchiveMode"= "Override_Archive"
   "isArchivingEnabled" = $true
   "collectionDepth"= [int]-1 # for collecting from begining
     "parameter1" = [int]0;
  "parameter2" = [int]0;
  "parameter3"= [int]0;
  "parameter4" = [int]0
} | ConvertTo-Json

Invoke-RestMethod -Uri $Uri -Headers $headers -Method Post   -Body $body
}
function Option3 {
     $Uri = "https://"+$PM+":8501/lr-admin-api/logsources/"
$body = @{
   "id"= -1
   "systemMonitorId" = [int]$collectorID;
   "name" = $machine+" WinEvtXML - Sys "+$date;
   "host"=  @{
    "id" = [int]$hostid
    #"name"= "LogRhythmE9PM01"
  }
  "entity"=  @{
    "id" = [int]$entityid
  }
   "logSourceType" = @{
   "id"= [int]$systemLogsourceTypeID
    #"name" = "MS Windows Event Logging XML - Security"
  }
  "mpePolicy" =  @{
  "id"=[int]$systemLogsourceTypempeid
    #"name" = "LogRhythm Default v2.0"
  }
   "mpeProcessingMode" = "EventForwardingEnabled"
   "filePath"= $machine+":System"
   "defMsgArchiveMode"= "Override_Archive"
   "isArchivingEnabled" = $true
   "collectionDepth"= [int]-1 # for collecting from begining
     "parameter1" = [int]0;
  "parameter2" = [int]0;
  "parameter3"= [int]0;
  "parameter4" = [int]0

} | ConvertTo-Json

Invoke-RestMethod -Uri $Uri -Headers $headers -Method Post   -Body $body
}
function Option4 {
     $Uri = "https://"+$PM+":8501/lr-admin-api/logsources/"
$body = @{
   "id"= -1
   "systemMonitorId" = [int]$collectorID;
   "name" = $machine+" WinEvtXML - powershell "+$date;
   "host"=  @{
    "id" = [int]$hostid
    #"name"= "LogRhythmE9PM01"
  }
  "entity"=  @{
    "id" = [int]$entityid
  }
   "logSourceType" = @{
   "id"= [int]$powershellLogsourceTypeID
    #"name" = "MS Windows Event Logging XML - Security"
  }
  "mpePolicy" =  @{
  "id"=[int]$powershellLogsourceTypempeid
    #"name" = "LogRhythm Default v2.0"
  }
   "mpeProcessingMode" = "EventForwardingEnabled"
   "filePath"= $machine+":Microsoft-Windows-PowerShell/Operational"
   "defMsgArchiveMode"= "Override_Archive"
   "isArchivingEnabled" = $true
   "collectionDepth"= [int]-1 # for collecting from begining
     "parameter1" = [int]0;
  "parameter2" = [int]0;
  "parameter3"= [int]0;
  "parameter4" = [int]0
} | ConvertTo-Json

Invoke-RestMethod -Uri $Uri -Headers $headers -Method Post   -Body $body
}
function Option5 {
    $Uri = "https://"+$PM+":8501/lr-admin-api/logsources/"
$body = @{
   "id"= -1
   "systemMonitorId" = [int]$collectorID;
   "name" = $machine+" WinEvtXML - sysmon "+$date;
   "host"=  @{
    "id" = [int]$hostid
    #"name"= "LogRhythmE9PM01"
  }
  "entity"=  @{
    "id" = [int]$entityid
  }
   "logSourceType" = @{
   "id"= [int]$sysmonLogsourceTypeID
    #"name" = "MS Windows Event Logging XML - Security"
  }
  "mpePolicy" =  @{
  "id"=[int]$sysmonLogsourceTypempeid
    #"name" = "LogRhythm Default v2.0"
  }
   "mpeProcessingMode" = "EventForwardingEnabled"
   "filePath"= $machine+":Microsoft-Windows-Sysmon/Operational"
   "defMsgArchiveMode"= "Override_Archive"
    "isArchivingEnabled" = $true
   "collectionDepth"= [int]-1 # for collecting from begining
     "parameter1" = [int]0;
  "parameter2" = [int]0;
  "parameter3"= [int]0;
  "parameter4" = [int]0
} | ConvertTo-Json

Invoke-RestMethod -Uri $Uri -Headers $headers -Method Post   -Body $body
}

$headers = @{'Content-Type'="application/json";'Authorization'="Bearer $Token"}

Write-Host "Welcome! this script will help you adding log source using API."
Write-Host ""
Write-Host "If you have any question please feel free to send me an email on ibrahim.hamza@exabeam.com or call me on +966550715303."
Write-Host ""
Write-Host " _______           _______  ______   _______  _______  _______ 
(  ____ \|\     /|(  ___  )(  ___ \ (  ____ \(  ___  )(       )
| (    \/( \   / )| (   ) || (   ) )| (    \/| (   ) || () () |
| (__     \ (_) / | (___) || (__/ / | (__    | (___) || || || |
|  __)     ) _ (  |  ___  ||  __ (  |  __)   |  ___  || |(_)| |
| (       / ( ) \ | (   ) || (  \ \ | (      | (   ) || |   | |
| (____/\( /   \ )| )   ( || )___) )| (____/\| )   ( || )   ( |
(_______/|/     \||/     \||/ \___/ (_______/|/     \||/     \|"

Write-Host ""
Write-Host "Please type your PM IP/Name"
Write-Host ""
$pm = Read-Host
Write-Host ""
Write-Host "Please type your token"
Write-Host ""
$token = Read-Host
Write-Host ""
$date = Get-Date -Format "yyyy-MM-dd"
Write-Host "Please enter your Machine Name"
Write-Host ""
$machine = $null
$machine = Read-Host
$machine = $machine.Trim()
$hostDetails = $null
$hostid = $null
$hostDetails = gethostdetails -machine $machine
$hostid=$hostDetails.hostid
$entityid=$hostDetails.entityid
Write-Host "Host ID: $hostid"
Write-Host "Entity ID: $entityid"
Write-Host ""
Read-Host -Prompt "Press Enter to continue"
$collectors = getCollectorID
# Display the collected information
if ($collectors -ne $null) {
    Write-Host "Collector IDs and Names:"
    $collectors | Format-Table -Property id, name
}
Write-Host ""
Write-Host "Please enter your Collector Agent ID from list above"
Write-Host ""
$collectorID = Read-Host
Write-Host("")
Write-Host("====================  Log Sources Type ID  ==================")
Write-Host("")
$securityLogsourceTypeID = getlogsourcetypesecurity
Write-Host("the security log source type id is $securityLogsourceTypeID")
$applicationLogsourceTypeID = getlogsourcetypeapplication
Write-Host("the application log source type id is $applicationLogsourceTypeID")
$systemLogsourceTypeID = getlogsourcetypesystem
Write-Host("the system log source type id is $systemLogsourceTypeID")
$powershellLogsourceTypeID = getlogsourcetypepowershell
Write-Host("the powershell log source type id is $powershellLogsourceTypeID")
$sysmonLogsourceTypeID = getlogsourcetypesysmon
Write-Host("the sysmon log source type id is $sysmonLogsourceTypeID")
Write-Host("")
Write-Host("====================  MPE Policy ID  ========================")
Write-Host("")
$securityLogsourceTypempeid = getlogsourcetypesecuritympepolicyid
Write-Host("the security log source type MPE Policy id is $securityLogsourceTypempeid")
$applicationLogsourceTypempeid = getlogsourcetypeapplicationmpepolicyid
Write-Host("the application log source type MPE Policy id is $applicationLogsourceTypempeid")
$systemLogsourceTypempeid = getlogsourcetypesystemmpepolicyid
Write-Host("the system log source type MPE Policy id is $systemLogsourceTypempeid")
$powershellLogsourceTypempeid = getlogsourcetypepowershellmpepolicyid
Write-Host("the powershell log source type MPE Policy id is $powershellLogsourceTypempeid")
$sysmonLogsourceTypempeid = getlogsourcetypesysmonmpepolicyid
Write-Host("the sysmon log source type MPE Policy id is $sysmonLogsourceTypempeid")

Write-Host("")
# Prompt the user for input
Write-Host ("1) Windows XML - Security")
Write-Host ("2) Windows XML - Application")
Write-Host ("3) Windows XML - System")
Write-Host ("4) Windows XML - PowerShell")
Write-Host ("5) Windows XML - Sysmon")
Write-Host("")
$userInput = Read-Host "Please select options (comma separated, e.g. 1,2,3)"

Write-Host("")
# Remove spaces and split input into an array
$userInput = $userInput -replace '\s', ''  # Remove spaces
$options = $userInput -split ','          # Split by comma

# Use switch statement to execute functions based on user selection
foreach ($option in $options) {
    switch ($option) {
        '1' {
            Option1
            break
        }
        '2' {
            Option2
            break
        }
        '3' {
            Option3
            break
        }
        '4' {
            Option4
            break
        }
        '5' {
            Option5
            break
        }
        default {
            Write-Host "Invalid selection: $option"
        }
    }
}

