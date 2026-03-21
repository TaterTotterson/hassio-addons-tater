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
3. Install and **start** Redis Stack

Redis Stack should be running before Tater is started.

## Install Tater AI Assistant

After Redis Stack is installed and running:

1. Open **Settings -> Add-ons -> Add-on Store**
2. Find **Tater AI Assistant** under the Tater add-on repository
3. Install Tater
4. (Optional) Configure Redis settings if you use an external Redis server
5. Start the Tater add-on

## Post-install setup (one-time)

After starting Tater, open the add-on Web UI and configure your model/server
inside Tater itself:

1. Open **Tater Web UI**
2. Go to **Settings -> Hydra Models**
3. Configure your Base Model (or Beast Mode head models)
4. Save model settings

Model settings are no longer configured in Home Assistant add-on options.

## Redis (automatic)

If a Redis add-on is installed, Tater will automatically connect with no
additional configuration.

Default used by this add-on:
- Redis Stack add-on from this repository -> `redis_host: localhost`

You only need to change Redis settings in add-on config when using an external
Redis server.

## You're ready

Once Redis is running and Hydra Models are configured in the Tater Web UI,
open the Tater UI from the add-on page and start chatting.
