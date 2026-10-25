# Pin the add-on to the Tater release it was validated with. A config version
# bump makes Home Assistant rebuild the add-on and pull this release.
FROM ghcr.io/tatertotterson/tater:v1.9.0

# Install jq so we can read /data/options.json
RUN apt-get update \
    && apt-get install -y --no-install-recommends jq \
    && rm -rf /var/lib/apt/lists/*

# Copy the run script
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Use our wrapper as the container entrypoint
CMD ["/run.sh"]
