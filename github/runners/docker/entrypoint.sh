#!/bin/bash

# Check if the required arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <repo_name> <repo_token> <runner_name>"
    exit 1
fi

REPO_NAME=$1
GITHUB_TOKEN=$2
RUNNER_NAME=$3
GITHUB_URL="https://github.com/Capson12/$REPO_NAME"

# Start Docker daemon in the background
sudo dockerd > /tmp/dockerd.log 2>&1 &

# # Wait for Docker daemon to be ready
# echo "Waiting for Docker daemon to start..."
# for i in {1..30}; do
#     if docker info > /dev/null 2>&1; then
#         echo "Docker daemon is ready!"
#         break
#     fi
#     sleep 1
# done

# if ! docker info > /dev/null 2>&1; then
#     echo "Failed to start Docker daemon"
#     cat /tmp/dockerd.log
#     exit 1
# fi

# Configure the runner using expect
expect << EOF
spawn ./config.sh --url $GITHUB_URL --token $GITHUB_TOKEN

send -- "\r"
send -- "$RUNNER_NAME\r"
send -- "docker\r"
send -- "\r"

expect eof
EOF

# Start the runner
./run.sh
