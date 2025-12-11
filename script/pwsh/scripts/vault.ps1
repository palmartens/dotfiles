function VaultIsSealed {
    return (vault status -format=json | ConvertFrom-Json).sealed
}


function GetVaultStatus {
    # param([Parameter(Mandatory=$true)]$Status)
    $status = (vault status -format=json | ConvertFrom-Json)

    # Eerst proberen op basis van JSON velden (meest betrouwbaar)
    if ($Status.sealed -ne $null -and $Status.initialized -ne $null) {
        if (-not $Status.initialized) {
            Write-Host "Vault is NIET geïnitialiseerd. Unseal is niet mogelijk tot init is gedaan." -ForegroundColor Yellow
            return
        }
        if ($Status.sealed -eq $false) {
            Write-Host "✅ Vault is succesvol unsealed." -ForegroundColor Green
        } else {
            Write-Host "❌ Vault is nog SEALED." -ForegroundColor Red
        }        
        return
    }

    # Fallback: exitcode interpretatie (kan per versie/omgeving variëren)
    switch ($Status.exitCode) {
        0 { Write-Host "✅ Vault is UNSEALED (status exitcode = 0)." -ForegroundColor Green }
        1 { Write-Host "❌ Vault is SEALED (status exitcode = 1)." -ForegroundColor Red }
        2 { Write-Host "ℹ️ Vault is NIET geïnitialiseerd (status exitcode = 2)." -ForegroundColor Yellow }
        3 { Write-Host "ℹ️ Vault is STANDBY (status exitcode = 3)." -ForegroundColor Yellow }
        default { Write-Warning "Onbekende status exitcode: $($Status.exitCode). JSON parsing mislukte of versie wijkt af." }
    }
}


function VaultUnseal {
  param(
    [int]$Threshold = 3,
    [string]$VaultCmd = "vault"
  )

  function Read-UnsealKeys {
      param([int]$Count)
      $keys = @()
      for ($i = 1; $i -le $Count; $i++) {
          $secure = Read-Host "Unseal key $i" -AsSecureString
          if (-not $secure) { throw "Key $i mag niet leeg zijn." }
          # SecureString -> plain in memory (alleen tijdelijk)
          $ptr = [Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($secure)
          try {
              $plain = [Runtime.InteropServices.Marshal]::PtrToStringUni($ptr)
          } finally {
              [Runtime.InteropServices.Marshal]::ZeroFreeCoTaskMemUnicode($ptr)
          }
          $keys += $plain
      }
      return $keys
  }

  # 1) Basisvalidaties
  # Controleer VAULT_ADDR
  if (-not $env:VAULT_ADDR) {
      Write-Error "VAULT_ADDR is niet gezet. Voorbeeld: `$env:VAULT_ADDR='http://127.0.0.1:8200'"
      exit 1
  }
  
  try {
      $versionOut = & $VaultCmd -version 2>$null
  } catch {
      Write-Error "De 'vault' CLI werd niet gevonden als '$VaultCmd'. Zet de CLI in PATH of geef een volledig pad mee via -VaultCmd."
      exit 1
  }

  if (!(VaultIsSealed)) {
    Write-Host "Vault is al unsealed. Geen actie nodig." -ForegroundColor Green
        return

  }

  # 2) Keys inlezen  
  $keys = Read-UnsealKeys -Count $Threshold

  # 3) Unseal uitvoeren voor elke key
  for ($i = 0; $i -lt $keys.Count; $i++) {
      Write-Host "Unseal stap $($i+1)/$($keys.Count)..."

      # Start proces met stdout/stderr-capturing
      $psi = New-Object System.Diagnostics.ProcessStartInfo
      $psi.FileName = $VaultCmd
      $psi.Arguments = "operator unseal $($keys[$i])"
      $psi.RedirectStandardOutput = $true
      $psi.RedirectStandardError  = $true
      $psi.UseShellExecute = $false

      $p = [System.Diagnostics.Process]::Start($psi)
      $stdout = $p.StandardOutput.ReadToEnd()
      $stderr = $p.StandardError.ReadToEnd()
      $p.WaitForExit()

      if ($p.ExitCode -ne 0) {
          Write-Error "Unseal commando gaf een fout:`n$($stderr.Trim())`n$($stdout.Trim())"
          exit $p.ExitCode
      } else {
          # Toon een korte statusregel (laatste regel)
          $lastLine = ($stdout.Trim() -split "`r?`n")[-1]
          if ($lastLine) { Write-Host $lastLine } else { Write-Host "Stap geslaagd." }
      }
  }

  GetVaultStatus
}
