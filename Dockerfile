# Use an official CUDA base image
FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

# Set environment variables
ENV PYTHON_VERSION=3.10
ENV TZ=Europe/Bratislava
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /eDo

# Update and install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends gnupg2 curl ca-certificates && \
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub | apt-key add - && \
    apt-get update && \
    apt-get install -y \
    wget \
    build-essential \
    bzip2 \
    csh \
    libglib2.0-0 \
    libxext6 \
    libsm6 \
    libxrender1 \
    git \
    mercurial \
    subversion \
    python3.10 \
    python3-pip \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a symlink for python
RUN ln -s /usr/bin/python3 /usr/bin/python

# Run the install script
ENV PIP_CACHE_DIR=/tmp/pip-cache
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --cache-dir=$PIP_CACHE_DIR -r /tmp/requirements.txt

# Set the default command to run bash
CMD ["/bin/bash"]
