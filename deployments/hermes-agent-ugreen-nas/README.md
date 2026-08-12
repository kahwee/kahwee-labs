# Hermes Agent on a UGREEN NAS

Reproducible companion files for [How to Run Hermes Agent on a UGREEN NAS with Docker](https://kahwee.com/2026/hermes-agent-ugreen-nas-docker/).

## Deploy

1. Pull the Hermes image you intend to test.
2. Record its immutable digest with `docker image inspect nousresearch/hermes-agent:latest --format '{{index .RepoDigests 0}}'`.
3. Copy `.env.example` to `.env` and replace every placeholder.
4. Confirm the image's runtime UID and GID before changing host permissions.
5. Run `docker compose run --rm hermes setup`.
6. Run `docker compose up -d`.
7. Run `./verify.sh`.

The Compose file intentionally has no `latest` fallback. Port 8642 binds only to the supplied NAS LAN address. Do not port-forward it from a router.
