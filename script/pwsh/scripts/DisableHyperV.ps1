# Check for Administrator privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "`n❌ This script must be run as Administrator. Exiting..." -ForegroundColor Red
    exit
}

# Features that may interfere with VirtualBox performance
$features = @(
    "Microsoft-Hyper-V-All",          # Schakelt alle Hyper-V subfeatures uit
    "VirtualMachinePlatform",         # Nodig voor WSL2, maar vertraagt VirtualBox
    "WindowsHypervisorPlatform",      # Alternatieve hypervisorlaag
    "WindowsSandbox",                 # Virtuele testomgeving
    "Windows-Defender-ApplicationGuard", # Beveiligde browseromgeving
    "Containers"                      # Windows container support
)

Write-Host "`n🔍 Disabling virtualization-related features that may affect VirtualBox..." -ForegroundColor Cyan

$changesMade = $false

foreach ($feature in $features) {
    try {
        $status = Get-WindowsOptionalFeature -Online -FeatureName $feature
        if ($status.State -eq "Enabled") {
            Write-Host "➡ $feature is enabled. Disabling..." -ForegroundColor Yellow
            Disable-WindowsOptionalFeature -Online -FeatureName $feature -NoRestart
            $changesMade = $true
        } else {
            Write-Host "✅ $feature is already disabled." -ForegroundColor Green
        }
    } catch {
        Write-Host "⚠️ Feature $feature not found or not applicable on this system." -ForegroundColor DarkYellow
    }
}

# Final message
if ($changesMade) {
    Write-Host "`n✅ Changes have been applied. Please restart your system to activate them." -ForegroundColor Green
} else {
    Write-Host "`n👍 No conflicting features were active. No reboot required." -ForegroundColor Cyan
}