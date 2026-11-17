@echo off
chcp 65001 >nul
title [05] Download via certutil - Validacao EDR
color 0E
cls
echo ============================================================
echo   [05] DOWNLOAD VIA CERTUTIL (abuso de LOLBin)
echo   MITRE ATT&CK: T1105  ^|  Severidade: ALTA
echo ============================================================
echo.
echo   Simula o uso do certutil (ferramenta assinada da MS)
echo   para baixar um arquivo. O conteudo baixado e INOFENSIVO.
echo ============================================================
echo.
pause

if not exist "C:\temp" mkdir "C:\temp"

echo.
echo [*] Baixando arquivo de teste via certutil...
certutil.exe -urlcache -split -f https://raw.githubusercontent.com/github/gitignore/main/README.md C:\temp\teste-download.txt

echo.
if exist "C:\temp\teste-download.txt" (
  echo [OK] Arquivo baixado em C:\temp\teste-download.txt
) else (
  echo [!] Download nao concluido. O EDR pode ter bloqueado.
)

echo.
echo ------------------------------------------------------------
echo   Verifique o ALERTA no console do seu EDR.
echo   Esperado: certutil fazendo download / T1105 (ALTA).
echo ------------------------------------------------------------
echo.
echo [*] Limpando arquivo baixado...
del /q "C:\temp\teste-download.txt" >nul 2>&1
echo [OK] Limpeza concluida.
echo.
pause
