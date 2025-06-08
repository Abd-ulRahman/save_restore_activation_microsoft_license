set ScriptPath=%~dp0
rem Offline script to save and restore activation for Microsoft Windows and Office licenses by Thelogh
rem Backup and Restore Microsoft Windows and Microsoft Office License Activation Offline
rem For all requests write on the blog
rem REPOSITORY
rem https://github.com/thelogh/save_restore_activation_microsoft_license
rem V.2.0.0

echo Do not connect your PC or SERVER to the internet until the license has been restored!!!
echo Please make sure the internet is disconnected before you continue.
pause

rem Check the backup directory exist or not
if not exist "%ScriptPath%license" echo The 'license' directory is missing. && goto end

rem The files are ready, go on to restore license(s)

rem Stop the services
net stop clipsvc
net stop sppsvc

cmd /v:on /c XCOPY %ScriptPath%license\2.0\ C:\Windows\System32\spp\store\2.0 /O /X /E /H /K /Y

echo Restoring license is finished. You may need to check whether there is some errors in the output above.
echo You computer will reboot after you press any key.
pause >nul
shutdown /r /t 0

:end 
echo Please check make sure the backup directory is existed and retry by running this programme again.
