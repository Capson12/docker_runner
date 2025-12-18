#!/bin/bash

read -p "Enter Container Name (Docker or Terraform): " FOLDER_NAME

read -p "Enter Repository Name, for your Runner: " REPO_NAME

read -p "Enter Repository Token, for your access: " REPO_TOKEN

read -p "Enter Container Name: " RUNNER_CONTAINER



docker build -t $RUNNER_CONTAINER dck-runner-builder/repo/github/runners/$FOLDER_NAME

docker run -d $RUNNER_CONTAINER $REPO_NAME $REPO_TOKEN