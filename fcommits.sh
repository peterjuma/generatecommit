#!/bin/bash

# default=1
# count=${1:-1}
COUNT=${1:-1}

sh commits.sh 1

FILE=$(lipsum -n 1 -w 1 | awk '{print tolower($0) ext}' | awk '{gsub(/\.|\ /,"")}1')
FILENAME=${2:-"${FILE}.md"}

if [ $# -eq 0 ]
  then
    COMMITMSG=$(python3 commitmsg.py)
    git add .
    git commit --amend -m "${COMMITMSG}"
    git push --force
    exit 1
fi

for (( i=1; i<=$COUNT; i++ ))
do
    sh ./editfiles.sh $FILENAME
    COMMITMSG=$(python3 commitmsg.py)
    git add $FILENAME
    git commit --amend -m "${COMMITMSG}"
done

git push --force
