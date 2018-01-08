# php7.0用の設定
# ビルドコマンド
# docker build -t ubuntu:php70 .

FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y apache2 php7.0 php7.0-mysql php7.0-gd php7.0-mcrypt php7.0-curl php7.0-intl  php7.0-opcache libapache2-mod-php7.0 php7.0-mbstring php7.0-ldap php7.0-sqlite3 php7.0-xml php7.0-zip curl
RUN a2enmod rewrite
RUN a2enmod ssl

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

COPY 000-default.conf /etc/apache2/sites-available
COPY default-ssl.conf /etc/apache2/sites-available
RUN a2ensite default-ssl

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV CAKE_ENV development

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
