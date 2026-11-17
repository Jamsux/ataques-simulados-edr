# 15. Download via BitsAdmin (BITS Jobs)

[English](../en/15-download-bitsadmin/README.md) | **Portugues**

**Tatica MITRE ATT&CK:** Command and Control, Ingress Tool Transfer
**IDs:** T1197, T1105
**Severidade esperada:** Alta
**Precisa de admin:** Nao
**Destrutivo:** Nao

## Para que serve, na visao do atacante

O BITS, de Background Intelligent Transfer Service, e o servico do Windows que baixa atualizacoes em segundo plano, com calma, aproveitando a rede ociosa. O atacante abusa desse mesmo servico, pela ferramenta bitsadmin, para baixar sua proxima carga de forma discreta. O download fica registrado como uma tarefa legitima do sistema, e pode ate continuar depois de um reinicio.

## Por que e perigoso

E um LOLBin especialmente silencioso. Como o proprio Windows faz o download, por um servico confiavel e em segundo plano, muitas defesas nao olham com atencao. Alem disso, o BITS e persistente, a transferencia sobrevive a reinicios e quedas de conexao, o que ajuda o atacante a trazer ferramentas sem levantar bandeira.

## Analogia

Em vez de buscar a encomenda ele mesmo, o ladrao usa o servico de entregas da propria empresa, que ja entra e sai o dia todo, para trazer a ferramenta la de fora. Ninguem estranha mais uma entrega de rotina.

## O que o script faz

Usa o bitsadmin para baixar um arquivo de texto inofensivo, um README publico do GitHub, para C:\temp. Nenhum codigo malicioso e executado. O arquivo e apagado ao final.

## Exemplo do comando

```cmd
bitsadmin /transfer jobTeste /download /priority normal https://raw.githubusercontent.com/github/gitignore/main/README.md C:\temp\bits-teste.txt
```

Equivalente moderno em PowerShell, que o atacante tambem usa.

```powershell
Start-BitsTransfer -Source https://exemplo.com/arquivo.txt -Destination C:\temp\bits-teste.txt
```

## O que o EDR deve detectar

* O bitsadmin criando uma tarefa de transferencia e baixando da internet.
* Uso do servico BITS para trazer arquivos, padrao T1197.
* Classificacao como Ingress Tool Transfer, severidade alta.

## Pre requisitos

* Acesso a internet na VM de teste.

## Limpeza

```cmd
del C:\temp\bits-teste.txt
```
