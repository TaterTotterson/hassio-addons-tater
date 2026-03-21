# Tater AI Assistant (Home Assistant add-on)

Tater is an AI assistant with deep Home Assistant integration via tools like:

- `web_search` - web discovery inside Assist flows
- `ha_control` - control lights, switches, media players, etc.
- `events_query` - summarize stored house events
- `mister_remote`, `overseerr_*`, `comfyui_*`, and more

## Configuration

In the **Configuration** tab, set:

- **REDIS_HOST / REDIS_PORT**
  Where Tater should find Redis. This can be:
  - Another Home Assistant add-on (Redis), or
  - An external Redis-Stack instance on your network.

After configuring, click **Save** and then **Restart** the add-on.

LLM/model settings are configured inside Tater WebUI, not in add-on options.

## First-time setup

1. Start the add-on.
2. Click **Open Web UI** to launch the TaterOS web interface.
3. In the WebUI:
   - Open **Settings -> Hydra Models** and set your model/server.
   - Configure integrations like **Home Assistant**, **Overseerr**, **ComfyUI**, etc.
   - Enable the `homeassistant` and `ha_automations` portals if you want Tater
     wired into Assist and automation bridges.

## Agent Lab storage (default)

This add-on stores Agent Lab data in Home Assistant's config directory by
default for persistence:

- `/config/agent_lab` (persistent)
- `/app/agent_lab` (symlink to the config path)

## Using Tater with Assist / Conversation

Once the `homeassistant` portal is enabled in Tater:

1. In Home Assistant, go to **Settings -> Voice Assistants -> Assist Pipelines**.
2. Add an external conversation agent pointing at the Tater HA bridge, for example:

   - URL: `http://homeassistant.local:8787/tater-ha/v1/query`
   - Method: `POST`

3. Follow the Tater README for details on the expected payload and responses.

## Logs

Add-on logs show:

- TaterOS startup (FastAPI/Uvicorn)
- Integration activity
- The Home Assistant bridge health endpoint (`/tater-ha/v1/health`)

You can view these under **Settings -> Add-ons -> Tater AI Assistant -> Logs**.
