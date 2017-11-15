#!/bin/bash -x 
AdminUser="root"
#LICENCE_LOCATION="/share/scratch/ERP_SIOS"
LICENCE_LOCATION="/home/vkedhari/licence"
HOST=`uname -n | sed 's/\..*$//'`
INDIVIDUAL_LICENCE="$LICENCE_LOCATION/$HOST-lic"
LICENCE_DIRECTORY="/var/LifeKeeper/license"

checkAdminUser ()
{
	if  ! `id | grep $AdminUser > /dev/null 2>&1`
	then
	echo "ERROR -- Script must be run as $AdminUser... Exiting" >&2
	exit 10
	fi
}

copyLicenseFileLocally ()
{

if ! cp -rp  /tmp/$HOST-lic/* $LICENCE_DIRECTORY
then
	echo "$INDIVIDUAL_LICENCE not copied over to $LICENCE_DIRECTORY... Exiting" >&2
	exit 15
else
	echo "$INDIVIDUAL_LICENCE copied over to $LICENCE_DIRECTORY successfully."
fi
}

restartLicense ()
{

/opt/LifeKeeper/bin/lkstop -f > /dev/null 2>&1
if [ $? -ne 0 ]
then 
	echo "/opt/LifeKeeper/bin/lkstop -f not started... Exiting" >&2
	exit 20
else
	/opt/LifeKeeper/bin/lkstart > /dev/null 2>&1
	if [ $? -ne 0 ]
	then
		echo "/opt/LifeKeeper/bin/lkstart not started... Exiting" >&2
		exit 25
	else
		/opt/LifeKeeper/bin/lklicmgr > /dev/null 2>&1
		if [ $? -ne 0 ]
		then 
			echo "/opt/LifeKeeper/bin/lklicmgr... Exiting" >&2
			exit 30
		else
			echo "Services started successfully."
		fi
	fi
fi

}

#checkAdminUser
copyLicenseFileLocally
restartLicense
