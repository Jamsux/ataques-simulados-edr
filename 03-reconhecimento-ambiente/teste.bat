@echo off
chcp 65001 >nul
title [03] Reconhecimento do Ambiente - Validacao EDR
color 0E
cls
echo ============================================================
echo   [03] RECONHECIMENTO DO AMBIENTE (Discovery)
echo   MITRE ATT&CK: T1082/T1087/T1016/T1018  ^|  Sev.: MEDIA
echo ============================================================
echo.
echo   Simula a rajada de comandos que um atacante roda logo
echo   apos invadir, para mapear a maquina e a rede.
echo ============================================================
echo.
pause
echo.

echo [*] whoami /all
whoami /all
echo.
echo [*] net user
net user
echo.
echo [*] net localgroup administrators
net localgroup administrators
echo.
echo [*] systeminfo (resumido)
systeminfo | findstr /B /C:"Nome do host" /C:"Host Name" /C:"Nome do sistema operacional" /C:"OS Name"
echo.
echo [*] ipconfig /all (resumido)
ipconfig | findstr /C:"IPv4"
echo.
echo [*] net view
net view
echo.
echo [*] arp -a
arp -a
echo.
echo [*] nltest /dclist (controladores de dominio)
nltest /dclist: 2>nul

echo.
echo ------------------------------------------------------------
echo   Verifique o ALERTA no console do seu EDR.
echo   Esperado: atividade de discovery/reconnaissance (MEDIA).
echo ------------------------------------------------------------
echo.
pause
