#!/bin/bash

# Check if the required arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <repo_name> <repo_token>"
    exit 1
fi

REPO_NAME=$1
GITHUB_TOKEN=$2
GITHUB_URL="https://github.com/Capson12/$REPO_NAME"

# Configure the runner using expect
expect << EOF
spawn ./config.sh --url $GITHUB_URL --token $GITHUB_TOKEN

send -- "\r"
send -- "\r"
send -- "\r"
send -- "\r"

expect eof
EOF

# Start the runner
./run.sh


