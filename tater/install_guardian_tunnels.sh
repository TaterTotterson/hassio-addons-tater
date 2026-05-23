#!/bin/sh
set -eu

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
    iproute2 \
    iptables \
    wireguard-tools

install -d -m 0755 /usr/share/keyrings /etc/apt/sources.list.d

. /etc/os-release
OS_ID="${ID:-debian}"
OS_CODENAME="${VERSION_CODENAME:-bookworm}"

case "$OS_ID" in
    debian|ubuntu)
        ;;
    *)
        OS_ID="debian"
        OS_CODENAME="bookworm"
        ;;
esac

curl -fsSL "https://pkgs.tailscale.com/stable/${OS_ID}/${OS_CODENAME}.noarmor.gpg" \
    -o /usr/share/keyrings/tailscale-archive-keyring.gpg
curl -fsSL "https://pkgs.tailscale.com/stable/${OS_ID}/${OS_CODENAME}.tailscale-keyring.list" \
    -o /etc/apt/sources.list.d/tailscale.list

curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg \
    -o /usr/share/keyrings/cloudflare-main.gpg
echo "deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared any main" \
    > /etc/apt/sources.list.d/cloudflared.list

apt-get update
apt-get install -y --no-install-recommends tailscale cloudflared

rm -rf /var/lib/apt/lists/*
