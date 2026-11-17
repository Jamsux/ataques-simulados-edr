# 15. Download via BitsAdmin (BITS Jobs)

[Portugues](../../15-download-bitsadmin/README.md) | **English**

**MITRE ATT&CK tactic:** Command and Control, Ingress Tool Transfer
**IDs:** T1197, T1105
**Expected severity:** High
**Needs admin:** No
**Destructive:** No

## What it is for, from the attacker point of view

BITS, short for Background Intelligent Transfer Service, is the Windows service that downloads updates in the background, slowly, using idle network. The attacker abuses that same service, through the bitsadmin tool, to download their next payload discreetly. The download is recorded as a legitimate system task, and it can even continue after a reboot.

## Why it is dangerous

It is an especially quiet LOLBin. Since Windows itself performs the download, through a trusted service and in the background, many defenses do not look closely. In addition, BITS is persistent, the transfer survives reboots and connection drops, which helps the attacker bring tools without raising a flag.

## Analogy

Instead of fetching the package themselves, the burglar uses the company own delivery service, which already comes and goes all day, to bring the tool from outside. No one finds one more routine delivery strange.

## What the script does

Uses bitsadmin to download a harmless text file, a public README from GitHub, into C:\temp. No malicious code is executed. The file is deleted at the end.

## Example command

```cmd
bitsadmin /transfer jobTeste /download /priority normal https://raw.githubusercontent.com/github/gitignore/main/README.md C:\temp\bits-teste.txt
```

Modern PowerShell equivalent, which the attacker also uses.

```powershell
Start-BitsTransfer -Source https://example.com/file.txt -Destination C:\temp\bits-teste.txt
```

## What the EDR should detect

* bitsadmin creating a transfer job and downloading from the internet.
* Use of the BITS service to bring files, pattern T1197.
* Classification as Ingress Tool Transfer, high severity.

## Prerequisites

* Internet access on the test VM.

## Cleanup

```cmd
del C:\temp\bits-teste.txt
```
