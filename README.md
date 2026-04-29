# baikal-docker
Baïkal CalDAV and CardDAV Server in Docker

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
