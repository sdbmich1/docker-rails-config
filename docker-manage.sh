#!/bin/bash
# Docker management script for the multi-container application

# Check if .env file exists, if not, create it from template
if [ ! -f .env ]; then
  if [ -f env.example ]; then
    echo "Creating .env file from template..."
    cp env.example .env
    echo "Please edit .env file with your credentials."
    exit 1
  else
    echo "Error: env.example file not found."
    exit 1
  fi
fi

# Function to display help information
show_help() {
  echo "Docker Container Management Script"
  echo ""
  echo "Usage: $0 [command]"
  echo ""
  echo "Commands:"
  echo "  build       Build all containers"
  echo "  build-api   Build only the API container"
  echo "  up          Start all containers in detached mode"
  echo "  up-api      Start only the API container"
  echo "  down        Stop all containers"
  echo "  logs        View logs from all containers"
  echo "  logs-api    View logs from the API container"
  echo "  shell-api   Open a shell in the API container"
  echo "  restart     Restart all containers"
  echo "  clean       Remove all containers and volumes"
  echo "  help        Display this help message"
  echo ""
}

# Check if command is provided
if [ $# -eq 0 ]; then
  show_help
  exit 1
fi

# Execute command based on argument
case "$1" in
  build)
    docker compose build
    ;;
  build-api)
    docker compose build api
    ;;
  up)
    docker compose up -d
    echo "Containers started. Use '$0 logs' to view logs."
    ;;
  up-api)
    docker compose up -d api
    echo "API container started. Use '$0 logs-api' to view logs."
    ;;
  down)
    docker compose down
    ;;
  logs)
    docker compose logs -f
    ;;
  logs-api)
    docker compose logs -f api
    ;;
  shell-api)
    docker compose exec api bash
    ;;
  restart)
    docker compose down
    docker compose up -d
    echo "Containers restarted. Use '$0 logs' to view logs."
    ;;
  clean)
    echo "Are you sure you want to remove all containers and volumes? [y/N]"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
      docker compose down -v
      echo "All containers and volumes removed."
    else
      echo "Operation cancelled."
    fi
    ;;
  help)
    show_help
    ;;
  *)
    echo "Unknown command: $1"
    show_help
    exit 1
    ;;
esac 