# devtools-kit

A Docker-based development infrastructure toolkit for learning and practicing essential tools in an isolated, containerized environment. Easily extend with additional services and tools as needed.

## About

This project provides a flexible, orchestrated environment for running multiple development services and tools locally. Services are defined in Docker Compose files and can be added, removed, or modified based on your learning goals.

## Quick Start

```bash
cd docker
docker-compose -f docker-compose.root.yaml up -d
```

All services will start and run in the background. Data is persisted across restarts.

## Services

Check individual `docker/[service-name]/` directories for service-specific setup, configuration, and documentation. Each service has its own Docker Compose file and README.

Available services:
- `docker/postgres/` - PostgreSQL setup
- `docker/monitoring/` - Prometheus & Grafana monitoring stack
- `docker/nexus/` - Maven artifact repository

Additional services can be added by creating new directories and Docker Compose configurations.

## How It Works

All services communicate via an internal Docker network. Each service runs in its own container and exposes specific ports for local access. Check the respective service directories for port mappings and configuration details.

## Tech Stack

- **Orchestration**: Docker & Docker Compose
- **Infrastructure**: Linux-based containerized services
- **Networking**: Docker bridge network (`devtools`)

## Project Structure

```
devtools-kit/
├── docker/
│   ├── docker-compose.root.yaml      # Main orchestration file
│   ├── [service-name]/
│   │   ├── docker-compose.yaml       # Service-specific configuration
│   │   ├── README.md                 # Service documentation
│   │   └── ...                       # Service-specific files
├── README.md                         # This file
└── LICENSE
```

## Adding New Services

To add a new service:

1. Create a new directory under `docker/[service-name]/`
2. Add a `docker-compose.yaml` with your service configuration
3. Include a `README.md` documenting setup, ports, and credentials
4. Reference it in `docker/docker-compose.root.yaml` or run independently

Example:
```bash
cd docker/[new-service]
docker-compose up -d
```

## Development Notes

- Each service is containerized and isolated
- Services share a Docker network for inter-container communication
- Data is persisted in named volumes (survives container restarts)
- This is a development/learning environment—not production-ready
- Refer to individual service READMEs for specific details, ports, and credentials

