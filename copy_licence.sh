#!/bin/bash -x 
#AdminUser="root"
#LICENCE_LOCATION="/share/scratch/ERP_SIOS"
LICENCE_LOCATION="/home/vkedhari/licence"
HOST=`uname -n | sed 's/\..*$//'`
INDIVIDUAL_LICENCE="$LICENCE_LOCATION/$HOST-lic"
LICENCE_DIRECTORY="/var/LifeKeeper/license"
TMP_LOC="/tmp/$HOST-lic"
TMP_LOC_FILES="ls -ld /tmp/$HOST-lic/*"

copyLicenseFileLocally ()
{
if ! cp -rp  $INDIVIDUAL_LICENCE /tmp/
#chmod -R 775 /tmp/$HOST-lic && chown -R 0:0 /tmp/$HOST-lic
then
	echo "$INDIVIDUAL_LICENCE not copied over to $TMP_LOC Exiting" >&2
	exit 15
else
	echo "$INDIVIDUAL_LICENCE copied over to $TMP_LOC successfully and the files are \n"
        echo "$(ls -ld /tmp/$HOST-lic/*)"
fi
}
#checkAdminUser
copyLicenseFileLocally
