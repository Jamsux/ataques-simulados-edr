# 10. Clear Event Logs (anti forensics)

[Portugues](../../10-limpar-logs-eventos/README.md) | **English**

**MITRE ATT&CK tactic:** Defense Evasion
**ID:** T1070.001, Clear Windows Event Logs
**Expected severity:** High
**Needs admin:** Yes
**Destructive:** YES

## Warning, this test is destructive

It deletes Windows log records, for example Security and System. These records do not come back. Only run it on a VM with a snapshot and, preferably, clear a less critical log for the demonstration.

## What it is for, from the attacker point of view

After acting, the attacker wants to erase the footprints. The Windows event logs record logins, executions and changes. By clearing these records, they make the investigation harder. The security team loses the camera tape of that period.

## Why it is dangerous

It is an anti forensics technique. It destroys the evidence that would let you understand what happened, when and how. Even if the attack is discovered, without logs it is much harder to measure the damage and close the door that was used. For that reason, the very act of clearing logs should raise a high alert.

## Analogy

The burglar, on the way out, takes the tape, or erases the recording, from the security cameras. The crime may be noticed, but no one can reconstruct exactly what they did.

## What the script does

1. Asks for explicit confirmation, typing the word LIMPAR, which means clear.
2. For safety, by default it clears a non essential log, the Windows PowerShell log, to raise the alert without destroying the Security log.
3. Shows, as text only, the command that would clear the Security log. Use it only if you really need to.

## Example commands

```cmd
wevtutil cl "Windows PowerShell"
```

More aggressive, it wipes the security trail, use with care.

```cmd
wevtutil cl Security
```

## What the EDR should detect

* wevtutil clearing event logs, an anti forensics technique.
* Classification as Clear Windows Event Logs, T1070.001, high severity.

## Prerequisites

* Administrator.
* A VM snapshot. The deleted logs do not come back.

## Cleanup

* There is no command to revert this. The logs grow again with use. For the previous state, restore the snapshot.
