$domains = (Get-ADTrust -Filter *).Name+(Get-ADDomainController).domain

ForEach ($Domain in $Domains){  

try
{
Get-ADComputer -Identity "hrsd-altrex-web"  -Server $domain -Properties Name,DNSHostName,CanonicalName,OperatingSystem,OperatingSystemVersion,IPv4Address,LastLogonDate | Select-Object Name,DNSHostName,@{'n'='Domain';'e'={$_.CanonicalName.split("/")[0]}},OperatingSystem,OperatingSystemVersion,IPv4Address,LastLogonDate 
}
catch{
}
}
