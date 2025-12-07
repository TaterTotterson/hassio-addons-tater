# Wrapper image that *uses your prebuilt Tater image* as the base
ARG BUILD_FROM=ghcr.io/tatertotterson/tater:latest
FROM ${BUILD_FROM}

# Install jq so run.sh can parse /data/options.json
# (Assumes Debian/Ubuntu base image, which your Tater image uses.)
RUN apt-get update \
    && apt-get install -y --no-install-recommends jq \
    && rm -rf /var/lib/apt/lists/*

# Copy our HA entrypoint
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Use the wrapper script as the container command
CMD ["/run.sh"]
