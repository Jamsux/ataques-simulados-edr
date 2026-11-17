# Ataques Simulados para Validacao de EDR

**Portugues** | [English](en/README.md)

![Licenca](https://img.shields.io/badge/licen%C3%A7a-MIT-green)
![Tecnicas](https://img.shields.io/badge/t%C3%A9cnicas-16-blue)
![MITRE ATT&CK](https://img.shields.io/badge/MITRE%20ATT%26CK-mapeado-red)
![Plataforma](https://img.shields.io/badge/plataforma-Windows-0078D6)
![Idiomas](https://img.shields.io/badge/idiomas-PT%20%7C%20EN-orange)
![PRs](https://img.shields.io/badge/PRs-bem--vindos-brightgreen)

Laboratorio didatico para validar a deteccao de um EDR usando apenas ferramentas nativas do Windows (as chamadas LOLBins, ou Living Off the Land Binaries).

Embora os exemplos tenham nascido de um teste com o WithSecure Elements, nada aqui depende de um fabricante especifico. As mesmas tecnicas servem para validar qualquer produto de EDR ou antivirus de proxima geracao (CrowdStrike, SentinelOne, Microsoft Defender for Endpoint, Sophos, TrendMicro, Cortex XDR e outros). Onde o texto fala em "seu EDR", leia o produto que voce estiver validando.

A ideia e simples. Simular o comportamento de um atacante real, de forma controlada e sem causar dano, para confirmar que o EDR:

1. Detecta a atividade.
2. Mostra a telemetria com qualidade, ou seja, processo pai, processo filho, linha de comando completa e usuario.
3. Classifica a severidade corretamente.
4. Mapeia para o MITRE ATT&CK.

Cada tecnica tem sua propria pasta, com um README explicado para leigos e um script .bat pronto para rodar.

## Aviso importante, leia antes de tudo

* Use somente em uma maquina de laboratorio isolada, uma VM descartavel, sem acesso a rede de producao.
* Voce deve ter autorizacao formal para realizar estes testes.
* Nunca rode isto em um computador de producao, pessoal ou de terceiros.
* Prepare-se para reverter tudo. Cada pasta explica como limpar o que foi criado.

Leia o arquivo [AVISO-LEGAL.md](AVISO-LEGAL.md) por completo. Ao usar este material, voce concorda com ele.

## O que e um EDR, para o analista leigo

EDR quer dizer Endpoint Detection and Response, em portugues Deteccao e Resposta em Endpoints.

Pense no antivirus tradicional como um porteiro que confere uma lista de fotos de bandidos conhecidos, as chamadas assinaturas. Se o rosto nao esta na lista, ele deixa passar.

O EDR e um detetive que nao olha so o rosto. Ele observa o comportamento. Por que o Word abriu o PowerShell, que baixou um arquivo da internet e tentou ler a memoria de senhas as 3 da manha? Mesmo sem nunca ter visto aquele arquivo, o comportamento denuncia o ataque.

Este repositorio produz justamente esses comportamentos suspeitos, sem a parte perigosa de verdade, para voce conferir se o detetive esta acordado.

## Pre requisitos do laboratorio

| Item | Detalhe |
|------|---------|
| Maquina de teste | Windows 10 ou 11 em VM isolada. Tire um snapshot antes de comecar |
| Agente instalado | O EDR que voce quer validar, ativo e reportando ao console |
| Privilegio | Alguns testes precisam de Prompt como Administrador, indicado em cada pasta |
| Maquina atacante | Somente para o teste de shell reversa, pasta 06. Um servidor ou VM com um listener |

Dica. Tire um snapshot da VM antes de comecar. Assim, se algo ficar bagunçado, voce volta ao estado limpo em segundos.

## Como usar

1. Abra a pasta da tecnica que quer testar.
2. Leia o README dela, que explica o risco e o que vai acontecer.
3. Clique com o botao direito no arquivo .bat e escolha Executar como administrador, quando indicado.
4. Va ao console do seu EDR e confirme que o alerta apareceu.
5. Rode a limpeza descrita no README da tecnica.

Atalhos na pasta _scripts:

* executar-todos.bat roda todas as tecnicas em sequencia, com pausa entre elas.
* limpar-tudo.bat desfaz as alteracoes feitas pelos testes.

## Indice das tecnicas

| Num | Tecnica | Tatica (MITRE) | ID | Severidade | Admin | Destrutivo |
|-----|---------|----------------|----|-----------|:-----:|:----------:|
| 01 | [Coleta de credenciais (LSASS)](01-coleta-credenciais-lsass/) | Credential Access | T1003.001 | Critica | Sim | Nao |
| 02 | [PowerShell ofuscado](02-powershell-ofuscado/) | Execution e Defense Evasion | T1059.001, T1027 | Alta | Nao | Nao |
| 03 | [Reconhecimento do ambiente](03-reconhecimento-ambiente/) | Discovery | T1082, T1087 | Media | Nao | Nao |
| 04 | [Persistencia (Run e Agendador)](04-persistencia-run-e-agendador/) | Persistence | T1547.001, T1053.005 | Alta | Parcial | Nao |
| 05 | [Download via certutil](05-download-via-certutil/) | Command and Control | T1105 | Alta | Nao | Nao |
| 06 | [Shell reversa](06-shell-reversa/) | Command and Control | T1059.001 | Critica | Nao | Nao |
| 07 | [Desativar ou evadir o antivirus](07-evasao-desativar-defender/) | Defense Evasion | T1562.001 | Alta | Sim | Reversivel |
| 08 | [Bypass de UAC (fodhelper)](08-bypass-uac-fodhelper/) | Privilege Escalation | T1548.002 | Alta | Nao | Nao |
| 09 | [Exclusao de Shadow Copies](09-exclusao-shadow-copies/) | Impact (ransomware) | T1490 | Critica | Sim | SIM |
| 10 | [Limpar logs de eventos](10-limpar-logs-eventos/) | Defense Evasion | T1070.001 | Alta | Sim | SIM |
| 11 | [Execucao via mshta](11-execucao-mshta/) | Defense Evasion e Execution | T1218.005 | Alta | Nao | Nao |
| 12 | [Criacao de conta admin](12-criacao-conta-admin/) | Persistence e Priv. Esc. | T1136.001 | Alta | Sim | Reversivel |
| 13 | [Movimento lateral (3 tecnicas)](13-movimento-lateral/) | Lateral Movement | T1047, T1053.005, T1569.002 | Alta | Sim | Reversivel |
| 14 | [Exfiltracao (3 canais)](14-exfiltracao/) | Exfiltration | T1048.003, T1567, T1048 | Alta | Nao | Nao |
| 15 | [Download via BitsAdmin](15-download-bitsadmin/) | Command and Control | T1197, T1105 | Alta | Nao | Nao |
| 16 | [Anti forense (3 tecnicas)](16-anti-forense/) | Defense Evasion | T1070, T1070.004, T1070.006 | Alta | Sim | SIM |

Atencao. As tecnicas 09, 10 e 16 fazem alteracoes destrutivas, apagam pontos de restauracao, logs ou artefatos forenses. Sao seguras numa VM com snapshot, mas leia o README antes.

## Por que estas tecnicas

Elas cobrem as principais taticas da cadeia de um ataque real, o chamado kill chain, entao voce valida o EDR de ponta a ponta:

```
Execucao de codigo ......... 02, 11
Evasao de defesa ........... 07, 10, 16
Elevacao de privilegio ..... 08
Acesso a credenciais ....... 01
Descoberta ................. 03
Movimento lateral .......... 13
Persistencia ............... 04, 12
Comando e Controle ......... 05, 06, 15
Exfiltracao ................ 14
Impacto .................... 09
```

Se o seu EDR pega todas, ele esta enxergando o ataque em todas as fases, nao so no comeco ou no fim.

## Mapa de cobertura (MITRE ATT&CK Navigator)

O arquivo [mitre-attack-navigator-layer.json](mitre-attack-navigator-layer.json) pinta no mapa oficial do MITRE ATT&CK todas as tecnicas cobertas por este laboratorio. E otimo para visualizar a cobertura e usar em apresentacoes.

Como usar:

1. Abra o MITRE ATT&CK Navigator em https://mitre-attack.github.io/attack-navigator/
2. Clique em Open Existing Layer e depois em Upload from local.
3. Selecione o arquivo mitre-attack-navigator-layer.json deste repositorio.

## Licenca e responsabilidade

Material exclusivamente educacional e para testes autorizados. Veja [AVISO-LEGAL.md](AVISO-LEGAL.md). O autor nao se responsabiliza por uso indevido.
