using namespace System.Net
using namespace System.Data

<###
Application configuration settings needed are as follows:
WorkspaceName
SynapsePoolName
###>

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "Trigger started for Pause request $($env:WorkspaceName + ' / ' + $env:SynapsePoolName)"

#In this cmdlet, ResourceGroupName is optional because Workspace names are unique which is enough to narrow down the scope.
$body = Update-AzSynapseSqlPool -WorkspaceName $env:WorkspaceName -Name $env:SynapsePoolName -Suspend

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})

# Write response to log stream
$body
Write-Host "Trigger completed for Pause request."
