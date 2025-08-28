# DuckDB Docker & Helm Chart

This repository contains a complete solution for running DuckDB in containers and deploying it on Kubernetes using Helm charts.

## 🐳 Docker Image

### Features

- Configurable extensions support
- Persistent data directory at `/duckdb/data`
- DuckDB configuration directory at `/root/.duckdb`

### Running the Container

```bash
# Basic CLI mode
docker run -it duckdb:latest

# UI mode (exposes port 4213)
docker run -p 4213:4213 -it duckdb:latest -ui

# With persistent data
docker run -v $(pwd)/data:/duckdb/data -it duckdb:latest

# With custom configuration
docker run -v $(pwd)/duckdbrc:/root/.duckdb/duckdbrc -it duckdb:latest
```

## 🚀 Helm Chart

### Features

- **DuckDB UI**: Web-based interface accessible on port 4213
- **Configurable Extensions**: Install and load DuckDB extensions automatically
- **Persistent Storage**: Configurable persistent volume for data storage
- **Custom Configuration**: ConfigMap-based duckdbrc configuration
- **Kubernetes Native**: Full Kubernetes integration with health checks

### Installation

```bash
# Add the Helm repository
helm repo add beslovas https://beslovas.github.io/duckdb
helm repo update

# Install the chart
helm install my-duckdb beslovas/duckdb

# Install with custom values
helm install my-duckdb beslovas/duckdb \
  --set persistence.size=20Gi \
  --set duckdb.extensions[0]=httpfs \
  --set duckdb.extensions[1]=parquet
```

### Configuration

The chart supports extensive configuration through `values.yaml`:

```yaml
duckdb:
  ui: true
  extensions:
    - httpfs
    - parquet
    - json
    - sqlite
  config:
    memory_limit: "2GB"
    threads: 8

persistence:
  enabled: true
  size: 20Gi
  storageClass: "fast-ssd"

service:
  type: LoadBalancer
  port: 4213
```

### Available Extensions

- `httpfs`: HTTP file system support
- `parquet`: Parquet file format support
- `json`: JSON functions and operators
- `sqlite`: SQLite compatibility
- `postgres`: PostgreSQL compatibility
- `mysql`: MySQL compatibility
- `excel`: Excel file support
- `arrow`: Apache Arrow support

## 📚 Documentation

### Helm Chart Documentation

See [helm/duckdb/README.md](helm/duckdb/README.md) for detailed Helm chart documentation.

### API Reference

- **DuckDB Documentation**: https://duckdb.org/docs/
- **Helm Documentation**: https://helm.sh/docs/
- **Kubernetes Documentation**: https://kubernetes.io/docs/

### Prerequisites

- Kubernetes 1.19+
- Helm 3.0+

## 📄 License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [DuckDB Team](https://duckdb.org/) for the excellent database

