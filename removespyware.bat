@echo off
cls

echo.
echo  ==========================================================
echo  Windows 11 Telemetry and Bloatware Remover by SH4D0WKR00KS
echo  ==========================================================
echo.
echo  WARNING : Modifying system settings can potentially disrupt functionality. Use with caution.

echo.
echo  Choose what to remove:
echo.
echo  1. Telemetry and data collection (Disables data collection by Microsoft)
echo  2. Web search (Removes Bing integration in Windows Search)
echo  3. Windows 11's advertising ID (Opt-out of targeted advertising)
echo  4. Built-in apps (Completely removes Edge, Cortana, Feedback Hub)
echo  5. Built-in services (Disables DiagTrack, dmwappushservice, WerSvc)
echo  6. All of the above (Perform all removals mentioned above)
echo  7. Exit

set /p choice=Enter your choice (1-7): 

if %choice%==1 goto telemetry
if %choice%==2 goto cortana
if %choice%==3 goto advertising
if %choice%==4 goto apps
if %choice%==5 goto services
if %choice%==6 goto recall
if %choice%==7 goto all
if %choice%==8 goto exit
echo Invalid choice. Please try again.
pause
goto menu

:telemetry
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowDeviceNameInTelemetry /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v MaxTelemetryEnabled /t REG_DWORD /d 0 /f
echo Telemetry and data collection disabled.
pause
goto menu

:cortana
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableWebSearch /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableCortana /t REG_DWORD /d 1 /f
echo Cortana and web search disabled.
pause
goto menu

:advertising
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f
echo Windows 11's advertising ID disabled.
pause
goto menu

:apps
powershell -Command "Get-AppXPackage -AllUsers | Where-Object {$_.Name -like '*Cortana*' } | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppXPackage -AllUsers | Where-Object {$_.Name -like '*MicrosoftEdge*' } | Remove-AppxPackage -ErrorAction SilentlyContinue"
powershell -Command "Get-AppXPackage -AllUsers | Where-Object {$_.Name -like '*FeedbackHub*' } | Remove-AppxPackage -ErrorAction SilentlyContinue"
echo Built-in apps removed (if applicable).
pause
goto menu

:services
sc stop DiagTrack
sc config DiagTrack start= disabled
sc stop dmwappushservice
sc config dmwappushservice start= disabled
sc stop WerSvc
sc config WerSvc start= disabled
echo Built-in services disabled.
pause
goto menu

:recall
schtasks /delete /tn "Microsoft\Windows\Recall\Recall_ScheduledTask" /f
schtasks /delete /tn "Microsoft\Windows\Recall\Recall_ScheduledTask_User" /f
echo Recall disabled.
pause
goto menu

:all
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowDeviceNameInTelemetry /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v MaxTelemetryEnabled /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableWebSearch /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableCortana /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f
powers
