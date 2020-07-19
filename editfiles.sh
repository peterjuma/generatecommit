#!/bin/bash
FILES="$@"
for filename in $FILES
  do
  	[ -f "$filename" ] && { echo "Editing file $filename"; echo "Edited file $filename on $(date +%F_%H-%M-%S)" >> $filename; } || { echo "Skipping...file $filename does not exist" ;}
done
