# 04. Persistencia (Chave Run e Tarefa Agendada)

**Tatica MITRE ATT&CK:** Persistence
**IDs:** T1547.001, T1053.005
**Severidade esperada:** Alta
**Precisa de admin:** Parcial
**Destrutivo:** Nao

## Para que serve, na visao do atacante

Depois de entrar na maquina, o atacante quer garantir o retorno mesmo apos um reinicio. Para isso cria um gatilho que faz um programa dele rodar sozinho, por exemplo toda vez que o usuario faz login.

Dois jeitos classicos, ambos com ferramentas nativas do Windows:

* Chave Run no registro, que executa algo ao logar.
* Tarefa Agendada, o schtasks, que executa em horarios ou eventos definidos.

## Por que e perigoso

Persistencia e o que transforma uma invasao rapida em uma presenca duradoura. Voce reinicia, encerra o processo, acha que resolveu, e o programa reaparece. Enquanto a persistencia nao for removida, o incidente nao termina de verdade.

## Analogia

E como o invasor esconder uma copia da chave de casa embaixo do tapete. Voce tranca a porta todos os dias, mas ele volta a entrar quando quiser.

## O que o script faz

1. Cria uma chave Run no registro apontando para a Calculadora, o calc.exe.
2. Cria uma Tarefa Agendada chamada WinUpdater que dispararia ao logar.

A carga e apenas o calc.exe, totalmente inofensivo. O que gera o alerta e o ato de criar o mecanismo de persistencia, identico ao de um ataque real. O script ja remove o que criou ao final.

## Exemplo dos comandos

```cmd
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v Updater /t REG_SZ /d "C:\Windows\System32\calc.exe" /f

schtasks /create /tn "WinUpdater" /tr "C:\Windows\System32\calc.exe" /sc onlogon /f
```

## O que o EDR deve detectar

* Escrita em chave de autoinicio, a Run key, do registro.
* Criacao de tarefa agendada por linha de comando.
* Classificacao como persistencia, T1547.001 e T1053.005, severidade alta.

## Pre requisitos

* A chave Run em HKCU nao exige admin. A tarefa agendada pode pedir admin dependendo da politica.

## Limpeza

```cmd
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v Updater /f
schtasks /delete /tn "WinUpdater" /f
```
