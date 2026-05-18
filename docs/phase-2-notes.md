# Phase 2 — Active Directory Core

## Status
✅ Complete

## What was built
- WS2022-Golden image (clean Windows Server 2022 Standard Desktop, patched, with VMware Tools)
- DC01 — primary domain controller at 10.50.2.11
- DC02 — secondary domain controller at 10.50.2.12
- joe.lab forest at functional level Windows Server 2016 (WinThreshold)
- NetBIOS domain: JOE
- DNS integrated, AD-replicated
- DHCP server on DC01 for USERS scope (10.50.3.100-200) via pfSense DHCP relay
- OU structure matching enterprise convention (AGDLP-ready)
- LAB-Baseline-Computers GPO with password policy, audit policy, screen lock
- AD Recycle Bin enabled

## OU structure

joe.lab
├── _Admin
├── _Servers
│   ├── File
│   ├── Mail
│   ├── Web
│   └── Security
├── _Workstations
│   └── HQ
├── _Users
│   ├── Employees
│   │   ├── Finance
│   │   ├── HR
│   │   ├── Sales
│   │   └── Engineering
│   ├── Contractors
│   └── ServiceAccounts
└── _Groups
├── Role
├── Resource
└── App

## Baseline GPO settings
- Password: 14 char min, 90 day max age, history 24
- Lockout: 5 attempts, 15 min duration
- Audit policy: comprehensive logon/account/policy change auditing
- Screen lock: 10 min timeout, password-protected
- Windows Firewall: enabled all profiles, inbound block, outbound allow

## FSMO roles
- All five held by DC01 (default state)
- Practiced transfer to DC02 and back — operationally tested

## DNS
- DC01 and DC02 run AD-integrated DNS
- DC01 DNS: 127.0.0.1, 10.50.2.12
- DC02 DNS: 127.0.0.1, 10.50.2.11
- pfSense forwards joe.lab queries to 10.50.2.11

## DHCP
- DC01 serves DHCP for USERS scope 10.50.3.100-200
- pfSense relays USERS DHCP requests to 10.50.2.11
- pfSense DHCP disabled on USERS interface

## Verification done
- Get-ADDomain ✓
- Get-ADForest ✓
- Get-ADDomainController shows both ✓
- repadmin /replsummary shows zero failures ✓
- dcdiag /v passes ✓
- FSMO transfer DC01→DC02→DC01 ✓
- nslookup dc01.joe.lab from management host ✓

## Snapshots
- WS2022-Golden: 01-golden-clean
- DC01: 01-renamed-static-ip, 02-ad-ds-installed, 03-baseline-gpo, 04-phase2-complete
- DC02: 01-dc-promoted, 02-phase2-complete

## Next
Phase 3 — Windows 11 client, Linux client, join to domain, Intune/Entra hybrid identity