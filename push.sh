default="master"
branch=${1:-$default}
COMMIT=$(python3 commitmsg.py)
DATE=$(date +%d/%m/%Y@%T)
COMMITMSG=$(echo $COMMIT | cut -d"|" -f1)
COMMITMSGURL=$(echo $COMMIT | cut -d"|" -f2)
#echo "Making Changes on $DATE" >> README.md
#echo "\tMESSAGE: $COMMITMSG" >> README.md
#echo "\tURL: $COMMITMSGURL\n\n\n" >> README.md
#git add README.md
git add *
git commit -a -m "${COMMITMSG}"
git push -u origin $branch
