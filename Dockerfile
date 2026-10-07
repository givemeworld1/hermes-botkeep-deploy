# Hermes Agent - Botkeep Dockerfile
# Based on Hermes's official Dockerfile but simplified for Botkeep's runtime

FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    git \
    curl \
    libffi-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user (Botkeep runs as non-root)
RUN useradd -ms /bin/bash hermes
WORKDIR /app
RUN chown hermes:hermes /app

# Copy source code
COPY . /app

# Install Hermes in editable mode (setup.py allows editable installs)
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -e . 2>&1 || \
    pip install --no-cache-dir -r requirements.txt

# Set environment variables
ENV HERMES_HOME=/app/.hermes-data
ENV HERMES_WRITE_SAFE_ROOT=/app/.hermes-data
ENV PYTHONUNBUFFERED=1

# Run the gateway
CMD ["python", "main.py"]
