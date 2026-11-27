$updateCachePath = 'C:\Windows\SoftwareDistribution\Download'
try {
    Stop-Service -Name wuauserv -Force `
        -ErrorAction SilentlyContinue
    Get-ChildItem -Path $updateCachePath -Recurse -File `
        -ErrorAction SilentlyContinue |
        Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-30) } |
        Remove-Item -Force -ErrorAction SilentlyContinue
    Start-Service -Name wuauserv -ErrorAction SilentlyContinue
    Write-Output 'Stale Windows Update cache cleared'
    exit 0
} catch {
    Write-Error "Failed to clear Windows Update cache: $_"
    exit 1
}
