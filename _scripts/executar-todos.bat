@echo off
chcp 65001 >nul
title Validacao de EDR - Executar TODOS os testes
color 0E
cls
echo ============================================================
echo   VALIDACAO DE EDR - BATERIA COMPLETA
echo ============================================================
echo.
echo   AVISO: execute apenas em LABORATORIO ISOLADO (VM).
echo   Tire um SNAPSHOT da VM antes de continuar.
echo.
echo   Alguns testes exigem Prompt como ADMINISTRADOR.
echo   Os testes 09 e 10 sao DESTRUTIVOS (shadow copies / logs).
echo.
echo ============================================================
echo.
set /p OK="Digite SIM para continuar (ou feche a janela): "
if /I not "%OK%"=="SIM" goto :fim

set BASE=%~dp0..

for %%T in (
  "01-coleta-credenciais-lsass"
  "02-powershell-ofuscado"
  "03-reconhecimento-ambiente"
  "04-persistencia-run-e-agendador"
  "05-download-via-certutil"
  "06-shell-reversa"
  "07-evasao-desativar-defender"
  "08-bypass-uac-fodhelper"
  "11-execucao-mshta"
  "12-criacao-conta-admin"
) do (
  echo.
  echo ------------------------------------------------------------
  echo   Executando: %%~T
  echo ------------------------------------------------------------
  call "%BASE%\%%~T\teste.bat"
  echo.
  echo   ^>^> Confira o alerta no console do seu EDR e tecle algo.
  pause >nul
)

echo.
echo ============================================================
echo   OBSERVACAO: os testes 09 (shadow copies) e 10 (logs) sao
echo   DESTRUTIVOS e NAO foram incluidos aqui. Rode-os manualmente
echo   se precisar valida-los.
echo ============================================================
echo.
echo   Para desfazer as alteracoes, rode: limpar-tudo.bat
:fim
echo.
pause
