@echo off
chcp 65001 >nul
title [11] Execucao via mshta - Validacao EDR
color 0E
cls
echo ============================================================
echo   [11] EXECUCAO VIA MSHTA (abuso de LOLBin)
echo   MITRE ATT&CK: T1218.005  ^|  Severidade: ALTA
echo ============================================================
echo.
echo   Simula o mshta executando um script. Carga INOFENSIVA
echo   (apenas exibe uma mensagem e fecha).
echo ============================================================
echo.
pause

echo.
echo [*] Executando mshta com script inofensivo...
mshta.exe vbscript:Execute("MsgBox ""Teste EDR - mshta (inofensivo)"":close")

echo.
echo ------------------------------------------------------------
echo   Verifique o ALERTA no console do seu EDR.
echo   Esperado: mshta executando script / T1218.005 (ALTA).
echo ------------------------------------------------------------
echo.
pause
