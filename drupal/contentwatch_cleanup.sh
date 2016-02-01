#!/bin/bash

if [ -z "$2" ]; then
	echo "usage: $0 <site> <days> [-list]"
	echo "     [-list] - generates list without archiving or removing."
	exit
fi
SITED=$1
DAYS=$2
LISTONLY=$3
LOGDIR="/web/$SITED/htdocs/sites/default/files/contentwatch"
if [ -d $LOGDIR ]; then
	echo "$LISTONLY $LOGDIR in progress...."
	cd $LOGDIR
else
	echo "Directory does not exist! $LOGDIR"
	exit 1
fi

TIMESTAMP=`date +%s`

# Generate list of "old" files
`find . -name \*.txt -mtime +$DAYS -print > $TIMESTAMP"."contentwatch_cleanup.lst`
#echo "find create -name \*.txt -mtime +$DAYS -print > $TIMESTAMP"."contentwatch_cleanup.lst"

# Check to make sure we had permission
if [ ! -f $TIMESTAMP."contentwatch_cleanup.lst" ]; then
	echo There was a problem generating the list of files to cleanup.
	exit 1
fi
# Check to make sure the list is not empty.
if [ ! -s  $TIMESTAMP."contentwatch_cleanup.lst" ]; then
	echo No files were found to cleanup.
	rm $TIMESTAMP."contentwatch_cleanup.lst"
	exit
else
	NUMFILES=`cat $TIMESTAMP."contentwatch_cleanup.lst" | wc -l `
fi
if [ "$LISTONLY" != "-list" ]; then
	echo List: $TIMESTAMP."contentwatch_cleanup.lst"
	echo "Archiving $NUMFILES files..."
	`cat $TIMESTAMP."contentwatch_cleanup.lst" | xargs chmod 666`
	`cat $TIMESTAMP."contentwatch_cleanup.lst" | xargs chown duane.jennings`
	`tar -czvpf $TIMESTAMP."contentwatch.tgz" --remove-files --files-from $TIMESTAMP."contentwatch_cleanup.lst"`
else
	cat $TIMESTAMP."contentwatch_cleanup.lst"
	echo $NUMFILES files are in the list.
	rm $TIMESTAMP."contentwatch_cleanup.lst"
fi
