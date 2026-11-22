# Hermes Agent on a UGREEN NAS

Security-first companion files for [How to Run Hermes Agent on a UGREEN NAS with Docker](https://kahwee.com/2026/hermes-agent-ugreen-nas-docker/).

## Default posture

The default deployment is messaging-only:

- no host ports are published;
- secrets are stored in `.env` inside the chosen host data directory, not forwarded into Docker's inspectable container environment;
- the image must be pinned by digest;
- CPU, memory, and process counts are bounded;
- the container cannot gain new privileges;
- no Docker socket or broad NAS directory is mounted.

## Deploy

1. Pull the Hermes image you intend to test.
2. Record its immutable digest with `docker image inspect nousresearch/hermes-agent:latest --format '{{index .RepoDigests 0}}'`.
3. Copy `.env.example` to `.env` and replace the Compose-only placeholders.
4. Set `HERMES_DATA_DIR` to an existing, dedicated directory on the NAS. For an existing gateway, use its current mount source. For a new install, create the directory first and set `HERMES_UID` and `HERMES_GID` to its intended numeric owner and group. Compose refuses to create a missing directory.
5. Run `docker compose run --rm hermes setup`. Enter provider and messaging credentials in the wizard; Hermes writes them to the private data volume.
6. In the chosen data directory, check ownership and run `chmod 700 . && chmod 600 .env` as its owner.
7. In the data directory’s `config.yaml`, enable a circuit breaker for the unattended gateway:

   ```yaml
   tool_loop_guardrails:
     hard_stop_enabled: true
     hard_stop_after:
       exact_failure: 5
       idempotent_no_progress: 5
   ```

8. Run `docker compose up -d`.
9. Run `./verify.sh`.

Never commit the resulting `.env`, paste it into an issue, or mount the Docker socket. Backups of the data directory contain secrets, sessions, and memories; encrypt them and restrict access like the live directory.

## Optional API access

The API is disabled by default. If a local client requires it:

1. Generate a key with `openssl rand -hex 32`.
2. Add these values to the data directory’s `.env` on the NAS:

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
