@echo off
chcp 65001 >nul
title [15] Download via BitsAdmin - Validacao de EDR
color 0E
cls
echo ============================================================
echo   [15] DOWNLOAD VIA BITSADMIN (BITS Jobs)
echo   MITRE ATT&CK: T1197 / T1105  ^|  Severidade: ALTA
echo ============================================================
echo.
echo   Simula o uso do servico BITS para baixar um arquivo.
echo   O conteudo baixado e INOFENSIVO. O script limpa no fim.
echo ============================================================
echo.
pause

if not exist "C:\temp" mkdir "C:\temp"

echo.
echo [*] Baixando arquivo de teste via bitsadmin...
bitsadmin /transfer jobTeste /download /priority normal https://raw.githubusercontent.com/github/gitignore/main/README.md C:\temp\bits-teste.txt

echo.
if exist "C:\temp\bits-teste.txt" (
  echo [OK] Arquivo baixado em C:\temp\bits-teste.txt
) else (
  echo [!] Download nao concluido. O EDR pode ter bloqueado.
)

echo.
echo ------------------------------------------------------------
echo   Verifique o ALERTA no console do seu EDR.
echo   Esperado: BITS Jobs / Ingress Tool Transfer (ALTA).
echo ------------------------------------------------------------
echo.
echo [*] Limpando arquivo baixado...
del /q "C:\temp\bits-teste.txt" >nul 2>&1
echo [OK] Limpeza concluida.
echo.
pause
