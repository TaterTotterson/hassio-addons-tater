#!/usr/bin/env bash
set -e

CONFIG_PATH=/data/options.json

# Read user options from Home Assistant
LLM_HOST=$(jq -r '.llm_host // "10.4.20.210"' "$CONFIG_PATH")
LLM_PORT=$(jq -r '.llm_port // empty' "$CONFIG_PATH")
LLM_MODEL=$(jq -r '.llm_model // "qwen/qwen3-next-80b"' "$CONFIG_PATH")
LLM_API_KEY=$(jq -r '.llm_api_key // empty' "$CONFIG_PATH")
REDIS_HOST=$(jq -r '.redis_host // "localhost"' "$CONFIG_PATH")
REDIS_PORT=$(jq -r '.redis_port // 6379' "$CONFIG_PATH")

export LLM_HOST="$LLM_HOST"
export LLM_PORT="$LLM_PORT"
export LLM_MODEL="$LLM_MODEL"
export LLM_API_KEY="$LLM_API_KEY"
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
echo "  LLM_HOST=${LLM_HOST}"
if [ -n "$LLM_PORT" ]; then
  echo "  LLM_PORT=${LLM_PORT}"
else
  echo "  LLM_PORT=(not set)"
fi
echo "  LLM_MODEL=${LLM_MODEL}"

if [ -n "$LLM_API_KEY" ]; then
  echo "  LLM_API_KEY=set"
else
  echo "  LLM_API_KEY=not set"
fi

echo "  REDIS_HOST=${REDIS_HOST}"
echo "  REDIS_PORT=${REDIS_PORT}"

# Your base image's WORKDIR is /app
cd /app

# Start Streamlit
exec streamlit run webui.py --server.address 0.0.0.0 --server.port 8501
