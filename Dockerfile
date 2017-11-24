FROM ubuntu:16.04
MAINTAINER Carlos Porras <carlos.porras.0508@gmail.com>
LABEL Description="Cutting-edge LAMP stack, based on Ubuntu 16.04 LTS. Includes .htaccess support and popular PHP5.6 features, including composer and mail() function." \
	License="Apache License 2.0" \
	Usage="docker run -d -p [HOST WWW PORT NUMBER]:80 -p [HOST DB PORT NUMBER]:3306 -v [HOST WWW DOCUMENT ROOT]:/var/www/html -v [HOST DB DOCUMENT ROOT]:/var/lib/mysql drexlerux/lamp" \
	Version="1.0"

RUN apt-get update
RUN apt-get -y install locales

# Initialize environment
CMD ["/sbin/my_init"]
ENV DEBIAN_FRONTEND noninteractive
# Set the locale
RUN \
    locale-gen en_US.UTF-8 && \
    localedef en_US.UTF-8 -i en_US -fUTF-8 && \
    dpkg-reconfigure locales && \
    echo "LANG=en_US.UTF-8" >> /etc/default/locale && \
    echo "LANGUAGE=en_US.UTF-8" >> /etc/default/locale && \
    echo "LC_ALL=en_US.UTF-8" >> /etc/default/locale && \
    export LANG=en_US.UTF-8 && \
    export LANGUAGE=en_US.UTF-8 && \
    export LC_ALL=en_US.UTF-8 && \
    LANG=en_US.UTF-8 && \
    LANGUAGE=en_US.UTF-8 && \
    LC_ALL=en_US.UTF-8 && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

RUN apt-get update
RUN apt-get install software-properties-common -y
RUN LC_ALL=C.UTF-8 apt-add-repository -y ppa:ondrej/php
RUN apt-get update
RUN apt-get upgrade -y

COPY debconf.selections /tmp/
RUN debconf-set-selections /tmp/debconf.selections

RUN apt-get install -y \
	php5.6 \
	php5.6-bz2 \
	php5.6-cgi \
	php5.6-cli \
	php5.6-common \
	php5.6-curl \
	php5.6-dev \
	php5.6-enchant \
	php5.6-fpm \
	php5.6-gd \
	php5.6-gmp \
	php5.6-imap \
	php5.6-interbase \
	php5.6-intl \
	php5.6-json \
	php5.6-ldap \
	php5.6-mcrypt \
	php5.6-mysql \
	php5.6-odbc \
	php5.6-opcache \
	php5.6-pgsql \
	php5.6-phpdbg \
	php5.6-pspell \
	php5.6-readline \
	php5.6-recode \
	php5.6-snmp \
	php5.6-sqlite3 \
	php5.6-sybase \
	php5.6-tidy \
	php5.6-xmlrpc \
	php5.6-xsl
RUN apt-get install apache2 libapache2-mod-php5.6 -y

RUN apt-get install postfix -y
RUN apt-get install git composer nano vim curl ftp -y

ENV LOG_STDOUT **Boolean**
ENV LOG_STDERR **Boolean**
ENV LOG_LEVEL warn
ENV ALLOW_OVERRIDE All
ENV DATE_TIMEZONE UTC
ENV TERM dumb

COPY index.php /var/www/html/
COPY run-script.sh /usr/sbin/

RUN a2enmod rewrite
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN chmod +x /usr/sbin/run-script.sh
RUN chown -R www-data:www-data /var/www/html

VOLUME /var/www/html
VOLUME /var/log/httpd
VOLUME /var/lib/mysql
VOLUME /var/log/mysql

EXPOSE 80

CMD ["/usr/sbin/run-script.sh"]