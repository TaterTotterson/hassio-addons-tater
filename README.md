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
[Tater](https://github.com/TaterTotterson/Tater) and optional supporting
services directly on your Home Assistant system.

Looking for the Tater Native satellite integration? It now lives in the
dedicated
[Tater Home Assistant Satellites](https://github.com/TaterTotterson/Tater-Home-Assistant-Satellites)
repository so this repository remains compatible with the Home Assistant
Add-on Store.

## Install Tater for Home Assistant

First, add the Tater add-on repository to Home Assistant:

[![Add Repository to Home Assistant](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](
https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/TaterTotterson/hassio-addons-tater
)

Once the repository has been added, the available add-ons will appear
automatically in the Home Assistant Add-on Store.

## Install Tater AI Assistant

1. Open **Settings -> Add-ons -> Add-on Store**
2. Find **Tater AI Assistant** under the Tater add-on repository
3. Install Tater
4. Start the Tater add-on

Tater uses its built-in Redis by default. No separate Redis installation or
configuration is required.

## Post-install setup (one-time)

After starting Tater, open the add-on Web UI and complete setup inside Tater:

1. Open **Tater Web UI**
2. Go to **Settings -> Hydra Models**
3. Configure your Base Model (or Beast Mode head models)
4. Save model settings

Model settings are no longer configured in Home Assistant add-on options.

## Redis storage

The built-in Redis stores its database inside Tater's persistent Agent Lab at
`/config/tater/agent_lab/redis`. This includes Tater settings, memory, verbas,
and automations.

The Redis connection configuration is saved at:

- `/config/tater/.runtime/redis_connection.json`

The complete persistent data root is:

- `/config/tater` (includes `agent_lab` and `.runtime`)

The add-on points Tater directly at these persistent directories instead of
using container-local `/app` directories.

## Optional external Redis Stack

Install the separate **Redis Stack** add-on only if you want Tater to use an
external Redis server instead of its built-in one:

1. Open **Settings -> Add-ons -> Add-on Store**
2. Find **Redis Stack** under the Tater add-on repository
3. Install Redis Stack
4. Optionally configure a password in its **Configuration** tab
5. Start Redis Stack
6. In Tater, open **Settings -> Redis Connection**
7. Change **Mode** to **External** and use:
   - Host: `localhost`
   - Port: `6379`
   - Password: leave blank unless configured in Redis Stack

If Tater cannot detect a usable Redis connection at startup, the WebUI shows a
Redis setup popup. Enter your Redis details there (host, port, optional
password/TLS) and save.

## You're ready

Once Hydra Models are configured in the Tater Web UI, open the Tater UI from
the add-on page and start chatting.
