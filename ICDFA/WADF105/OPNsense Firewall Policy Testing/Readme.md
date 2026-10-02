# 🛡️ OPNsense Firewall Policy Testing, Logging & Packet Analysis
> **Practical Lab 02 — WADF105: Network Security Fundamentals**  
> **Author:** Muhammad Haseeb | Cybersecurity & Digital Forensics Fellow (ICDFA)

![OPNsense](https://img.shields.io/badge/Firewall-OPNsense_24.x-orange?style=for-the-badge&logo=opnsense)
![Ubuntu](https://img.shields.io/badge/OS-Ubuntu_Linux-E95420?style=for-the-badge&logo=ubuntu)
![Wireshark](https://img.shields.io/badge/Tool-Wireshark-167DAA?style=for-the-badge&logo=wireshark)
![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)

---

## 📋 Table of Contents
- [Executive Summary](#-executive-summary)
- [Network Topology & Architecture](#-network-topology--architecture)
- [Firewall Rule Matrix & Logic](#-firewall-rule-matrix--logic)
- [Methodology & Test Execution](#-methodology--test-execution)
- [Wireshark & State Analysis](#-wireshark--state-analysis)
- [Evidence Inventory](#-evidence-inventory)
- [Key Technical Takeaways](#-key-technical-takeaways)
- [Lab Restoration](#-lab-restoration)

---

## 📌 Executive Summary
This project details the controlled implementation and validation of stateful firewall policies within an isolated security laboratory environment. Using an **OPNsense** virtual gateway and an **Ubuntu** endpoint, custom security rules were deployed to enforce granular traffic filtering. 

The primary objectives achieved include:
1. Demonstrating sequential **top-down rule processing** (first-match evaluation).
2. Enforcing targeted layer-3 (ICMP) and layer-4 (TCP Port 80) block rules without disrupting core services (DNS/HTTPS).
3. Correlating blocked traffic against **OPNsense Live View** logs and **Wireshark** packet captures.
4. Analyzing state table dynamics and automatic outbound NAT behavior.

---

## 📐 Network Topology & Architecture

The deployment consists of two primary virtual nodes connected over an isolated virtual network (`ICDFA-LAN`), routed through an OPNsense firewall to an external NAT network.

```text
                    ┌───────────────────────────────┐
                    │        EXTERNAL / WAN         │
                    │        DHCP / NAT Network     │
                    └───────────────┬───────────────┘
                                    │
                                    │ WAN
                                    ▼
             ┌──────────────────────────────────────────┐
             │        🔥 ICDFA NSLAB FIREWALL           │
             │            OPNsense Firewall             │
             │                                          │
             │  WebGUI: https://10.10.10.1              │
             │  LAN:    10.10.10.1/24                   │
             └───────────────────┬──────────────────────┘
                                 │
                                 │ LAN
                                 ▼
              ╔════════════════════════════════════════╗
              ║             ICDFA-LAN                  ║
              ║          10.10.10.0/24                 ║
              ╚════════════════════╤═══════════════════╝
                                   │
                                   │
                                   ▼
             ┌──────────────────────────────────────────┐
             │       🖥️ ICDFA NSLAB CLIENT              │
             │          Ubuntu Workstation              │
             │                                          │
             │  Host: icdfa-nslab-client-v1             │
             │  IP:   10.10.10.x                        │
             └──────────────────────────────────────────┘
                                     v
               +--------------------------------------------+
               |         icdfa-nslab-client-v1              |
               |          (Ubuntu Workstation)              |
               |          IP Address: 10.10.10.x            |
               +--------------------------------------------+
