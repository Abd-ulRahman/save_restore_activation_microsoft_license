rem Offline script to save and restore activation for Microsoft Windows and Office licenses by Thelogh
rem Backup and Restore Microsoft Windows and Microsoft Office License Activation Offline
rem https://www.alldiscoveries.com/backup-and-restore-microsoft-windows-and-microsoft-office-license-activation-offline/
rem For all requests write on the blog
rem REPOSITORY
rem https://github.com/thelogh/save_restore_activation_microsoft_license
rem V.1.0.0

net stop clipsvc
net stop sppsvc
xcopy .\license\2.0\ C:\Windows\System32\spp\store\2.0 /O /X /E /H /K /Y
xcopy .\GenuineTicket\tokens.dat C:\ProgramData\Microsoft\Windows\ClipSVC /O /X /H /K /Y
copy /Y .\winactivationkey.reg C:\Windows\System32\winactivationkey.reg
psexec -i -s -accepteula reg import C:\Windows\System32\winactivationkey.reg
del C:\Windows\System32\winactivationkey.reg
shutdown /r /t 0
