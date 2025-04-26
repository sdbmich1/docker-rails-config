#!/bin/bash
set -e

# Debug environment variables
echo "Database connection details:"
echo "DATABASE_URL: $DATABASE_URL"

# Simple delay to wait for PostgreSQL to start
echo "Waiting for PostgreSQL to start..."
sleep 5
echo "Proceeding with application startup..."

# Check if gem is available
if command -v gem &> /dev/null; then
  # Verify rack-cors is installed and available
  echo "Verifying rack-cors gem installation..."
  if ! gem list rack-cors -i > /dev/null 2>&1; then
    echo "Installing rack-cors gem..."
    gem install rack-cors
  fi
  echo "rack-cors gem is installed"
else
  echo "gem command not found, skipping gem installation"
fi

# Setup Rails environment
cd /app
echo "Setting up database..."
if [ -f /app/bin/rails ]; then
  # Try to connect to database and run migrations - may fail if database isn't ready yet
  bundle exec rake db:create db:migrate 2>/dev/null || echo "Database setup not successful, will retry..."
  # If first attempt failed, wait a bit more and try again
  if [ $? -ne 0 ]; then
    echo "Waiting additional time for database..."
    sleep 5
    bundle exec rake db:create db:migrate 2>/dev/null || echo "Database setup still not successful. Check your connection settings."
  fi
fi

# Remove any existing server.pid file
rm -f /app/tmp/pids/server.pid

# Start Rails server
echo "Starting Rails server..."
exec "$@" 