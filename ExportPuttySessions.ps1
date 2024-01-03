$Date = Get-Date -Format "yyyyMMddHHmmss"
$FileName = [Environment]::GetFolderPath("MyDocuments") + "\putty_sessions_" + $env:computername + "_$Hostname_$Date.reg"
$RegistryPath = "HKCU\Software\SimonTatham\PuTTY\Sessions"

reg export $RegistryPath $FileName /Y
