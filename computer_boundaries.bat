@echo off
TITLE BatchParenting
color 9f
echo.
REM echo  ## This file must be run as an Administrator in order to make changes! ##
echo.
IF NOT EXIST "\Windows\System32\drivers\etc\hosts.bak" copy \Windows\System32\drivers\etc\hosts \Windows\System32\drivers\etc\hosts.bak
set myniciscalled=none
IF NOT EXIST "%programfiles%\Batch Parenting" mkdir "%programfiles%\Batch Parenting"
IF EXIST "%programfiles%\Batch Parenting\%computername%.ini" set /p myniciscalled=<"%programfiles%\Batch Parenting\%computername%.ini"
:RESTART
CLS
echo.
echo  What do you need to do? 
echo.
echo  1. Block access: YouTube, Roblox, Facebook, Twitch
REM Build this out to take in domains and build the hosts file accordingly.
echo  2. Allow access: YouTube, Roblox, Facebook, Twitch
echo  3. Disable internet
echo  4. Enable internet
echo. 
REM echo  5. Turn on login time restrictions
REM Build this out to take in time specified for account specified.
REM echo  6. Turn off login time restrictions
echo  7. Remove MS Store from PC
echo.
echo  8. Disable Wi-Fi
echo  9. Enable Wi-Fi
echo.
echo  P. Reset another user's password
REM Build this out to specify the password set.
echo  S. Store my settings
echo.
echo  X. Close this Window
echo.
echo  # Recognized network connection: %myniciscalled%
IF /I %myniciscalled%==none echo  # Select 'S' to save your settings!
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
IF /I %PARENTSEL%==S GOTO MYSETTINGS
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
REM net user laurel /time:all
echo.
REM echo Laurel's login time is not restricted.
echo.
PAUSE
GOTO RESTART
:TIMERES
CLS
echo.
echo  # Time Restrictions #
echo  Step 1: Select that account
echo.
net user
echo.
set /p kidaccount= Type the account name to restrict: 
echo.
:TIMERES2
CLS
echo.
echo  # Restricting: %kidaccount% #
echo  Step 2: Pick the days
echo.
echo  Y. Seven days a week
echo  W. Weekends only
echo  M. Monday thru Friday
echo  S. Specify first and last day
echo.
set /p restrictday= What day(s) can %kidaccount% use the computer: 
IF /I %restrictday%==Y GOTO TIMERES7
IF /I %restrictday%==W GOTO TIMERESW
IF /I %restrictday%==M GOTO TIMERESM
IF /I %restrictday%==S GOTO TIMERESS
GOTO TIMERES
:TIMERES7
set onlydays=Su-M
GOTO TIMERESN
:TIMERESW
set onlydays=Sa-Su
GOTO TIMERESN
:TIMERESM
set onlydays=M-F
GOTO TIMERESN
:TIMERESS
CLS
echo.
echo  # Restricting: %kidaccount% #
echo  Step 2: Pick the days
echo.
echo  We need to set the days they can login from start to finish.
echo.
echo  For example:
echo  If you want to specify from Tuesday to Thursday, Tuesday would be
echo   entered first and Thursday would be entered second.
echo.
echo  Day Format:  Su, M, T, W, Th, F, Sa
echo.
set /p firstday= First day of the week %kidaccount% can login: 
echo.
set /p lastday= Last day of the week %kidaccount% can login: 
echo.
echo  %kidaccount% will be able to login %firstday% to %lastday%.
echo.
set /p isthatright= If that's correct we can set a time: 
IF NOT /I %isthatright%==Y GOTO TIMERESS
:TIMERESN
CLS
echo.
echo  # Restricting: %kidaccount% #
echo  Step 3: Pick the time
echo.
echo  Examples: 8a is 8:00am and 10p is 10:00pm
echo.
set /p starttime=What is the earliest time %kidaccount% can login:

set /p stoptime=When is their time up: 
echo.
echo  2 -> Let me fix the days
echo  1 -> Let me select a different account
echo  N -> Let me fix the times
echo  Y -> Continue
echo.
echo  So %kidaccount% can login %firstday% thru %lastday%, from %starttime% to %stoptime%.
echo.
set /p timetobuild= Everything look correct?: 
echo.
IF /I %timetobuild%==N GOTO TIMERESN
IF /I %timetobuild%==1 GOTO TIMERES
IF /I %timetobuild%==2 GOTO TIMERES2
REM Time to build the command with the provided variables and store the final command for reference.
:REMOVEMSS
REM Remove
powershell.exe Get-AppxPackage -allusers *WindowsStore* | Remove-AppxPackage
REM Reinstall
REM Get-AppxPackage -allusers *WindowsStore* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register “$($_.InstallLocation)\AppXManifest.xml”}
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
:MYSETTINGS
echo.
REM IF NOT EXIST "%programfiles%\Boundaries" mkdir "%programfiles%\Boundaries"
echo  # Here's a list of how you're connected to your network:
echo.
wmic nic where NetConnectionStatus=2 get NetConnectionID
echo.
set /p myniciscalled= Please type the name listed under 'NetConnectionID' (case sensitive): 
echo %myniciscalled% > "%programfiles%\Batch Parenting\%computername%.ini"
echo.
PAUSE
GOTO RESTART
:HELPH
CLS
echo.
echo.
PAUSE
GOTO RESTART
:BUBYE
EXIT