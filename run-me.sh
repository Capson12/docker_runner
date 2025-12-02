#!/bin/bash

read -p "Enter Container Name (Docker or Terraform): " FOLDER_NAME

read -p "Enter Repository Name, for your Runner: " REPO_NAME

read -p "Enter Repository Token, for your access: " REPO_TOKEN

read -p "Enter Container Name" RUNNER_CONTAINER

REPO_URL=git@github.com:Capson12/docker_runner.git


git clone --no-checkout $REPO_URL repo
cd repo

git sparse-checkout init --cone

git sparse-checkout set "github/$FOLDER_NAME"

git checkout

cd $FOLDER_NAME

docker build -t $RUNNER_CONTAINER .

docker run -d --name $REPO_NAME-$RUNNER_CONTAINER -e $REPO_NAME -e $REPO_TOKEN $RUNNER_CONTAINER