$global:devws = "C:\Users\Philippe.martens\Sources\ws"
Import-Module posh-git
Import-Module PSColor
New-Alias v vagrant
New-Alias ll ls
New-Alias vi nvim

. "$env:Onedrive\Documents\PowerShell\outlookofflineonline.ps1"

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
# $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
# if (Test-Path($ChocolateyProfile)) {
#   Import-Module "$ChocolateyProfile"
# }

function weer { curl "wttr.in/Eijsden?format=3&m" }
#(@(& 'C:/Users/Philippe.martens/AppData/Local/Programs/oh-my-posh/bin/oh-my-posh.exe' init powershell --config='C:\Users\Philippe.martens\AppData\Local\Programs\oh-my-posh\themes\spaceship.omp.json' --print) -join "`n") | Invoke-Expression
