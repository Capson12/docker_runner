#!/bin/bash
set -e

# Configure runner, expects these env vars: GITHUB_URL, GITHUB_TOKEN, RUNNER_NAME
if [[ -z "$GITHUB_URL" || -z "$GITHUB_TOKEN" ]]; then
  echo "GITHUB_URL and GITHUB_TOKEN must be set as environment variables."
  exit 1
fi

if [[ -z "$RUNNER_NAME" ]]; then
  RUNNER_NAME="packer-runner-$(hostname)"
fi

cd /home/docker/actions-runner

# Remove previous config if exists
if [ -f .runner ]; then
  ./config.sh remove --unattended --token "$GITHUB_TOKEN" || true
fi

./config.sh \
  --unattended \
  --url "$GITHUB_URL" \
  --token "$GITHUB_TOKEN" \
  --name "$RUNNER_NAME" \
  --labels "packer,ubuntu" \
  --work "/home/docker/_work"

cleanup() {
  echo "Removing runner..."
  ./config.sh remove --unattended --token "$GITHUB_TOKEN"
}
trap 'cleanup; exit 130' INT TERM

# Start the runner
exec ./run.sh
