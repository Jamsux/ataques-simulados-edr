# 08. Bypass de UAC (via fodhelper)

[English](../en/08-bypass-uac-fodhelper/README.md) | **Portugues**

**Tatica MITRE ATT&CK:** Privilege Escalation
**ID:** T1548.002
**Severidade esperada:** Alta
**Precisa de admin:** Nao, esse e o ponto
**Destrutivo:** Nao

## Para que serve, na visao do atacante

O UAC, de User Account Control, e aquela janela do Windows que pergunta se voce deseja permitir que um app faca alteracoes. Ela existe para que acoes de administrador precisem de uma confirmacao.

Alguns programas nativos do Windows, como o fodhelper.exe, sobem para administrador sem mostrar essa janela. O atacante abusa desse comportamento, usando o registro, para rodar o que quiser ja como admin, sem clicar em Sim e, muitas vezes, partindo de um usuario comum.

## Por que e perigoso

E elevacao de privilegio, ou seja, pegar um acesso limitado e transforma-lo em poder total na maquina, de forma silenciosa, sem a confirmacao do UAC. Com privilegio de admin, quase todas as outras tecnicas deste repositorio ficam disponiveis.

## Analogia

E como descobrir que uma porta especifica dos fundos nunca tranca e nao tem camera. O funcionario comum, que so podia entrar na recepcao, passa a ter acesso ao cofre, sem pedir a chave a ninguem.

## O que o script faz

1. Cria uma chave de registro especifica que o fodhelper.exe consulta.
2. Executa o fodhelper.exe, que abriria o comando definido sem o UAC.
3. Remove a chave de registro ao final.

A carga e inofensiva, abrir a calculadora. O que gera o alerta e a manipulacao do registro mais a execucao do fodhelper.

## Exemplo dos comandos

```cmd
reg add "HKCU\Software\Classes\ms-settings\Shell\Open\command" /ve /d "C:\Windows\System32\calc.exe" /f
reg add "HKCU\Software\Classes\ms-settings\Shell\Open\command" /v DelegateExecute /t REG_SZ /f
fodhelper.exe
```

## O que o EDR deve detectar

* Modificacao da chave ms-settings Shell Open command seguida de fodhelper.exe.
* Padrao conhecido de UAC bypass, T1548.002, severidade alta.

## Pre requisitos

* Usuario comum ja serve, pois demonstra a elevacao.

## Limpeza

```cmd
reg delete "HKCU\Software\Classes\ms-settings\Shell\Open\command" /f
```
