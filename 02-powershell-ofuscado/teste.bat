@echo off
chcp 65001 >nul
title [02] PowerShell Ofuscado - Validacao EDR
color 0E
cls
echo ============================================================
echo   [02] POWERSHELL OFUSCADO (comando codificado em Base64)
echo   MITRE ATT&CK: T1059.001 / T1027  ^|  Severidade: ALTA
echo ============================================================
echo.
echo   Simula execucao disfarcada com -Enc -W Hidden -NoProfile.
echo   A carga e inofensiva (apenas 'whoami').
echo ============================================================
echo.
pause

echo.
echo [*] Executando PowerShell ofuscado (janela oculta)...
powershell.exe -NoP -NonI -W Hidden -Enc dwBoAG8AYQBtAGkA

echo.
echo [OK] Comando ofuscado executado.
echo.
echo ------------------------------------------------------------
echo   Verifique o ALERTA no console do seu EDR.
echo   Esperado: execucao ofuscada / EncodedCommand (ALTA).
echo ------------------------------------------------------------
echo.
pause
