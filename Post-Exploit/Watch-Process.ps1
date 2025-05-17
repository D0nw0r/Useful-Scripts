## this powershell script uses https://raw.githubusercontent.com/markwragg/PowerShell-Watch/master/Watch/Public/Watch-Command.ps1
## the goal is to use Watch-Command to fetch a task running
## When this task is found, check its details

$processName = "backup"

$modulePath = ".\Watch-Command.ps1"
. $modulePath

$scriptBlock = {
    $process = Get-Process -ProcessName $processName
    if ($process) {
        $owner = (Get-WmiObject -Class Win32_Process -Filter "ProcessId = $($process.Id)" | Select-Object -ExpandProperty GetOwner).User
        $process | Add-Member -NotePropertyName Owner -NotePropertyValue $owner -PassThru
    } else {
        Write-Host "Process '$processName' not found."
        Write-Host "Trying again."
    }
}

Watch-Command -ScriptBlock $scriptBlock
