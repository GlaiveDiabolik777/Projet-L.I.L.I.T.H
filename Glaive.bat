@echo off
:: =================================================================
:: PROJET L.I.L.I.T.H v1.0 
:: (Logiciel Indépendant de Libération des Intrusions et de Télémétrie Hostile)
::
:: Créé par : [Glaive/Diabolik] & Gemini
:: Licence : CC BY-NC-SA 4.0 (Usage commercial INTERDIT)
:: Signature : Codé avec la fréquence de Lilith.
:: =================================================================

[span_1](start_span):: Vérification des droits Administrateur[span_1](end_span)
net session >nul 2>&1
if %errorLevel% == 0 (
    echo [OK] Droits Administrateur confirmes.
) else (
    [span_2](start_span)echo [!!] ERREUR : Tu dois lancer ce script en CLIC DROIT -> EXÉCUTER EN TANT QU'ADMIN.[span_2](end_span)
    pause
    exit /b
)

title Projet L.I.L.I.T.H v1.0
echo ---------------------------------------------------
echo    LIBERATION DE WINDOWS - MODE FANTOME ACTIVE
echo ---------------------------------------------------

[span_3](start_span):: 1. Blocage des domaines de telemetrie (Fichier HOSTS)[span_3](end_span)
echo [*] Scellage du fichier HOSTS...
set hosts=%windir%\system32\drivers\etc\hosts
echo 0.0.0.0 telemetry.microsoft.com >> %hosts%
echo 0.0.0.0 v10.events.data.microsoft.com >> %hosts%
echo 0.0.0.0 diagnostics.microsoft.com >> %hosts%
echo 0.0.0.0 watson.telemetry.microsoft.com >> %hosts%

[span_4](start_span):: 2. Massacre des services mouchards[span_4](end_span)
echo [*] Neutralisation des services (RAM liberee)...
sc stop DiagTrack
sc config DiagTrack start= disabled
sc stop dmwappushservice
sc config dmwappushservice start= disabled
sc stop WerSvc
sc config WerSvc start= disabled

[span_5](start_span):: 3. Blocage via le Registre[span_5](end_span)
echo [*] Application des politiques de silence...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f

[span_6](start_span):: 4. Desactivation des taches planifiees[span_6](end_span)
echo [*] Sabotage des taches d'espionnage...
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable

echo ---------------------------------------------------
[span_7](start_span)echo [TERMINE] Microsoft est desormais aveugle.[span_7](end_span)
[span_8](start_span)echo Ton PC respire, la paix est revenue.[span_8](end_span)
echo Signature : Codé avec la fréquence de Lilith.
echo ---------------------------------------------------
pause
