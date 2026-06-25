function gpa-ops {
    if (gpaVpnConnected) {
        wt -w new `
            nt --title "nnllmba001" pwsh -NoExit -command "ssh nnllmba001" `; `
            nt --title "nnllmbp001" pwsh -NoExit -command "ssh nnllmbp001" `; `
            nt --title "nlgpaprdsftp01" pwsh -NoExit -command "ssh nlgpaprdsftp01" `; `
            nt --title "nlgpaprdapp01" pwsh -NoExit -command "ssh nlgpaprdapp01" `; `
            nt --title "nlgpaprddb01" pwsh -NoExit -command "ssh nlgpaprddb01"
    }

}

function gpa-ops-ota {
    if (gpaVpnConnected) {
        wt -w new `
            nt --title "nnllmba001" pwsh -NoExit -command "ssh nnllmba001" `; `
            nt --title "nlgpaotaapp01" pwsh -NoExit -command "ssh nlgpaotaapp01" `; `
            nt --title "nlgpaotadb01" pwsh -NoExit -command "ssh nlgpaotadb01"
    }

}

function gpaVpnConnected {
    # check if the VPN is connected by looking for a route to the nnllmba001 server.
    $target = '172.24.3.1/32'   # nnllmba001 IP
    $route = Get-NetRoute -DestinationPrefix $target -ErrorAction SilentlyContinue |
         Sort-Object RouteMetric |
         Select-Object -First 1

    if ($route) {
        Write-Host "VPN connected, connecting to servers"
        return $true
    } else {
        Write-Host "VPN not connected, please connect to the GPA VPN first" -ForegroundColor Red
        return $false
    }
}