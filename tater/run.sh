#!/usr/bin/env bash
set -e

# Point Tater directly at Home Assistant's persistent config storage. Using
# Tater's supported path overrides avoids relying on container-local /app
# directories or symlinks that disappear when Supervisor recreates the add-on.
TATER_DATA_ROOT="${TATER_DATA_ROOT:-/config/tater}"
export TATER_AGENT_ROOT="${TATER_AGENT_ROOT:-$TATER_DATA_ROOT/agent_lab}"
export TATER_RUNTIME_DIR="${TATER_RUNTIME_DIR:-$TATER_DATA_ROOT/.runtime}"
export TATER_NATIVE_SATELLITE_CREDENTIALS_PATH="${TATER_NATIVE_SATELLITE_CREDENTIALS_PATH:-$TATER_RUNTIME_DIR/native_satellite_credentials.json}"

mkdir -p "$TATER_AGENT_ROOT" "$TATER_RUNTIME_DIR"

echo "Starting Tater with:"
echo "  Redis setup is configured in Tater WebUI popup on first run"
echo "  Agent Lab path: $TATER_AGENT_ROOT"
echo "  Runtime path: $TATER_RUNTIME_DIR"
echo "  Native satellite credentials: $TATER_NATIVE_SATELLITE_CREDENTIALS_PATH"
echo "  LLM/Model settings are configured in Tater WebUI -> Settings -> Hydra Models"

# Your base image's WORKDIR is /app
cd /app

# Start TaterOS Web UI
export HTMLUI_HOST="0.0.0.0"
export HTMLUI_PORT="8501"
exec sh run_ui.sh
