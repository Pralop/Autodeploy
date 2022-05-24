FROM wordpress

# Set environment variables used by the Wordpress image
# DB_USER and DB_PASSWORD are included as an example. However,
# these should be removed and set during docker run.
ENV WORDPRESS_DB_HOST=127.0.0.1 \
    WORDPRESS_DB_USER=wpuser \
    WORDPRESS_DB_PASSWORD=P@ssw0rd! \
    WORDPRESS_DB_NAME=wpsite \
    WORDPRESS_TABLE_PREFIX=wp_
#COPY Hello.txt /var/www/html/wp-content/plugins/
#COPY Hello.txt /var/www/html/wp-content/themes/
#COPY Hello.txt /var/www/html/wp-content/uploads/
