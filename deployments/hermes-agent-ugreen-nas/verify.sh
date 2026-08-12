#!/bin/sh
set -eu

compose="docker compose"
base_url="http://${NAS_LAN_IP:?Set NAS_LAN_IP}:8642"

echo "1/6 Container state"
$compose ps --status running hermes

echo "2/6 Runtime identity"
$compose exec -T hermes id

echo "3/6 Health endpoint"
curl --fail --silent --show-error "$base_url/health"
printf '\n'

echo "4/6 Unauthenticated API rejection"
status="$(curl --silent --output /dev/null --write-out '%{http_code}' "$base_url/v1/models")"
case "$status" in 401|403) ;; *) echo "Expected 401 or 403, received $status" >&2; exit 1 ;; esac

echo "5/6 Persistent configuration"
$compose exec -T hermes sh -c 'test -r /opt/data/config.yaml && test -r /opt/data/.env'

echo "6/6 Permission errors in recent logs"
if $compose logs --tail=200 hermes | grep -iE 'permission denied|config.*error'; then
  echo "Found a possible configuration or permission error" >&2
  exit 1
fi

echo "Core verification passed. Test the Telegram allowlist manually."
