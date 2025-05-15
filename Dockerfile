FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive


# Step 1: Install required packages for Docker installation
RUN sudo apt-get update && sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Step 2: Add Docker's official GPG key
RUN sudo mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Step 3: Set up the Docker stable repository
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Step 4: Install Docker Engine, CLI, and Containerd
RUN sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Step 5: Add your user to the docker group to manage Docker as a non-root user
RUN sudo groupadd docker
RUN sudo usermod -aG docker $USER

# Apply the new group membership
RUN newgrp docker
