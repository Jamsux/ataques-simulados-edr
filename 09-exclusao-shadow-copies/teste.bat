@echo off
chcp 65001 >nul
title [09] Exclusao de Shadow Copies - Validacao EDR
color 0C
cls
echo ============================================================
echo   [09] EXCLUSAO DE SHADOW COPIES (comportamento ransomware)
echo   MITRE ATT&CK: T1490  ^|  Severidade: CRITICA
echo ============================================================
echo.
echo   *** ATENCAO: ESTE TESTE E DESTRUTIVO ***
echo   Ele APAGA os pontos de restauracao (shadow copies).
echo   Use SOMENTE em VM com SNAPSHOT recente.
echo   Requer ADMINISTRADOR.
echo ============================================================
echo.

net session >nul 2>&1
if %errorlevel% NEQ 0 (
  echo [ERRO] Execute este script como ADMINISTRADOR.
  pause
  exit /b 1
)

set /p OK="Digite APAGAR para confirmar a exclusao (ou feche): "
if /I not "%OK%"=="APAGAR" (
  echo Operacao cancelada.
  pause
  exit /b 0
)

echo.
echo [*] Listando shadow copies atuais...
vssadmin list shadows 2>nul | findstr /C:"shadow copy"

echo.
echo [*] Apagando TODAS as shadow copies (destrutivo)...
vssadmin delete shadows /all /quiet

echo.
echo ------------------------------------------------------------
echo   Verifique o ALERTA no console do seu EDR.
echo   Esperado: Inhibit System Recovery / ransomware (CRITICO).
echo ------------------------------------------------------------
echo.
echo   LIMPEZA: nao ha reversao por comando.
echo   Restaure o SNAPSHOT da VM para recuperar o estado.
echo.
pause
