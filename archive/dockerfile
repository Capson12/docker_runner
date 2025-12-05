FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive TZ=Europe/London

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    jq \
    git \
    tzdata \
    expect \
    unzip \
    gpg \
    lsb-release \
    && apt-get clean

# Install Terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list \
    && apt-get update && apt-get install -y terraform

# Create a user for the runner
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo \
    && echo "docker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
# Switch to the user
USER docker
WORKDIR /home/docker


#RUN sudo apt-get install expect -y

# Download the GitHub runner
RUN curl -o actions-runner-linux-x64-2.325.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.325.0/actions-runner-linux-x64-2.325.0.tar.gz \
    && tar xzf ./actions-runner-linux-x64-2.325.0.tar.gz \
    && rm ./actions-runner-linux-x64-2.325.0.tar.gz


# Install GitHub runner dependencies
RUN sudo ./bin/installdependencies.sh


# Add the entrypoint script
COPY entrypoint.sh .

# Make the script executable
RUN sudo chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
