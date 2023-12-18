function FindCLSIDInRegistry($clsid) {
    $hkcrPath = if (Test-Path "HKCR:\") {"HKCR:\"} else {"HKLM:\SOFTWARE\Classes\"}
    $paths = @(
        $hkcrPath,
        "HKLM:\SOFTWARE\Classes\CLSID\"
    )

    foreach ($path in $paths) {
        $regPath = Join-Path -Path $path -ChildPath $clsid
        try {
            if (Test-Path $regPath -ErrorAction SilentlyContinue) {
                return $regPath
            }
        } catch {
            # Error is caught but not displayed
        }
    }

    return $null
}

try {
    $Tasks = Get-ScheduledTask -ErrorAction SilentlyContinue
    if ($null -eq $Tasks) {
        Write-Host "No scheduled tasks found or access denied."
        return
    }
} catch {
    Write-Host "Error retrieving scheduled tasks."
    return
}

foreach ($Task in $Tasks) {
    if ($Task -and $Task.Actions.ClassId -ne $null -and $Task.Triggers.Enabled -eq $true -and $Task.Principal.GroupId -eq "Users") {
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
