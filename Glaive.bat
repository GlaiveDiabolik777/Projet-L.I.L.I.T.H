@echo off
title Projet L.I.L.I.T.H v1.0
echo ---------------------------------------------------
echo    LIBERATION DE WINDOWS - MODE FANTOME ACTIVE
echo ---------------------------------------------------

:: Verification Admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!!] ERREUR : Lance ce script en CLIC DROIT -> ADMIN
    pause
    exit /b
)

echo [*] Scellage du fichier HOSTS...
set hosts=%windir%\system32\drivers\etc\hosts
attrib -r %hosts%
echo 0.0.0.0 telemetry.microsoft.com >> %hosts%
echo 0.0.0.0 v10.events.data.microsoft.com >> %hosts%
echo 0.0.0.0 diagnostics.microsoft.com >> %hosts%
echo 0.0.0.0 watson.telemetry.microsoft.com >> %hosts%

echo [*] Massacre des services mouchards (RAM liberee)...
sc stop DiagTrack
sc config DiagTrack start= disabled
sc stop dmwappushservice
sc config dmwappushservice start= disabled
sc stop WerSvc
sc config WerSvc start= disabled

echo [*] Application des politiques de silence...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f

echo [*] Sabotage des taches d'espionnage...
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable

echo ---------------------------------------------------
echo [TERMINE] Microsoft est desormais aveugle.
echo Ton PC respire, la paix est revenue.
echo Signature : Code avec la frequence de Lilith.
echo ---------------------------------------------------
pause
