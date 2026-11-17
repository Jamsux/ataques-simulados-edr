# 13. Movimento Lateral (Lateral Movement)

[English](../en/13-movimento-lateral/README.md) | **Portugues**

**Tatica MITRE ATT&CK:** Lateral Movement e Execution
**IDs:** T1047, T1053.005, T1569.002, T1021
**Severidade esperada:** Alta
**Precisa de admin:** Sim, no alvo
**Destrutivo:** Reversivel

Esta pasta mostra tres tecnicas de movimento lateral, todas com ferramentas nativas do Windows. O script pede um alvo e usa 127.0.0.1 como padrao, para rodar de forma contida no proprio laboratorio. Em um teste real, use uma segunda maquina do seu lab como alvo.

## Para que serve, na visao do atacante

Depois de dominar a primeira maquina, o atacante quer se espalhar pela rede, pulando para outros computadores e servidores ate chegar no que interessa, por exemplo o controlador de dominio. Em vez de instalar ferramentas, ele usa recursos de administracao remota que ja existem no Windows.

## Por que e perigoso

O movimento lateral e o que transforma a invasao de um unico computador no comprometimento da rede inteira. E a diferenca entre perder uma maquina e perder a empresa. Como usa ferramentas legitimas de administracao, costuma se misturar ao trabalho normal do time de TI, por isso detecta-lo e tao importante.

## Analogia

O ladrao entrou por uma janela, mas agora pega o molho de chaves mestras do predio e comeca a abrir uma porta atras da outra, andando pelos andares como se fosse o zelador.

## As tres tecnicas mostradas

### Tecnica 1, WMIC remoto (T1047)

Usa o WMI, um servico de gerenciamento do Windows, para criar um processo em outra maquina.

```cmd
wmic /node:ALVO process call create "calc.exe"
```

### Tecnica 2, Tarefa Agendada remota (T1053.005)

Cria e dispara uma tarefa agendada em outra maquina.

```cmd
schtasks /create /s ALVO /tn "LatMovTest" /tr "C:\Windows\System32\calc.exe" /sc once /st 23:59 /f
schtasks /run /s ALVO /tn "LatMovTest"
```

### Tecnica 3, Servico remoto com sc (T1569.002)

Cria e inicia um servico em outra maquina, uma tecnica no estilo do PsExec.

```cmd
sc \\ALVO create LatMovSvc binPath= "cmd.exe /c calc.exe" start= demand
sc \\ALVO start LatMovSvc
```

Bonus, PowerShell Remoting via WinRM, T1021.006.

```powershell
Invoke-Command -ComputerName ALVO -ScriptBlock { calc.exe }
```

## O que o EDR deve detectar

* Criacao remota de processo por WMI, o wmic acionando um processo em outra maquina.
* Criacao ou execucao remota de tarefa agendada.
* Criacao remota de servico, padrao tipo PsExec.
* Classificacao como Lateral Movement, severidade alta.

## Pre requisitos

* Administrador na maquina de origem e no alvo.
* O alvo acessivel na rede do laboratorio. Use 127.0.0.1 para um teste contido.

## Limpeza

```cmd
schtasks /delete /s ALVO /tn "LatMovTest" /f
sc \\ALVO delete LatMovSvc
```
