# 12. Administrator Account Creation

[Portugues](../../12-criacao-conta-admin/README.md) | **English**

**MITRE ATT&CK tactic:** Persistence and Privilege Escalation
**ID:** T1136.001, Create Account
**Expected severity:** High
**Needs admin:** Yes
**Destructive:** Reversible

## What it is for, from the attacker point of view

Instead of relying on stealing passwords, the attacker simply creates their own account on the machine and puts it in the Administrators group. That way they have legitimate and permanent access, with a name that looks harmless, for example suporte_ti, backup or svc_update.

## Why it is dangerous

It is a form of persistence that is very hard to notice. The new account blends in with the real company accounts. The intruder can come back whenever they want, as an administrator, without needing any exploitation. Many attacks go unnoticed for weeks because of an account like this.

## Analogy

The intruder registers themselves as an employee in the HR system and issues a manager badge. Now they walk in through the front door, greet security and no one questions them.

## What the script does

1. Creates a local user called suporte_ti.
2. Adds that user to the Administrators group.
3. Removes the account at the end, doing the reversal.

In a domain, the equivalent would be net user add domain and net group Domain Admins. Here we use a local account to keep the test contained.

## Example commands

```cmd
net user suporte_ti Senha@Forte123 /add
net localgroup administrators suporte_ti /add
```

## What the EDR should detect

* Account creation from the command line and inclusion in the administrators group.
* Classification as Create Account, T1136.001, high severity.

## Prerequisites

* Administrator.

## Cleanup

```cmd
net localgroup administrators suporte_ti /delete
net user suporte_ti /delete
```
