# Check for Administrator privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "`n❌ This script must be run as Administrator. Exiting..." -ForegroundColor Red
    exit
}

# Features that may interfere with VirtualBox, but are needed for WSL2, Sandbox, etc.
$features = @(
    "VirtualMachinePlatform",         # Nodig voor WSL2
    "HypervisorPlatform"      # Nodig voor sommige container- en WSL2-scenario's
)

Write-Host "`n🔧 Enabling WSL2-related features..." -ForegroundColor Cyan

$changesMade = $false

foreach ($feature in $features) {
    try {
        $status = Get-WindowsOptionalFeature -Online -FeatureName $feature
        if ($status.State -ne "Enabled") {
            Write-Host "➡ Enabling $feature..." -ForegroundColor Yellow
            Enable-WindowsOptionalFeature -Online -FeatureName $feature -All -NoRestart
            $changesMade = $true
        } else {
            Write-Host "✅ $feature is already enabled." -ForegroundColor Green
        }
    } catch {
        Write-Host "⚠️ Feature $feature not found or not applicable on this system." -ForegroundColor DarkYellow
    }
}

# Final message
if ($changesMade) {
    Write-Host "`n✅ Changes have been applied. Please restart your system to activate them." -ForegroundColor Green
} else {
    Write-Host "`n👍 All required features are already enabled. No reboot required." -ForegroundColor Cyan
}