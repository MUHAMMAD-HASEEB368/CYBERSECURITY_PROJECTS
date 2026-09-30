### 📝 Lab 01 Completion Questions & Answers

#### Question 1: What is the difference between the OPNsense WAN and LAN interfaces?

**Answer:**

* **WAN (Wide Area Network):** Connects the firewall to external networks or the internet (configured via VirtualBox NAT on `10.0.2.15/24` or `172.16.100.2/30`). It handles outbound Network Address Translation (NAT) and blocks unsolicited incoming traffic from the outside.


* **LAN (Local Area Network):** Connects the firewall to the protected internal network segment (`10.10.10.1/24` on `ICDFA-LAN`). It acts as the default gateway, provides DHCP services to internal hosts, and serves as the management entry point for internal clients.



---

#### Question 2: Why must both internal adapters use the same VirtualBox network name?

**Answer:**

The internal network name in VirtualBox (e.g., `ICDFA-LAN`) defines a specific virtual software switch segment. Both the firewall's LAN interface and the Ubuntu client's network adapter must share the exact same case-sensitive network name so they are plugged into the same logical Layer 2 broadcast domain. If the names do not match, the VMs will be isolated on separate virtual switches and unable to communicate.

---

#### Question 3: What information does the default route provide to Ubuntu?

**Answer:**

The default route (e.g., `default via 10.10.10.1`) informs the Ubuntu operating system where to send network packets when the destination IPv4 address does not belong to any directly connected local subnet (`10.10.10.0/24`). It instructs the client to encapsulate and forward all external traffic to the OPNsense firewall interface at `10.10.10.1` for routing.

---

#### Question 4: Which packet exchange allows Ubuntu to learn the firewall MAC address?

**Answer:**

The **Address Resolution Protocol (ARP)** packet exchange allows Ubuntu to learn the firewall's physical MAC address. Ubuntu sends a Layer 2 **ARP Request** broadcast (`who has 10.10.10.1? tell 10.10.10.102`), and the OPNsense firewall responds with a Layer 2 **ARP Reply** unicast frame providing its hardware MAC address.

---

#### Question 5: Why does a successful ping to 1.1.1.1 not automatically prove that DNS is working?

**Answer:**

Pinging `1.1.1.1` tests connectivity directly using a raw IPv4 address, which relies strictly on Layer 3 IP routing and ICMP functionality. It bypasses domain name resolution entirely. Domain Name System (DNS) operates on Layer 7 to resolve human-readable domain names (like `opnsense.org`) into IP addresses. Therefore, IP routing can function properly even if DNS server settings or Unbound DNS services are completely misconfigured or failing.
