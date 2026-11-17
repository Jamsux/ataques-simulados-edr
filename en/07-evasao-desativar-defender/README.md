# 07. Defense Evasion (tampering with the antivirus)

[Portugues](../../07-evasao-desativar-defender/README.md) | **English**

**MITRE ATT&CK tactic:** Defense Evasion
**ID:** T1562.001, Impair Defenses
**Expected severity:** High
**Needs admin:** Yes
**Destructive:** Reversible

The example commands use Windows Defender because it is the native antivirus, but the technique applies to any product. What matters is validating that your EDR detects the attempt to weaken the protection.

## What it is for, from the attacker point of view

Before acting, the attacker tries to blind the defenses. With the antivirus, two common moves are adding an exclusion, that is, telling the antivirus to ignore everything in a folder, and turning off real time protection.

That way, they create a blind spot where their malicious programs run without being blocked.

## Why it is dangerous

Disabling or creating exclusions in the antivirus is like turning off the cameras before the heist. Everything that comes after becomes much easier and quieter. A good EDR must detect the very attempt to weaken it. That is one of the most important detections.

## Analogy

The burglar, before going in, covers the security camera lens with tape. The crime itself comes later, but tampering with the camera is already the first clear sign that something wrong is about to happen.

## What the script does

1. Creates a folder exclusion, C:\temp, in the antivirus.
2. Optionally, shows the command that would disable real time protection.
3. Reverts both at the end, removes the exclusion and re enables protection.

In many environments, Tamper Protection in Windows blocks these commands. And that is great. It means one more layer is working.

## Example commands

```powershell
Add-MpPreference -ExclusionPath "C:\temp"
Set-MpPreference -DisableRealtimeMonitoring $true
```

## What the EDR should detect

* A change in the antivirus settings, the exclusion or the disabling of protection.
* Classification as Impair Defenses, T1562.001, high severity.

## Prerequisites

* PowerShell or Command Prompt as Administrator.

## Cleanup

```powershell
Remove-MpPreference -ExclusionPath "C:\temp"
Set-MpPreference -DisableRealtimeMonitoring $false
```
