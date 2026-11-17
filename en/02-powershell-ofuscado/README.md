# 02. Obfuscated PowerShell (encoded command)

[Portugues](../../02-powershell-ofuscado/README.md) | **English**

**MITRE ATT&CK tactic:** Execution and Defense Evasion
**ID:** T1059.001, T1027
**Expected severity:** High
**Needs admin:** No
**Destructive:** No

## What it is for, from the attacker point of view

PowerShell is a very powerful automation tool that already ships with Windows. The attacker uses it to run commands, but hides what they are doing. They turn the command into scrambled text, in Base64 format, run it with the window hidden and without loading the profile, to leave no traces.

## Why it is dangerous

Obfuscation is meant to fool whoever reads the logs and the security filters that look for obvious words, such as download or invoke. A command that looks like a pile of random letters may, in fact, be downloading a virus. It is one of the most common forms of disguised execution.

## Analogy

It is like sending a note written in code, in tiny handwriting, slipped under the door, with the light off. Whoever passes by understands nothing, but the recipient, the computer, decodes it and obeys.

## What the script does

Runs PowerShell with the typical attack parameters, NoProfile, NonInteractive, WindowStyle Hidden and EncodedCommand. The scrambled command, for safety, only runs the harmless whoami, but the disguise pattern is identical to a real attack.

## Example command

```powershell
powershell.exe -NoP -NonI -W Hidden -Enc dwBoAG8AYQBtAGkA
```

The value dwBoAG8AYQBtAGkA is just the text whoami encoded in Base64. What triggers the alert is the combination of suspicious parameters, not what the command does.

## What the EDR should detect

* Use of EncodedCommand or Enc combined with a hidden window.
* A command line with obfuscated content, in Base64.
* Classification as suspicious or obfuscated execution, T1059.001 plus T1027.

## Prerequisites

* No special privilege.

## Cleanup

* Nothing to clean. The test does not change the system.
