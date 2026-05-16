
# Enterprise Lab

Building a complete enterprise-grade IT infrastructure from scratch on a single workstation.

## What this is

A portfolio project demonstrating end-to-end design and operation of a small enterprise IT environment, including:

- Segmented virtual network (firewall, VLANs, DMZ, isolated RED zone)
- Hybrid identity (Active Directory + Entra ID)
- Modern endpoint management (Intune, Autopilot)
- Full security stack (Wazuh SIEM, EDR, vulnerability scanning, NDR, DFIR)
- AI-controlled synthetic users (GHOSTS + local LLM via Ollama on RTX 4070)
- Backup, monitoring, ticketing, documentation
- Infrastructure as Code (Terraform, Ansible, Packer)
- Cloud integration (Oracle Cloud Always Free)

## Lab specs

- **Host:** AMD Ryzen 7 7800X3D, 32 GB DDR5, RTX 4070 12 GB, 1.82 TB NVMe
- **Hypervisor:** VMware Workstation Pro 17 (free for personal use)
- **Internal AD domain:** corp.joe.lab

## Architecture

![Network topology](diagrams/network-topology.png)

5-zone segmented network with stateful firewall enforcement:
- MGMT, SERVERS, USERS, DMZ, RED zones
- Default-deny on RED (attack lab isolation)
- AD ports only between USERS and SERVERS
- See [docs/network-plan.md](docs/network-plan.md) for full IP plan

## Current phase

🚧 Phase 0 complete — PC prepped, toolkit installed, ISOs staged. Starting Phase 1 (network).

## Phases

- [x] Phase 0 — PC prep, toolkit, repo
- [ ] Phase 1 — Network foundation (pfSense, VLANs, firewall)
- [ ] Phase 2 — Active Directory core (DC01, DC02)
- [ ] Phase 3 — Endpoints + Intune/Entra hybrid identity
- [ ] Phase 4 — File services + Veeam backup
- [ ] Phase 5 — BadBlood + GOAD-Light
- [ ] Phase 6 — Wazuh SIEM
- [ ] Phase 7 — Security stack expansion
- [ ] Phase 8 — GHOSTS AI synthetic users
- [ ] Phase 9 — Red team tooling
- [ ] Phase 10 — Operations layer (GLPI, BookStack)
- [ ] Phase 11 — Cloud integration (Oracle)
- [ ] Phase 12 — IaC & automation
- [ ] Phase 13 — Operational cadence