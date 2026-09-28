# 🦈 Lab 02: TCP/IP, Ethernet, ARP & Wireshark Traffic Analysis

<p align="center">
  <img src="https://img.shields.io/badge/Course-WADF105-blue?style=for-the-badge&logo=openaccess" alt="Course">
  <img src="https://img.shields.io/badge/Lab%20Status-Completed%20%E2%9C%85-success?style=for-the-badge" alt="Status">
  <img src="https://img.shields.io/badge/Platform-Wireshark%204.x-1679A7?style=for-the-badge&logo=wireshark&logoColor=white" alt="Wireshark">
  <img src="https://img.shields.io/badge/Hypervisor-VirtualBox-183A61?style=for-the-badge&logo=virtualbox&logoColor=white" alt="VirtualBox">
</p>

---

## 📋 Executive Overview
This laboratory exercise focuses on deep packet analysis and layer-2/layer-3 traffic dissection within the multi-homed **ICDFA** virtual laboratory environment. Instead of relying solely on high-level connectivity testing tools like `ping`, this analysis utilizes **Wireshark** to capture, filter, and inspect Ethernet frames, ARP exchanges, ICMP headers, DNS queries, and TCP connection establishment workflows.

The primary objective is to demonstrate how local hosts discover gateways via address resolution protocol (ARP), analyze the structural differences between data link layer (MAC) addressing and network layer (IP) routing, and save complete packet captures for compliance and forensic auditing.

---

## 🎨 Network Architecture & Segment Map

```text
[ ICDFA-LAN Subnet: 10.10.10.0/24 ]
├── Client Workstation  (icdfa-nslab-client-v1)   : 10.10.10.102/24 | MAC: 08:00:27:35:d0:7a
└── OPNsense Gateway    (icdfa-nslab-firewall-v1) : 10.10.10.1/24   | MAC: 08:00:27:4b:3c:58
      │
      ├── [ Layer 2 Discovery ] ──► ARP Request/Reply (Gateway MAC Resolution)
      └── [ Layer 3 Routing   ] ──► Traffic Directed to Remote Subnets
            │
            ▼
[ ICDFA-DMZ Subnet: 10.10.20.0/24 ]
└── DMZ Web/DNS Server  (icdfa-nslab-dmz-v1)      : 10.10.20.10/24  | MAC: Gateway Routed
