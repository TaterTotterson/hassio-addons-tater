# Tater AI Assistant (Home Assistant add-on)

Tater is an AI assistant that connects to any OpenAI API–compatible LLM, with
deep Home Assistant integration via plugins like:

- `web_search` – LLM with web search inside Assist
- `ha_control` – control lights, switches, media players, etc.
- `events_query` – summarize stored house events
- `mister_remote`, `overseerr_*`, `comfyui_*`, and more

## Configuration

In the **Configuration** tab, set:

- **LLM_HOST**  
  Host URL of your LLM server (Ollama, LM Studio, LocalAI, or `https://api.openai.com`).

- **LLM_PORT**  
  Port of the LLM server (leave blank or `0` when using `https://api.openai.com`).

- **LLM_MODEL**  
  Model name, e.g. `gemma3-27b-abliterated`, `qwen3-next-80b`, or `gpt-4o`.

- **LLM_API_KEY**  
  Required when using ChatGPT / OpenAI or any API-key-protected backend.

- **REDIS_HOST / REDIS_PORT**  
  Where Tater should find Redis. This can be:
  - Another Home Assistant add-on (Redis), or
  - An external Redis-Stack instance on your network.

After configuring, click **Save** and then **Restart** the add-on.

## First-time setup

1. Start the add-on.
2. Click **Open Web UI** to launch the Tater Streamlit interface.
3. In the WebUI:
   - Verify your LLM connection in **Chat Settings**.
   - Configure plugins like **Home Assistant**, **Overseerr**, **ComfyUI**, etc.
   - Enable the `homeassistant` and `ha_automations` platforms if you want Tater
     wired into Assist and automation bridges.

## Using Tater with Assist / Conversation

Once the `homeassistant` platform is enabled in Tater:

1. In Home Assistant, go to **Settings → Voice Assistants → Assist Pipelines**.
2. Add an external conversation agent pointing at the Tater HA bridge, for example:

   - URL: `http://homeassistant.local:8787/tater-ha/v1/query`  
   - Method: `POST`

3. Follow the Tater README for details on the expected payload and responses.

## Logs

Add-on logs show:

- Tater Streamlit startup
- LLM connectivity messages
- Plugin activity
- The Home Assistant bridge health endpoint (`/tater-ha/v1/health`)

You can view these under **Settings → Add-ons → Tater AI Assistant → Logs**.
