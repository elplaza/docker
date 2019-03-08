# Inizio il build dell'immagine
FROM ubuntu:latest

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Installo i pacchetti che servono (andrebbero ricontrollati!)
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y \
	apache2 \
	apt-utils \
	build-essential \
	curl \
	locales \
	nano \
	php \
	php-bcmath \
	php-curl \
	php-dev \
	php-gd \
	php-gettext \
	php-intl \
	php-imagick \
	php-json \
	php-mbstring \
	php-memcache \
	php-memcached \
	php-mongodb \
	php-mysql \
	php-pear \
	php-zip \
	php-xdebug \
	vim \
	tar \
	zip \
	wget

RUN echo "Europe/Rome" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

RUN apt-get update && apt-get install -y composer

# Settiamo l'italiano come locale
RUN locale-gen it_IT.utf8
ENV LANG it_IT.utf8
ENV LANGUAGE it_IT:it
ENV LC_ALL it_IT.utf8

# Abilitiamo alcuni moduli di apache
RUN a2enmod rewrite

COPY creation.conf /etc/apache2/sites-available/
COPY creationart.conf /etc/apache2/sites-available/

RUN a2ensite creationart.conf && \
	a2dissite 000-default.conf

# Cartella di lavoro
WORKDIR /var/www/html

# Vado a montare il volume dove metterò il codice
VOLUME /var/www/html

EXPOSE 80

# Comando lanciato quando si runna il container
CMD apache2ctl -D FOREGROUND
