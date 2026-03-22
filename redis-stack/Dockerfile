FROM redis/redis-stack:7.4.0-v8

RUN apt-get update \
    && apt-get install -y --no-install-recommends jq \
    && rm -rf /var/lib/apt/lists/*

COPY run.sh /run.sh
RUN chmod +x /run.sh

# Keep the base image CMD (starts Redis Stack + RedisInsight), but inject
# add-on option handling first.
ENTRYPOINT ["/run.sh"]
