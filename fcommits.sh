#!/bin/bash

# default=1
# count=${1:-1}
# COUNT=${1:-1}

FILE=$(lipsum -n 1 -w 1 | awk '{print tolower($0) ext}' | awk '{gsub(/\.|\ /,"")}1')
FILENAME=${2:-"${FILE}.md"}


sh ./editfiles.sh $FILENAME
COMMITMSG=$(python3 commitmsg.py)
#COMMITMSG=$(curl -s http://whatthecommit.com/ | grep -A2 '<div id="content">' | awk -F: 'NR==2 {sub(/<p>/,"");print $1}')
git add $FILENAME
git commit -a -m "${COMMITMSG}"
git push


COMMITMSG=$(python3 commitmsg.py)
git commit --amend -m "${COMMITMSG}"
git push --force

