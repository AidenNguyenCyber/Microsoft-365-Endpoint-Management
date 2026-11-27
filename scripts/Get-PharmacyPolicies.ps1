#Requires -Version 7.0
$ErrorActionPreference = 'Stop'
if (-not (Get-MgContext)) {
    throw 'Connect to Microsoft Graph in this process first.'
}
$tags = @(Get-MgBetaDeviceManagementRoleScopeTag `
    -Filter "displayName eq 'Pharmacy'")
if ($tags.Count -ne 1) {
    throw 'Expected exactly one Pharmacy scope tag.'
}
$tagId = [string]$tags[0].Id
Write-Output "Pharmacy scope tag ID: $tagId"

Get-MgBetaDeviceManagementDeviceConfiguration -All |
    Where-Object { $_.RoleScopeTagIds -contains $tagId } |
    Select-Object DisplayName, Id

Get-MgBetaDeviceManagementConfigurationPolicy -All |
    Where-Object { $_.RoleScopeTagIds -contains $tagId } |
    Select-Object Name, Id

Get-MgBetaDeviceManagementDeviceCompliancePolicy -All |
    Where-Object { $_.RoleScopeTagIds -contains $tagId } |
    Select-Object DisplayName, Id
