#!/bin/bash
FILES="$@"

md="

### Editing file on $(date +%F_%H-%M-%S)

> This is a blockquote.
> 
> This is the second paragraph in the blockquote.
>
> ## This is an H2 in a blockquote

"

for filename in $FILES
  do
  	[ -f "$filename" ] && { echo "Editing file $filename"; echo "${md}" >> $filename; } || { echo "Skipping...file $filename does not exist" ;}
done