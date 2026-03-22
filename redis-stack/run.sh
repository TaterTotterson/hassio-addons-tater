#!/bin/sh
set -eu

CONFIG_PATH="${CONFIG_PATH:-/data/options.json}"

ALLOW_EMPTY_PASSWORD="true"
REDIS_PASSWORD=""

if [ -f "$CONFIG_PATH" ]; then
  ALLOW_EMPTY_PASSWORD="$(jq -r 'if .allow_empty_password == null then true else .allow_empty_password end' "$CONFIG_PATH")"
  REDIS_PASSWORD="$(jq -r '.redis_password // empty' "$CONFIG_PATH")"
fi

if [ -n "$REDIS_PASSWORD" ] && [ "$REDIS_PASSWORD" != "null" ]; then
  export REDIS_ARGS="--requirepass ${REDIS_PASSWORD}"
  echo "Starting Redis Stack with password authentication enabled"
elif [ "$ALLOW_EMPTY_PASSWORD" = "true" ]; then
  unset REDIS_ARGS || true
  echo "Starting Redis Stack without password authentication"
else
  echo "ERROR: redis_password is required when allow_empty_password is false."
  exit 1
fi

if [ "$#" -eq 0 ]; then
  echo "ERROR: No startup command provided by base image."
  exit 1
fi

exec "$@"
