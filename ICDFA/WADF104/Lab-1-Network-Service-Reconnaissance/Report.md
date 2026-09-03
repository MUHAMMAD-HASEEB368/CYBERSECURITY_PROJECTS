# Lab 1 — Network & Service Reconnaissance Report

**Analyst:** Muhammad Haseeb

**Target:** Metasploitable 2 (192.168.224.131)

**Attacker Environment:** Kali Linux (192.168.224.x) within the ICDFA isolated training lab (VMware host-only network)

## 1. Target Identification & Host Discovery

The reconnaissance phase commenced with verifying the local attacker environment. The Kali Linux interface and IP were identified using `ip addr`, while the target's IP (192.168.224.131) was confirmed locally via `ifconfig` on the Metasploitable 2 VM. Network connectivity was successfully verified using a standard ICMP ping (`ping -c 4 192.168.224.131`).

To map the lab subnet, an `nmap -sn 192.168.224.0/24` host discovery sweep was executed, which successfully identified the target as a live host within the authorised testing boundary.

## 2. TCP Port Scanning & Service Enumeration

Initial probing began with a default Nmap TCP scan to identify the top 1,000 common ports, followed immediately by service and version detection (`nmap -sV`). This successfully fingerprinted core services, revealing specific software versions such as vsftpd 2.3.4, OpenSSH 4.7p1, and Apache httpd 2.2.8. Increasing the version detection intensity to the maximum level (`--version-intensity 9`) yielded identical results, confirming that the default `-sV` probes were sufficient for this well-documented target.

To ensure no non-standard services were missed, a full 65,535 TCP port scan was conducted (`sudo nmap -p-`). This expansive scan surfaced multiple high-numbered and RPC ports completely missed by the default scan, including ports 1099, 1524, 2049, 2121, 3632, 5432, 8009, 8180, 8787, 34703, 43490, 51947, and 53104.

This full scan was subsequently combined with version detection (`sudo nmap -p- -sV`) to generate the definitive service inventory, revealing a total of 29 open TCP ports. Running this same extensive scan with a `-T4` timing template yielded the exact same inventory but completed significantly faster, proving optimal for this reliable, isolated lab network. Focus scans on specific ranges (e.g., ports 1-1024) and individual targeted ports (21, 22, 23, 25, 80, 139, 445) were also tested to validate how subsets of the full inventory can be efficiently re-audited.

## 3. OS Fingerprinting & Aggressive Scanning

Operating system detection was performed using `sudo nmap -O`, which identified the target as a Unix/Linux system (CPE: `cpe:/o:linux:linux_kernel`). This was independently corroborated by SMB enumeration scripts, which disclosed the OS as Unix running Samba 3.0.20-Debian, alongside the computer name `metasploitable` and FQDN `metasploitable.localdomain`.

An aggressive scan (`sudo nmap -A`) was then executed to combine OS detection, versioning, default scripts, and traceroute into a single pass. Compared to the standalone `-sV` scan, this aggressive approach provided three distinct advantages:

* **Script Output:** Default NSE scripts extracted rich protocol banners (e.g., SMB OS and computer-name disclosure).
* **Detailed OS Profiling:** It provided specific CPE identifiers missing from the baseline scan.
* **Expanded Service Strings:** It pulled fuller software strings, such as exact Samba OS builds and specific IRC server software details.

## 4. UDP Reconnaissance

UDP port scanning presents unique challenges due to its connectionless nature. Executing `sudo nmap -sU` and a targeted `--top-ports 20 -sV` scan revealed port 53 (ISC BIND 9.4.2) as definitively open. Most other queried UDP ports returned an `open|filtered` state, an expected ambiguity indicating that no response was received. Notably, port 137 (netbios-ns) returned a Windows-style NetBIOS fingerprint. Given the overwhelming evidence of a Unix/Samba environment from the TCP scans, this Windows signature was documented as a fingerprinting artifact rather than an accurate OS reflection.

## 5. Nmap Scripting Engine (NSE) Enumeration

Leveraging the default script set (`nmap -sC -sV`) provided immediate tactical value. The `smb-protocols` and SMB OS scripts successfully leaked the target's OS build and domain structure, while `ssh-hostkey` retrieved the SSH algorithms and fingerprints essential for verifying server identity.

Targeted NSE scripts were then deployed against specific services:

* **Port 80:** `http-title` retrieved the page title, and `http-headers` captured the server header (`Apache/2.2.8 (Ubuntu) DAV/2`).
* **Ports 139/445:** `smb-protocols` enumerated supported SMB versions.
* **Port 21:** The generic `banner` script was cross-referenced with the `-sV` results, perfectly matching the vsftpd 2.3.4 version string.

## 6. Web Application Fingerprinting

HTTP responses were manually validated using curl -I http://192.168.224.131, confirming the server headers, PHP presence (`X-Powered-By: PHP/5.2.4-2ubuntu5.10`), and a `200 OK` status.

Automated web fingerprinting was conducted using WhatWeb at escalating aggression levels:

* **Basic & Level 1 (`-a 1`):** Identified Apache 2.2.8, PHP 5.2.4-2ubuntu5.10, WebDAV, and the page title. Verbose mode (`-v`) expanded on these plugins with detailed descriptions.
* **Level 3 (`-a 3 -v`):** Returned the same core technology stack as Level 1, as the primary surface is easily identifiable without heavy fuzzing.
* **Level 4 (`-a 4 -v`):** The heaviest aggression level successfully discovered a hidden installation of Matomo (formerly Piwik), a PHP-based analytics platform. This demonstrates the value of high-intensity scanning for uncovering secondary applications not linked on the index page.
* **Redirection Testing:** Appending `--follow-redirect=always` against HTTPS (`port 443`) resulted in a refused connection, confirming the port is closed. The HTTP scan returned the base fingerprint, verifying that no redirect chain is implemented on this server.

## Final Analytical Conclusion

The target (192.168.224.131) exposes an intentionally vast and diverse attack surface, far exceeding typical real-world deployments. The 30 open TCP services span file transfer (FTP), remote administration (SSH, Telnet, VNC, rlogin), mail (SMTP), DNS, file sharing (Samba/NFS), databases (MySQL, PostgreSQL), and distributed compilation (distccd). The web infrastructure is particularly notable, hosting two separate web stacks: an Apache 2.2.8/PHP environment on port 80 and an Apache Tomcat deployment on port 8180 (with an associated AJP connector on 8009).

OS fingerprinting consistently identifies the host as a Unix/Linux environment (Ubuntu, Samba 3.0.20-Debian), firmly overriding an anomalous Windows NetBIOS response observed during the UDP scan. Web enumeration isolated an outdated PHP stack with WebDAV active and a hidden Matomo analytics directory that only surfaced under aggressive fuzzing.

Crucially, while this reconnaissance phase has mapped a massive footprint of exposed services—many of which (e.g., vsftpd 2.3.4, distccd, UnrealIRCd, Samba 3.X) are historically associated with critical vulnerabilities—an open port or identified version only confirms exposure, not exploitability. Validating actual vulnerability requires precise CVE matching and safe exploitation, which transitions this workflow out of the reconnaissance phase and sets the foundation for the web-application testing phase in Lab 2.
