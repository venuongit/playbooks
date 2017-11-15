#!/bin/bash -x
AdminUser="root"
DATE=`date +%m-%d-%y` 
LIST_LOCATION="/home/joslewis/ansible/ERP/files"
LIST_FILE="$LIST_LOCATION/Etc_Services-SAPMessagrServerPorts_v2"
SERVICES="/etc/services"

checkAdminUser ()
{
if  ! `id | grep $AdminUser > /dev/null 2>&1`
then
	echo "ERROR -- Script must be run as $AdminUser... Exiting" >&2
	exit 10
fi
}

# Take backup of /etc/services.
backupServices ()
{
if ! cp $SERVICES $SERVICES.${DATE}
then
	echo "$SERVICES has failed to be backed... Exiting" >&2
	exit 20
else
	echo "$SERVICES backed up successfully."
fi
}

# Append the list at the end of /etc/services.
appendServices ()
{

if ! /bin/cat "$LIST_FILE" >> $SERVICES
then
	echo "$SERVICES file was not appended successfully... Exiting" >&2
	exit 30
else
	echo "$SERVICES was appended successfully"
fi
}

# Checkup for duplicate entries in /etc/services.
checkDuplicateEntries ()
{

if ! sed '$!N; /^\(.*\)\n\1$/!P; D' $SERVICES > $SERVICES.tmp
then
	echo "Duplicates not removed from $SERVICES... Exiting" >&2
	exit 40
else 
	echo "Duplicates not removed from $SERVICES"
fi
}

# Update ownership and file permissions on /etc/services.
updateOwnershipAndPermission()
{

if ! mv $SERVICES.tmp $SERVICES
then 
	echo " $SERVICES.tmp not updated to $SERVICES... Exiting" >&2
	exit 50
else
	if ! /bin/chown 0:0 $SERVICES
	then
		echo "Ownership not updated on $SERVICES... Exiting" >&2
		exit 60
	else
		if ! /bin/chmod 0644 $SERVICES
		then
			echo "Permissions not updated on $SERVICES"
			exit 70
		else 
			echo "Move, Ownership and Permissions completed successfully."
		fi
	fi
fi

}

checkAdminUser
backupServices
appendServices
checkDuplicateEntries
updateOwnershipAndPermission
