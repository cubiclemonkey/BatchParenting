@echo off
TITLE Basic Parental Lockdown
echo.
echo  ## This file must be run as an Administrator in order to make changes! ##
echo.
REM IF NOT EXIST "\Windows\System32\drivers\etc\hosts.bak" echo ## This is a backup of your default hosts file ## %date% - %time% >> \Windows\System32\drivers\etc\hosts
IF NOT EXIST "\Windows\System32\drivers\etc\hosts.bak" copy \Windows\System32\drivers\etc\hosts \Windows\System32\drivers\etc\hosts.bak
:RESTART
CLS
echo.
echo  What do you need to do? 
echo.
echo  1. Block access: YouTube, Roblox, Facebook, Twitch
echo  2. Allow access: YouTube, Roblox, Facebook, Twitch
echo  3. Disable internet
echo  4. Enable internet
echo. 
echo  5. Turn on login time restrictions
echo  6. Turn off login time restrictions
echo  7. Remove MS Store from PC
echo.
echo  8. Disable Wi-Fi
echo  9. Enable Wi-Fi
echo.
echo  P. Reset another user's password
echo.
echo  X. Close this Window
echo.
set /p PARENTSEL=You must choose wisely: 
echo.
IF /I %PARENTSEL%==1 GOTO BLOCKWEB
IF /I %PARENTSEL%==2 GOTO DISAWEBB
IF /I %PARENTSEL%==3 GOTO SETDNS
IF /I %PARENTSEL%==4 GOTO DNSRES
IF /I %PARENTSEL%==5 GOTO TIMERES
IF /I %PARENTSEL%==6 GOTO TIMENOR
IF /I %PARENTSEL%==7 GOTO REMOVEMSS
IF /I %PARENTSEL%==8 GOTO DISABLE
IF /I %PARENTSEL%==9 GOTO ENABLE
IF /I %PARENTSEL%==P GOTO CHANGEPW
IF /I %PARENTSEL%==H GOTO HELPH
IF /I %PARENTSEL%==X GOTO BUBYE
:BLOCKWEB
echo  What websites need to be blocked?
echo.
echo  A - YouTube, Twitch, Facebook, Roblox
REM echo  B - YouTube, Twitch, Facebook, Roblox, and domains I can specify
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
:DISAWEBB
copy \Windows\System32\drivers\etc\hosts.bak \Windows\System32\drivers\etc\hosts /y
GOTO RESTART
:TIMENOR
net user laurel /time:all
echo.
echo Laurel's login time is not restricted.
echo.
PAUSE
GOTO RESTART
:TIMERES
net user laurel /times:Su-Th,10:00-19:00;F-Sa,10:00-19:00
echo.
echo Laurel's login times have been restricted to:
echo.
echo Sunday - Thursday, 10:00 to 19:00
echo Friday - Saturday, 10:00 to 19:00
echo.
PAUSE
GOTO RESTART
:REMOVEMSS
Remove
Get-AppxPackage -allusers *WindowsStore* | Remove-AppxPackage

Reinstall
Get-AppxPackage -allusers *WindowsStore* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register “$($_.InstallLocation)\AppXManifest.xml”}
GOTO RESTART
:SETDNS
echo.
netsh interface ip set dnsservers Wi-Fi static 127.0.0.1
echo.
PAUSE
GOTO RESTART
:DNSRES
netsh interface ip set dns Wi-Fi dhcp
echo.
ipconfig /all | findstr DNS
GOTO RESTART
:DISABLE
netsh interface ip set Wi-Fi disabled
GOTO RESTART
:ENABLE
netsh interface ip set Wi-Fi enabled
GOTO RESTART
:CHANGEPW
echo.
echo Which user's password are we changing? Don't
net user
set /p theyforgothuh= Enter the correct username: 
net user %theyforgothuh% password
echo %theyforgothuh% password is now: password
echo.
PAUSE
GOTO RESTART
:HELPH
CLS
echo.
echo  David, here! Don't get too wrapped around the axle! I hoped to make everything self explanatory.
echo  But if I failed at that, send me an email: thomasdb78@gmail.com
echo.
copy "C:\Parental Management\HelpPlease.url" C:\Users\%username%\Desktop\ > nul
echo  I've dropped a shortcut on the Desktop. That will download what's need to help me get connected.
echo.
echo  Cheers!
echo.
PAUSE
GOTO RESTART
:BUBYE
EXIT