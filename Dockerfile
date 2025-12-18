# Dockerfile for LaTeX CV Template Project
# Provides consistent LaTeX environment for building CVs and cover letters
FROM texlive/texlive:latest

# Install additional dependencies
RUN apt-get update && \
    apt-get install -y \
    make \
    poppler-utils \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace

# Default command
CMD ["/bin/bash"]

