# Tater AI Assistant (Home Assistant add-on)

Tater is an AI assistant with deep Home Assistant integration via tools like:

- `web_search` - web discovery inside Assist flows
- `ha_control` - control lights, switches, media players, etc.
- `events_query` - summarize stored house events
- `mister_remote`, `overseerr_*`, `comfyui_*`, and more

## Configuration

This add-on no longer uses Redis environment variables in add-on options.
The **Configuration** tab can be left empty (`{}`).

Redis is configured inside the Tater Web UI:

- On first run (or when Redis is missing), Tater shows a Redis setup popup.
- Enter host, port, and optional password/TLS settings.
- Save, then continue setup in the Web UI.

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

This add-on stores data under `/config/tater` by default for persistence:

- `/config/tater/agent_lab` (persistent)
- `/app/agent_lab` (symlink to the config path)

Redis setup config is also persisted:

- `/config/tater/.runtime/redis_connection.json` (persistent)
- `/app/.runtime/redis_connection.json` (symlinked runtime path used by Tater)

If you were on an older add-on version, existing data at `/config/agent_lab`
and `/config/.runtime` is auto-migrated on startup.

## Guardian Core tunnel controls

This add-on includes:

- `tailscale` and `tailscaled`
- `wg` and `wg-quick`
- `cloudflared`

The add-on requests:

- host networking
- `/dev/net/tun`
- `NET_ADMIN`
- `NET_RAW`

Those are needed for Guardian Core to control Tailscale and WireGuard tunnel
interfaces. Cloudflare Tunnel normally does not need the extra tunnel device or
network capabilities, but it is included in the same add-on image.

Inside Tater, Guardian Core still requires **Allow Tunnel Controls** before it
will run start/stop actions.

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
