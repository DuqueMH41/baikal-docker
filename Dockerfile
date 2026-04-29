FROM php:8.3-apache

# Install dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    curl \
    libsqlite3-dev \
    && docker-php-ext-install pdo pdo_sqlite \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Enable Apache rewrite (CalDAV/CardDAV)
RUN a2enmod rewrite

WORKDIR /var/www

# Pin version (YOU control upgrades)
ENV BAIKAL_VERSION=0.10.0

# Download Baikal
RUN curl -L https://github.com/sabre-io/Baikal/releases/download/${BAIKAL_VERSION}/baikal-${BAIKAL_VERSION}.zip -o baikal.zip \
    && unzip baikal.zip \
    && rm baikal.zip

# Copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Fix Apache document root
ENV APACHE_DOCUMENT_ROOT=/var/www/baikal/html
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
    && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
