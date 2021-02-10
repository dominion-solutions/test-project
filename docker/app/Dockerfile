FROM alpine:3.12

RUN apk update \
    && addgroup www-data -S \
    && adduser www-data -S -G www-data \
    && apk add composer php7-dom php7-fileinfo php7-fpm php7-opcache php7-pecl-redis php7-pdo \
        php7-pdo_pgsql php7-pgsql php7-session php7-tokenizer php7-xml php7-xmlwriter --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community \
    && apk add nginx supervisor nodejs npm \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log \
    && mkdir -p /etc/nginx/sites-enabled \
    && mkdir -p /var/run/php-fpm \
    && mkdir -p /var/run/nginx \
    && rm /etc/nginx/conf.d/default.conf \
    && rm -rf /etc/init.d/nginx \
    && rm -rf /etc/init.d/php-fpm7

COPY docker/app/docker-entrypoint.sh /

COPY docker/app/nginx/nginx.conf /etc/nginx/nginx.conf
COPY docker/app/nginx/default.conf /etc/nginx/sites-enabled/default.conf
COPY docker/app/php-fpm/www.conf /etc/php7/php-fpm.d/www.conf
COPY docker/app/supervisord/nginx.ini /etc/supervisor.d/nginx.ini
COPY docker/app/supervisord/php-fpm.ini /etc/supervisor.d/php-fpm.ini

COPY . /var/www/html/

RUN cd /var/www/html \
    && composer install --no-dev \
    && chown -R www-data: /var/www/html \
    && chmod +x /docker-entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD [ "/usr/bin/supervisord"]
