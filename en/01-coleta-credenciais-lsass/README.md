# 01. Credential Dumping (LSASS dump)

[Portugues](../../01-coleta-credenciais-lsass/README.md) | **English**

**MITRE ATT&CK tactic:** Credential Access
**ID:** T1003.001
**Expected severity:** Critical
**Needs admin:** Yes
**Destructive:** No

## What it is for, from the attacker point of view

Windows keeps, in the memory of a process called lsass.exe (Local Security Authority Subsystem Service), the passwords and credentials of whoever is logged in on the machine. The attacker copies that memory to a file and later, with offline tools, extracts passwords, hashes and access tickets.

With that, they can impersonate other users, including administrators.

## Why it is dangerous

This is the most valuable moment of many attacks. With valid credentials in hand, the intruder stops looking like an intruder and starts acting like a legitimate employee. They can hop from one machine to another across the network, in what is called lateral movement, without setting off obvious alarms, reaching servers and domain controllers.

## Analogy

Imagine that all the company keys hang on a board inside a room. lsass.exe is that board. The attacker takes a photo of the whole board and leaves calmly. Later, at home, they copy each key at leisure.

## What the script does

1. Finds the identification number, the PID, of the lsass.exe process.
2. Uses the native tool rundll32.exe with the comsvcs.dll library, both from Windows, to generate a memory file with the .dmp extension of LSASS.

The generated file is just a memory copy, created for the test. It is not sent anywhere and is deleted during cleanup.

## Example command

```cmd
rundll32.exe C:\Windows\System32\comsvcs.dll, MiniDump <LSASS_PID> C:\temp\lsass.dmp full
```

## What the EDR should detect

* Read access to the lsass.exe process by an unusual process, rundll32.exe.
* The classic credential dumping pattern.
* It should appear with critical severity and mapped as T1003.001.

## Prerequisites

* Command Prompt as Administrator.
* The C:\temp folder, which the script creates if it does not exist.

## Cleanup

```cmd
del C:\temp\lsass.dmp
```
