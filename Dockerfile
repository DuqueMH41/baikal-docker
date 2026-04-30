FROM php:8.3-apache

RUN apt-get update \
    && apt-get install -y unzip curl libsqlite3-dev \
    && docker-php-ext-install pdo pdo_sqlite sqlite3 opcache \
    && apt-get purge -y --auto-remove \
    && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite

WORKDIR /var/www

ENV BAIKAL_VERSION=0.11.1

RUN curl -fL https://github.com/sabre-io/Baikal/releases/download/${BAIKAL_VERSION}/baikal-${BAIKAL_VERSION}.zip -o baikal.zip \
    && unzip baikal.zip \
    && rm baikal.zip

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV APACHE_DOCUMENT_ROOT=/var/www/baikal/html
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
    && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

RUN chown -R www-data:www-data /var/www/baikal

VOLUME /var/www/baikal/Specific

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
