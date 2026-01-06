#!/bin/bash

# Check if the required arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <repo_name> <repo_token>"
    exit 1
fi

REPO_NAME=$1
GITHUB_TOKEN=$2
RUNNER_NAME=$3
GITHUB_URL="https://github.com/Capson12/$REPO_NAME"

# Configure the runner using expect

# 1.Runner Group
# 2.name of runner
# 3.Labels
# 4.Accept default settings
expect << EOF
spawn ./config.sh --url $GITHUB_URL --token $GITHUB_TOKEN


send -- "\r"
send -- "$RUNNER_NAME\r"
send -- "packer\r"
send -- "\r"

expect eof
EOF

# Start the runner
./run.sh

