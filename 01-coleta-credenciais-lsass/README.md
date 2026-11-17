# 01. Coleta de Credenciais (Dump do LSASS)

[English](../en/01-coleta-credenciais-lsass/README.md) | **Portugues**

**Tatica MITRE ATT&CK:** Credential Access
**ID:** T1003.001
**Severidade esperada:** Critica
**Precisa de admin:** Sim
**Destrutivo:** Nao

## Para que serve, na visao do atacante

O Windows mantem, na memoria de um processo chamado lsass.exe (Local Security Authority Subsystem Service), as senhas e credenciais de quem esta logado na maquina. O atacante copia essa memoria para um arquivo e depois, com ferramentas offline, extrai senhas, hashes e tickets de acesso.

Com isso ele consegue se passar por outros usuarios, inclusive administradores.

## Por que e perigoso

Este e o momento mais valioso de muitos ataques. Com credenciais validas em maos, o invasor deixa de parecer um intruso e passa a agir como um funcionario legitimo. Ele consegue pular de uma maquina para outra pela rede, no chamado movimento lateral, sem disparar alarmes obvios, chegando ate servidores e controladores de dominio.

## Analogia

Imagine que todas as chaves da empresa ficam penduradas num quadro dentro de uma sala. O lsass.exe e esse quadro. O atacante tira uma foto do quadro inteiro e sai tranquilo. Depois, em casa, ele copia cada chave com calma.

## O que o script faz

1. Descobre o numero de identificacao, o PID, do processo lsass.exe.
2. Usa a ferramenta nativa rundll32.exe com a biblioteca comsvcs.dll, ambas do Windows, para gerar um arquivo de memoria com extensao .dmp do LSASS.

O arquivo gerado e apenas uma copia de memoria, criada para o teste. Ele nao e enviado para lugar nenhum e e apagado na limpeza.

## Exemplo do comando

```cmd
rundll32.exe C:\Windows\System32\comsvcs.dll, MiniDump <PID_do_LSASS> C:\temp\lsass.dmp full
```

## O que o EDR deve detectar

* Acesso de leitura ao processo lsass.exe por um processo incomum, o rundll32.exe.
* Padrao classico de roubo de credenciais, o credential dumping.
* Deve aparecer com severidade critica e mapeado como T1003.001.

## Pre requisitos

* Prompt de Comando como Administrador.
* Pasta C:\temp, que o script cria se nao existir.

## Limpeza

```cmd
del C:\temp\lsass.dmp
```
