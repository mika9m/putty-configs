$mydocspath=[environment]::GetFolderPath('MyDocuments')

# Define the path to the CSV file containing the session information
$csvPath = $mydocspath+"\putty_sessions.csv"

# Import the CSV file as an array of objects
$sessionData = Import-Csv -Path $csvPath

# Define the root key for the PuTTY sessions in the Windows registry
$puttySessionsRoot = "HKCU:\Software\SimonTatham\PuTTY\Sessions\"

# Loop through each session in the CSV file
foreach ($session in $sessionData) {

    # Define the name of the session in the registry
    $sessionName = $session.Name -replace ' ', '%20'
    #$sessionName = $session.Name

    $sessionPath = $puttySessionsRoot + $sessionName

    if (Test-Path $sessionPath) {
        Write-Host "Session $sessionName already exists."
    } else {
        Copy-Item "HKCU:\Software\SimonTatham\PuTTY\Sessions\Default%20Settings" $sessionPath -Recurse

        # Set the session configuration values in the registry
        Write-Host $sessionName,$session.HostName,$session.UserName
        Set-ItemProperty -Path $sessionPath -Name "HostName" -Value $session.HostName
        Set-ItemProperty -Path $sessionPath -Name "PortNumber" -Value $session.PortNumber
        Set-ItemProperty -Path $sessionPath -Name "Protocol" -Value $session.Protocol
        Set-ItemProperty -Path $sessionPath -Name "UserName" -Value $session.UserName
    }
}

New-Item -ItemType Directory -Path $mydocspath -Name PuTTY_logs -Force

$puttylogpath=$mydocspath+"\PuTTY_logs"

$Items=Get-ChildItem -Path HKCU:\SOFTWARE\SimonTatham\PuTTY\Sessions\ | Select-Object Name

foreach ($Item in $Items) {

    $Path=$Item.Name
    $Path=$Path -replace "HKEY_CURRENT_USER", "HKCU:"

    #Set Values
    Set-ItemProperty -Path $path -Name "FontHeight" -Value 11 -Type DWord
    Set-ItemProperty -Path $path -Name "Font" -Value "Consolas" -Type String
    Set-ItemProperty -Path $path -Name "PasteRTF" -Value 1
    Set-ItemProperty -Path $path -Name "LogType" -Value 1
    Set-ItemProperty -Path $path -Name "LogFileName" -Value $puttylogpath"\putty_log_&P_&H_&Y-&M-&D_&T.txt"
    Set-ItemProperty -Path $path -Name "TCPKeepalives" -Value 1
    Set-ItemProperty -Path $path -Name "PingIntervalSecs" -Value 300
    Set-ItemProperty -Path $path -Name "AgentFwd" -Value 1
    Set-ItemProperty -Path $path -Name "Colour0"  -Value "0,0,0"
    Set-ItemProperty -Path $path -Name "Colour1"  -Value "201,85,0"
    Set-ItemProperty -Path $path -Name "Colour2"  -Value "244,244,244"
    Set-ItemProperty -Path $path -Name "Colour3"  -Value "244,244,244"
    Set-ItemProperty -Path $path -Name "Colour4"  -Value "63,63,63"
    Set-ItemProperty -Path $path -Name "Colour5"  -Value "255,128,0"
    Set-ItemProperty -Path $path -Name "Colour6"  -Value "62,62,62"
    Set-ItemProperty -Path $path -Name "Colour7"  -Value "102,102,102"
    Set-ItemProperty -Path $path -Name "Colour8"  -Value "151,11,22"
    Set-ItemProperty -Path $path -Name "Colour9"  -Value "222,0,0"
    Set-ItemProperty -Path $path -Name "Colour10"  -Value "7,150,42"
    Set-ItemProperty -Path $path -Name "Colour11"  -Value "135,213,162"
    Set-ItemProperty -Path $path -Name "Colour12"  -Value "248,238,199"
    Set-ItemProperty -Path $path -Name "Colour13"  -Value "241,208,7"
    Set-ItemProperty -Path $path -Name "Colour14"  -Value "0,62,138"
    Set-ItemProperty -Path $path -Name "Colour15"  -Value "46,108,186"
    Set-ItemProperty -Path $path -Name "Colour16"  -Value "233,70,145"
    Set-ItemProperty -Path $path -Name "Colour17"  -Value "255,162,159"
    Set-ItemProperty -Path $path -Name "Colour18"  -Value "137,209,236"
    Set-ItemProperty -Path $path -Name "Colour19"  -Value "28,250,254"
    Set-ItemProperty -Path $path -Name "Colour20"  -Value "128,128,128"
    Set-ItemProperty -Path $path -Name "Colour21"  -Value "255,255,128"
}

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
