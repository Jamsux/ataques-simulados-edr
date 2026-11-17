# 09. Shadow Copy Deletion (ransomware behavior)

[Portugues](../../09-exclusao-shadow-copies/README.md) | **English**

**MITRE ATT&CK tactic:** Impact
**ID:** T1490, Inhibit System Recovery
**Expected severity:** Critical
**Needs admin:** Yes
**Destructive:** YES

## Warning, this test is destructive

It deletes the shadow copies of the machine, which are the Windows restore points. Only run it on a VM with a recent snapshot. After the test, restore the snapshot if you want the points back.

## What it is for, from the attacker point of view

Before encrypting the files, ransomware deletes the Windows shadow copies. Those copies would let the victim recover the files without paying. By destroying them, the attacker removes the victim plan B.

## Why it is dangerous

It is the move that makes ransomware devastating. Without the shadow copies, and without an external backup, there is no way back. Either you pay the ransom, or you lose the data. Detecting the vssadmin delete shadows command is one of the most urgent signs of a ransomware attack in progress.

## Analogy

Before setting fire to the documents, the criminal also destroys the backup copy that was in the safe. That way, no path is left to rebuild what was lost.

## What the script does

1. Asks for explicit confirmation, typing the word APAGAR, which means delete.
2. Lists the existing shadow copies.
3. Runs vssadmin delete shadows, deleting all of them.

## Example command

```cmd
vssadmin delete shadows /all /quiet
```

Variations used by attackers, wmic shadowcopy delete and wbadmin delete catalog quiet.

## What the EDR should detect

* vssadmin deleting shadow copies, a classic ransomware signature.
* Classification as Inhibit System Recovery, T1490, critical severity.

## Prerequisites

* Administrator.
* A VM snapshot taken beforehand. The deleted copies do not come back via script.

## Cleanup

* There is no command to revert this. Restore the VM snapshot. Windows recreates shadow copies according to the System Protection configuration.
