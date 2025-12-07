#!/usr/bin/env bash
set -e

CONFIG_PATH=/data/options.json

echo "[Tater add-on] Using config at ${CONFIG_PATH}"

if [ -f "$CONFIG_PATH" ]; then
  # Read values from HA options.json
  LLM_HOST=$(jq -r '.llm_host // empty' "$CONFIG_PATH")
  LLM_PORT=$(jq -r '.llm_port // empty' "$CONFIG_PATH")
  LLM_MODEL=$(jq -r '.llm_model // empty' "$CONFIG_PATH")
  REDIS_HOST=$(jq -r '.redis_host // empty' "$CONFIG_PATH")
  REDIS_PORT=$(jq -r '.redis_port // empty' "$CONFIG_PATH")

  # Export only if set
  [ -n "$LLM_HOST" ]   && export LLM_HOST
  [ -n "$LLM_PORT" ]   && export LLM_PORT
  [ -n "$LLM_MODEL" ]  && export LLM_MODEL
  [ -n "$REDIS_HOST" ] && export REDIS_HOST
  [ -n "$REDIS_PORT" ] && export REDIS_PORT
fi

# Sensible defaults if Redis fields are missing
export REDIS_HOST="${REDIS_HOST:-core-redis_stack}"
export REDIS_PORT="${REDIS_PORT:-6379}"

echo "[Tater add-on] Starting with:"
echo "  LLM_HOST=${LLM_HOST:-<unset>}"
echo "  LLM_PORT=${LLM_PORT:-<unset>}"
echo "  LLM_MODEL=${LLM_MODEL:-<unset>}"
echo "  REDIS_HOST=${REDIS_HOST}"
echo "  REDIS_PORT=${REDIS_PORT}"

# Start Tater WebUI (your original image uses Streamlit)
exec streamlit run webui.py --server.address 0.0.0.0 --server.port 8501
