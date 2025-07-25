#!/bin/bash

# === Shadowsocks Auto Installer ===
# Tested on Ubuntu 20.04/22.04 & Debian 11+

set -e

# === User Configuration ===
PORT=8388
PASSWORD=$(openssl rand -base64 16)
METHOD=aes-256-gcm
USE_OBFS=true  # Set to false if not needed

echo "Installing Shadowsocks-libev..."

# Install base tools
apt update
apt install -y shadowsocks-libev qrencode curl

# Optional: Simple-obfs plugin
if [ "$USE_OBFS" = true ]; then
  echo "Installing Simple-OBFS plugin..."
  apt install -y simple-obfs
fi

# Create config directory
mkdir -p /etc/shadowsocks-libev

# Write config file
cat <<EOF > /etc/shadowsocks-libev/config.json
{
  "server": "0.0.0.0",
  "server_port": $PORT,
  "password": "$PASSWORD",
  "timeout": 60,
  "method": "$METHOD",
  $( [ "$USE_OBFS" = true ] && echo '"plugin":"obfs-server","plugin_opts":"obfs=http",')
  "fast_open": false,
  "reuse_port": true,
  "no_delay": true
}
EOF

# Enable Shadowsocks service
systemctl enable shadowsocks-libev
systemctl restart shadowsocks-libev

# Set up UFW firewall
if command -v ufw &>/dev/null; then
  echo "Configuring UFW firewall..."
  ufw allow $PORT/tcp
  ufw allow $PORT/udp
fi

# Get server public IP
SERVER_IP=$(curl -s https://ipinfo.io/ip)

# Generate Shadowsocks URI
ENCODED=$(echo -n "$METHOD:$PASSWORD@$SERVER_IP:$PORT" | base64 -w0)
SS_URI="ss://$ENCODED"

if [ "$USE_OBFS" = true ]; then
  SS_URI="$SS_URI?plugin=obfs-local%3Bobfs%3Dhttp"
fi

echo
echo "=== Shadowsocks Server Installed ==="
echo "Connection Info (Scan this QR in client app):"
echo
qrencode -t ANSIUTF8 "$SS_URI"
echo
echo "Manual URI:"
echo "$SS_URI"
echo
