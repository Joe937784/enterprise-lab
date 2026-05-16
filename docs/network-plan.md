# Network IP Plan

## Lab overview
- **Host PC:** AMD Ryzen 7 7800X3D, 32 GB DDR5, RTX 4070
- **Hypervisor:** VMware Workstation Pro 17
- **Firewall:** pfSense CE 2.7.x
- **Internal AD domain:** joe.lab

## WAN side (real home network)
- Home router gateway: 192.168.2.1
- DHCP range: assigned by home router
- pfSense WAN IP: DHCP from 192.168.2.1

## Lab subnets

| Zone | Subnet | Gateway | DHCP | Purpose |
|---|---|---|---|---|
| MGMT | 10.50.1.0/24 | 10.50.1.1 | .100-.200 | Admin workstation, switch management IPs |
| SERVERS | 10.50.2.0/24 | 10.50.2.1 | none | Domain controllers, file server, SIEM |
| USERS | 10.50.3.0/24 | 10.50.3.1 | .100-.200 | Workstations, GHOSTS clients |
| DMZ | 10.50.4.0/24 | 10.50.4.1 | .100-.200 | Mail server, public-facing services |
| RED | 10.66.66.0/24 | 10.66.66.1 | none | Kali, GOAD — isolated attack lab |

## Server static IPs

| Device | IP | Zone | Purpose |
|---|---|---|---|
| DC01 | 10.50.2.11 | SERVERS | Primary DC, DNS, DHCP |
| DC02 | 10.50.2.12 | SERVERS | Secondary DC, DNS |
| FS01 | 10.50.2.20 | SERVERS | File server |
| Wazuh | 10.50.2.50 | SERVERS | SIEM manager |
| Mailcow | 10.50.4.50 | DMZ | Mail server |
| Nextcloud | 10.50.4.30 | DMZ | Self-hosted cloud |
| Kali | 10.66.66.10 | RED | Attack VM |
| GOAD-DC | 10.66.66.20 | RED | Vulnerable AD DC |
| GOAD-SRV | 10.66.66.21 | RED | Vulnerable AD member |
| GOAD-WS | 10.66.66.22 | RED | Vulnerable workstation |

## Firewall rule summary
- **MGMT** → any: allowed (privileged network)
- **SERVERS** → any: allowed (need internet for updates, AD replication)
- **USERS** → SERVERS: AD ports only (53, 88, 389, 445, 636, 3268)
- **USERS** → DMZ: web only (80, 443)
- **USERS** → internet: web only (80, 443)
- **DMZ** → internal: blocked
- **DMZ** → internet: allowed
- **RED** → all: blocked (default-deny — must explicitly enable for exercises)

## Notes
- pfSense will serve DHCP on MGMT, USERS, DMZ
- DC01 will serve DHCP on the USERS network after Phase 2 (Windows DHCP failover with DC02)
- DNS upstream: pfSense uses 1.1.1.1 and 9.9.9.9, internal lookups forwarded to DC01/DC02 once AD is up