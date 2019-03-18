# Inizio il build dell'immagine
FROM ubuntu:latest

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y \
	apt-utils \
	build-essential \
	curl \
	libssl-dev \
	locales \
	nano \
	vim \
	tar \
	tzdata \
	zip \
	wget

RUN echo "Europe/Rome" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

# Settiamo l'italiano come locale
RUN locale-gen it_IT.utf8
ENV LANG it_IT.utf8
ENV LANGUAGE it_IT:it
ENV LC_ALL it_IT.utf8

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y nodejs

RUN npm install -g javascripting

# Cartella di lavoro
WORKDIR /app

# Vado a montare il volume dove metterò il codice
VOLUME /app

COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

# Comando lanciato quando si runna il container
CMD ["bash"]
