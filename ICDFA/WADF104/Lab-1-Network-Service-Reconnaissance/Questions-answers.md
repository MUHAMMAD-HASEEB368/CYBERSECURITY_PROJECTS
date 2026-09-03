# Lab Questions & Answers

**1. What is reconnaissance?**

It is the initial information-gathering phase before any exploitation happens. The goal is to map out the target's attack surface by identifying live hosts, open ports, and the specific software versions running on them.

**2. What is the difference between host discovery and port scanning?**

Host discovery (-sn) just checks if an IP address is online without touching any specific ports. Port scanning is the next step, where we probe a known live host to see exactly which TCP or UDP ports are open.

**3. Explain open, closed and filtered.**

- **Open** — a service is actively listening and accepting connections on that port.
- **Closed** — the host responded, but no service is listening on that port.
- **Filtered** — Nmap cannot determine the true state because a firewall or filter is blocking the probe or its response.

**4. What does -sV do?**

It grabs service banners and probes the open ports to figure out the exact software and version running (for example, identifying vsftpd 2.3.4 instead of just generically saying "ftp is open").

**5. What does -O do?**

 OS enables fingerprinting. Nmap analyzes how the target's TCP/IP stack responds to specific packets and compares it against its database to guess the operating system.

**6. Explain what -A combines and why it is noisier.**

The -A flag is an aggressive shortcut that runs OS detection (-O), version scanning (-sV), default scripts (-sC), and a traceroute all at once. It’s considered "noisy" because it generates a massive amount of network traffic and logs, making it very easy for a firewall or IDS to detect.

**7. What does -p- mean?**

It tells Nmap to scan all 65,535 TCP ports instead of just the top 1,000 default ones. This ensures we don't miss any services hiding on non-standard ports.

**8. Why can UDP scans take longer?**

UDP is connectionless. If a UDP port is open, it often just ignores the probe and sends nothing back. Nmap has to wait for timeouts and resend packets to figure out if the port is actually open or just filtered, which slows down the whole scan.

**9. What does -sC do?**

It runs Nmap's default set of NSE scripts to automatically gather basic information, like pulling service banners or checking for common, easily identifiable vulnerabilities.

**10. What information did the HTTP title/headers scripts reveal?**

The http-title script pulled the page title ("Metasploitable2 - Linux"). The http-headers script leaked the backend technology, specifically showing Server: Apache/2.2.8 (Ubuntu) DAV/2 and X-Powered-By: PHP/5.2.4-2ubuntu5.10.

**11. What did SMB/SSH/FTP enumeration add?**

SMB: Disclosed the exact OS build (Unix/Samba 3.0.20-Debian) and the hostname.
SSH: Dumped the host key algorithms and fingerprints.
FTP: The banner script grabbed the exact vsftpd 2.3.4 string, which cross-validated my initial -sV results.

**12. What is the difference between Nmap service detection and WhatWeb fingerprinting?**

Nmap focuses on the network layer to identify daemons and versions (e.g., finding Apache on port 80). WhatWeb works at the application layer, analyzing HTTP responses and HTML source code to identify the specific web technologies, analytics plugins, or CMS frameworks running on top of that server.

**13. How did WhatWeb levels 1, 3 and 4 differ?**

Levels 1 and 3 identified the same core web stack (Apache, PHP), with level 3 just providing longer descriptions. Level 4, however, was aggressive enough to uncover a hidden Matomo analytics installation that the lighter scans completely missed.

**14. Why must aggressive scanning/fingerprinting remain inside the authorised lab?**

Aggressive scans generate a huge volume of traffic that can crash fragile services or trigger security alerts. Scanning systems without explicit written permission is illegal under computer misuse laws. We keep this activity strictly within the isolated lab environment to practice safely and legally.
