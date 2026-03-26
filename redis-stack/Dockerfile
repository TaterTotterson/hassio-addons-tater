FROM redis/redis-stack:7.4.0-v8

RUN apt-get update \
    && apt-get install -y --no-install-recommends jq \
    && rm -rf /var/lib/apt/lists/*

COPY run.sh /run.sh
RUN chmod +x /run.sh

# Start with add-on option handling, then delegate to Redis Stack startup.
ENTRYPOINT ["/run.sh"]
CMD ["/entrypoint.sh"]
