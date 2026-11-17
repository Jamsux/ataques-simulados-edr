# 07. Evasao de Defesa (mexer no antivirus)

**Tatica MITRE ATT&CK:** Defense Evasion
**ID:** T1562.001, Impair Defenses
**Severidade esperada:** Alta
**Precisa de admin:** Sim
**Destrutivo:** Reversivel

Os comandos de exemplo usam o Windows Defender por ser o antivirus nativo, mas a tecnica vale para qualquer produto. O que importa e validar que o seu EDR detecta a tentativa de enfraquecer a protecao.

## Para que serve, na visao do atacante

Antes de agir, o atacante tenta cegar as defesas. Com o antivirus, dois movimentos comuns sao adicionar uma exclusao, ou seja, dizer ao antivirus para ignorar tudo em uma pasta, e desligar a protecao em tempo real.

Assim, ele cria um ponto cego onde seus programas maliciosos rodam sem serem barrados.

## Por que e perigoso

Desativar ou criar exclusoes no antivirus e como desligar as cameras antes do assalto. Tudo o que vier depois fica muito mais facil e silencioso. Um bom EDR precisa detectar a propria tentativa de ser enfraquecido. Essa e uma das deteccoes mais importantes.

## Analogia

O ladrao, antes de entrar, cobre a lente da camera de seguranca com fita. O crime em si vem depois, mas mexer na camera ja e o primeiro sinal claro de que algo errado vai acontecer.

## O que o script faz

1. Cria uma exclusao de pasta, a C:\temp, no antivirus.
2. Opcionalmente, mostra o comando que desativaria a protecao em tempo real.
3. Reverte ambos ao final, remove a exclusao e reativa a protecao.

Em muitos ambientes, a Protecao contra Adulteracao, a Tamper Protection do Windows, impede esses comandos. E isso e otimo. Significa uma camada a mais funcionando.

## Exemplo dos comandos

```powershell
Add-MpPreference -ExclusionPath "C:\temp"
Set-MpPreference -DisableRealtimeMonitoring $true
```

## O que o EDR deve detectar

* Alteracao nas configuracoes do antivirus, a exclusao ou o desligar da protecao.
* Classificacao como Impair Defenses, T1562.001, severidade alta.

## Pre requisitos

* PowerShell ou Prompt como Administrador.

## Limpeza

```powershell
Remove-MpPreference -ExclusionPath "C:\temp"
Set-MpPreference -DisableRealtimeMonitoring $false
```
