set ScriptPath=%~dp0
rem Offline script to save and restore activation for Microsoft Windows and Office licenses by Thelogh
rem Backup and Restore Microsoft Windows and Microsoft Office License Activation Offline
rem For all requests write on the blog
rem REPOSITORY
rem https://github.com/thelogh/save_restore_activation_microsoft_license
rem V.2.0.0

echo Please make sure the internet is disconnected before you continue.
pause

rem Check the backup directory exist or not
if not exist "%ScriptPath%GenuineTicket" echo The 'GenuineTicket' directory is missing. && goto end
if not exist "%ScriptPath%winactivationkey.reg" echo File 'winactivationkey.reg' is missing && goto end

rem The files are ready, go on to restore license(s)

rem Stop the services
net stop clipsvc
net stop sppsvc

XCOPY %ScriptPath%GenuineTicket\tokens.dat C:\ProgramData\Microsoft\Windows\ClipSVC /O /X /H /K /Y
copy /Y %ScriptPath%winactivationkey.reg C:\Windows\System32\winactivationkey.reg
%ScriptPath%psexec -i -s -accepteula reg import C:\Windows\System32\winactivationkey.reg
del C:\Windows\System32\winactivationkey.reg

echo You computer will reboot after you press any key.
pause >nul
shutdown /r /t 0

:end 
echo Please check make sure the backup directory is existed and retry by running this programme again.
