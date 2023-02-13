# Use the penultimate stable version of Debian as the base
FROM debian:10.7

# Install the required packages for MariaDB
RUN apt-get update && apt-get install -y \
    mariadb-server 

# Copy the configuration file for MariaDB
COPY conf.cnf /etc/mysql/conf.cnf

# Set the permissions for the configuration file
RUN chmod 644 /etc/mysql/my.cnf

# Expose the default MariaDB port
EXPOSE 3306

# Start the MariaDB service
RUN service mysql start
RUN mysql < /var/www/base.sql
RUN rm -f /var/www/base.sql
CMD ["mysqld", "--bind-address=0.0.0.0"]
