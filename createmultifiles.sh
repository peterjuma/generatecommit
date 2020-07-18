#!/bin/bash
default=5
stub="File000"
count=${1:-$default}

for (( i=1; i<$count+1; i++))
do
  filename=$stub$i".txt"
  [ -f $filename ] && echo "$filename exists, moving on" || { echo $(date +%F_%H-%M-%S) This is my message of the day  > $filename; echo "$filename created"; }
done
