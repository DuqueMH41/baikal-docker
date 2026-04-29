# baikal-docker
Baïkal CalDAV and CardDAV Server in Docker, will keep updating new versions, made with AI help, built from sabre.io official guide

# Baikal Docker (Custom)

Self-hosted Baikal (CalDAV/CardDAV) with Docker.

## Features

* Baikal 0.11.1
* PHP 8.3
* SQLite database
* Data stored in `data/`
* Config stored in `config/`

## Run

docker compose up -d --build

Access:
http://localhost:8080

## Volumes

* ./config → /var/www/baikal/config
* ./data → /var/www/baikal/Specific

## Usage

### Option 1 — Use prebuilt image docker compose example for UgreenNAS

```yaml
services:
  baikal:
    image: ghcr.io/duquemh41/baikal:latest
    container_name: Baikal
    restart: unless-stopped

    volumes:
      - /volume1/docker/baikal/config:/var/www/baikal/config
      - /volume1/docker/baikal/data:/var/www/baikal/Specific
```

### Option 2 — Build locally

```bash
git clone https://github.com/duquemh41/baikal-docker.git
cd baikal-docker
docker build -t baikal .
docker compose up -d
```
