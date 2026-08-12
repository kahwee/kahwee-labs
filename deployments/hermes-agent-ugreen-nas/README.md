# Hermes Agent on a UGREEN NAS

Security-first companion files for [How to Run Hermes Agent on a UGREEN NAS with Docker](https://kahwee.com/2026/hermes-agent-ugreen-nas-docker/).

## Default posture

The default deployment is messaging-only:

- no host ports are published;
- secrets are stored in `/volume1/docker/hermes/.env`, not forwarded into Docker's inspectable container environment;
- the image must be pinned by digest;
- the container cannot gain new privileges;
- no Docker socket or broad NAS directory is mounted.

## Deploy

1. Pull the Hermes image you intend to test.
2. Record its immutable digest with `docker image inspect nousresearch/hermes-agent:latest --format '{{index .RepoDigests 0}}'`.
3. Copy `.env.example` to `.env` and replace the Compose-only placeholders.
4. Confirm the image's runtime UID and GID before changing host permissions.
5. Run `docker compose run --rm hermes setup`. Enter provider and messaging credentials in the wizard; Hermes writes them to the private data volume.
6. On the NAS, run `chmod 700 /volume1/docker/hermes && chmod 600 /volume1/docker/hermes/.env`.
7. Run `docker compose up -d`.
8. Run `./verify.sh`.

Never commit the resulting `.env`, paste it into an issue, or mount the Docker socket.

## Optional API access

The API is disabled by default. If a local client requires it:

1. Generate a key with `openssl rand -hex 32`.
2. Add these values to `/volume1/docker/hermes/.env` on the NAS:

   ```env
   API_SERVER_ENABLED=true
   API_SERVER_HOST=0.0.0.0
   API_SERVER_PORT=8642
   API_SERVER_KEY=replace-with-the-generated-value
   ```

3. Start with the localhost-only override:

   ```bash
   docker compose -f compose.yaml -f compose.api.yaml up -d
   ```

4. Reach it from another machine through an SSH tunnel:

   ```bash
   ssh -L 8642:127.0.0.1:8642 your-user@your-nas
   ```

The client then connects to `http://127.0.0.1:8642` on your own machine. Do not change the host binding to `0.0.0.0`, port-forward it from a router, or send the API key over plain HTTP on a shared LAN. For persistent remote access, use an authenticated TLS reverse proxy or a private VPN and review the official Hermes security documentation.

Run `VERIFY_API=1 API_SERVER_KEY='your-key' ./verify.sh` on the NAS to include authenticated API checks. The script does not print the key.
