# Construct the base path to the Putty session registry keys
$puttyBaseKeyPath = "HKCU:\Software\SimonTatham\PuTTY\Sessions"

# Get a list of all Putty session keys
$sessionKeys = Get-ChildItem -Path $puttyBaseKeyPath  | Where-Object { $_.PSChildName -ne "Default%20Settings" }

# Loop through each session and set the window title to the session name
foreach ($sessionKey in $sessionKeys) {

    $sessionName = $sessionKey.PSChildName
    $sessionKeyPath = "$puttyBaseKeyPath\$sessionName"
    
    # Get the current window title for the session
    # $windowTitle = (Get-ItemProperty -Path $sessionKeyPath -Name "WindowTitle").WindowTitle

    $newWindowTitle = "$sessionName" -replace '%20', ' '

    Write-Host $sessionName
    
    # Set the new window title for the session
    Set-ItemProperty -Path $sessionKeyPath -Name "WinTitle" -Value $newWindowTitle
    Set-ItemProperty -Path $sessionKeyPath -Name "WindowTitle" -Value $newWindowTitle
}