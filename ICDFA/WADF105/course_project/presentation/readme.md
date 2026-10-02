<div align="center">

# 📊 Presentation

### Opening a Secure Website: Tracing HTTPS Communication Using the TCP/IP Model

![PowerPoint](https://img.shields.io/badge/PowerPoint-.pptx-D24726?style=for-the-badge&logo=microsoftpowerpoint&logoColor=white)
![Slides](https://img.shields.io/badge/Content%20Slides-12-0E7C86?style=for-the-badge)
![Speaker Notes](https://img.shields.io/badge/Speaker%20Notes-Included-1B7F4B?style=for-the-badge)

</div>

---

## 📖 About

This folder contains the main presentation for the WADF105 course project. It traces one HTTPS communication, from the user's laptop to the web server and back, through the four layers of the TCP/IP model.

| | |
| --- | --- |
| **File** | [`HTTPS_TCPIP_Presentation.pptx`](HTTPS_TCPIP_Presentation.pptx) |
| **Format** | PowerPoint, 16:9 |
| **Structure** | 1 title slide, **12 content slides**, 1 references slide |
| **Speaker notes** | Included on every slide (open *Notes* view) |
| **Delivery time** | Designed for a 12-15 minute presentation |
| **Author** | Muhammad Haseeb |

## 🗂️ Slide Overview

| # | Slide | What it covers |
| :-: | --- | --- |
| 1 | Communication Scenario | The six steps of opening `https://example.com` |
| 2 | TCP/IP Model and OSI Mapping | Four TCP/IP layers mapped to the seven OSI layers |
| 3 | DNS Resolution | Domain name to IP address; UDP port 53 (TCP also possible) |
| 4 | TCP Connection Establishment | Three-way handshake (SYN, SYN/ACK, ACK) to port 443 |
| 5 | TLS and HTTPS | Authentication, encryption and integrity; HTTP/3 over QUIC |
| 6 | Encapsulation and Decapsulation | Data, segment, packet, frame, bits, and the reverse |
| 7 | **Original Packet Journey Diagram** | Sender, devices, destination, layers and direction |
| 8 | Protocol Analysis Table | Layer, protocol, PDU, addressing and purpose |
| 9 | TCP vs UDP | Comparison with application examples |
| 10 | Realistic Communication Failure | DNS resolution failure scenario |
| 11 | Troubleshooting the DNS Failure | Identify, diagnose, resolve, verify |
| 12 | Complete Process and Conclusion | The full journey and how the layers cooperate |

Followed by a **References** slide (IETF standards) and the AI-use declaration.

## ▶️ How to Use

1. **Download** `HTTPS_TCPIP_Presentation.pptx` (click the file, then the download button; GitHub does not preview `.pptx` files).
2. Open it in **Microsoft PowerPoint** (or LibreOffice Impress / Google Slides).
3. To read the script, open **View → Notes Page**, or use **Presenter View** in slideshow mode.
4. Practise with a timer. The target is 12-15 minutes in total, roughly 1 minute per slide.

## ✏️ Editing the Diagrams

All diagrams (packet journey, handshake, encapsulation, flows) are built from **native PowerPoint shapes and lines**, so they stay editable.

- Click any shape to change text, colour or position.
- To make the packet journey diagram specific to your own lab, replace the example text with real IP, MAC and port values from your own Wireshark capture.
- Keep the same layout order (sender, home router, ISP, Internet routers, server) so the narration still matches.

## 🎨 Design Notes

| Element | Choice |
| --- | --- |
| Palette | Navy `#0B1F3A`, teal `#0E7C86`, orange `#C96A12` (response / highlights) |
| Typeface | Calibri throughout |
| Layout | Navy header band, topic tag on every slide, footer with slide number |
| Colour meaning (diagram) | Teal = request direction, orange = response direction |

## ✅ Technical Accuracy Points

The presentation deliberately avoids common mistakes:

- DNS **commonly** uses UDP port 53 but can also use TCP.
- **TLS** provides encryption; TCP does not encrypt.
- HTTPS traditionally uses **TCP port 443**; **HTTP/3 uses QUIC over UDP**.
- **IP addresses** stay the same end to end (NAT rewrites the private source address at the home router); **MAC addresses** change at every hop.
- A successful `ping` to an IP address does **not** prove that DNS works.
- UDP is not simply "faster": it has lower overhead and no TCP reliability mechanisms.

## 📚 Sources

Protocol details are based on IETF standards (RFC 9293, 768, 791, 1035, 8446 and 9114). The full reference list is on the last slide and in the [main README](../README.md).



<div align="center">

⬅️ [Back to the main project README](../README.md)

</div>
