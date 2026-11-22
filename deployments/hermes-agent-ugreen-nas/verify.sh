#!/bin/sh
set -eu

compose="docker compose"

echo "1/7 Container state"
$compose ps --status running hermes

echo "2/7 Runtime identity"
$compose exec -T --user hermes hermes id

echo "3/7 No API port published by default"
if [ "${VERIFY_API:-0}" != "1" ] && $compose port hermes 8642 >/dev/null 2>&1; then
  echo "Port 8642 is published. Use compose.api.yaml only when API access is intentional." >&2
  exit 1
fi

echo "4/7 Persistent configuration"
$compose exec -T --user hermes hermes sh -c 'test -x /opt/data && test -w /opt/data && test -r /opt/data/config.yaml && test -r /opt/data/.env'

echo "5/7 Secret-file permissions"
env_mode="$($compose exec -T --user hermes hermes stat -c '%a' /opt/data/.env)"
case "$env_mode" in 600|400) ;; *) echo "/opt/data/.env must be mode 600 or 400; found $env_mode" >&2; exit 1 ;; esac

echo "6/7 No placeholder credentials"
if ! $compose exec -T --user hermes hermes sh -c '
  if grep -qE "replace-with|your-(key|token|id)" /opt/data/.env; then exit 1; else test "$?" -eq 1; fi
'; then
  echo "Could not confirm absence of placeholders in /opt/data/.env" >&2
  exit 1
fi

echo "7/7 Permission errors in recent logs"
if $compose logs --tail=200 hermes | grep -qiE 'permission denied|config.*error'; then
  echo "Found a possible configuration or permission error" >&2
  exit 1
fi

if [ "${VERIFY_API:-0}" = "1" ]; then
  : "${API_SERVER_KEY:?Set API_SERVER_KEY only for this verification command}"
  base_url="http://127.0.0.1:8642"

  echo "API health endpoint"
  curl --fail --silent --show-error "$base_url/health"
  printf '\n'

  echo "Unauthenticated API rejection"
  status="$(curl --silent --output /dev/null --write-out '%{http_code}' "$base_url/v1/models")"
  case "$status" in 401|403) ;; *) echo "Expected 401 or 403, received $status" >&2; exit 1 ;; esac

  echo "Authenticated API access"
  curl --fail --silent --show-error -H "Authorization: Bearer $API_SERVER_KEY" "$base_url/v1/models" >/dev/null
fi

echo "Core verification passed. Test the messaging allowlist manually."
