# Phase 1 — Network Foundation

## Status
✅ Complete

## Final architecture
- pfSense CE 2.8.1 firewall (2 vCPU, 2 GB RAM, 20 GB ZFS disk)
- 6 virtual NICs across WAN + 5 internal zones
- VMware host adapter on MGMT VMnet for management access

## Interface mapping
| Zone | pfSense Label | em# | VMnet | Subnet | DHCP |
|------|--------------|-----|-------|--------|------|
| WAN | WAN | em0 | VMnet10 (Bridged) | 192.168.2.x | DHCP from home router |
| MGMT | LAN (renamed MGMT) | em5 | VMnet5 (Host-only, host-connected) | 10.50.1.0/24 | .100-.200 |
| SERVERS | OPT1 (renamed SERVERS) | em2 | VMnet2 | 10.50.2.0/24 | None (static only) |
| USERS | OPT2 (renamed USERS) | em1 | VMnet3 | 10.50.3.0/24 | .100-.200 |
| DMZ | OPT3 (renamed DMZ) | em3 | VMnet4 | 10.50.4.0/24 | None (servers only) |
| RED | OPT4 (renamed RED) | em4 | VMnet12 | 10.66.66.0/24 | None (manual only) |

## Design decisions
- Made MGMT the LAN interface — anti-lockout rule lives on management network (best practice vs. on user network)
- DMZ has no DHCP — only static servers (Mailcow, Nextcloud) live there
- RED zone fully isolated — no DHCP, default-deny firewall, host adapter NOT connected
- Used aliases (AD_Ports, Web_Ports) for clean rule management
- DNS resolver in forwarding mode to upstream (1.1.1.1, 9.9.9.9) — will switch to forward-to-DC after Phase 2

## Firewall rules
| Interface | Direction | Action |
|-----------|-----------|--------|
| MGMT | → any | Allow (privileged) |
| SERVERS | → any | Allow (updates, replication) |
| USERS | → SERVERS:AD_Ports | Allow TCP+UDP |
| USERS | → DMZ:Web_Ports | Allow |
| USERS | → internet:Web_Ports | Allow |
| DMZ | → 10.50.0.0/16 | Block |
| DMZ | → internet | Allow |
| RED | → any | Block (default-deny) |

## Suricata IDS
- Installed and running on WAN
- Ruleset: ETOpen Emerging Threats
- Alerts logged to system log
- Will tune rule categories in later phases

## Backups
- VMware snapshot: `02-phase1-complete`
- pfSense config (encrypted XML): `pfsense/config-backups/pfsense-config-phase1.xml`

## Connectivity tests passed
- WAN → 1.1.1.1: ✓
- MGMT → SERVERS interface: ✓
- DNS lookup of google.com: ✓
- Host browser → https://10.50.1.1: ✓ (anti-lockout rule on MGMT)

## Next
Phase 2 — Build DC01 (Server 2022 Core) on SERVERS VLAN at 10.50.2.11