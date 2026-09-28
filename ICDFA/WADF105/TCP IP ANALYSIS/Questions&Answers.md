# 🔍 ARP & Network Analysis: Q&A

> Lab analysis based on Wireshark captures between a **Client**, the **OPNsense** firewall/router, and the target host `10.10.20.10`.

---

## 📑 Table of Contents
1. [Why is ARP request sent to broadcast?](#1-why-is-the-arp-request-sent-to-ffffffffffff)
2. [Why is ARP reply unicast?](#2-why-does-the-arp-reply-normally-use-unicast-instead-of-broadcast)
3. [Why is the destination MAC the OPNsense LAN MAC?](#3-when-the-client-sends-to-10102010-why-is-the-ethernet-destination-the-opnsense-lan-mac)
4. [Proof that the MAC came from OPNsense](#4-what-evidence-proves-that-the-mac-stored-in-the-client-neighbour-table-came-from-opnsense)
5. [Capture filter vs Display filter](#5-what-is-the-difference-between-a-wireshark-capture-filter-and-a-display-filter)
6. [ARP works but TCP fails: what next?](#6-if-arp-succeeds-but-the-tcp-handshake-does-not-complete-which-layers-should-be-investigated-next)

---

## 1. Why is the ARP request sent to `ff:ff:ff:ff:ff:ff`?

The sender knows the **target IP** but not its **MAC address**, so it has no unicast destination to use. `ff:ff:ff:ff:ff:ff` is the Ethernet **broadcast address**: every device on the local segment receives the frame.

- Only the host that owns the requested IP replies.
- All other hosts silently discard the request.

**Wireshark view:**
```
Ethernet II, Dst: ff:ff:ff:ff:ff:ff (Broadcast)
ARP: Who has <target IP>? Tell <sender IP>
```

---

## 2. Why does the ARP reply normally use unicast instead of broadcast?

The request already contains the requester's **MAC and IP** (Sender fields), so the replier knows exactly who asked.

| Reason | Explanation |
|---|---|
| **Efficiency** | Only the requester needs the answer |
| **Less noise** | Other hosts are not interrupted |
| **Security/privacy** | Fewer devices see the mapping |

**Wireshark view:**
```
Ethernet II, Dst: <Client MAC>   (unicast)
ARP: <target IP> is at <target MAC>
```

---

## 3. When the Client sends to `10.10.20.10`, why is the Ethernet destination the OPNsense LAN MAC?

`10.10.20.10` is on a **different subnet** from the Client, so the Client cannot reach it directly at Layer 2. It follows this logic:

1. Destination IP is **not** in my subnet, so send it to the **default gateway**.
2. Resolve the **gateway's MAC** via ARP.
3. Build the frame with:
   - **IP destination** = `10.10.20.10` (unchanged end to end)
   - **Ethernet destination** = **OPNsense LAN MAC** (changes at every hop)

```
Layer 3 (IP):        Client IP  ──────────────►  10.10.20.10
Layer 2 (Ethernet):  Client MAC ──► OPNsense LAN MAC   (next hop only)
```

> 💡 **Key idea:** IP addresses identify the final destination; MAC addresses identify only the next hop.

---

## 4. What evidence proves that the MAC stored in the Client neighbour table came from OPNsense?

Correlate **three pieces of evidence**:

**① Client neighbour table**
```bash
ip neigh show        # Linux
arp -a               # Windows / Linux
```
Shows: `<Gateway IP>  lladdr  aa:bb:cc:dd:ee:ff  REACHABLE`

**② Wireshark ARP reply**
- Filter: `arp.opcode == 2`
- The **Sender MAC address** (ARP layer) and the **Ethernet source** must both equal the MAC in the neighbour table.

**③ OPNsense interface**
- *Interfaces → Overview* (or `ifconfig` in the shell) shows the **LAN interface MAC**.

✅ **Conclusion:** if the MAC in **①** = the ARP reply sender MAC in **②** = the LAN MAC in **③**, then the neighbour entry was learned from OPNsense. The timing also matches: the entry appears right after the ARP reply in the capture.

---

## 5. What is the difference between a Wireshark capture filter and a display filter?

| Feature | Capture Filter | Display Filter |
|---|---|---|
| **Applied** | Before/during capture | After capture |
| **Syntax** | BPF (tcpdump style) | Wireshark's own syntax |
| **Effect** | Packets not matching are **never saved** | Packets are only **hidden**, not deleted |
| **Reversible** | ❌ No | ✅ Yes |
| **Example** | `arp` or `host 10.10.20.10` | `arp` or `ip.addr == 10.10.20.10` |
| **Use case** | Reduce file size, high-traffic links | Analyse and drill down |

> 💡 If unsure, capture broadly and filter with display filters. You can't recover packets dropped by a capture filter.

---

## 6. If ARP succeeds but the TCP handshake does not complete, which layers should be investigated next?

ARP success proves **Layer 2 works** and the next hop is reachable. Move **upward** from there:

| Layer | What to check |
|---|---|
| **L3: Network** | Routing table, default gateway, return route from `10.10.20.10`, NAT, asymmetric routing, `ping` / `traceroute` |
| **L4: Transport** | SYN sent? SYN-ACK received? RST returned? Is the service listening on that port? (`ss -tlnp`, `netstat`) |
| **Firewall (L3/L4)** | OPNsense rules (LAN → target), states table, blocked/dropped logs, host firewall on the target |
| **MTU / fragmentation** | MSS/MTU mismatch causing large packets to drop |

**Reading the capture:**

| Observation | Likely cause |
|---|---|
| SYN only, no reply | Firewall drop, routing problem, or host down |
| SYN → RST | Port closed / service not running |
| SYN → SYN-ACK, but no final ACK | Client-side or return-path issue |
| Repeated SYN retransmissions | Packet loss or silent filtering |

---

## 🛠️ Tools Used
- Wireshark
- OPNsense
- `ip` / `arp` / `ss`
