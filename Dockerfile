FROM alpine:3.17
LABEL maintainer="contact@bouillaudmartin.fr"
LABEL description="Alpine based image with apache2 and php8"

# Setup apache and php
RUN apk --no-cache --update \
    add apache2 \
    curl \
    php-apache2 \
    php-bcmath \
    php-bz2 \
    php-calendar \
    php-common \
    php-ctype \
    php-curl \
    php-dom \
    php-gd \
    php-iconv \
    php-mbstring \
    php-mysqli \
    php-mysqlnd \
    php-openssl \
    php-pdo_mysql \
    php-pdo_pgsql \
    php-pdo_sqlite \
    php-phar \
    php-session \
    php-xml \
    && mkdir /htdocs

EXPOSE 80

VOLUME /htdocs

ADD docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD curl -X GET --fail http://localhost:80 || exit 1

ENTRYPOINT ["/docker-entrypoint.sh"]