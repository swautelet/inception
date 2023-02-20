# Use the latest version of the official debian buster image as the base
FROM debian:10.7 

# Install the required packages for WordPress
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    libzip-dev \
    unzip \
    libpng-dev \
    php-cgi \
    php-mysqli \
    php-fpm \
    php-pdo \
    php-gd php-cli \
    php-mbstring

# Install the PHP extensions required by WordPress
# RUN docker-php-ext-install mysqli pdo pdo_mysql zip gd
# ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# RUN chmod +x /usr/local/bin/install-php-extensions
# RUN install-php-extensions gd xdebug

# Download and extract the latest version of WordPress
RUN mkdir -p /var/www/html
# RUN curl -O https://wordpress.org/latest.zip \
#     && unzip latest.zip \
#     && rm latest.zip \
#     && mv wordpress /var/www/html
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp
RUN mkdir /run/php
COPY conf/www.conf /etc/php/7.3/fpm/pool.d/
# Set the working directory to the root of the WordPress installation
WORKDIR /var/www/html/

EXPOSE 9000

RUN export PATH="$PATH:/usr/local/mysql/bin"
# Set the permissions for the WordPress files
# RUN chown -R swautele:swautele /var/www/html/wordpress

# Entrypoint configuration
COPY ./tools/wp.sh /usr/local/bin/wp_script.sh
RUN chmod +x /usr/local/bin/wp_script.sh
ENTRYPOINT ["/usr/local/bin/wp_script.sh"]

# Start the PHP-FPM service
CMD ["php-fpm7.3", "-F"]
