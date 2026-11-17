# 16. Anti Forense (apagar rastros)

[English](../en/16-anti-forense/README.md) | **Portugues**

**Tatica MITRE ATT&CK:** Defense Evasion
**IDs:** T1070, T1070.004, T1070.006
**Severidade esperada:** Alta
**Precisa de admin:** Sim
**Destrutivo:** SIM, em parte

Esta pasta mostra tres tecnicas anti forenses. A primeira, a alteracao de datas, e inofensiva e roda em um arquivo de teste. As outras duas apagam o USN Journal e os arquivos de Prefetch, que nao voltam. So execute em VM com snapshot.

## Para que serve, na visao do atacante

Alem de limpar os logs de eventos, o atacante apaga outros rastros que os investigadores usam para reconstruir o que aconteceu. Ele muda as datas dos arquivos que criou, para que nao chamem atencao, e apaga registros do sistema de arquivos que mostrariam sua atividade.

## Por que e perigoso

A pericia digital depende desses vestigios para contar a historia do ataque, quando cada arquivo foi criado ou alterado e o que foi executado. Destruindo essas pistas, o atacante atrasa ou inviabiliza a investigacao, dificulta medir o estrago e esconde por onde entrou. Detectar a destruicao desses artefatos e um sinal forte de alguem tentando se esconder.

## Analogia

Depois do assalto, o ladrao passa um pano em tudo que tocou, troca as etiquetas de data das caixas que mexeu e queima o livro de registro da portaria. Mesmo que descubram o roubo, fica muito mais dificil saber como e quando ele agiu.

## As tres tecnicas mostradas

### Tecnica 1, Timestomp, alterar datas (T1070.006)

Muda a data de criacao e modificacao de um arquivo, para disfarca-lo. Inofensiva, roda num arquivo de teste.

```powershell
$f='C:\temp\timestomp-teste.txt'
(Get-Item $f).LastWriteTime='01/01/2010 08:00'
(Get-Item $f).CreationTime='01/01/2010 08:00'
```

### Tecnica 2, apagar o Prefetch (T1070.004)

O Prefetch guarda indicios de quais programas foram executados. Apaga-lo remove essa trilha. Destrutivo.

```cmd
del /q /f C:\Windows\Prefetch\*.pf
```

### Tecnica 3, apagar o USN Journal (T1070)

O USN Journal e o diario de alteracoes do sistema de arquivos. Apaga-lo remove o historico de mudancas. Destrutivo.

```cmd
fsutil usn deletejournal /d C:
```

## O que o EDR deve detectar

* Alteracao suspeita de datas de arquivos, o timestomping.
* Exclusao em massa do Prefetch.
* Exclusao do USN Journal via fsutil.
* Classificacao como Indicator Removal, Defense Evasion, severidade alta.

## Pre requisitos

* Administrador.
* Snapshot da VM. O Prefetch e o USN Journal apagados nao voltam por script.

## Limpeza

* A tecnica 1 cria e apaga um arquivo de teste, sem efeito duradouro.
* Para as tecnicas 2 e 3 nao ha reversao por comando. O Windows reconstroi o Prefetch e o USN Journal com o uso. Para o estado anterior, restaure o snapshot.
