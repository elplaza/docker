#!/bin/bash

# check if directory is "mounted" correctly
if [ -z "$(ls -A $PWD)" ]; then
	echo "the folder '$PWD' is empty"
	echo "Please install app in '$PWD'"
	exit 1
fi

# installo le librerie tramite composer
composer update

case "$1" in
	run-tests)
		./bin/phpunit
		;;

	run-kata)
		php kata.php
		;;

	bash)
		/bin/bash
		;;

	*)
		echo "This container accepts the following commands:"
		echo "- run-tests"
		echo "- run-kata"
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