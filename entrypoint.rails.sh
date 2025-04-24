#!/bin/bash
set -e

# Define the app directory 
APP_DIR="/app"

# Remove a potentially pre-existing server.pid for Rails
rm -f $APP_DIR/tmp/pids/server.pid

# Only install dependencies in development mode
if [ "$RAILS_ENV" != "production" ]; then
  # Remove the Gemfile.lock and let bundler rebuild it if in dev mode
  rm -f $APP_DIR/Gemfile.lock
  bundle install --no-deployment
fi

# Create a monkeypatch file to fix Logger issue
mkdir -p $APP_DIR/config/initializers
cat > $APP_DIR/config/initializers/logger_fix.rb <<EOF
require 'logger'
module ActiveSupport
  module LoggerThreadSafeLevel
    module Logger
      # Implement the missing Logger module to fix compatibility issues
      def local_level
        @local_level
      end

      def local_level=(level)
        @local_level = level
      end
    end
  end
end
EOF

# Wait for the database to be ready
echo "Waiting for database to be ready..."
max_attempts=30
counter=0
until pg_isready -h $DATABASE_HOST -p $DATABASE_PORT -U $DATABASE_USER || [ $counter -eq $max_attempts ]
do
  echo "Waiting for database connection..."
  sleep 2
  ((counter++))
done

# Run database migrations if in production or manually triggered
if [ "$RAILS_ENV" = "production" ] || [ "$RUN_MIGRATIONS" = "true" ]; then
  echo "Running database migrations..."
  bundle exec rails db:migrate
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile)
exec "$@" 