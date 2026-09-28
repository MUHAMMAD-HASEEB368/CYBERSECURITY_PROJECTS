# Lab 01: Virtual Lab Commissioning & Network Validation

## 📋 Overview
This repository documents the commissioning, initial configuration, and network validation of the multi-homed virtual enterprise architecture for **WADF105**. The objective of this lab is to establish a fully functional, segmented virtual network using Oracle VM VirtualBox, verify layer-2/layer-3 connectivity across subnets, and create baseline snapshots for subsequent security and digital forensics exercises.

---

## 🛠️ Infrastructure & System Architecture

The laboratory deployment consists of four distinct Virtual Machine (VM) nodes mapped across dedicated VirtualBox Internal Networks and a NAT Uplink:

| VM Name | System Role | Interface | Assigned IP Address | Network Segment | MAC Addressing |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **`icdfa-nslab-client-v1`** | Internal Workstation | Adapter 1 | `10.10.10.2/24` | `ICDFA-LAN` | Unique Generated |
| **`icdfa-nslab-firewall-v1`** | OPNsense Security Gateway | Adapter 1 (LAN)<br>Adapter 2 (DMZ)<br>Adapter 3 (WAN) | `10.10.10.1/24`<br>`10.10.20.1/24`<br>`172.16.100.2/24` | `ICDFA-LAN`<br>`ICDFA-DMZ`<br>`ICDFA-TRANSIT` | Unique Generated |
| **`icdfa-nslab-dmz-v1`** | Web & DNS Server | Adapter 1 | `10.10.20.10/24` | `ICDFA-DMZ` | Unique Generated |
| **`icdfa-nslab-vrouter-v1`** | Boundary Transit Router | Adapter 1 (WAN)<br>Adapter 2 (Transit) | `10.250.0.1/24`<br>`172.16.100.1/24` | `ICDFA-UPLINK`<br>`ICDFA-TRANSIT` | Unique Generated |

---

## 🔑 Key Execution & Validation Steps

### 1. Adapter Isolation & MAC Collision Prevention
- Mapped discrete VirtualBox Internal Networks (`ICDFA-LAN`, `ICDFA-DMZ`, `ICDFA-TRANSIT`) and NAT Network (`ICDFA-UPLINK`).
- Re-generated and verified unique MAC addresses across all virtual adapters to prevent ARP collisions and Ethernet frame misdirection.

### 2. Network Diagnostics & Routing Verification
- Verified active IPv4 configurations and default gateway parameters using `ip -4 -br address` and `ip route`.
- Confirmed core service routing, ICMP connectivity, and OPNsense gateway administration via console interface output.

### 3. Baseline Recovery Snapshots
- Following complete validation of all network segments, clean power-down sequences were executed.
- Created `LAB-BASELINE-VALIDATED` snapshots across all four virtual machines to serve as a known-good recovery baseline for future attack/defense simulations.

---

## 📸 Lab Evidence & Deliverables

- **Evidence Report:** Full PDF report containing interface tables, diagnostic outputs, and technical responses.
- **Verification Outputs:** Console/Terminal verification metrics capturing active IP assignments and interface status.
- **Baseline Snapshot:** `LAB-BASELINE-VALIDATED` configuration saved across VirtualBox Manager.

---

## 👤 Author & Course Details

- **Author:** Muhammad Haseeb
- **Course Code:** WADF105 - Network Security Fundamentals
- **Program:** Fellowship in Cybersecurity and Digital Forensics (ICDFA)
