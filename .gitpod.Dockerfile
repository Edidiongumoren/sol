FROM gitpod/workspace-base:ubuntu-22.04

RUN sudo apt-get update && \
    sudo apt-get install -y \
    build-essential \
    libssl-dev \
    pkg-config
