#!/bin/bash
default=5
stub="File000"
count=${1:-$default}

for (( i=1; i<$count+1; i++))
do 
  filename=$stub$i".txt"
  echo $filename
  echo $(date +%F_%H-%M-%S) This is my message of the day  > $filename
done
