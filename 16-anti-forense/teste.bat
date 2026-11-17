@echo off
chcp 65001 >nul
title [16] Anti Forense - Validacao de EDR
color 0C
cls
echo ============================================================
echo   [16] ANTI FORENSE (apagar rastros, 3 tecnicas)
echo   MITRE ATT&CK: T1070.006 / T1070.004 / T1070  ^|  Sev.: ALTA
echo ============================================================
echo.
echo   *** ATENCAO: TECNICAS 2 e 3 SAO DESTRUTIVAS ***
echo   Apagam Prefetch e USN Journal (nao voltam).
echo   Use SOMENTE em VM com SNAPSHOT. Requer ADMINISTRADOR.
echo ============================================================
echo.

net session >nul 2>&1
if %errorlevel% NEQ 0 (
  echo [ERRO] Execute este script como ADMINISTRADOR.
  pause
  exit /b 1
)

if not exist "C:\temp" mkdir "C:\temp"

echo.
echo [1/3] Timestomp - alterando datas de um arquivo de teste (inofensivo)...
echo conteudo de teste> "C:\temp\timestomp-teste.txt"
powershell -NoP -C "$f='C:\temp\timestomp-teste.txt';(Get-Item $f).LastWriteTime='01/01/2010 08:00';(Get-Item $f).CreationTime='01/01/2010 08:00';Get-Item $f | Format-List Name,CreationTime,LastWriteTime"
del /q "C:\temp\timestomp-teste.txt" >nul 2>&1

echo.
set /p OK="Digite APAGAR para rodar as tecnicas DESTRUTIVAS 2 e 3 (ou ENTER para pular): "
if /I not "%OK%"=="APAGAR" goto :fim

echo.
echo [2/3] Apagando arquivos de Prefetch (destrutivo)...
del /q /f C:\Windows\Prefetch\*.pf >nul 2>&1
echo     Prefetch limpo.

echo.
echo [3/3] Apagando o USN Journal do volume C (destrutivo)...
fsutil usn deletejournal /d C:
echo     USN Journal apagado.

:fim
echo.
echo ------------------------------------------------------------
echo   Verifique o ALERTA no console do seu EDR.
echo   Esperado: Indicator Removal / anti forense (ALTA).
echo ------------------------------------------------------------
echo.
echo   LIMPEZA: sem reversao por comando para Prefetch e USN.
echo   Restaure o SNAPSHOT da VM se necessario.
echo.
pause
