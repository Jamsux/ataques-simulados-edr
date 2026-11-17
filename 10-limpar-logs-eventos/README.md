# 10. Limpar Logs de Eventos (anti forense)

[English](../en/10-limpar-logs-eventos/README.md) | **Portugues**

**Tatica MITRE ATT&CK:** Defense Evasion
**ID:** T1070.001, Clear Windows Event Logs
**Severidade esperada:** Alta
**Precisa de admin:** Sim
**Destrutivo:** SIM

## Atencao, este teste e destrutivo

Ele apaga registros de log do Windows, por exemplo Security e System. Esses registros nao voltam. So execute em VM com snapshot e, de preferencia, limpe um log menos critico para a demonstracao.

## Para que serve, na visao do atacante

Depois de agir, o atacante quer apagar as pegadas. Os logs de eventos do Windows registram logins, execucoes e alteracoes. Limpando esses registros, ele dificulta a investigacao. O time de seguranca perde a fita da camera daquele periodo.

## Por que e perigoso

E uma tecnica anti forense. Destroi as provas que permitiriam entender o que aconteceu, quando e como. Mesmo que o ataque seja descoberto, sem logs fica muito mais dificil medir o estrago e fechar a porta usada. Por isso, o proprio ato de limpar logs deve disparar um alerta alto.

## Analogia

O ladrao, ao sair, leva a fita, ou apaga a gravacao, das cameras de seguranca. O crime pode ser notado, mas ninguem consegue reconstituir exatamente o que ele fez.

## O que o script faz

1. Pede confirmacao explicita, digitar a palavra LIMPAR.
2. Por seguranca, limpa por padrao um log nao essencial, o Windows PowerShell, para gerar o alerta sem destruir o log de Seguranca.
3. Mostra, apenas como texto, o comando que limparia o log de Security. Use so se realmente precisar.

## Exemplo dos comandos

```cmd
wevtutil cl "Windows PowerShell"
```

Mais agressivo, apaga a trilha de seguranca, use com cuidado.

```cmd
wevtutil cl Security
```

## O que o EDR deve detectar

* O wevtutil limpando logs de eventos, uma tecnica anti forense.
* Classificacao como Clear Windows Event Logs, T1070.001, severidade alta.

## Pre requisitos

* Administrador.
* Snapshot da VM. Os logs apagados nao voltam.

## Limpeza

* Nao ha reversao por comando. Os logs crescem de novo com o uso. Para o estado anterior, restaure o snapshot.
