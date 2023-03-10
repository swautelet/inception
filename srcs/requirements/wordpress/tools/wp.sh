#!/bin/sh

if [ ! -f "/var/www/html/wordpress/wp-config.php" ]; then
    echo "Downloading Wordpress"
    mkdir -p /var/www/html/
    wget https://wordpress.org/latest.tar.gz -O /tmp/wordpress.tar.gz
    tar xzf /tmp/wordpress.tar.gz -C /var/www/html/
    cp -R /var/www/html/wordpress/* /var/www/html
    rm -rf /tmp/wordpress.tar.gz
    rm -rf /var/www/html/wordpress

    # wp core download --allow-root
    sed -i "s/username_here/$DB_LOGIN/g" wp-config-sample.php
    sed -i "s/password_here/$DB_PASSWORD/g" wp-config-sample.php
    sed -i "s/localhost/$DB_HOSTNAME/g" wp-config-sample.php
    sed -i "s/database_name_here/$DB_NAME/g" wp-config-sample.php
    cp wp-config-sample.php wp-config.php
    echo between download and config create 
    # env
    # whereis wp
    # wp config create --dbname=$DB_NAME --dbuser=$DB_LOGIN --dbpass=$DB_PASSWORD --dbhost=$DB_HOSTNAME --allow-root
    echo between config create and install
    wp core install --url=$WP_URL --title=$WP_TITLE --admin_user="$WP_ADMIN_LOGIN" --admin_password="$WP_ADMIN_PASSWORD" --admin_email=info@example.com --allow-root
    echo between install and user create
    wp user create "$WP_ADMIN_LOGIN" "$WP_ADMIN_EMAIL" --user_pass="$WP_ADMIN_PASSWORD" --role=administrator --allow-root
    echo between theme and user 
    wp theme install inspiro --activate --allow-root
else
    echo "Download failed"
fi

exec "$@"