@echo off
TITLE Basic Parental Lockdown
echo.
echo  ## This file must be run as an Administrator in order to make changes! ##
echo.
IF NOT EXIST "\Windows\System32\drivers\etc\hosts.bak" echo ## This is a backup of your default hosts file ## %date% - %time% >> \Windows\System32\drivers\etc\hosts
IF NOT EXIST "\Windows\System32\drivers\etc\hosts.bak" copy \Windows\System32\drivers\etc\hosts \Windows\System32\drivers\etc\hosts.bak\
:RESTART
CLS
echo.
echo  What do you need to do? 
echo.
echo  1. Block websites on this computer
echo  2. Whitelist sites on this computer
echo  3. Disable website blocking
echo. 
echo  4. Restrict account login during certain times
echo  5. Disable login time restrictions
echo  X. Remove MS Store from PC
echo.
echo  6. Specify different DNS Server
echo  7. Reset DNS Server settings
echo.
set /p PARENTSEL=Enter the corresponding number: 
echo.
IF /I %PARENTSEL%==1 GOTO BLOCKWEB
IF /I %PARENTSEL%==2 GOTO WHITEWEB
IF /I %PARENTSEL%==3 GOTO DISAWEBB
IF /I %PARENTSEL%==4 GOTO TIMELOG
IF /I %PARENTSEL%==5 GOTO TIMERES
IF /I %PARENTSEL%==X GOTO REMOVEMSS
IF /I %PARENTSEL%==6 GOTO SETDNS
IF /I %PARENTSEL%==7 GOTO DNSRES
:BLOCKWEB
echo  What websites need to be blocked?
echo.
echo  A - YouTube, Twitch, Facebook, Roblox
echo  B - YouTube, Twitch, Facebook, Roblox, and domains I can specify
echo  C - View what is currently blocked
echo  M - Main Menu
echo.
set /p BLOCKWHAT=Enter the corresponding letter: 
IF /I %BLOCKWHAT%==A GOTO BLOCKWEBA
IF /I %BLOCKWHAT%==B GOTO BLOCKWEBB
IF /I %BLOCKWHAT%==C GOTO VIEWBLOCKS
IF /I %BLOCKWHAT%==M GOTO RESTART
GOTO BLOCKWEB
:BLOCKWEBA
echo. > \Windows\System32\drivers\etc\hosts
echo ## Sites below this line are blocked ## %date% - %time% >> \Windows\System32\drivers\etc\hosts
echo. >> \Windows\System32\drivers\etc\hosts
echo 127.0.0.1    youtube.com >> \Windows\System32\drivers\etc\hosts
echo 127.0.0.1    www.youtube.com >> \Windows\System32\drivers\etc\hosts
echo 127.0.0.1    twitch.com >> \Windows\System32\drivers\etc\hosts
echo 127.0.0.1    www.twitch.com >> \Windows\System32\drivers\etc\hosts
echo 127.0.0.1    roblox.com >> \Windows\System32\drivers\etc\hosts
echo 127.0.0.1    www.roblox.com >> \Windows\System32\drivers\etc\hosts
echo 127.0.0.1    facebook.com >> \Windows\System32\drivers\etc\hosts
echo 127.0.0.1    www.facebook.com >> \Windows\System32\drivers\etc\hosts
ipconfig /flushdns
GOTO RESTART
:BLOCKWEBB
echo. > \Windows\System32\drivers\etc\hosts
echo ## Sites below this line are blocked ## %date% - %time% >> \Windows\System32\drivers\etc\hosts
echo. >> \Windows\System32\drivers\etc\hosts
echo 127.0.0.1    youtube.com >> \Windows\System32\drivers\etc\hosts
echo 127.0.0.1    www.youtube.com >> \Windows\System32\drivers\etc\hosts
echo 127.0.0.1    twitch.com >> \Windows\System32\drivers\etc\hosts
echo 127.0.0.1    www.twitch.com >> \Windows\System32\drivers\etc\hosts
echo 127.0.0.1    roblox.com >> \Windows\System32\drivers\etc\hosts
echo 127.0.0.1    www.roblox.com >> \Windows\System32\drivers\etc\hosts
echo 127.0.0.1    facebook.com >> \Windows\System32\drivers\etc\hosts
echo 127.0.0.1    www.facebook.com >> \Windows\System32\drivers\etc\hosts
ipconfig /flushdns
REM PAUSE
GOTO RESTART
:VIEWBLOCKS
echo.
type \Windows\System32\drivers\etc\hosts
echo.
GOTO BLOCKWEB
:WHITEWEB
:DISAWEBB
copy \Windows\System32\drivers\etc\hosts.bak \Windows\System32\drivers\etc\hosts /y
:TIMELOG
:TIMERES
:REMOVEMSS
Remove
Get-AppxPackage -allusers *WindowsStore* | Remove-AppxPackage

Reinstall
Get-AppxPackage -allusers *WindowsStore* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register “$($_.InstallLocation)\AppXManifest.xml”}
:SETDNS
echo.
wmic nic where NetConnectionStatus=2 get NetConnectionID,Name
echo.
set /p changedns= Type the 'NetConnectionID' you see listed: 
echo.
netsh interface ip set dns "%changedns%" static 127.0.0.1
echo.
ipconfig /all | findstr DNS
echo.
echo  M - Go to Main Menu
echo.
echo  X - Exit this tool
echo.
set /p laststep=Select an option: 
echo.
IF /I %laststep%==M GOTO RESTART
IF /I %laststep%==X echo EXIT
:DNSRES
netsh interface ip set dns "%changedns%" dhcp
echo.
ipconfig /all | findstr DNS
GOTO RESTART

