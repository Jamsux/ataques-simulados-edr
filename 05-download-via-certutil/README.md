# 05. Download via certutil (LOLBin)

[English](../en/05-download-via-certutil/README.md) | **Portugues**

**Tatica MITRE ATT&CK:** Command and Control, Ingress Tool Transfer
**ID:** T1105
**Severidade esperada:** Alta
**Precisa de admin:** Nao
**Destrutivo:** Nao

## Para que serve, na visao do atacante

Depois de entrar com um acesso pequeno, o atacante precisa trazer da internet a proxima fase, mais ferramentas e scripts. Em vez de usar um navegador, que chamaria atencao, ele usa um programa legitimo e assinado pela Microsoft, o certutil.exe, cuja funcao original e lidar com certificados, mas que tambem sabe baixar arquivos.

## Por que e perigoso

Esse abuso de ferramenta confiavel, chamado LOLBin, de Living Off the Land Binary, faz o download passar vestido de inocente. Muitas defesas confiam em programas assinados pela Microsoft e nao desconfiam de um certutil baixando algo. E como o malware entrar pela porta da frente, de terno.

## Analogia

O ladrao nao carrega a ferramenta de arrombamento ele mesmo. Ele pede para o carteiro, em quem todo mundo confia, entregar o pacote dentro de casa. O carteiro, o certutil, e honesto. Esta sendo usado.

## O que o script faz

Usa o certutil para baixar um arquivo de texto inofensivo, um README publico do GitHub, para C:\temp. Nenhum codigo malicioso e executado. O alvo e so demonstrar o padrao de download via LOLBin. O arquivo e apagado ao final.

## Exemplo do comando

```cmd
certutil.exe -urlcache -split -f https://raw.githubusercontent.com/github/gitignore/main/README.md C:\temp\teste-download.txt
```

## O que o EDR deve detectar

* O certutil.exe realizando download da internet, um uso anomalo.
* Padrao de Ingress Tool Transfer, T1105.
* Severidade alta, especialmente se seguido de execucao.

## Pre requisitos

* Acesso a internet na VM de teste.

## Limpeza

```cmd
del C:\temp\teste-download.txt
```
