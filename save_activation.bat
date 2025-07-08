@echo off
setlocal enabledelayedexpansion

:: Set paths for backup and logs
set "ScriptPath=%~dp0"
set "backupDir=%~dp0ActivationBackup"
set "logFile=%backupDir%\backup_log.txt"

rem Offline script to save and restore activation for Microsoft Windows and Office licenses by Thelogh
rem Backup and Restore Microsoft Windows and Microsoft Office License Activation Offline
rem For all requests write on the blog
rem REPOSITORY
rem https://github.com/thelogh/save_restore_activation_microsoft_license
rem V.2.0.0


rem Create directories for placing the license and token file.
:: Create backup directory
if not exist "!backupDir!" mkdir "!backupDir!"
if not exist "!backupDir!\WindowsActivation" mkdir "!backupDir!\WindowsActivation"
if not exist "!backupDir!\OfficeActivation" mkdir "!backupDir!\OfficeActivation"

rem Stop the services to get the WindowsActivation and token file
net stop clipsvc
net stop sppsvc

:: Save activation tokens for Windows
XCOPY %SystemRoot%\System32\spp\store "!backupDir!\WindowsActivation" /O /X /E /H /K /Y
	echo Windows activation saved to !backupDir!\WindowsActivation >> "!logFile!"

:: Save activation tokens for Office
XCOPY %ProgramData%\Microsoft\Windows\ClipSVC\tokens.dat "!backupDir!\OfficeActivation" /O /X /H /K /Y
	echo Office activation saved to !backupDir!\OfficeActivation >> "!logFile!"

rem Dump the licnese in registry 
:: Backup product keys (if available via registry)
"!ScriptPath!\PsExec.exe" -i -s -accepteula reg export HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\{7746D80F-97E0-4E26-9543-26B41FC22F79} .\winactivationkey.reg

copy %SystemRoot%\System32\winactivationkey.reg "!backupDir!"

del %SystemRoot%\System32\winactivationkey.reg
	echo Registry export completed >> "!logFile!"

rem Bring back the services
net start clipsvc
net start sppsvc

echo All done. Activation backup saved to: "!backupDir!"
pause
