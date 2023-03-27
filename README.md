# putty-configs
PowerShell scripts to fix PuTTY configs and create new sessions from CSV

**Please read, understand and modify if needed before running!**

Before running, backup your existing sessions and settings:

    reg export HKCU\Software\SimonTatham\PuTTY\Sessions ([Environment]::GetFolderPath("Desktop") + "\putty-sessions.reg") /Y

    reg export HKCU\Software\SimonTatham ([Environment]::GetFolderPath("Desktop") + "\putty.reg") /Y


## putty_create_sessions_from_csv.ps1
Create new PuTTY sessions from putty_sessions.csv

## putty_fix_windowtitle.ps1
Change window title to session name for every PuTTY session in registry

## putty_settings.ps1
Change settings for all PuTTY sessions:
- Change font to 11pt Consolas
- Enable RTF copy to clipboard
- Enable logging to C:\temp\PuTTY_logs
- Enable TCP keepalives
- Enable agent forwarding
- Change colors to black on light grey
