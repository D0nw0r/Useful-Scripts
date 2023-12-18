function FindCLSIDInRegistry($clsid) {
    $paths = @(
        "HKCR:\CLSID\",
        "HKLM:\SOFTWARE\Classes\CLSID\"
    )

    foreach ($path in $paths) {
        $regPath = Join-Path -Path $path -ChildPath $clsid
        if (Test-Path $regPath) {
            return $regPath
        }
    }

    return $null
}

$Tasks = Get-ScheduledTask

foreach ($Task in $Tasks) {
    if ($Task.Actions.ClassId -ne $null -and $Task.Triggers.Enabled -eq $true -and $Task.Principal.GroupId -eq "Users") {
        Write-Host "Task Name: " $Task.TaskName
        Write-Host "Task Path: " $Task.TaskPath
        Write-Host "CLSID: " $Task.Actions.ClassId

        $clsidLocation = FindCLSIDInRegistry($Task.Actions.ClassId)
        if ($clsidLocation -ne $null) {
            Write-Host "CLSID Location in Registry: " $clsidLocation
        } else {
            Write-Host "CLSID Location: Not found in registry"
        }

        Write-Host
    }
}
