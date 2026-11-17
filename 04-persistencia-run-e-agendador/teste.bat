@echo off
chcp 65001 >nul
title [04] Persistencia (Run + Agendador) - Validacao EDR
color 0E
cls
echo ============================================================
echo   [04] PERSISTENCIA - Chave Run + Tarefa Agendada
echo   MITRE ATT&CK: T1547.001 / T1053.005  ^|  Sev.: ALTA
echo ============================================================
echo.
echo   Simula a criacao de mecanismos de retorno automatico.
echo   Carga inofensiva: calc.exe. O script limpa no final.
echo ============================================================
echo.
pause

echo.
echo [*] Criando chave Run (autoinicio ao logar)...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v Updater /t REG_SZ /d "C:\Windows\System32\calc.exe" /f

echo.
echo [*] Criando Tarefa Agendada 'WinUpdater' (ao logar)...
schtasks /create /tn "WinUpdater" /tr "C:\Windows\System32\calc.exe" /sc onlogon /f

echo.
echo ------------------------------------------------------------
echo   Verifique o ALERTA no console do seu EDR.
echo   Esperado: persistencia (Run key / Scheduled Task) - ALTA.
echo ------------------------------------------------------------
echo.
pause

echo.
echo [*] Limpando persistencia criada...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v Updater /f >nul 2>&1
schtasks /delete /tn "WinUpdater" /f >nul 2>&1
echo [OK] Limpeza concluida.
echo.
pause
