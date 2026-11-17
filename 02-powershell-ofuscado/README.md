# 02. PowerShell Ofuscado (comando codificado)

[English](../en/02-powershell-ofuscado/README.md) | **Portugues**

**Tatica MITRE ATT&CK:** Execution e Defense Evasion
**ID:** T1059.001, T1027
**Severidade esperada:** Alta
**Precisa de admin:** Nao
**Destrutivo:** Nao

## Para que serve, na visao do atacante

O PowerShell e uma ferramenta de automacao poderosissima que ja vem no Windows. O atacante a usa para rodar comandos, mas esconde o que esta fazendo. Ele transforma o comando em um texto embaralhado, no formato Base64, roda com a janela oculta e sem carregar o perfil, para nao deixar rastros.

## Por que e perigoso

A ofuscacao serve para enganar quem le os logs e os filtros de seguranca que procuram por palavras obvias, como download ou invoke. Um comando que parece um amontoado de letras aleatorias pode, na verdade, estar baixando um virus. E uma das formas mais comuns de execucao disfarcada.

## Analogia

E como mandar um recado escrito em codigo, com letra miuda, por baixo da porta, com a luz apagada. Quem passa nao entende nada, mas o destinatario, o computador, decifra e obedece.

## O que o script faz

Executa um PowerShell com os parametros tipicos de ataque, o NoProfile, o NonInteractive, o WindowStyle Hidden e o EncodedCommand. O comando embaralhado, por seguranca, apenas roda o inofensivo whoami, mas o padrao de disfarce e identico ao de um ataque real.

## Exemplo do comando

```powershell
powershell.exe -NoP -NonI -W Hidden -Enc dwBoAG8AYQBtAGkA
```

O valor dwBoAG8AYQBtAGkA e so o texto whoami codificado em Base64. O que dispara o alerta e a combinacao de parametros suspeitos, nao o que o comando faz.

## O que o EDR deve detectar

* Uso de EncodedCommand ou Enc combinado com janela oculta.
* Linha de comando com conteudo ofuscado, em Base64.
* Classificacao como execucao suspeita ou ofuscada, T1059.001 mais T1027.

## Pre requisitos

* Nenhum privilegio especial.

## Limpeza

* Nada a limpar. O teste nao altera o sistema.
