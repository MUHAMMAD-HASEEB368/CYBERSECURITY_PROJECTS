# 📝 Analysis Questions & Answers

**Lab:** WADF105 – Practical Laboratory 2: OPNsense Firewall Policy Testing, Logging and Packet Analysis

---

## Q1. Why must the specific block rules be placed above the broad allow rule?

> **Short answer:** Because OPNsense processes rules **top-down** and stops at the first match.

OPNsense checks firewall rules from top to bottom, and with **Quick** enabled the first matching rule decides the action. The `Default allow LAN to any` rule matches all outbound traffic. If it were placed above the block rules, every packet would match it first and be allowed, so the `LAB2` block rules would never be reached. Placing the specific block rules above it ensures matching traffic is blocked, and everything else still falls through to the allow rule.

---

## Q2. Which five packet attributes are most useful when explaining a firewall decision?

| # | Attribute | Why it matters |
| :-: | --- | --- |
| 1 | **Source IP** | Identifies which host generated the traffic. |
| 2 | **Destination IP** | Shows where the traffic was going (e.g. `1.1.1.1`). |
| 3 | **Protocol** | Distinguishes ICMP, TCP and UDP, which rules match on. |
| 4 | **Destination port** | Separates services such as HTTP (80) and HTTPS (443). |
| 5 | **Interface / Direction** | Shows where the packet entered the firewall (LAN, In). |

Combined with the **action** (block/pass) and the **rule label**, these attributes show exactly which rule matched a packet and why.

---

## Q3. Why did blocking ICMP not block HTTPS?

> **Short answer:** Different protocol, different port, different destination.

The block rule matched only **ICMP** traffic to **`1.1.1.1/32`**. HTTPS uses **TCP port 443** and goes to different destinations, so it did not match the rule. It continued down the rule list and was permitted by the `Default allow LAN to any` rule.

---

## Q4. What difference was observed between blocked TCP port 80 and permitted TCP port 443 traffic?

| | **Port 80 (Blocked)** | **Port 443 (Permitted)** |
| --- | --- | --- |
| **TCP handshake** | Never completed | Completed (SYN → SYN-ACK → ACK) |
| **Wireshark** | Repeated SYN retransmissions, no reply | Established connection with TLS traffic |
| **Data** | None | Encrypted TLS (HTTPS) |
| **`curl` result** | Timed out | Returned a response |
| **Firewall log** | Block entry with `LAB2 BLOCK OUTBOUND HTTP` | No block entry |

The firewall silently dropped the port 80 packets, so the client kept retransmitting SYN packets until `curl` timed out.

---

## Q5. What role does outbound NAT play when the client uses a private IPv4 address?

The client uses a private address (`10.10.10.x`), which is **not routable on the internet**. Outbound NAT:

- Translates the client's private source IP to the firewall's external IP address.
- Records the connection in the **state table**.
- Uses that state to send reply traffic back to the correct client.

Without outbound NAT, replies from internet hosts could not reach the client.

---

## Q6. Why is restoring the original state important in a controlled security laboratory?

- **Repeatability:** later labs start from a known, clean baseline.
- **Safety:** leftover test rules could cause unexpected blocking or leave security gaps.
- **Verification:** restoring and re-testing confirms the changes were understood and fully reversible.
- **Good practice:** it matches real-world change management, where temporary changes are always rolled back and documented.
