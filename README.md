# apache-php docker image
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/StrapDown.js/graphs/commit-activity)  [![Docker](https://badgen.net/badge/icon/docker?icon=docker&label)](https://https://docker.com/) [![Docker Pulls](https://badgen.net/docker/pulls/martinbouillaud/apache-php?icon=docker&label=pulls)](https://hub.docker.com/r/martinbouillaud/apache-php)  [![Docker Image Size](https://img.shields.io/docker/image-size/martinbouillaud/apache-php?sort=date)](https://hub.docker.com/r/martinbouillaud/apache-php/)


## Tags
 * **latest** : martinbouillaud/apache-php:latest -> martinbouillaud/apache-php:8.1
 * **8.1** : martinbouillaud/apache-php:8.1
 * **8.0** : martinbouillaud/apache-php:8.0
 * **7.4** : martinbouillaud/apache-php:7.4

## Volumes

| Volume   | Description  |  
|---|---|
| /app  | Sources files for your Website  | 
|  /errors |  html files for generic errors  |
| /etc/apache2/conf-available/z-app.conf  |  Apache2 Main configuration file |
| /etc/apache2/sites-available/000-default.conf  |  Main virtualhost configuration |
| /usr/local/etc/php/conf.d/app.ini | PHP configuration file (php.ini) |

## Ports

| Port   | Description  |  
|---|---|
| 80 | Main default port to communicate with  | 

### Docker Compose usage

```
version: '3'
services:
	apache-php:
		container_name: apache-php
		restart: always
		image: martinbouillaud/apache-php:latest
		volumes:
			- $PWD/app:/app
		ports:
			- 80:80
```

### Docker Run usage

```
docker run --detach \
    --name apache-php \
    --publish 80:80 \
    --restart always \
    --volume /docker/data/www:/app \
    martinbouillaud/apache-php:latest
```

