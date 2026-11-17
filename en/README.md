# Simulated Attacks for EDR Validation

[Portugues](../README.md) | **English**

A hands on, beginner friendly lab to validate EDR detection using only tools that ship natively with Windows (the so called LOLBins, or Living Off the Land Binaries).

Although these examples started from a test with WithSecure Elements, nothing here depends on a specific vendor. The same techniques work to validate any EDR or next generation antivirus product (CrowdStrike, SentinelOne, Microsoft Defender for Endpoint, Sophos, TrendMicro, Cortex XDR and others). Wherever the text says "your EDR", read the product you are validating.

The idea is simple. Simulate the behavior of a real attacker, in a controlled way and without causing harm, to confirm that the EDR:

1. Detects the activity.
2. Shows quality telemetry, that is, parent process, child process, full command line and user.
3. Classifies the severity correctly.
4. Maps it to MITRE ATT&CK.

Each technique has its own folder, with a README explained for beginners and a ready to run .bat script.

Note about the scripts. The .bat scripts live in the folders at the repository root and are shared by both languages. This English folder contains only the translated documentation. Each page below links to the matching script at the root.

## Important notice, read before anything else

* Use only on an isolated lab machine, a throwaway VM, with no access to the production network.
* You must have formal authorization to run these tests.
* Never run this on a production, personal or third party computer.
* Be ready to revert everything. Each folder explains how to clean up what it created.

Read the [LEGAL.md](LEGAL.md) file in full. By using this material, you agree to it.

## What is an EDR, for the beginner analyst

EDR stands for Endpoint Detection and Response.

Think of traditional antivirus as a doorkeeper who checks a list of mugshots of known criminals, the so called signatures. If the face is not on the list, it lets the person through.

An EDR is a detective who does not look only at the face. It watches behavior. Why did Word open PowerShell, which downloaded a file from the internet and tried to read the password memory at 3 in the morning? Even without ever having seen that file, the behavior gives the attack away.

This repository produces exactly these suspicious behaviors, without the truly dangerous part, so you can check whether the detective is awake.

## Lab prerequisites

| Item | Detail |
|------|--------|
| Test machine | Windows 10 or 11 in an isolated VM. Take a snapshot before you start |
| Installed agent | The EDR you want to validate, active and reporting to the console |
| Privilege | Some tests need an Administrator prompt, noted in each folder |
| Attacker machine | Only for the reverse shell test, folder 06. A server or VM with a listener |

Tip. Take a snapshot of the VM before you start. That way, if something gets messy, you return to the clean state in seconds.

## How to use

1. Open the folder of the technique you want to test.
2. Read its README, which explains the risk and what will happen.
3. Right click the .bat script at the repository root and choose Run as administrator, when indicated.
4. Go to your EDR console and confirm the alert showed up.
5. Run the cleanup described in the technique README.

Shortcuts in the _scripts folder at the root:

* executar-todos.bat runs all techniques in sequence, with a pause between them.
* limpar-tudo.bat undoes the changes made by the tests.

## Index of techniques

| Num | Technique | Tactic (MITRE) | ID | Severity | Admin | Destructive |
|-----|-----------|----------------|----|----------|:-----:|:-----------:|
| 01 | [Credential dumping (LSASS)](01-coleta-credenciais-lsass/) | Credential Access | T1003.001 | Critical | Yes | No |
| 02 | [Obfuscated PowerShell](02-powershell-ofuscado/) | Execution and Defense Evasion | T1059.001, T1027 | High | No | No |
| 03 | [Environment discovery](03-reconhecimento-ambiente/) | Discovery | T1082, T1087 | Medium | No | No |
| 04 | [Persistence (Run and Scheduler)](04-persistencia-run-e-agendador/) | Persistence | T1547.001, T1053.005 | High | Partial | No |
| 05 | [Download via certutil](05-download-via-certutil/) | Command and Control | T1105 | High | No | No |
| 06 | [Reverse shell](06-shell-reversa/) | Command and Control | T1059.001 | Critical | No | No |
| 07 | [Disable or evade the antivirus](07-evasao-desativar-defender/) | Defense Evasion | T1562.001 | High | Yes | Reversible |
| 08 | [UAC bypass (fodhelper)](08-bypass-uac-fodhelper/) | Privilege Escalation | T1548.002 | High | No | No |
| 09 | [Shadow Copy deletion](09-exclusao-shadow-copies/) | Impact (ransomware) | T1490 | Critical | Yes | YES |
| 10 | [Clear event logs](10-limpar-logs-eventos/) | Defense Evasion | T1070.001 | High | Yes | YES |
| 11 | [Execution via mshta](11-execucao-mshta/) | Defense Evasion and Execution | T1218.005 | High | No | No |
| 12 | [Admin account creation](12-criacao-conta-admin/) | Persistence and Priv. Esc. | T1136.001 | High | Yes | Reversible |

Warning. Techniques 09 and 10 make destructive changes, they delete restore points or logs. They are safe on a VM with a snapshot, but read the README first.

## Why these techniques

They cover the main tactics of a real attack chain, the so called kill chain, so you validate the EDR end to end:

```
Execution  >  Evasion  >  Escalation  >  Credential  >  Discovery  >  Persistence  >  Command and  >  Impact
of code      of defense   of privilege   access                      keep access     Control          damage
 02,11        07,10        08            01            03             04,12           05,06            09
```

If your EDR catches all of them, it is seeing the attack at every stage, not only at the beginning or the end.

## License and responsibility

Material strictly for education and authorized testing. See [LEGAL.md](LEGAL.md). The author is not responsible for misuse. Licensed under the MIT License, see [LICENSE](../LICENSE).
