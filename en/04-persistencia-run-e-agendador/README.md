# 04. Persistence (Run Key and Scheduled Task)

[Portugues](../../04-persistencia-run-e-agendador/README.md) | **English**

**MITRE ATT&CK tactic:** Persistence
**IDs:** T1547.001, T1053.005
**Expected severity:** High
**Needs admin:** Partial
**Destructive:** No

## What it is for, from the attacker point of view

After getting onto the machine, the attacker wants to guarantee their return even after a reboot. For that they create a trigger that makes a program of theirs run on its own, for example every time the user logs in.

Two classic ways, both with native Windows tools:

* A Run key in the registry, which runs something at logon.
* A Scheduled Task, schtasks, which runs at defined times or events.

## Why it is dangerous

Persistence is what turns a quick breach into a lasting presence. You reboot, kill the process, think you solved it, and the program comes back. Until the persistence is removed, the incident is not really over.

## Analogy

It is like the intruder hiding a copy of the house key under the doormat. You lock the door every day, but they walk back in whenever they want.

## What the script does

1. Creates a Run key in the registry pointing to the Calculator, calc.exe.
2. Creates a Scheduled Task called WinUpdater that would fire at logon.

The payload is just calc.exe, completely harmless. What raises the alert is the act of creating the persistence mechanism, identical to a real attack. The script already removes what it created at the end.

## Example commands

```cmd
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v Updater /t REG_SZ /d "C:\Windows\System32\calc.exe" /f

schtasks /create /tn "WinUpdater" /tr "C:\Windows\System32\calc.exe" /sc onlogon /f
```

## What the EDR should detect

* A write to an autostart key, the Run key, in the registry.
* Creation of a scheduled task from the command line.
* Classification as persistence, T1547.001 and T1053.005, high severity.

## Prerequisites

* The Run key under HKCU does not require admin. The scheduled task may require admin depending on policy.

## Cleanup

```cmd
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v Updater /f
schtasks /delete /tn "WinUpdater" /f
```
