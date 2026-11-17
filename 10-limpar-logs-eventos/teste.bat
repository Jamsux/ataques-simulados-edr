@echo off
chcp 65001 >nul
title [10] Limpar Logs de Eventos - Validacao EDR
color 0C
cls
echo ============================================================
echo   [10] LIMPAR LOGS DE EVENTOS (anti-forense)
echo   MITRE ATT&CK: T1070.001  ^|  Severidade: ALTA
echo ============================================================
echo.
echo   *** ATENCAO: ESTE TESTE E DESTRUTIVO ***
echo   Apaga registros de log do Windows (nao voltam).
echo   Por seguranca, limpa o log 'Windows PowerShell'.
echo   Use SOMENTE em VM com SNAPSHOT. Requer ADMINISTRADOR.
echo ============================================================
echo.

net session >nul 2>&1
if %errorlevel% NEQ 0 (
  echo [ERRO] Execute este script como ADMINISTRADOR.
  pause
  exit /b 1
)

set /p OK="Digite LIMPAR para confirmar (ou feche): "
if /I not "%OK%"=="LIMPAR" (
  echo Operacao cancelada.
  pause
  exit /b 0
)

echo.
echo [*] Limpando o log 'Windows PowerShell' (gera o alerta)...
wevtutil cl "Windows PowerShell"

echo.
echo   (Comando mais agressivo, NAO executado por padrao:)
echo       wevtutil cl Security

echo.
echo ------------------------------------------------------------
echo   Verifique o ALERTA no console do seu EDR.
echo   Esperado: Clear Windows Event Logs / anti-forense (ALTA).
echo ------------------------------------------------------------
echo.
echo   LIMPEZA: sem reversao por comando. Restaure o SNAPSHOT.
echo.
pause
