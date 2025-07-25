# 🛡️ Shadowsocks Auto Installer

Easily deploy a secure [Shadowsocks-libev](https://github.com/shadowsocks/shadowsocks-libev) proxy server on any VPS.

## 📱 Mobile Client Apps

	•	iOS: Shadowrocket (paid) or Potatso Lite (free)
	•	Android: Shadowsocks FOSS
	•	macOS: ClashX

⸻
 
## 🔒 Features

	•	AES-256-GCM encryption
	•	Optional HTTP Obfuscation (via simple-obfs)
	•	Auto-generated QR Code
	•	UFW firewall rules
	•	Works globally

⸻
 
## 🔧 What It Does

	•	Installs shadowsocks-libev with aes-256-gcm encryption
	•	Optionally adds simple-obfs plugin (HTTP disguise)
	•	Configures UFW firewall rules
	•	Outputs your connection as a QR code + URI


⸻

## 🔒 Example Features

	✅ AES-256-GCM encryption
	✅ Optional plugin: obfs=http
	✅ Auto-generated random password
	✅ Compatible with most mobile and desktop proxy clients
	✅ Fast and lightweight (SOCKS5-based)
	✅ Ideal for personal use, censorship bypass, or lightweight privacy

⸻

## 🧠 FAQ

Q: Is this a VPN?

No — Shadowsocks is a proxy, not a full VPN. It only routes selected traffic (usually browser/app), not all system traffic.

Q: Can I use this for streaming or gaming?

Yes! Shadowsocks has low latency and is ideal for streaming, especially when VPNs are blocked or slow.

Q: How do I uninstall it?

SSH into your server and run:

## 🔧 Install Script

Run this on your server:

```bash
wget -O ss-install.sh https://raw.githubusercontent.com/yourusername/shadowsocks-autosetup/main/ss-install.sh
chmod +x ss-install.sh
./ss-install.sh

