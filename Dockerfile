# Use an official PHP runtime as a parent image
FROM php:8.1-apache

WORKDIR /var/www/html

COPY composer.lock composer.json /var/www/html/

RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    && docker-php-ext-install pdo pdo_mysql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer install --no-scripts

COPY . /var/www/html

EXPOSE 80

CMD ["apache2-foreground"]

