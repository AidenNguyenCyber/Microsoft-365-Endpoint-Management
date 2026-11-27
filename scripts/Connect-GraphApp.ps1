#Requires -Version 7.0
[CmdletBinding()]
param(
    [Parameter(Mandatory)][guid]$TenantId,
    [Parameter(Mandatory)][guid]$ClientId
)
$ErrorActionPreference = 'Stop'
Import-Module Microsoft.Graph.Authentication
$secret = Read-Host 'Enter client secret Value' -AsSecureString
$credential = [PSCredential]::new($ClientId.ToString(), $secret)
Connect-MgGraph -TenantId $TenantId.ToString() `
    -ClientSecretCredential $credential `
    -ContextScope Process -NoWelcome
Get-MgContext | Select-Object TenantId, ClientId, AuthType
