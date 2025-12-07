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

Set **one** of the following:

##### Option A: Local LLM (Ollama, LM Studio, LocalAI)
```yaml
llm_host: http://<your-llm-host>:11434
llm_model: <model-name>
```
Examples:
- llm_model: llama3.1
- llm_model: gemma3-27b-abliterated

After setting your LLM options, click **Save** and then **Restart** the Tater add-on.

---

### 🧠 Redis (automatic)

If a Redis add-on is installed, Tater will automatically connect with no additional configuration.

Defaults used by Tater:
- Official Home Assistant Redis add-on → redis_host: core-redis
- Redis Stack add-on from this repository → redis_host: core-redis_stack

You only need to change Redis settings if you are using an external Redis server.

---

### ✅ You’re ready to go

Once Redis is running and the LLM settings are configured, open the Tater Web UI
from the add-on page and start chatting.

Tater will now integrate with Home Assistant, plugins, and automations automatically.
