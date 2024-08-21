FROM ubuntu:22.04

# Set environment variables to non-interactive
ENV DEBIAN_FRONTEND=non-interactive

# Update package list and install essential packages
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    llvm-11 llvm-11-dev \
    clang \
    nasm \
    cmake \
    pkg-config \
    git \
    wget \
    unzip \
    curl

# Clean up to reduce image size
RUN   apt-get autoremove -y && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/*

# Install google-test
RUN wget -O google-test.zip https://github.com/google/googletest/archive/03597a01ee50ed33e9dfd640b249b4be3799d395.zip && \
    unzip google-test.zip && \
    cd googletest-* && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install && \
    cd ../../ && \
    rm -rf google-test.zip googletest-*

# Reset environment variable
ENV DEBIAN_FRONTEND=

# Set the working directory
WORKDIR /workspace

# Set the default command
CMD ["bash"]