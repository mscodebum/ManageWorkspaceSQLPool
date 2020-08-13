using namespace System.Net

<###
Application configuration settings needed are as follows:
WorkspaceName
SynapsePoolName
###>

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "Trigger started for Resume request $($env:WorkspaceName + ' / ' + $env:SynapsePoolName)"

#Resume the instance.
$body = Update-AzSynapseSqlPool -WorkspaceName $env:WorkspaceName -Name $env:SynapsePoolName -Resume

# Associate values to output bindings by calling 'Push-OutputBinding'.

Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})
 
# Write response to log stream
$body
Write-Host "Trigger completed for Pause request."