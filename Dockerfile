FROM python:3.11-slim

# Install system dependencies: git, curl, build tools (for C extensions like pylcs), Node.js v20 LTS
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    ca-certificates \
    build-essential \
    python3-dev \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Verify versions
RUN python --version && node --version && npm --version

WORKDIR /app

# Install Moonshot with all components (cache mount avoids re-downloading on rebuilds)
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install "aiverify-moonshot[all]"

# Download moonshot-data and moonshot-ui into /app
RUN python -m moonshot -i moonshot-data -i moonshot-ui

EXPOSE 3000

CMD ["python", "-m", "moonshot", "web"]
