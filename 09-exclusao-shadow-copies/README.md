# 09. Exclusao de Shadow Copies (comportamento de ransomware)

[English](../en/09-exclusao-shadow-copies/README.md) | **Portugues**

**Tatica MITRE ATT&CK:** Impact
**ID:** T1490, Inhibit System Recovery
**Severidade esperada:** Critica
**Precisa de admin:** Sim
**Destrutivo:** SIM

## Atencao, este teste e destrutivo

Ele apaga as copias de sombra, as Shadow Copies da maquina, que sao os pontos de restauracao do Windows. So execute em uma VM com snapshot recente. Depois do teste, restaure o snapshot se quiser os pontos de volta.

## Para que serve, na visao do atacante

Antes de criptografar os arquivos, o ransomware apaga as copias de sombra do Windows. Essas copias permitiriam a vitima recuperar os arquivos sem pagar. Destruindo elas, o atacante elimina o plano B da vitima.

## Por que e perigoso

E o movimento que torna o ransomware devastador. Sem as copias de sombra, e sem backup externo, nao ha como voltar atras. Ou se paga o resgate, ou se perdem os dados. Detectar o comando vssadmin delete shadows e um dos sinais mais urgentes de um ataque de ransomware em andamento.

## Analogia

Antes de atear fogo nos documentos, o criminoso destroi tambem a copia de seguranca que estava no cofre. Assim, nao sobra nenhuma via para reconstruir o que foi perdido.

## O que o script faz

1. Pede uma confirmacao explicita, digitar a palavra APAGAR.
2. Lista as copias de sombra existentes.
3. Executa vssadmin delete shadows, apagando todas.

## Exemplo do comando

```cmd
vssadmin delete shadows /all /quiet
```

Variacoes usadas por atacantes, wmic shadowcopy delete e wbadmin delete catalog quiet.

## O que o EDR deve detectar

* O vssadmin apagando copias de sombra, uma assinatura classica de ransomware.
* Classificacao como Inhibit System Recovery, T1490, severidade critica.

## Pre requisitos

* Administrador.
* Snapshot da VM feito antes. As copias apagadas nao voltam por script.

## Limpeza

* Nao ha reversao por comando. Restaure o snapshot da VM. O Windows recria copias de sombra conforme a configuracao de Protecao do Sistema.
