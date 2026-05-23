<div align="center">
  <a href="https://taterassistant.com">
    <img src="images/tater-repo-logo.png" alt="Home Assistant Add-ons" width="460"/>
  </a>
</div>
<h3 align="center">
  <a href="https://taterassistant.com">taterassistant.com</a>
</h3>

# Tater Add-ons for Home Assistant

This repository contains Home Assistant add-ons for running
[Tater](https://github.com/TaterTotterson/Tater) and its required services
directly on your Home Assistant system.

## Install Tater for Home Assistant

First, add the Tater add-on repository to Home Assistant:

[![Add Repository to Home Assistant](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](
https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/TaterTotterson/hassio-addons-tater
)

Once the repository has been added, both add-ons will appear automatically
in the Home Assistant Add-on Store.

## Install Redis Stack

Tater uses Redis for memory, verbas, and automations.

1. Open **Settings -> Add-ons -> Add-on Store**
2. Find **Redis Stack** under the Tater add-on repository
3. Install Redis Stack
4. (Optional) In Redis Stack **Configuration**, set:
   - `allow_empty_password: false`
   - `redis_password: "<your password>"`
5. Start Redis Stack

Redis Stack should be running before Tater is started.

## Install Tater AI Assistant

After Redis Stack is installed and running:

1. Open **Settings -> Add-ons -> Add-on Store**
2. Find **Tater AI Assistant** under the Tater add-on repository
3. Install Tater
4. Start the Tater add-on

## Post-install setup (one-time)

After starting Tater, open the add-on Web UI and complete setup inside Tater:

1. Open **Tater Web UI**
2. If prompted, complete the **Redis setup popup** and save
3. Go to **Settings -> Hydra Models**
4. Configure your Base Model (or Beast Mode head models)
5. Save model settings

Model settings are no longer configured in Home Assistant add-on options.

## Redis setup

Redis host/port is no longer configured in add-on options or `.env`.

If Tater cannot detect a usable Redis connection at startup, the WebUI shows a
Redis setup popup. Enter your Redis details there (host, port, optional
password/TLS) and save.

Default for Redis Stack add-on in this repository:
- Host: `localhost`
- Port: `6379`
- Password: leave blank unless you set `redis_password` in Redis Stack config

Saved Redis config path:
- `/app/.runtime/redis_connection.json` (persisted at `/config/tater/.runtime/redis_connection.json`)

Persistent data root:
- `/config/tater` (includes `agent_lab` and `.runtime`)

Older installs are auto-migrated from `/config/agent_lab` and `/config/.runtime`.

## Guardian Core tunnels

The Tater add-on includes the system tools Guardian Core needs for tunnel
support:

- Tailscale / tailscaled
- WireGuard / wg-quick
- Cloudflare Tunnel / cloudflared

The add-on runs on the host network. It also requests `/dev/net/tun` plus
`NET_ADMIN` and `NET_RAW` so Guardian Core can start and stop Tailscale or
WireGuard from inside the add-on. Cloudflare Tunnel normally only needs outbound
network access, but it uses the same add-on image.

Guardian tunnel controls are still disabled inside Tater by default. Enable
**Allow Tunnel Controls** in Guardian Core before using start/stop actions.

## You're ready

Once Redis is running and Hydra Models are configured in the Tater Web UI,
open the Tater UI from the add-on page and start chatting.
