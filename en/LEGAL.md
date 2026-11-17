# Legal Notice and Responsibility

[Portugues](../AVISO-LEGAL.md) | **English**

## Purpose

This repository exists solely for educational purposes and for the authorized validation of security tools, such as EDR and antivirus, in controlled lab environments.

The goal is defensive. To help IT and security analysts prove that their detection tools work, by understanding how certain behaviors appear, or not, in the EDR console.

## Authorized use

You may only use this material if all of the conditions below are true:

* You have explicit written permission to test the machine or machines involved.
* The tests run on an isolated lab machine that you control.
* No production or third party network, system or data is affected.

## Prohibited use

It is expressly prohibited to use this material to:

* Attack, break into or compromise systems without authorization.
* Access, steal or destroy third party data.
* Any illegal activity.

Accessing computer systems without authorization is a crime. In Brazil, for example, Law number 12,737 of 2012, known as the Carolina Dieckmann Law, and Law number 14,155 of 2021, among others. Similar laws exist in most countries, such as the Computer Fraud and Abuse Act in the United States and the Computer Misuse Act in the United Kingdom.

## Nature of the scripts

The scripts were written to generate telemetry and alerts safely:

* They contain no real malware.
* They do not exfiltrate real data.
* They use harmless payloads, for example opening the calculator or printing text.

Even so, some techniques make real changes to the system, such as persistence, deletion of shadow copies, clearing of logs and account creation. For that reason, always take a snapshot of the VM beforehand and use the cleanup routines.

## Disclaimer

This material is provided as is, without warranties. The author and contributors are not responsible for any damage, data loss or consequence arising from the use, authorized or not, of this content. The responsibility lies entirely with whoever runs it.

By using any part of this repository, you declare that you have read, understood and agreed to this notice.
