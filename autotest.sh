#!/bin/sh

# Exit on non defined variables and on non zero exit codes
set -eu

echo '# Building the container'

docker build ./ -t apache-php:latest

NET="${DOCKER_NETWORK:-apache-php}"

# use failure to switch on create
docker network inspect ${NET} 1>/dev/null 2> /dev/null || docker network create ${NET}

echo '# Preparing test folder'

TMP_DIR="$(mktemp -d 2>/dev/null || mktemp -d -t 'apache-php')"

printf "<?php \n\
    echo 'PHP: ' . PHP_MAJOR_VERSION . PHP_EOL;\n\
    echo 'Host: ' . \$_SERVER['SERVER_NAME'] . PHP_EOL;\n\
    echo 'Memory-limit: ' . ini_get('memory_limit') . PHP_EOL;\n\
    echo 'Timezone: ' . ini_get('date.timezone') . PHP_EOL;\n\
    " > "${TMP_DIR}/index.php"

chmod 777 "${TMP_DIR}"
chmod 666 "${TMP_DIR}/index.php"

echo '# Running test containers'

# stop if exists or silently exit
docker stop apache-php-test 1>/dev/null 2> /dev/null || echo '' >/dev/null

docker run --rm --detach \
    --name apache-php-test \
    --network ${NET} \
    --volume ${TMP_DIR}:/htdocs \
    --env HTTP_SERVER_NAME="www.example.xyz" \
    --env TZ="Europe/Paris" \
    --env PHP_MEMORY_LIMIT="256M" \
    apache-php:latest 1>/dev/null

echo ''
echo '# Running tests'

docker run --rm --network ${NET} curlimages/curl:latest -s http://apache-php-test

echo ''
echo '# Cleaning up'
docker stop apache-php-test 1>/dev/null
docker network rm ${NET} 1>/dev/null

rm "${TMP_DIR}/index.php"
rmdir "${TMP_DIR}"