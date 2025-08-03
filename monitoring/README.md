# Monitoring

This directory contains the default configuration for monitoring PostgreSQL databases using Prometheus and Grafana, with metrics collection via `postgres-exporter`.

## Services

- **Prometheus**: Collects and stores database metrics via `postgres-exporter`.
- **Grafana**: Visualization of metrics and customizable dashboards.
- **postgres-exporter**: Exports PostgreSQL metrics to Prometheus.

## Structure

- `docker-compose.yaml`: Orchestrates all required monitoring services.
- `prometheus/prometheus.yml`: Prometheus configuration to scrape metrics from the exporter.
- `grafana/provisioning/datasources/datasource.yaml`: Automatically configures the Prometheus datasource in Grafana.

## Prerequisites

- Docker and Docker Compose installed.
- A running and accessible PostgreSQL database (adjust environment variable values in the `.env` file).

## How to use

1. Create environment variables with the correct values.
2. Start the monitoring environment:

   ```sh
   docker-compose up -d
   ```

3. Access the services:
   - Prometheus: http://localhost:9090
   - Grafana: http://localhost:3000

4. Import PostgreSQL + Prometheus dashboards into Grafana for advanced visualization.

## Notes

- This environment is intended for development and testing. For production, adjust sensitive variables and data persistence settings.
