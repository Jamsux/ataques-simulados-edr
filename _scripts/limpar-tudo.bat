@echo off
chcp 65001 >nul
title Validacao de EDR - LIMPEZA geral
color 0A
cls
echo ============================================================
echo   LIMPEZA - desfazendo alteracoes dos testes
echo ============================================================
echo   Execute como ADMINISTRADOR para limpar tudo.
echo.
pause

echo [04] Removendo persistencia (Run key e tarefa agendada)...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v Updater /f >nul 2>&1
schtasks /delete /tn "WinUpdater" /f >nul 2>&1

echo [05/01] Removendo arquivos baixados / dumps em C:\temp...
del /q "C:\temp\teste-download.txt" >nul 2>&1
del /q "C:\temp\lsass.dmp" >nul 2>&1

echo [07] Removendo exclusao do Defender e reativando protecao...
powershell -NoP -C "Remove-MpPreference -ExclusionPath 'C:\temp' -ErrorAction SilentlyContinue; Set-MpPreference -DisableRealtimeMonitoring $false" >nul 2>&1

echo [08] Removendo chave de registro do bypass de UAC...
reg delete "HKCU\Software\Classes\ms-settings\Shell\Open\command" /f >nul 2>&1

echo [12] Removendo conta de administrador de teste...
net localgroup administrators suporte_ti /delete >nul 2>&1
net user suporte_ti /delete >nul 2>&1

echo.
echo ============================================================
echo   Limpeza concluida.
echo   OBS: logs de eventos (teste 10) e shadow copies (teste 09)
echo   NAO sao recuperaveis por script - restaure o SNAPSHOT da VM.
echo ============================================================
echo.
pause
