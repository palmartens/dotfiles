# ref https://mikecrowley.us/2018/07/05/start-outlook-in-offline-mode-without-opening-it-first/
# [HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\Profiles\Outlook\0a0d020000000000c000000000000046]
# Online
# "00030398"=hex:02,00,00,00
# offline
# "00030398"=hex:01,00,00,00

function Set-Outlookmode
{
    [CmdletBinding()]
    Param
    (        
		[ValidateSet('online', 'offline')]
		$mode='offline'
    )
	$AdminKey = "HKCU:\Software\Microsoft\Office\16.0\outlook\Profiles\Outlook\0a0d020000000000c000000000000046"
	#Set-ItemProperty -Path $AdminKey -Name "00030398" -Value 0
    #((Get-ItemProperty -Path "HKCU:\Software\Microsoft\Office\16.0\outlook\Profiles\adautzenberg\0a0d020000000000c000000000000046")."00030398")[0]=1 # offline
    # 2 # online

    $byteval=((Get-ItemProperty -Path $AdminKey)."00030398")
	switch($mode)
	{
		'online' {
		# "00030398"=hex:02,00,00,00
            $byteval[0]=2
          	write-host -foreground yellow "Setting outlook to online modus"

		}
		'offline' {
		# "00030398"=hex:01,00,00,00
            $byteval[0]=1
          	write-host -foreground yellow "Setting outlook to offline modus"
		}
		
	}

    Set-ItemProperty -Path $AdminKey -Name "00030398" -Value $byteval

}

