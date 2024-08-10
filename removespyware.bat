@echo off
cls

@echo off
setlocal
start /b "C:\Program Files\VideoLAN\VLC\vlc.exe" "music.mp3"
timeout /t 1 /nobreak >nul
nircmd sendkeypress rwin+down
endlocal

echo.
echo  Windows 11 telemetry and bloatware remover by SH4D0WKR00KS
echo  ====================
echo.
echo  Choose what to remove:
echo.
echo  1. Telemetry and data collection
echo  2. web search
echo  3. Windows 11's advertising ID
echo  4. Built-in apps (Edge, Feedback Hub)
echo  5. Built-in services (DiagTrack, dmwappushservice, WerSvc)
echo  6. All of the above
echo  7. Exit
echo.
set /p choice=Enter your choice: 

if %choice%==1 goto telemetry
if %choice%==2 goto cortana
if %choice%==3 goto advertising
if %choice%==4 goto apps
if %choice%==5 goto services
if %choice%==6 goto all
if %choice%==7 goto exit
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
powershell -Command "Get-AppXPackage -AllUsers |Where-Object {$_.InstallLocation -like "*Microsoft.Windows.Cortana*"} | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register $($_.InstallLocation)}"
powershell -Command "Get-AppXPackage -AllUsers |Where-Object {$_.InstallLocation -like "*Microsoft.MicrosoftEdge*"} | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register $($_.InstallLocation)}"
powershell -Command "Get-AppXPackage -AllUsers |Where-Object {$_.InstallLocation -like "*Microsoft.WindowsFeedbackHub*"} | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register $($_.InstallLocation)}"
echo Built-in apps removed.
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

:all
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowDeviceNameInTelemetry /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v MaxTelemetryEnabled /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableWebSearch /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableCortana /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f
powershell -Command "Get-AppXPackage -AllUsers |Where-Object {$_.InstallLocation -like "*Microsoft.Windows.Cortana*"} | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register $