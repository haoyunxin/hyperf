FROM php:8.1.9-cli-alpine
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk add libpq-dev ca-certificates --no-cache && \
    apk update && \
    apk add tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone && apk del tzdata && \
    update-ca-certificates && \
    docker-php-ext-install pcntl pdo_mysql mysqli bcmath

RUN docker-php-ext-install pdo_pgsql pgsql

RUN pecl install mongodb && \
    pecl install amqp && \
    pecl install redis && \
    pecl install swoole && \
    docker-php-ext-enable mongodb amqp redis swoole

RUN curl -sS https://getcomposer.org/installer | php && mv ./composer.phar /usr/bin/composer && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

VOLUME /var/www
WORKDIR /var/www
