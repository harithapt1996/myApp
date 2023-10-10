# Use an official PHP runtime as a parent image
FROM php:8.1-apache

# Change the default Apache user and group to match your local user
# Adjust these values based on your host user and group IDs
ARG APACHE_RUN_USER=myuser
ARG APACHE_RUN_GROUP=mygroup

# Set the working directory
WORKDIR /var/www/html

# Copy Composer files
COPY composer.lock composer.json /var/www/html/

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    && docker-php-ext-install pdo pdo_mysql

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Composer dependencies
RUN composer install --no-scripts

# Copy phpunit.xml from the build context to /var/www/html
COPY phpunit.xml /var/www/html/

# Copy application code
COPY . /var/www/html

# Copy custom Apache virtual host configuration
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

# Enable the custom virtual host
RUN a2ensite 000-default.conf

# Change Apache user and group
RUN usermod -u 1000 $APACHE_RUN_USER && groupmod -g 1000 $APACHE_RUN_GROUP
RUN chown -R $APACHE_RUN_USER:$APACHE_RUN_GROUP /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
