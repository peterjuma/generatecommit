#!/bin/bash
FILES="$@"
for f in $FILES
  do
    echo "Editing file $f" 
    echo "Edited file $f on $(date +%F_%H-%M-%S)" >> $f
done

