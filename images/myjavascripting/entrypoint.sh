#!/bin/bash

# check if directory is "mounted" correctly
if [ -z "$(ls -A $PWD)" ]; then
	echo "the folder '$PWD' is empty"
	echo "Please install app in '$PWD'"
	exit 1
fi

# aggiorno npm
npm i -g npm

# installo/aggiorno i pacchetti node
npm install

case "$1" in
	start)
		DEBUG=express:* npm start
		;;

	bash)
		/bin/bash
		;;

	*)
		echo "This container accepts the following commands:"
		echo "- start"
		echo "- bash"
		exit 1
esac

# read log file
while [ ! -e  "/var/log/syslog" ]
do
	echo "Waiting for log file: /var/log/syslog"
	sleep 2
done

tail -f "/var/log/syslog"
