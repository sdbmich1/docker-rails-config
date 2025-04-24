# Docker Container Setup

This repository contains Docker configurations for running a multi-container application with web and API components.

## Container Architecture

The application consists of the following containers:
- **web**: A Node.js web application
- **api**: A Ruby on Rails API
- **dev**: Development environment container
- **db**: PostgreSQL database
- **elasticsearch**: Search engine

## API Container

The API container runs a Ruby on Rails application that was fixed to address compatibility issues with the nokogiri gem.

### Ruby and Rails Compatibility

The API container uses Ruby 2.7 with Rails 6.1, which provides better compatibility for the dependencies used in the application, particularly nokogiri.

### Dockerfile Explanation

The `Dockerfile.rails` contains the following important components:

```dockerfile
FROM ruby:2.7 AS builder

# Install dependencies including PostgreSQL development files
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    postgresql-client \
    git \
    curl \
    libxml2-dev \
    libxslt-dev \
    pkg-config \
    zlib1g-dev \
    liblzma-dev \
    postgresql-server-dev-all

# ... other configuration ...

# Install specific bundler version
RUN gem install bundler -v 2.4.22

# Force using the system libraries for nokogiri
ENV NOKOGIRI_USE_SYSTEM_LIBRARIES=1

# Setup bundle config and force platform to avoid architecture-specific issues
RUN bundle config set --local without 'development test' && \
    bundle config set force_ruby_platform true
```

The key components that ensure compatibility:
1. **Ruby 2.7** instead of newer versions to maintain compatibility with Rails 6.1
2. **System libraries** for nokogiri to avoid compilation issues
3. **Specific bundler version** (2.4.22) compatible with Ruby 2.7
4. **force_ruby_platform** setting to avoid architecture-specific native extensions

### Entrypoint Script

The entrypoint script (`entrypoint.rails.sh`) performs several important tasks:

1. Removes any pre-existing server.pid file
2. Rebuilds the Gemfile.lock at runtime (in development mode)
3. Adds a monkeypatch for ActiveSupport Logger compatibility
4. Waits for the database to be ready before proceeding
5. Runs database migrations when appropriate
6. Starts the Rails server

## Version Control

This Docker configuration is version controlled using Git. Important files include:

- `Dockerfile.rails`: Multi-stage build for the Rails API container
- `entrypoint.rails.sh`: Entry point script for the Rails container
- `docker-compose.yml`: Configuration for all services
- `.gitignore`: Excludes unnecessary files from version control
- `docker-manage.sh`: Helper script for managing Docker containers

### Git Setup

To work with this repository:

```bash
# Clone the repository
git clone <repository-url>

# Create a new branch for your changes
git checkout -b feature/your-feature-name

# After making changes, stage them
git add .

# Commit your changes
git commit -m "Description of your changes"

# Push to the remote repository
git push origin feature/your-feature-name
```

## Building and Running

You can use the docker-manage.sh script to easily manage the containers:

```bash
# Set the script as executable (if not already)
chmod +x docker-manage.sh

# Show help
./docker-manage.sh help

# Build all containers
./docker-manage.sh build

# Build just the API container
./docker-manage.sh build-api

# Start all containers
./docker-manage.sh up

# Start just the API container
./docker-manage.sh up-api

# View logs from all containers
./docker-manage.sh logs

# View logs from the API container
./docker-manage.sh logs-api

# Open a shell in the API container
./docker-manage.sh shell-api

# Stop all containers
./docker-manage.sh down

# Clean up containers and volumes
./docker-manage.sh clean
```

Alternatively, you can use Docker Compose commands directly:

```bash
# Build all containers
docker compose build

# Build just the API container
docker compose build api

# Run all containers
docker compose up -d

# Run just the API container
docker compose up -d api

# Check API container logs
docker logs dev-api-1
```

## Troubleshooting

If you encounter issues with the nokogiri gem in the API container, check the following:

1. Ensure the Dockerfile.rails uses Ruby 2.7
2. Verify the NOKOGIRI_USE_SYSTEM_LIBRARIES environment variable is set
3. Check the entrypoint script is applying the Logger monkeypatch correctly 