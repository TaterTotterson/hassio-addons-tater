# Redis Stack (Home Assistant add-on)

Redis Stack provides Redis plus Redis modules used by Tater.

## Configuration

Use the add-on **Configuration** tab:

- `allow_empty_password` (`true`/`false`)
  - `true` allows Redis without authentication.
  - `false` requires `redis_password`.
- `redis_password` (optional unless `allow_empty_password` is `false`)
  - When set, Redis starts with `--requirepass <your_password>`.

## Notes for Tater

If you set `redis_password` here, enter the same password in Tater's Redis
setup popup (`Settings -> Redis`) so Tater can connect.

Default Redis endpoint from Home Assistant network:

- Host: `localhost`
- Port: `6379`

Redis data is persisted in `/data`.
