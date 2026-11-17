# 05. Download via certutil (LOLBin)

[Portugues](../../05-download-via-certutil/README.md) | **English**

**MITRE ATT&CK tactic:** Command and Control, Ingress Tool Transfer
**ID:** T1105
**Expected severity:** High
**Needs admin:** No
**Destructive:** No

## What it is for, from the attacker point of view

After getting in with a small foothold, the attacker needs to bring the next stage from the internet, more tools and scripts. Instead of using a browser, which would draw attention, they use a legitimate program signed by Microsoft, certutil.exe, whose original job is to handle certificates, but which also knows how to download files.

## Why it is dangerous

This abuse of a trusted tool, called a LOLBin, from Living Off the Land Binary, makes the download pass dressed as innocent. Many defenses trust programs signed by Microsoft and do not suspect a certutil downloading something. It is like the malware walking in the front door, in a suit.

## Analogy

The burglar does not carry the break in tool themselves. They ask the mail carrier, whom everyone trusts, to deliver the package inside the house. The carrier, certutil, is honest. They are being used.

## What the script does

Uses certutil to download a harmless text file, a public README from GitHub, into C:\temp. No malicious code is executed. The point is only to demonstrate the download pattern via a LOLBin. The file is deleted at the end.

## Example command

```cmd
certutil.exe -urlcache -split -f https://raw.githubusercontent.com/github/gitignore/main/README.md C:\temp\teste-download.txt
```

## What the EDR should detect

* certutil.exe performing a download from the internet, an anomalous use.
* The Ingress Tool Transfer pattern, T1105.
* High severity, especially if followed by execution.

## Prerequisites

* Internet access on the test VM.

## Cleanup

```cmd
del C:\temp\teste-download.txt
```
