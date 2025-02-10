$domains = (Get-ADTrust -Filter *).Name+(Get-ADDomainController).domain

$result= ForEach ($Domain in $Domains){  
try{

Get-ADComputer -Filter 'OperatingSystem -like "Windows*" -and enabled -eq "true"'  -Server $domain -Properties Name,DNSHostName,CanonicalName,OperatingSystem,OperatingSystemVersion,IPv4Address,LastLogonDate | Select-Object Name,DNSHostName,@{'n'='Domain';'e'={$_.CanonicalName.split("/")[0]}},OperatingSystem,OperatingSystemVersion,IPv4Address,LastLogonDate 

} 
catch{}
}

$result |Export-Csv devices.csv 
