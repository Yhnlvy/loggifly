# 🏗️ Local Build Guide

## 📋 Prerequisites

- Docker and Docker Compose installed
- Access to Docker socket (`/var/run/docker.sock`)
- Basic knowledge of YAML configuration

## 🚀 Quick Start

### 1. Configuration Preparation

Create the configuration directory and copy the template:

```bash
# Create configuration directory
mkdir -p loggifly/config

# Copy the template and edit it
cp config_template.yaml loggifly/config/config.yaml
# Then edit the file according to your needs
```

**Important**: The configuration file must be placed in `./loggifly/config/config.yaml` for the local build.

### 2. Build and Start

```bash
# Build the image from local source code
docker-compose -f docker-compose-local.yaml build

# Start the container
docker-compose -f docker-compose-local.yaml up -d

# View logs
docker-compose -f docker-compose-local.yaml logs -f
```

## 🔧 Development Commands

```bash
# Stop the container
docker-compose -f docker-compose-local.yaml down

# Rebuild after code modification
docker-compose -f docker-compose-local.yaml build --no-cache

# Restart after rebuild
docker-compose -f docker-compose-local.yaml up -d

# View logs in real-time
docker-compose -f docker-compose-local.yaml logs -f loggifly
```

## 🔄 Development

### Configuration Structure

The local build uses a specific directory structure:

```
loggifly/
├── docker-compose-local.yaml
├── loggifly/
│   └── config/
│       └── config.yaml          # Your configuration
├── app/                         # Source code
├── Dockerfile
└── config_template.yaml         # Template
```

### Example Configuration

```yaml
# Containers to monitor
containers:
  - name: my-app

# Global keywords
global_keywords:
  keywords:
    - error
    - warning
  keywords_with_attachment:
    - critical

notifications:
  debug:
    enabled: true

settings:
  log_level: DEBUG
  monitor_all_containers: false
```

### Quick Configuration

```bash
# Create your configuration
cp config_template.yaml loggifly/config/config.yaml
# Edit according to your needs
nano loggifly/config/config.yaml
```

## 🐛 Troubleshooting

### Build Issues

```bash
# Clean and rebuild completely
docker-compose -f docker-compose-local.yaml down
docker system prune -f
docker-compose -f docker-compose-local.yaml build --no-cache
```

### Docker Permission Issues

```bash
# Check that the user can access the Docker socket
sudo usermod -aG docker $USER
# Then restart the session
```

### Debug Logs

```bash
# View detailed logs
docker-compose -f docker-compose-local.yaml logs -f
```

## 🔗 Differences from Registry Version

- **Local Build**: Uses source code from the current directory
- **Registry Version**: Uses pre-built image from Docker Hub
- **Configuration**: Local build requires `./loggifly/config/config.yaml`
- **Development**: Local build allows real-time code modification

## 📚 Ressources

- [Documentation principale](README.md)
- [Template de configuration](config_template.yaml)
- [Exemple de configuration](config_example.yaml)
