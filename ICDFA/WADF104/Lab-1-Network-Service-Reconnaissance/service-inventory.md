# Service Inventory — Target 192.168.224.131 (Metasploitable 2)

Compiled from `sudo nmap -p- -sV 192.168.224.131` (full TCP port + version scan).

| Port  | Protocol | State | Service      | Version / Evidence                                              | Command |
|-------|----------|-------|--------------|-------------------------------------------------------------------|---------|
| 21    | tcp      | open  | ftp          | vsftpd 2.3.4                                                       | `nmap -p- -sV` |
| 22    | tcp      | open  | ssh          | OpenSSH 4.7p1 Debian 8ubuntu1 (protocol 2.0)                       | `nmap -p- -sV` |
| 23    | tcp      | open  | telnet       | Linux telnetd                                                      | `nmap -p- -sV` |
| 25    | tcp      | open  | smtp         | Postfix smtpd                                                      | `nmap -p- -sV` |
| 53    | tcp      | open  | domain       | ISC BIND 9.4.2                                                     | `nmap -p- -sV` |
| 80    | tcp      | open  | http         | Apache httpd 2.2.8 ((Ubuntu) DAV/2)                                | `nmap -p- -sV` |
| 111   | tcp      | open  | rpcbind      | 2 (RPC #100000)                                                    | `nmap -p- -sV` |
| 139   | tcp      | open  | netbios-ssn  | Samba smbd 3.X - 4.X (workgroup: WORKGROUP)                        | `nmap -p- -sV` |
| 445   | tcp      | open  | netbios-ssn  | Samba smbd 3.X - 4.X (workgroup: WORKGROUP)                        | `nmap -p- -sV` |
| 512   | tcp      | open  | exec?        | unidentified                                                       | `nmap -p- -sV` |
| 513   | tcp      | open  | login        | rlogin                                                             | `nmap -p- -sV` |
| 514   | tcp      | open  | tcpwrapped   | unidentified (tcpwrapped)                                          | `nmap -p- -sV` |
| 1099  | tcp      | open  | java-rmi     | GNU Classpath grmiregistry                                         | `nmap -p- -sV` |
| 1524  | tcp      | open  | bindshell    | Metasploitable root shell                                          | `nmap -p- -sV` |
| 2049  | tcp      | open  | nfs          | 2-4 (RPC #100003)                                                  | `nmap -p- -sV` |
| 2121  | tcp      | open  | ftp          | ProFTPD 1.3.1                                                      | `nmap -p- -sV` |
| 3306  | tcp      | open  | mysql        | MySQL 5.0.51a-3ubuntu5                                             | `nmap -p- -sV` |
| 3632  | tcp      | open  | distccd      | distccd v1 ((GNU) 4.2.4 (Ubuntu 4.2.4-1ubuntu4))                   | `nmap -p- -sV` |
| 5432  | tcp      | open  | postgresql   | PostgreSQL DB 8.3.0 - 8.3.7                                        | `nmap -p- -sV` |
| 5900  | tcp      | open  | vnc          | VNC (protocol 3.3)                                                 | `nmap -p- -sV` |
| 6000  | tcp      | open  | X11          | (access denied)                                                    | `nmap -p- -sV` |
| 6667  | tcp      | open  | irc          | UnrealIRCd                                                         | `nmap -p- -sV` |
| 6697  | tcp      | open  | irc          | UnrealIRCd                                                         | `nmap -p- -sV` |
| 8009  | tcp      | open  | ajp13        | Apache Jserv (Protocol v1.3)                                       | `nmap -p- -sV` |
| 8180  | tcp      | open  | http         | Apache Tomcat/Coyote JSP engine 1.1                                | `nmap -p- -sV` |
| 8787  | tcp      | open  | drb          | Ruby DRb RMI (Ruby 1.8; path /usr/lib/ruby/1.8/drb)                | `nmap -p- -sV` |
| 34703 | tcp      | open  | nlockmgr     | 1-4 (RPC #100021)                                                  | `nmap -p- -sV` |
| 43490 | tcp      | open  | status       | 1 (RPC #100024)                                                    | `nmap -p- -sV` |
| 51947 | tcp      | open  | mountd       | 1-3 (RPC #100005)                                                  | `nmap -p- -sV` |
| 53104 | tcp      | open  | java-rmi     | GNU Classpath grmiregistry                                         | `nmap -p- -sV` |

**Not shown:** 65505 closed TCP ports (reset).

## UDP Inventory (Top 20 ports)
Command: `sudo nmap -sU --top-ports 20 -sV 192.168.224.131`

| Port  | State          | Service      | Version/Evidence |
|-------|----------------|--------------|-------------------|
| 53    | open           | domain       | ISC BIND 9.4.2 |
| 67    | open\|filtered | dhcps        | — |
| 68    | open\|filtered | dhcpc        | — |
| 69    | open\|filtered | tftp         | — |
| 123   | open\|filtered | ntp          | — |
| 135   | open\|filtered | msrpc        | — |
| 137   | open           | netbios-ns   | Microsoft Windows netbios-ns (workgroup: WORKGROUP) |
| 138   | open\|filtered | netbios-dgm  | — |
| 139   | open\|filtered | netbios-ssn  | — |
| 161   | open\|filtered | snmp         | — |
| 162   | open\|filtered | snmptrap     | — |
| 445   | open\|filtered | microsoft-ds | — |
| 500   | open\|filtered | isakmp       | — |
| 514   | open\|filtered | syslog       | — |
| 520   | open\|filtered | route        | — |
| 631   | open\|filtered | ipp          | — |
| 1434  | open\|filtered | ms-sql-m     | — |
| 1900  | open\|filtered | upnp         | — |
| 4500  | open\|filtered | nat-t-ike    | — |
| 49152 | open\|filtered | unknown      | — |

## Additional Service/OS Info (from -sV / -A / SMB script output)
- Service Info (TCP scan): Hosts: metasploitable.localdomain, irc.Metasploitable.LAN; OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel
- SMB enumeration: OS: Unix (Samba 3.0.20-Debian); Computer name: metasploitable; Domain name: localdomain; FQDN: metasploitable.localdomain
- UDP scan Service Info: Host: METASPLOITABLE; OS: Windows (note: this is a false-positive fingerprint against NetBIOS on this Linux box — cross-checked against the TCP/SMB findings above, which correctly show Unix/Linux)
