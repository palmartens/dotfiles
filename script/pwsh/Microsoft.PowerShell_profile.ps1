$global:devws = "C:\Users\Philippe.martens\Sources\ws"
# Import-Module posh-git
# Import-Module PSColor
Set-Alias v vagrant
Set-Alias ll ls
Set-Alias vi nvim
Set-Alias wgupd WingetUpdate
Set-Alias wgupg WingetUpgrade

if (Test-Path Alias:cat) {
    Remove-Item Alias:cat -Force
}

Set-Alias cat batcat

Invoke-Expression (&starship init powershell)
Invoke-Expression (& zoxide init powershell | Out-String)

. "$env:Onedrive\Documents\PowerShell\scripts\outlookofflineonline.ps1"
. "$env:Onedrive\Documents\PowerShell\scripts\vault.ps1"
. "$env:Onedrive\Documents\PowerShell\scripts\gpa.ps1"

function weer { curl "wttr.in/Eijsden?format=3&m" }

# function DisableVbs {
#     & "C:\Users\Philippe.martens\OneDrive - CGI\Documents\PowerShell\Scripts\DGReadiness\DG_Readiness_Tool_v3.6.ps1" -Disable
# }

function DisableVbs {
    Write-Host("Disabling VBS")
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Host("This script must be run as administrator.")
        return
    }
    & "C:\Users\Philippe.martens\OneDrive - CGI\Documents\PowerShell\Scripts\DGReadiness\DG_Readiness_Tool_v3.6.ps1" -Disable
    Write-Host("VBS Disabled, please reboot.")

}

function EnableVbs {
    Write-Host("Enabling VBS")
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Host("This script must be run as administrator.")
        return
    }
    & "C:\Users\Philippe.martens\OneDrive - CGI\Documents\PowerShell\Scripts\DGReadiness\DG_Readiness_Tool_v3.6.ps1" -Enable
    Write-Host("VBS Enabled, please reboot.")

}

function DisableHyperV {
    Write-Host("Disabling HyperV")
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Host("This script must be run as administrator.")
        return
    }
    & "C:\Users\Philippe.martens\OneDrive - CGI\Documents\PowerShell\Scripts\DisableHyperV.ps1"
    & "C:\Users\Philippe.martens\OneDrive - CGI\Documents\PowerShell\Scripts\DGReadiness\DG_Readiness_Tool_v3.6.ps1" -Disable
    Write-Host("Hyp Disabled, please reboot.")

}

function EnableHyperV {
    Write-Host("Enabling HyperV")
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Host("This script must be run as administrator.")
        return
    }
    & "C:\Users\Philippe.martens\OneDrive - CGI\Documents\PowerShell\Scripts\EnableHyperV.ps1"
    &  "C:\Users\Philippe.martens\OneDrive - CGI\Documents\PowerShell\Scripts\DGReadiness\DG_Readiness_Tool_v3.6.ps1" -Enable
    Write-Host("Hyp Disabled, please reboot.")

}

function EnableWSL {
    Write-Host("Enabling WSL (2)")
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Host("This script must be run as administrator.")
        return
    }
    & "C:\Users\Philippe.martens\OneDrive - CGI\Documents\PowerShell\Scripts\EnableWSL.ps1"
    Write-Host("Hyp Disabled, please reboot.")

}

function fzfgo {
    $file = fzf -e --preview 'bat --style=numbers --color=always --line-range :500 {} 2>/dev/null || cat {}'
    if ($file) {
        Set-Location (Get-Item $file).Directory.FullName
    }
}

function batcat {
    bat -Pp $args
}

function WingetUpdate {
    winget upgrade
}

function WingetUpgrade {
    winget upgrade --all
}