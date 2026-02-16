FROM php:8.2-fpm-alpine

RUN apk add --no-cache curl mariadb-client
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions

RUN install-php-extensions mysqli mbstring opcache

WORKDIR /var/www/wordpress

RUN curl -o /usr/local/bin/wp -L https://github.com/wp-cli/wp-cli/releases/download/v2.11.0/wp-cli-2.11.0.phar \
 && chmod +x /usr/local/bin/wp

COPY conf/memory.ini /usr/local/etc/php/conf.d/memory.ini
COPY conf/www.conf  /usr/local/etc/php-fpm.d/www.conf
COPY tools/entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh && mkdir -p /var/run/php

RUN wp core download --path=/var/www/wordpress --allow-root \
 && chown -R www-data:www-data /var/www/wordpress

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["php-fpm", "-F"]