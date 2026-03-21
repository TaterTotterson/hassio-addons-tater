#!/usr/bin/env bash
set -e

CONFIG_PATH=/data/options.json

# Read user options from Home Assistant
REDIS_HOST=$(jq -r '.redis_host // "localhost"' "$CONFIG_PATH")
REDIS_PORT=$(jq -r '.redis_port // 6379' "$CONFIG_PATH")

export REDIS_HOST="$REDIS_HOST"
export REDIS_PORT="$REDIS_PORT"

# Ensure Agent Lab lives in Home Assistant's config for persistence
AGENT_LAB_ROOT="/config/agent_lab"
AGENT_LAB_LINK="/app/agent_lab"

mkdir -p "$AGENT_LAB_ROOT"

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

echo "Starting Tater with:"
echo "  REDIS_HOST=${REDIS_HOST}"
echo "  REDIS_PORT=${REDIS_PORT}"
echo "  LLM/Model settings are configured in Tater WebUI -> Settings -> Hydra Models"

# Your base image's WORKDIR is /app
cd /app

# Start TaterOS Web UI
export HTMLUI_HOST="0.0.0.0"
export HTMLUI_PORT="8501"
exec sh run_ui.sh
