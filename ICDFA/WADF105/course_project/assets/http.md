# 🔒 Opening a Secure Website: Tracing HTTPS Communication Using the TCP/IP Model

> **A University Cybersecurity & Computer Networking Project**

---

## 📖 Short Project Overview & Introduction

When a user opens a web browser and types `https://example.com`, a complex multi-layered networking protocol exchange occurs in milliseconds before any webpage is displayed. 

This project provides a comprehensive visual and technical breakdown of how **HTTPS (Hypertext Transfer Protocol Secure)** operates across the **TCP/IP Model**. From domain name resolution to packet routing and TLS encryption, this project demonstrates how modern networks ensure confidentiality, integrity, and reliable data transmission across the global internet.

---

## 🎬 Video Sequence & Workflow Breakdown

The accompanying presentation/video traces the step-by-step lifecycle of an HTTPS web request across **6 distinct phases**:

### 1. Request Initiation (0–5 sec)
* **Action:** The student enters `https://example.com` into the web browser and hits **Enter**.
* **Concept:** Initiates a web transaction requiring host identification, connection establishment, and encryption.

### 2. DNS Resolution (5–12 sec)
* **Concept:** Human-readable domain names (`example.com`) cannot be directly routed across the IP network.
* **Process:** The browser queries the DNS resolver to translate `example.com` into a unique **IPv4/IPv6 address** (e.g., `93.184.216.34`).

### 3. TCP 3-Way Handshake (12–20 sec)
* **Concept:** Transport layer protocol (**TCP**) establishes a reliable, connection-oriented session between the client and the web server on **Port 443**.
* **Handshake Sequence:**
  1. `SYN` (Synchronize): Client requests a connection setup.
  2. `SYN-ACK` (Synchronize-Acknowledge): Server acknowledges and requests setup back.
  3. `ACK` (Acknowledge): Client confirms, completing the connection.

### 4. TLS/SSL Encryption (20–27 sec)
* **Concept:** Upgrading plain HTTP into secure **HTTPS**.
* **Process:** The client and server perform a **TLS Handshake** to exchange digital certificates, negotiate cipher suites, and generate symmetric session keys. All subsequent application data is encrypted.

### 5. TCP/IP Encapsulation (27–35 sec)
* **Concept:** Data flows down through the 4-layer TCP/IP stack, attaching headers at each stage:
  * **Application Layer:** Raw HTTP Request Data
  * **Transport Layer (TCP):** Adds Source/Destination Ports & Sequence Numbers $\rightarrow$ *TCP Segment*
  * **Internet Layer (IP):** Adds Source/Destination IP Addresses $\rightarrow$ *IP Packet*
  * **Link Layer (Ethernet/Wi-Fi):** Adds Source/Destination MAC Addresses $\rightarrow$ *Frame*

### 6. End-to-End Packet Routing & Response (35–45 sec)
* **Path:** `Laptop` $\rightarrow$ `Local Router (Default Gateway)` $\rightarrow$ `ISP Core Network` $\rightarrow$ `Internet Edge Routers` $\rightarrow$ `Web Server`.
* **Response:** The web server receives the encrypted packet, decapsulates it, processes the HTTP GET request, and sends back the encrypted HTML response along the same route.

---

## 🎯 Key Takeaway & Summary

1. **DNS** locates the physical server address.
2. **TCP** establishes a reliable, error-checked connection (3-Way Handshake).
3. **TLS** encrypts the channel to ensure data security and privacy.
4. **IP** routes the data packets through interconnected networks.
5. **TCP/IP Layers** work together harmoniously to safely deliver the requested webpage.

---

## 🛠️ Concepts & Protocols Covered

* **Protocols:** HTTPS, HTTP, DNS, TCP, IP, TLS/SSL, Ethernet.
* **Ports:** Port 443 (HTTPS), Port 53 (DNS), Port 80 (HTTP).
* **Architecture:** TCP/IP 4-Layer Model vs. Client-Server Architecture.
* **Security Principles:** Encryption, Public Key Infrastructure (PKI), Handshake Negotiation.

---
