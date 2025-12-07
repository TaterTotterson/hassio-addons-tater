#!/usr/bin/env bash
set -e

CONFIG_PATH=/data/options.json

# Read user options from Home Assistant (with sane defaults)
LLM_HOST=$(jq -r '.llm_host // "10.4.20.210"' "$CONFIG_PATH")
LLM_PORT=$(jq -r '.llm_port // 1234' "$CONFIG_PATH")
LLM_MODEL=$(jq -r '.llm_model // "qwen/qwen3-next-80b"' "$CONFIG_PATH")
REDIS_HOST=$(jq -r '.redis_host // "core-redis_stack"' "$CONFIG_PATH")
REDIS_PORT=$(jq -r '.redis_port // 6379' "$CONFIG_PATH")

export LLM_HOST="$LLM_HOST"
export LLM_PORT="$LLM_PORT"
export LLM_MODEL="$LLM_MODEL"
export REDIS_HOST="$REDIS_HOST"
export REDIS_PORT="$REDIS_PORT"

echo "Starting Tater with:"
echo "  LLM_HOST=${LLM_HOST}"
echo "  LLM_PORT=${LLM_PORT}"
echo "  LLM_MODEL=${LLM_MODEL}"
echo "  REDIS_HOST=${REDIS_HOST}"
echo "  REDIS_PORT=${REDIS_PORT}"

# Your base image's WORKDIR is /app; make sure we're there
cd /app

# Start the same thing your prebuilt image would have started
exec streamlit run webui.py --server.address 0.0.0.0 --server.port 8501
