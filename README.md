# Tater Add-ons for Home Assistant

This repository contains Home Assistant add-ons for running
[Tater](https://github.com/TaterTotterson/Tater) and its required services
directly on your Home Assistant system.

## 🥔 Install Tater for Home Assistant

First, add the Tater add-on repository to Home Assistant:

[![Add Repository to Home Assistant](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](
https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/TaterTotterson/hassio-addons-tater
)

Once the repository has been added, **both add-ons will appear automatically**
in the Home Assistant Add-on Store.

## 🧠 Install Redis Stack

Tater uses Redis for memory, plugins, and automations.

1. Open **Settings → Add-ons → Add-on Store**
2. Find **Redis Stack** under the Tater add-on repository
3. Install and **start** Redis Stack

Redis Stack should be running before Tater is started.

## 🤖 Install Tater AI Assistant

After Redis Stack is installed and running:

1. Open **Settings → Add-ons → Add-on Store**
2. Find **Tater AI Assistant** under the Tater add-on repository
3. Install Tater
4. Configure your LLM settings
5. Start the Tater add-on

### ✅ Post-install setup (one-time)

After installing Tater, you must configure your LLM settings.
Redis will auto-connect if the Redis add-on is installed, but the LLM does
require manual setup.

#### 🧠 Configure your LLM

Open:

**Settings → Add-ons → Tater → Configuration**

Tater supports **both local LLM backends and cloud APIs like ChatGPT**.
Choose **one** of the options below.

##### Option A: Local LLM (Ollama, LM Studio, LocalAI)

llm_host: http://<your-llm-host>
llm_port: 11434
llm_model: <model-name>

Examples:
- llm_model: llama3.1
- llm_model: gemma3-27b-abliterated

No API key is required for local backends.

 ---

##### Option B: ChatGPT / OpenAI-compatible APIs
```
 llm_host: https://api.openai.com
llm_port:
llm_model: gpt-4o
llm_api_key: sk-xxxxxxxxxxxxxxxxxxxxxxxx
```
Notes:
- Leave `llm_port` blank when using HTTPS-based APIs
- llm_api_key is required only for ChatGPT / OpenAI-style services
- The API key field is stored securely and hidden in the Home Assistant UI

---

##### Leaving the API key blank

If you are not using ChatGPT or another cloud API:
- Leave llm_api_key empty
- Tater will ignore it and run normally with local models

After updating your LLM settings, click **Save** and then **Restart** the Tater add-on.

---

### 🧠 Redis (automatic)

If a Redis add-on is installed, Tater will automatically connect with no additional configuration.

Defaults used by Tater:
- Redis Stack add-on from this repository → redis_host: localhost

You only need to change Redis settings if you are using an external Redis server.

---

### ✅ You’re ready to go

Once Redis is running and the LLM settings are configured, open the Tater Web UI
from the add-on page and start chatting.

Tater will now integrate with Home Assistant, plugins, and automations automatically.
