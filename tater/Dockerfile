# Use your existing prebuilt Tater image as the base
FROM ghcr.io/tatertotterson/tater:latest

# Install jq so we can read /data/options.json
RUN apt-get update \
    && apt-get install -y --no-install-recommends jq ca-certificates curl gnupg \
    && rm -rf /var/lib/apt/lists/*

COPY install_guardian_tunnels.sh /tmp/install_guardian_tunnels.sh
RUN sh /tmp/install_guardian_tunnels.sh && rm -f /tmp/install_guardian_tunnels.sh

# Copy the run script
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Use our wrapper as the container entrypoint
CMD ["/run.sh"]
