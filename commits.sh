#!/bin/bash
default=1
stub=${2:-"File000*"}
count=${1:-$default}

for (( i=1; i<$count+1; i++))
do
	sh ./editfiles.sh $stub
	COMMIT=$(python3 commitmsg.py)
	DATE=$(date +%d/%m/%Y@%T)
	COMMITMSG=$(echo $COMMIT | cut -d"|" -f1)
	COMMITMSGURL=$(echo $COMMIT | cut -d"|" -f2)
	git add $stub
	git commit -a -m "${COMMITMSG}"
done
