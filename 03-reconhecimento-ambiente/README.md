# 03. Reconhecimento do Ambiente (Discovery)

[English](../en/03-reconhecimento-ambiente/README.md) | **Portugues**

**Tatica MITRE ATT&CK:** Discovery
**IDs:** T1082, T1087, T1016, T1018, T1033
**Severidade esperada:** Media
**Precisa de admin:** Nao
**Destrutivo:** Nao

## Para que serve, na visao do atacante

Assim que entra numa maquina, o atacante nao sabe onde caiu. Ele dispara uma rajada de comandos de enumeracao para responder. Quem sou eu? Sou admin? Qual e a rede? Quais outros computadores e servidores existem? Quem mais esta logado?

## Por que e perigoso

Sozinho, o reconhecimento nao causa dano, mas e o mapa do tesouro. Com essas respostas, o invasor decide para onde se mover e o que vale a pena roubar. Toda operacao seria comeca por aqui. Detectar essa fase cedo permite parar o ataque antes do estrago.

## Analogia

E o ladrao que, assim que entra na casa, acende as luzes de todos os comodos e anda olhando onde ficam o cofre, as joias e a saida dos fundos, antes de pegar qualquer coisa.

## O que o script faz

Executa, em sequencia rapida, varios comandos nativos de enumeracao. E justamente o padrao em rajada, muitos comandos de descoberta em segundos, que o EDR reconhece como suspeito.

## Exemplo dos comandos

```cmd
whoami /all
net user
net localgroup administrators
systeminfo
ipconfig /all
net view
arp -a
nltest /dclist:
```

## O que o EDR deve detectar

* Sequencia de comandos de descoberta em curto intervalo, uma deteccao comportamental.
* Uso de whoami, net, nltest e systeminfo em rajada.
* Classificacao como reconnaissance ou discovery, severidade media.

## Pre requisitos

* Nenhum privilegio especial.

## Limpeza

* Nada a limpar. Apenas leitura de informacoes.
