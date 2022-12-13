## Basic docker Apache PHP

Basic image with Apache & PHP 8.1 based on Alpine 3.17

[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/StrapDown.js/graphs/commit-activity) [![Docker Pulls](https://badgen.net/docker/pulls/martinbouillaud/apache-php?icon=docker&label=pulls)](https://hub.docker.com/r/martinbouillaud/apache-php:latest)  [![Docker Image Size](https://img.shields.io/docker/image-size/martinbouillaud/apache-php?sort=date)](https://hub.docker.com/r/martinbouillaud/apache-php/) [![Github last-commit](https://img.shields.io/github/last-commit/bilyboy785/docker-apache-php)](https://github.com/bilyboy785/apache-php) ![Push to Docker Hub](https://github.com/bilyboy785/docker-apache-php/actions/workflows/push_docker_hub.yml/badge.svg) ![Push to Github Registry](https://github.com/bilyboy785/docker-apache-php/actions/workflows/push_github_registry.yml/badge.svg)

## Docker Image Utilization

```bash
docker pull martinbouillaud/apache-php:latest
```

## Environnement variables

- `SERVER_ADMIN` (a [server admin](https://httpd.apache.org/docs/2.4/fr/mod/core.html#serveradmin), defaults to `you@example.com`)
- `HTTP_SERVER_NAME` (a [server name](https://httpd.apache.org/docs/2.4/fr/mod/core.html#servername), defaults to `www.example.com`)
- `LOG_LEVEL` (a [log level](https://httpd.apache.org/docs/2.4/fr/mod/core.html#loglevel), defaults to `info`)
- `TZ` (a [timezone](https://www.php.net/manual/timezones.php), defaults to `UTC`)
- `PHP_MEMORY_LIMIT` (a [memory-limit](https://www.php.net/manual/ini.core.php#ini.memory-limit), defaults to `256M`)
- `PHP_UPLOAD_MAX_FILESIZE` (a [upload_max_filesize](https://www.php.net/manual/fr/ini.core.php#ini.upload-max-filesize), defaults to `8M`)
- `PHP_POST_MAX_SIZE` (a [post_max_size](https://www.php.net/manual/fr/ini.core.php#ini.post-max-size), defaults to `8M`)

## Volumes

 - `/htdocs` default docroot inside this container

### Build

Replace *apache-php* and tags with whatever you want when building your own image.

```sh
docker build -t apache-php:latest .
```

## Run

```bash
docker run -d --name apache-php -v /opt/myapp:/htdocs -p 80:80 martinbouillaud/apache-php:latest
```

## Customized run

```sh
docker run -d \
    --name apache-php \
    -e HTTP_SERVER_NAME="www.example.xyz" \
    -e TZ="Europe/Paris" \
    -e PHP_MEMORY_LIMIT="512M" \
    -v /opt/myapp:/htdocs \
    --publish 80:80 \
    --restart unless-stopped \
    martinbouillaud/apache-php:latest
```

## Docker-compose Stack

```
version: "3.3"
apache-php:
    container_name: apache-php
    image: martinbouillaud/apache-php:latest
    ports:
        - "8080:80"
    environment:
        - HTTP_SERVER_NAME=apache-php.example.com
        - TZ=Europe/Paris
        - PHP_MEMORY_LIMIT=1024M
    volumes:
        - /opt/myapp:/htdocs
```
