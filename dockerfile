FROM --platform=linux/arm64 ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive TZ=Europe/London

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    jq \
    git \
    tzdata \
    expect \
    && apt-get clean

# Create a user for the runner
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo \
    && echo "docker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
# Switch to the user
USER docker
WORKDIR /home/docker


#RUN sudo apt-get install expect -y

# Download the GitHub runner
RUN curl -o actions-runner-linux-arm64-2.320.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.320.0/actions-runner-linux-arm64-2.320.0.tar.gz \
    && tar xzf ./actions-runner-linux-arm64-2.320.0.tar.gz \
    && rm ./actions-runner-linux-arm64-2.320.0.tar.gz


# Install GitHub runner dependencies
RUN sudo ./bin/installdependencies.sh


# Add the entrypoint script
COPY entrypoint.sh .

# Make the script executable
RUN sudo chmod +x entrypoint.sh
#RUN sudo chmod +x wte.sh
RUN ./entrypoint.sh

ENTRYPOINT ["./run.sh"]
