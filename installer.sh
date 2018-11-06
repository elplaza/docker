#!/bin/bash
declare -A APPS

usage()
{
	echo ""
	echo "Usage:"
	echo "	./installer.sh --app <appname> [--branch <branchname>]"
	echo ""
	echo "Parameters:"
	echo "	-a | --app <appname>		is the app to install"
	echo "	-b | --branch <branchname>	is the app branch to clone (default is develop)"
	echo "	-h | --help			this help"
	echo ""
	echo "Apps:"
	for service in ${!APPS[@]}
	do
		printf "	- %s\n" $service
	done
	echo ""
}

# we should rename these repositories!
APPS[fizzbuzzkata]="git@github.com-elplaza:elplaza/fizzbuzzkata.git"
APPS[my-first-ci-test]="git@github.com-elplaza:elplaza/my-first-ci-test.git"
APPS[mypsr]="git@github.com-elplaza:elplaza/mypsr.git"
APPS[localizer]="git@github.com-elplaza:elplaza/localizer.git"

# Default Branch
BRANCH="master"

# App
while [[ "$#" > 0 ]]; do
	case $1 in
		-a | --app) shift
					APP=$1
					;;
		-b | --branch) shift
					BRANCH=$1
					;;
		-h | --help) usage
					exit
					;;
		*)  		usage
					exit 1
	esac
	shift
done

if [ -z "$APP" ]; then
	echo ""
	echo "[ERROR] App name is required!"
	usage
	exit
fi

if [[ ! " ${!APPS[@]} " =~ " ${APP} " ]]; then
	echo ""
	echo "[ERROR] App '$APP' is not supported!"
	usage
	exit
fi

APP_DIR="apps/$APP/"
mkdir -p $APP_DIR

echo ""
echo "Installing branch '$BRANCH' of app '$APP' in '$APP_DIR':"
if [ -z "$(ls -A $APP_DIR)" ]; then
	echo "the folder '$APP_DIR' is empty"
	git clone -b $BRANCH ${APPS[$APP]} $APP_DIR
else
	echo "the folder '$APP_DIR' is not empty ..."
	REPOSITORY_DIR="$APP_DIR/.git"
	if [ -d $REPOSITORY_DIR ]; then
		echo "... '$APP_DIR' is already a git repository"
	else
		echo "... '$APP_DIR' is not a git repository"
	fi;
fi;
echo ""
