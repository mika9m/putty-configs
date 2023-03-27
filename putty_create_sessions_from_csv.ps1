# Define the path to the CSV file containing the session information
$csvPath = "C:\temp\putty_sessions.csv"

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
        #Set-ItemProperty -Path $sessionPath -Name "Password" -Value $session.Password
        #Set-ItemProperty -Path $sessionPath -Name "PublicKeyFile" -Value $session.PublicKeyFile
        #Set-ItemProperty -Path $sessionPath -Name "Passphrase" -Value $session.Passphrase    
    }
}