# 03. Environment Discovery

[Portugues](../../03-reconhecimento-ambiente/README.md) | **English**

**MITRE ATT&CK tactic:** Discovery
**IDs:** T1082, T1087, T1016, T1018, T1033
**Expected severity:** Medium
**Needs admin:** No
**Destructive:** No

## What it is for, from the attacker point of view

As soon as they land on a machine, the attacker does not know where they are. They fire off a burst of enumeration commands to answer. Who am I? Am I admin? What is the network? What other computers and servers exist? Who else is logged in?

## Why it is dangerous

On its own, discovery causes no harm, but it is the treasure map. With these answers, the intruder decides where to move and what is worth stealing. Every serious operation starts here. Detecting this phase early lets you stop the attack before the damage.

## Analogy

It is the burglar who, as soon as they enter the house, turns on the lights in every room and walks around looking for where the safe, the jewels and the back exit are, before taking anything.

## What the script does

Runs, in quick succession, several native enumeration commands. It is precisely the burst pattern, many discovery commands within seconds, that the EDR recognizes as suspicious.

## Example commands

```cmd
whoami /all
net user
net localgroup administrators
systeminfo
ipconfig /all
net view
arp -a
nltest /dclist:
```

## What the EDR should detect

* A sequence of discovery commands in a short interval, a behavioral detection.
* Use of whoami, net, nltest and systeminfo in a burst.
* Classification as reconnaissance or discovery, medium severity.

## Prerequisites

* No special privilege.

## Cleanup

* Nothing to clean. Only reading of information.
