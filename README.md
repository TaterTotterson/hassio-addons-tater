# Tater Add-ons for Home Assistant

This repository contains a Home Assistant add-on for running
[Tater](https://github.com/TaterTotterson/Tater) directly on your Home Assistant system.

## Add this repository to Home Assistant

1. In Home Assistant, go to **Settings → Add-ons → Add-on Store**.
2. Click the **⋮ (three dots)** menu in the top right and choose **Repositories**.
3. Add this URL:

   https://github.com/TaterTotterson/hassio-addons-tater

4. Press **Add**, then **Close**.
5. You’ll now see **Tater AI Assistant** in the list of available add-ons.

## Install the Tater add-on

1. Open **Tater AI Assistant** from the Add-on Store.
2. Click **Install**.
3. After installation:
   - Open the **Configuration** tab.
   - Set your LLM settings (host, model, API key).
   - Set Redis host/port (or point to your Redis add-on / external Redis).
4. Click **Start** to launch Tater.
5. Use **Open Web UI** to access the Tater Streamlit interface from inside Home Assistant.
