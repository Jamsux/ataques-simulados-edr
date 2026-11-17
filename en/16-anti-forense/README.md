# 16. Anti Forensics (erasing footprints)

[Portugues](../../16-anti-forense/README.md) | **English**

**MITRE ATT&CK tactic:** Defense Evasion
**IDs:** T1070, T1070.004, T1070.006
**Expected severity:** High
**Needs admin:** Yes
**Destructive:** YES, in part

This folder shows three anti forensics techniques. The first, changing timestamps, is harmless and runs on a test file. The other two delete the USN Journal and the Prefetch files, which do not come back. Only run it on a VM with a snapshot.

## What it is for, from the attacker point of view

Besides clearing the event logs, the attacker erases other traces that investigators use to reconstruct what happened. They change the dates of the files they created, so they do not stand out, and delete file system records that would show their activity.

## Why it is dangerous

Digital forensics relies on these traces to tell the story of the attack, when each file was created or changed and what was executed. By destroying these clues, the attacker delays or defeats the investigation, makes it harder to measure the damage and hides how they got in. Detecting the destruction of these artifacts is a strong sign of someone trying to hide.

## Analogy

After the robbery, the burglar wipes down everything they touched, swaps the date labels on the boxes they moved and burns the front desk logbook. Even if the theft is discovered, it becomes much harder to know how and when they acted.

## The three techniques shown

### Technique 1, Timestomp, changing dates (T1070.006)

Changes the creation and modification dates of a file, to disguise it. Harmless, runs on a test file.

```powershell
$f='C:\temp\timestomp-teste.txt'
(Get-Item $f).LastWriteTime='01/01/2010 08:00'
(Get-Item $f).CreationTime='01/01/2010 08:00'
```

### Technique 2, deleting the Prefetch (T1070.004)

The Prefetch stores evidence of which programs were run. Deleting it removes that trail. Destructive.

```cmd
del /q /f C:\Windows\Prefetch\*.pf
```

### Technique 3, deleting the USN Journal (T1070)

The USN Journal is the file system change diary. Deleting it removes the history of changes. Destructive.

```cmd
fsutil usn deletejournal /d C:
```

## What the EDR should detect

* Suspicious change of file dates, timestomping.
* Mass deletion of the Prefetch.
* Deletion of the USN Journal via fsutil.
* Classification as Indicator Removal, Defense Evasion, high severity.

## Prerequisites

* Administrator.
* A VM snapshot. The deleted Prefetch and USN Journal do not come back via script.

## Cleanup

* Technique 1 creates and deletes a test file, with no lasting effect.
* For techniques 2 and 3 there is no command to revert. Windows rebuilds the Prefetch and the USN Journal with use. For the previous state, restore the snapshot.
