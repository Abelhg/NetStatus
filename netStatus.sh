#!/bin/bash
# Checks Internet connection.

# Script's end timestamp
END=$(date -d "2018-12-15 18:00:00" +%s)
IP="8.8.8.8"
INIT=$(date "+%d-%m-%Y_%H-%M-%S")
FILENAME="log_"$INIT
INTERVAL=5

if [ $(date +%s) -gt $END ]; then
	echo "End timestamp is:" $(date -d @$END "+%d-%m-%Y %H:%M:%S")
	exit
fi

echo "INTERNET CONNECTION LOG" > $FILENAME
date "+%d-%m-%Y %H:%M:%S" >> $FILENAME
echo "" >> $FILENAME
echo "Check started. Logfile:" $FILENAME

while [ $(date +%s) -lt $END ]; do
	TS=$(date "+%d-%m-%Y %H:%M:%S")
	ping -q -c 1 $IP &> /dev/null
	if [ $? -eq 0 ]; then
		echo "$TS OK"
		echo "$TS OK" >> $FILENAME
	else
		echo "$TS ERROR"
		echo "$TS DOWN" >> $FILENAME
	fi
	sleep $INTERVAL
done