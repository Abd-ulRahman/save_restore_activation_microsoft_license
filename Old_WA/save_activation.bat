@echo off
set ScriptPath=%~dp0
rem Offline script to save and restore activation for Microsoft Windows and Office licenses by Thelogh
rem Backup and Restore Microsoft Windows and Microsoft Office License Activation Offline
rem For all requests write on the blog
rem REPOSITORY
rem https://github.com/thelogh/save_restore_activation_microsoft_license
rem V.1.0.0


rem Create directories for placing the license and token file.
if not exist "%ScriptPath%license" mkdir "%ScriptPath%license"
if not exist "%ScriptPath%GenuineTicket" mkdir "%ScriptPath%GenuineTicket"

rem Stop the services to get the license and token file
net stop clipsvc
net stop sppsvc
XCOPY C:\Windows\System32\spp\store "%ScriptPath%license" /E /H /C /I /Q
cmd /v:on /c XCOPY C:\ProgramData\Microsoft\Windows\ClipSVC\tokens.dat "%ScriptPath%GenuineTicket" /O /X /H /K /Y

rem Dump the licnese in registry 
%ScriptPath%psexec -i -s -accepteula reg export HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\{7746D80F-97E0-4E26-9543-26B41FC22F79} .\winactivationkey.reg

cmd /v:on /c copy C:\Windows\System32\winactivationkey.reg %ScriptPath%
cmd /v:on /c del C:\Windows\System32\winactivationkey.reg

rem Bring back the services
net start clipsvc
net start sppsvc

echo Your licnese file is located at .\At the same folder, please keep it safe.
pause
