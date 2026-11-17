@echo off
chcp 65001 >nul
title [12] Criacao de Conta Admin - Validacao EDR
color 0E
cls
echo ============================================================
echo   [12] CRIACAO DE CONTA DE ADMINISTRADOR
echo   MITRE ATT&CK: T1136.001  ^|  Severidade: ALTA
echo ============================================================
echo.
echo   Simula o atacante criando a propria conta admin.
echo   O script REMOVE a conta no final. Requer ADMINISTRADOR.
echo ============================================================
echo.
pause

net session >nul 2>&1
if %errorlevel% NEQ 0 (
  echo [ERRO] Execute este script como ADMINISTRADOR.
  pause
  exit /b 1
)

echo.
echo [*] Criando usuario local 'suporte_ti'...
net user suporte_ti Senha@Forte123 /add

echo.
echo [*] Adicionando 'suporte_ti' ao grupo Administradores...
net localgroup administrators suporte_ti /add

echo.
echo ------------------------------------------------------------
echo   Verifique o ALERTA no console do seu EDR.
echo   Esperado: Create Account / novo admin (ALTA).
echo ------------------------------------------------------------
echo.
pause

echo.
echo [*] Removendo a conta de teste...
net localgroup administrators suporte_ti /delete >nul 2>&1
net user suporte_ti /delete >nul 2>&1
echo [OK] Limpeza concluida.
echo.
pause
