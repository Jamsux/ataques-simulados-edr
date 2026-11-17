# 12. Criacao de Conta de Administrador

[English](../en/12-criacao-conta-admin/README.md) | **Portugues**

**Tatica MITRE ATT&CK:** Persistence e Privilege Escalation
**ID:** T1136.001, Create Account
**Severidade esperada:** Alta
**Precisa de admin:** Sim
**Destrutivo:** Reversivel

## Para que serve, na visao do atacante

Em vez de depender de roubar senhas, o atacante simplesmente cria a propria conta na maquina e a coloca no grupo Administradores. Assim ele tem um acesso legitimo e permanente, com um nome que parece inofensivo, por exemplo suporte_ti, backup ou svc_update.

## Por que e perigoso

E uma forma de persistencia muito dificil de notar. A conta nova se mistura as contas reais da empresa. O invasor pode voltar quando quiser, como administrador, sem precisar de exploracao nenhuma. Muitos ataques passam despercebidos por semanas por causa de uma conta assim.

## Analogia

O invasor cadastra a si mesmo como funcionario no sistema do RH e emite um cracha de gerente. Agora ele entra pela porta da frente, cumprimenta a seguranca e ninguem questiona.

## O que o script faz

1. Cria um usuario local chamado suporte_ti.
2. Adiciona esse usuario ao grupo Administradores.
3. Remove a conta ao final, fazendo a reversao.

Em dominio, o equivalente seria net user add domain e net group Domain Admins. Aqui usamos conta local para manter o teste contido.

## Exemplo dos comandos

```cmd
net user suporte_ti Senha@Forte123 /add
net localgroup administrators suporte_ti /add
```

## O que o EDR deve detectar

* Criacao de conta por linha de comando e inclusao no grupo de administradores.
* Classificacao como Create Account, T1136.001, severidade alta.

## Pre requisitos

* Administrador.

## Limpeza

```cmd
net localgroup administrators suporte_ti /delete
net user suporte_ti /delete
```
