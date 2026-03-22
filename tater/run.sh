#!/usr/bin/env bash
set -e

# Persist add-on runtime data under Home Assistant's config directory
TATER_DATA_ROOT="/config/tater"

# Ensure Agent Lab lives in Home Assistant's config for persistence
AGENT_LAB_ROOT="$TATER_DATA_ROOT/agent_lab"
AGENT_LAB_LINK="/app/agent_lab"
LEGACY_AGENT_LAB_ROOT="/config/agent_lab"

RUNTIME_ROOT="$TATER_DATA_ROOT/.runtime"
RUNTIME_LINK="/app/.runtime"
LEGACY_RUNTIME_ROOT="/config/.runtime"

mkdir -p "$TATER_DATA_ROOT"
mkdir -p "$AGENT_LAB_ROOT"
mkdir -p "$RUNTIME_ROOT"

if [ -d "$LEGACY_AGENT_LAB_ROOT" ] && [ -z "$(ls -A "$AGENT_LAB_ROOT" 2>/dev/null)" ] && [ -n "$(ls -A "$LEGACY_AGENT_LAB_ROOT" 2>/dev/null)" ]; then
  cp -a "$LEGACY_AGENT_LAB_ROOT"/. "$AGENT_LAB_ROOT"/
fi

if [ -L "$AGENT_LAB_LINK" ] && [ "$(readlink "$AGENT_LAB_LINK")" != "$AGENT_LAB_ROOT" ]; then
  rm "$AGENT_LAB_LINK"
fi

if [ -e "$AGENT_LAB_LINK" ] && [ ! -L "$AGENT_LAB_LINK" ]; then
  if [ -d "$AGENT_LAB_LINK" ] && [ -z "$(ls -A "$AGENT_LAB_LINK" 2>/dev/null)" ]; then
    rm -rf "$AGENT_LAB_LINK"
  elif [ -d "$AGENT_LAB_LINK" ] && [ -z "$(ls -A "$AGENT_LAB_ROOT" 2>/dev/null)" ]; then
    cp -a "$AGENT_LAB_LINK"/. "$AGENT_LAB_ROOT"/
    rm -rf "$AGENT_LAB_LINK"
  fi
fi

if [ ! -e "$AGENT_LAB_LINK" ]; then
  ln -s "$AGENT_LAB_ROOT" "$AGENT_LAB_LINK"
fi

if [ -d "$LEGACY_RUNTIME_ROOT" ] && [ -z "$(ls -A "$RUNTIME_ROOT" 2>/dev/null)" ] && [ -n "$(ls -A "$LEGACY_RUNTIME_ROOT" 2>/dev/null)" ]; then
  cp -a "$LEGACY_RUNTIME_ROOT"/. "$RUNTIME_ROOT"/
fi

if [ -L "$RUNTIME_LINK" ] && [ "$(readlink "$RUNTIME_LINK")" != "$RUNTIME_ROOT" ]; then
  rm "$RUNTIME_LINK"
fi

if [ -e "$RUNTIME_LINK" ] && [ ! -L "$RUNTIME_LINK" ]; then
  if [ -d "$RUNTIME_LINK" ] && [ -z "$(ls -A "$RUNTIME_LINK" 2>/dev/null)" ]; then
    rm -rf "$RUNTIME_LINK"
  elif [ -d "$RUNTIME_LINK" ] && [ -z "$(ls -A "$RUNTIME_ROOT" 2>/dev/null)" ]; then
    cp -a "$RUNTIME_LINK"/. "$RUNTIME_ROOT"/
    rm -rf "$RUNTIME_LINK"
  fi
fi

if [ ! -e "$RUNTIME_LINK" ]; then
  ln -s "$RUNTIME_ROOT" "$RUNTIME_LINK"
fi

echo "Starting Tater with:"
echo "  Redis setup is configured in Tater WebUI popup on first run"
echo "  Runtime config path: /app/.runtime/redis_connection.json"
echo "  Persistent data root: /config/tater"
echo "  LLM/Model settings are configured in Tater WebUI -> Settings -> Hydra Models"

# Your base image's WORKDIR is /app
cd /app

# Start TaterOS Web UI
export HTMLUI_HOST="0.0.0.0"
export HTMLUI_PORT="8501"
exec sh run_ui.sh
