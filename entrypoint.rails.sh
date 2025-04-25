#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails
rm -f /app/tmp/pids/server.pid

# Ensure tmp directory exists
mkdir -p /app/tmp/pids

# Wait for database
echo "Waiting for postgres..."
while ! pg_isready -h db -p 5432 -U postgres; do
  sleep 1
done
echo "PostgreSQL started"

# Create and migrate database if needed
bundle exec rails db:prepare

# Then exec the container's main process
exec "$@" 