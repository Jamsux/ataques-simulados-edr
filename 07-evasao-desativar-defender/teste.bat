@echo off
chcp 65001 >nul
title [07] Evasao - mexer no Defender - Validacao EDR
color 0E
cls
echo ============================================================
echo   [07] EVASAO DE DEFESA - alterar o Windows Defender
echo   MITRE ATT&CK: T1562.001  ^|  Severidade: ALTA
echo ============================================================
echo.
echo   Simula a criacao de exclusao e a tentativa de desligar a
echo   protecao em tempo real. O script REVERTE no final.
echo   Requer ADMINISTRADOR. Apenas em LAB ISOLADO.
echo ============================================================
echo.
pause

net session >nul 2>&1
if %errorlevel% NEQ 0 (
  echo [ERRO] Execute este script como ADMINISTRADOR.
  pause
  exit /b 1
)

if not exist "C:\temp" mkdir "C:\temp"

echo.
echo [*] Adicionando exclusao da pasta C:\temp no Defender...
powershell -NoP -C "Add-MpPreference -ExclusionPath 'C:\temp'"

echo.
echo [*] Tentando desativar a protecao em tempo real...
echo     (Tamper Protection pode BLOQUEAR - isso e bom!)
powershell -NoP -C "Set-MpPreference -DisableRealtimeMonitoring $true"

echo.
echo ------------------------------------------------------------
echo   Verifique o ALERTA no console do seu EDR.
echo   Esperado: Impair Defenses / alteracao do antivirus (ALTA).
echo ------------------------------------------------------------
echo.
pause

echo.
echo [*] Revertendo (removendo exclusao e reativando protecao)...
powershell -NoP -C "Remove-MpPreference -ExclusionPath 'C:\temp' -ErrorAction SilentlyContinue; Set-MpPreference -DisableRealtimeMonitoring $false"
echo [OK] Reversao concluida.
echo.
pause
