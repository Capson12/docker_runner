# Docker-in-Docker GitHub Actions Runner

This container provides a GitHub Actions self-hosted runner with Docker-in-Docker capabilities, Terraform, and Terragrunt pre-installed.

## Features

- Ubuntu 22.04 base image
- Docker-in-Docker support
- Terraform (v1.5.7)
- Terragrunt (latest)
- AWS CLI
- GitHub Actions Runner (v2.325.0)

## Building the Image

```bash
docker build -t github-runner-dind .
```

To specify custom Terraform or Terragrunt versions:

```bash
docker build --build-arg TF_VERSION=1.6.0 --build-arg TG_VERSION=v0.55.4 -t github-runner-dind .
```

## Running the Container

The container requires privileged mode to run Docker-in-Docker:

```bash
docker run --privileged -d \
  --name runner-dind \
  github-runner-dind <repo_name> <repo_token>
```

### Example:

```bash
docker run --privileged -d \
  --name runner-dind \
  github-runner-dind CVhtml AMWXDZXYCSTQHLPIRUODKXDI7IPFS
```

This will configure the runner for `https://github.com/Capson12/CVhtml`

## Important Notes

- The container **must** be run with `--privileged` flag for Docker-in-Docker to work
- The Docker daemon starts automatically when the container launches
- The runner user has sudo access and is added to the docker group
- Logs for the Docker daemon are stored in `/var/log/dockerd.log`

## Usage in GitHub Actions Workflows

Once the runner is registered, your workflows can use Docker commands:

```yaml
jobs:
  build:
    runs-on: self-hosted
    steps:
      - uses: actions/checkout@v3
      
      - name: Build Docker image
        run: docker build -t myapp .
      
      - name: Run Terraform
        run: terraform init && terraform plan
```

## Stopping the Container

```bash
docker stop runner-dind
docker rm runner-dind
```
