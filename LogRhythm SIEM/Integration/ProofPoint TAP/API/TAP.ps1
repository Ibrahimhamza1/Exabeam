# Define the base URL for the Proofpoint API
#refer to the api on this link i will use below https://help.proofpoint.com/Threat_Insight_Dashboard/API_Documentation/SIEM_API
$baseUrl = "https://tap-api-v2.proofpoint.com/v2/siem/messages/blocked?format=json&sinceSeconds=3600"

$Service_Principal = "change_me"
$Secret = "Change_me"
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("${Service_Principal}:${Secret}")))

$headers = @{
    "Authorization" = "Basic $base64AuthInfo"
}



try {
    # Sending the GET request
    $response = Invoke-RestMethod -Uri $baseUrl -Headers $headers -Method Get

    # Display the response (or handle the response as needed)
    $response | ConvertTo-Json -Depth 3
} catch {
    # Handle errors
    Write-Error "Error occurred: $_"
}

