$updateCachePath = 'C:\Windows\SoftwareDistribution\Download'
$oldFiles = Get-ChildItem -Path $updateCachePath -Recurse -File `
    -ErrorAction SilentlyContinue |
    Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-30) }
if ($oldFiles.Count -gt 0) {
    Write-Output "Found $($oldFiles.Count) stale cache files"
    exit 1
} else {
    Write-Output 'Windows Update cache is clean'
    exit 0
}
