# Use your existing prebuilt Tater image as the base
FROM ghcr.io/tatertotterson/tater:latest

# Install jq so we can read /data/options.json
RUN apt-get update \
    && apt-get install -y --no-install-recommends jq \
    && rm -rf /var/lib/apt/lists/*

# Copy the run script
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Use our wrapper as the container entrypoint
CMD ["/run.sh"]
