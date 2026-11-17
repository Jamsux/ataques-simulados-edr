@echo off
chcp 65001 >nul
title [13] Movimento Lateral - Validacao de EDR
color 0E
cls
echo ============================================================
echo   [13] MOVIMENTO LATERAL (3 tecnicas)
echo   MITRE ATT&CK: T1047 / T1053.005 / T1569.002  ^|  Sev.: ALTA
echo ============================================================
echo.
echo   Simula a propagacao para outra maquina com ferramentas
echo   nativas. Carga inofensiva: calc.exe. O script limpa no fim.
echo   Requer ADMINISTRADOR na origem e no alvo.
echo ============================================================
echo.
set /p ALVO="Digite o alvo (ENTER = 127.0.0.1): "
if "%ALVO%"=="" set ALVO=127.0.0.1
echo.
echo   Alvo selecionado: %ALVO%
echo.
pause

echo.
echo [1/3] WMIC remoto (T1047)...
wmic /node:"%ALVO%" process call create "calc.exe"

echo.
echo [2/3] Tarefa Agendada remota (T1053.005)...
schtasks /create /s %ALVO% /tn "LatMovTest" /tr "C:\Windows\System32\calc.exe" /sc once /st 23:59 /f
schtasks /run /s %ALVO% /tn "LatMovTest"

echo.
echo [3/3] Servico remoto com sc (T1569.002)...
sc \\%ALVO% create LatMovSvc binPath= "cmd.exe /c calc.exe" start= demand
sc \\%ALVO% start LatMovSvc

echo.
echo ------------------------------------------------------------
echo   Verifique o ALERTA no console do seu EDR.
echo   Esperado: Lateral Movement / execucao remota (ALTA).
echo ------------------------------------------------------------
echo.
pause

echo.
echo [*] Limpando tarefa e servico criados...
schtasks /delete /s %ALVO% /tn "LatMovTest" /f >nul 2>&1
sc \\%ALVO% delete LatMovSvc >nul 2>&1
echo [OK] Limpeza concluida.
echo.
pause
