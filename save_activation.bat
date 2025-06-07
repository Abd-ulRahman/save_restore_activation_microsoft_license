set ScriptPath=%~dp0
rem Offline script to save and restore activation for Microsoft Windows and Office licenses by Thelogh
rem Backup and Restore Microsoft Windows and Microsoft Office License Activation Offline
rem https://www.alldiscoveries.com/backup-and-restore-microsoft-windows-and-microsoft-office-license-activation-offline/
rem For all requests write on the blog
rem REPOSITORY
rem https://github.com/thelogh/save_restore_activation_microsoft_license
rem V.1.0.0

cmd /v:on /c md "%ScriptPath%license"

cmd /v:on /c md "%ScriptPath%GenuineTicket"

net stop clipsvc
net stop sppsvc
cmd /v:on /c XCOPY C:\Windows\System32\spp\store "%ScriptPath%license" /O /X /E /H /K /Y

net stop clipsvc
net stop sppsvc
cmd /v:on /c XCOPY C:\ProgramData\Microsoft\Windows\ClipSVC\tokens.dat "%ScriptPath%GenuineTicket" /O /X /H /K /Y

"%ScriptPath%psexec" -i -s -accepteula reg export HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\{7746D80F-97E0-4E26-9543-26B41FC22F79} .\winactivationkey.reg

cmd /v:on /c copy C:\Windows\System32\winactivationkey.reg "%ScriptPath%"

cmd /v:on /c del C:\Windows\System32\winactivationkey.reg

pause