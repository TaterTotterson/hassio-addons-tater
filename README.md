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

## Tater Native satellites for Home Assistant

The **Tater Satellite** custom integration lets Tater Native firmware connect
directly to Home Assistant and behave as a native Assist satellite. It is a
protocol adapter: it does not modify Tater or the satellite firmware, and the
Tater add-on does not need to be installed or running.

It provides:

- A real Home Assistant Assist satellite entity for each paired device
- Local wake-word activation with 16 kHz mono PCM sent into the selected Assist
  pipeline
- Announcements, continued conversations, timers, TTS playback, and diagnostics
- Secure six-digit first-pairing followed by a per-device credential
- Shared voice defaults and per-satellite settings for wake models, sensitivity,
  wake sounds, trainer captures, conversation behavior, AEC, volume, LEDs, and
  firmware logging
- Custom microWakeWord TFLite and WAV upload, stored inside Home Assistant
- Board-aware OTA updates and browser USB recovery for Voice PE, Satellite1,
  ReSpeaker XVF3800, and ESP32-S3-BOX-3

### Install with HACS

Until the integration is listed in the default HACS catalog:

1. Open **HACS -> Integrations**
2. Open the menu and choose **Custom repositories**
3. Add `https://github.com/TaterTotterson/hassio-addons-tater` as an
   **Integration**
4. Install **Tater Native Satellites**
5. Restart Home Assistant
6. Open **Settings -> Devices & services -> Add integration**
7. Search for **Tater Satellite** and add it

For a manual install, copy
`custom_components/tater_satellite` from this repository to
`/config/custom_components/tater_satellite`, restart Home Assistant, and add the
integration from **Devices & services**.

### Pair a satellite

1. Open **Tater Satellites** in the Home Assistant sidebar
2. Select **Add Satellite** to generate a temporary pairing code
3. Put the satellite into setup mode
4. In its setup page, enter the Home Assistant URL shown in the panel as the
   server and enter the pairing code
5. Save and let the satellite reboot

The firmware automatically appends `/api/tater/satellite/v1/ws`. After the
first connection, Home Assistant replaces the short pairing code with a
device-specific credential. Existing satellites can be returned to setup mode
using the physical setup-reset gesture documented in the
[Tater Native firmware guide](https://github.com/TaterTotterson/Tater-Native-Firmware#physical-setup-reset).

### Firmware updates and recovery

The **Firmware & Recovery** tab reads the latest official Tater Native release
manifest and matches images by reported board ID. Home Assistant downloads the
requested image, verifies its published size and SHA-256 hash, and then exposes
it through a short-lived URL.

- Use **Install update** for a connected satellite. The integration sends the
  board-matched OTA image and tracks progress through the satellite entity.
- Use **Browser USB Recovery** for a first flash or a satellite that cannot
  reconnect. Select the hardware and use Chrome or Edge over a secure Home
  Assistant connection.

USB recovery writes the release's merged factory image. OTA writes only the
application image and preserves the satellite's Wi-Fi and pairing data.

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

## You're ready

Once Redis is running and Hydra Models are configured in the Tater Web UI,
open the Tater UI from the add-on page and start chatting.
