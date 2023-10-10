# Use the official PHP image
FROM php:8.1-fpm

# Set the working directory to /app
WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy the current directory contents into the container at /app
COPY . /app

# Install application dependencies
RUN composer install --no-interaction --optimize-autoloader --no-suggest

# Set up Laravel environment
RUN php artisan key:generate

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
