FROM wordpress:latest

RUN docker-php-ext-install calendar

# sendmail
RUN apt-get update && apt-get install -y sendmail rsync
COPY ./php.ini /usr/local/etc/php/conf.d/php.ini
COPY ./prepare.sh /prepare.sh
RUN chmod +x /prepare.sh

# wp
RUN rm -rf /var/www/html/*
RUN rsync -a --exclude 'wp-content' /usr/src/wordpress/ /var/www/html/

CMD /prepare.sh && apache2-foreground
