$global:devws = "C:\Users\Philippe.martens\Sources\ws"
Import-Module posh-git
Import-Module PSColor
New-Alias v vagrant
New-Alias ll ls
New-Alias vi nvim

. "$env:Onedrive\Documents\PowerShell\outlookofflineonline.ps1"
. "$env:Onedrive\Documents\PowerShell\scripts\vault.ps1" 

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