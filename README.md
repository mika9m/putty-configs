# putty-configs
PowerShell scripts to fix PuTTY configs and create new sessions from CSV

**Please read, understand and modify if needed before running!**

Before running, backup your existing sessions and settings:

    reg export HKCU\Software\SimonTatham\PuTTY\Sessions ([Environment]::GetFolderPath("MyDocuments") + "\putty-sessions.reg") /Y

    reg export HKCU\Software\SimonTatham ([Environment]::GetFolderPath("MyDocuments") + "\putty.reg") /Y

To import backups back:

    reg import ([Environment]::GetFolderPath("MyDocuments") + "\putty-sessions.reg")

    reg import ([Environment]::GetFolderPath("MyDocuments") + "\putty.reg")

Before running, you might need to run:

     Set-ExecutionPolicy RemoteSigned

or
    Set-ExecutionPolicy -Scope CurrentUser Unrestricted

## putty_create_sessions_from_csv.ps1
Create new PuTTY sessions from putty_sessions.csv

If you need to mass-remove sessions, e.g. every session beginning with "example":

    Get-ChildItem -Path "HKCU:\Software\SimonTatham\PuTTY\Sessions" | Where-Object { $_.PSChildName -like "example*" } | Remove-Item -Recurse -Force

## putty_fix_windowtitle.ps1
Change window title to session name for every PuTTY session in registry

## putty_settings.ps1
Change settings for all PuTTY sessions:
- Change font to 11pt Consolas
- Enable RTF copy to clipboard
- Enable logging to MyDocuments\PuTTY_logs
- Enable TCP keepalives
- Enable agent forwarding
- Change colors to black on light grey
