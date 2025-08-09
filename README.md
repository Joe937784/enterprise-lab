# Enterprise Lab
**Goal:** pfSense + AD/DC + File Server + VPN + Win/Linux clients.

## Topology
- WAN ↔ pfSense ↔ LAN (DC, File Server, Clients)

## Milestones
1) pfSense install & LAN/DHCP ✓
2) AD/DC promote & DNS
3) GPOs (passwords, wallpaper)
4) File shares & NTFS perms
5) VPN access
6) Linux/Windows clients join

## How to Reproduce
- Hypervisor: VMware Workstation
- ISOs: pfSense, Windows Server, Windows Client, Ubuntu
- Network: NAT + Host-only (pfSense bridges)
