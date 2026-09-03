# Lab 1 — Network & Service Reconnaissance (Metasploitable 2)

## Environment
- **Attacker:** Kali Linux (VMware), isolated ICDFA lab network
- **Target:** Metasploitable 2 — `192.168.224.131`
- **Authorisation:** ICDFA authorised isolated training lab 

## Objective
Perform host discovery, TCP/UDP port scanning, service and OS fingerprinting, safe NSE enumeration, and web-service fingerprinting (WhatWeb) against the authorised lab target, and document the findings as an initial reconnaissance record for later web-application testing (Lab 2).

## What I did (step by step)
1. Identified Kali's own IP (`ip addr`) and the target's IP (`ifconfig` on Metasploitable 2), then confirmed connectivity with `ping -c 4`.
2. Identified host discovery (`nmap -sn`) to confirm the target is live on the lab subnet.
3. checked default TCP scan (`nmap <$ip>`) to see the common open ports.
4. Run service/version detection (`nmap -sV`) and compared it against maximum-intensity version detection (`--version-intensity 9`).
5. Discovered OS detection (`sudo nmap -O`) and cross-checked it against SMB-based OS disclosure.
6. Run an aggressive scan (`sudo nmap -A`) and noted the extra findings versus the default scan.
7. Discovered a full TCP port scan (`sudo nmap -p-`) and then combined it with version detection (`sudo nmap -p- -sV`) to build the final service inventory (29 open TCP ports found).
8. Compared full-scan timing with `-T4` for speed.
9. Tested a focused scans on selected ports (`-p 21,22,23,25,80,139,445`) and a port range (`-p 1-1024`) to compare against the full inventory.
10. Run UDP reconnaissance (`sudo nmap -sU` and `--top-ports 20 -sV`) and documented open/open|filtered states.
11. Run default and targeted NSE scripts: `-sC -sV`, `http-title`, `http-headers`, `smb-protocols`, `ssh-hostkey`, and `banner` (FTP), cross-validating banner text against `-sV` results.
12. Confirmed the web service's HTTP response headers manually.
13. Fingerprinted the web service with WhatWeb at increasing aggression levels (basic, `-v`, `-a 1`, `-a 3 -v`, `-a 4 -v`), compared the results, tested `--follow-redirect=always`, and saved verbose output to a file.
14. Compiled all findings into a final service inventory table and wrote up the answers to the 14 lab questions and a conclusion.

## Repository Contents
- `report.md` — full methodology and step-by-step findings, WhatWeb comparison, and conclusion
- `questions-answers.md` — answers to all 14 Part 8 lab questions
- `service-inventory.md` — complete TCP + UDP service inventory table
- `whatweb-results.txt` — saved WhatWeb verbose output 
- `screenshots/` — command + output screenshots (uncropped)

## Tools Used
Nmap 7.99, WhatWeb

## Key Findings (summary)
- 30 open TCP ports across FTP, SSH, Telnet, SMTP, DNS, HTTP (two stacks), SMB, NFS, MySQL, PostgreSQL, Java-RMI, distccd, IRC, and more
- Target OS: Unix/Linux (Ubuntu), Samba 3.0.20-Debian
- Web stack: Apache 2.2.8 (Ubuntu) + PHP 5.2.4, WebDAV enabled; Matomo analytics detected only at WhatWeb aggression level 4
- No HTTPS/redirect present (port 443 closed)

Full detail — including the required caveat that an open port/service is not, by itself, evidence of a vulnerability — is in `report.md`.

## Disclaimer
All testing was performed only against the authorised lab target within the ICDFA isolated training environment, per the lab's authorisation boundary.
