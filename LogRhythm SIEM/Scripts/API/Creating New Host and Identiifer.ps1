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

function getEntities {
    $newurl = "https://"+$PM+":8501/lr-admin-api/entities?count=1000&orderBy=id&dir=ascending"
    
    try {
        # Send the GET request to fetch the data
        $result = Invoke-RestMethod -Uri $newurl -Headers $headers -Method Get
        
        # Check if the response is valid and contains the necessary fields
        if ($result -ne $null) {
            $Entities = $result | Select-Object id, fullname
            return $Entities
        } else {
            Write-Host "No Entities found."
            return $null
        }
    }
    catch {
        Write-Error "An error occurred while retrieving the Entities: $($_.Exception.Message)"
        return $null
    }
}

function UpdateHostIPAddress {
    $newurl = "https://"+$PM+":8501/lr-admin-api/hosts/$hostid/identifiers"
    
    $body = @{
    "hostIdentifiers" =
    @(
     @{
      "type" = "IPAddress";
      "value" = $IPaddress;
    }
  )
} | ConvertTo-Json

 try {
        # Send the GET request to fetch the data
        $result = Invoke-RestMethod -Uri $newurl -Headers $headers -Method Post   -Body $body
        
        # Check if the response is valid and contains the necessary fields
        if ($result -ne $null) {
            Write-Host("IP Address has been successfully added to host")
            $hostinfo = $result
            return $hostinfo

        } else {
            Write-Host "No host found."
            return $null
        }
    }
    catch {
        Write-Error "An error occurred while creating the host IP Address Idenetifier: $($_.Exception.Message)"
        return $null
    }

}

function UpdateHostDNS {
    $newurl = "https://"+$PM+":8501/lr-admin-api/hosts/$hostid/identifiers"
    
    $body = @{
    "hostIdentifiers" = @(
    @{
      "type" = "DNSName";
      "value" = $DNSName;
    }
  )
} | ConvertTo-Json

 try {
        # Send the GET request to fetch the data
        $result = Invoke-RestMethod -Uri $newurl -Headers $headers -Method Post   -Body $body
        
        # Check if the response is valid and contains the necessary fields
        if ($result -ne $null) {
            Write-Host("DNS has been successfully added to host")
            $hostinfo = $result
            return $hostinfo

        } else {
            Write-Host "No host found."
            return $null
        }
    }
    catch {
        Write-Error "An error occurred while creating the host DNS Idenetifier: $($_.Exception.Message)"
        return $null
    }

}

function UpdateHostwindowsname {
    $newurl = "https://"+$PM+":8501/lr-admin-api/hosts/$hostid/identifiers"
    
    $body = @{
    "hostIdentifiers" = @(
    @{
      "type" = "WindowsName";
      "value" = $windowsname;
    }
  )
} | ConvertTo-Json

 try {
        # Send the GET request to fetch the data
        $result = Invoke-RestMethod -Uri $newurl -Headers $headers -Method Post   -Body $body
        
        # Check if the response is valid and contains the necessary fields
        if ($result -ne $null) {
            Write-Host("Windows Name has been successfully added to host")
            $hostinfo = $result
            return $hostinfo
        } else {
            Write-Host "No host found."
            return $null
        }
    }
    catch {
        Write-Error "An error occurred while creating the host Windows Name Idenetifier: $($_.Exception.Message)"
        return $null
    }

}

function CreateHost {
   $Uri = "https://"+$PM+":8501/lr-admin-api/hosts"
   write-host($EntityID)
$body = @{
   "id"= -1
   "name" = $machine;
  "entity"=  @{
    "id" = [int]$EntityID
    "name" = $EntityName
  }

   "riskLevel" = "Medium-Medium"
   "threatLevel"= "Medium-Medium"
   "recordStatusName"= "Active"
   "hostZone" = $hostzone
   "os" = $hostos
   "useEventlogCredentials"= $false
} | ConvertTo-Json

 try {
        # Send the GET request to fetch the data
        $result = Invoke-RestMethod -Uri $Uri -Headers $headers -Method Post   -Body $body
        
        # Check if the response is valid and contains the necessary fields
        if ($result -ne $null) {
            $hostinfo = $result
            return $hostinfo
        } else {
            Write-Host "No host found."
            return $null
        }
    }
    catch {
        Write-Error "An error occurred while creating the host: $($_.Exception.Message)"
        return $null
    }


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
$Entities = getEntities
# Display the collected information
if ($Entities -ne $null) {
    Write-Host "Entity IDs and Names:"
    $Entities | Format-Table -Property id, fullname
}
Write-Host ""
Write-Host "Please enter your Entity ID from list above"
Write-Host ""
$EntityID = Read-Host
Write-Host ""
Write-Host "Please enter your Entity Name from list above"
Write-Host ""
$EntityName = Read-Host
Write-Host("")
Write-Host ""
Write-Host "Please enter your Host Name"
Write-Host ""
$machine = $null
$machine = Read-Host
$machine = $machine.Trim()
Write-Host ""
Write-Host "1) Internal"
Write-Host "2) External"
Write-Host "3) DMZ"
Write-Host ""

# Get user input (number of the selected option)
$HostZoneSelection = Read-Host "Enter the number of the host zone"
Write-Host ""

# Define the variable to hold the hostzone value
$hostzone = ""

# Switch based on the user's selection
switch ($HostZoneSelection) {
    '1' { $hostzone = "Internal" }
    '2' { $hostzone = "External" }
    '3' { $hostzone = "DMZ" }
    default { Write-Host "Invalid selection!"; exit }
}

# Output the result
Write-Host "You selected Host Zone: $hostzone"
Write-Host ""

Write-Host "1)  Unknown"
Write-Host "2)  Other"
Write-Host "3)  WindowsNT4"
Write-Host "4)  Windows2000Professional"
Write-Host "5)  Windows2000Server"
Write-Host "6)  Windows2003Standard"
Write-Host "7)  Windows2003Enterprise"
Write-Host "8)  Windows95"
Write-Host "9)  WindowsXP"
Write-Host "10) WindowsVista"
Write-Host "11) Linux"
Write-Host "12) Solaris"
Write-Host "13) AIX"
Write-Host "14) HPUX"
Write-Host "15) Windows"
Write-Host ""

# Get user input (number of the selected option)
$OSSelection = Read-Host "Enter the number of the host zone"
Write-Host ""

# Define the variable to hold the hostzone value
$hostos = ""

# Switch based on the user's selection
switch ($OSSelection) {
    	'1'  { $hostos = "Unknown" }
    '2'  { $hostos = "Other" }
    '3'  { $hostos = "WindowsNT4" }
    '4'  { $hostos = "Windows2000Professional" }
    '5'  { $hostos = "Windows2000Server" }
    '6'  { $hostos = "Windows2003Standard" }
    '7'  { $hostos = "Windows2003Enterprise" }
    '8'  { $hostos = "Windows95" }
    '9'  { $hostos = "WindowsXP" }
    '10' { $hostos = "WindowsVista" }
    '11' { $hostos = "Linux" }
    '12' { $hostos = "Solaris" }
    '13' { $hostos = "AIX" }
    '14' { $hostos = "HPUX" }
    '15' { $hostos = "Windows" }
    default { Write-Host "Invalid selection!"; exit }
}

# Output the result
Write-Host "You selected Host OS: $hostos"
Write-Host ""

$createhostdetails = CreateHost
if ($createhostdetails -ne $null) {
    Write-Host("")
    Write-Host "Host Details are:"
    $createhostdetails
    $hostid = $createhostdetails.id
}
Write-Host("")
Write-Host("Host Id is "+ $hostid)
Write-Host("")
Write-Host("====================  Adding IP Address Identifier to Host ============")
Write-Host("")
$IPaddress = Read-Host "Enter the IP Address of the Host , just hit enter if you don't need to add a value"
Write-Host ""

Write-Host("")
Write-Host("====================  Adding DNS Identifier to Host  ==================")
Write-Host("")
$DNSName = Read-Host "Enter the DNS of the host , just hit enter if you don't need to add a value"
Write-Host ""
Write-Host("")
Write-Host("====================  Adding Hostname Identifier to Host  =============")
Write-Host("")
$windowsname = Read-Host "Enter the Windows Name of the host , just hit enter if you don't need to add a value"
Write-Host ""

UpdateHostIPAddress
UpdateHostDNS
UpdateHostwindowsname
