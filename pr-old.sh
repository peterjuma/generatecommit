CUR_HEAD=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)
git pull --all --rebase

if [[ "$CUR_HEAD" == "master" || "$CUR_HEAD" == "main" ]]; then
    # Checkout from an older commit (HEAD~5)
    git checkout HEAD~5
    
    NEW_HEAD=$(cat /usr/share/dict/web2a | sort -R | head -1 | sed 's/ //g')
    git checkout -b ${NEW_HEAD}
    
    sh commits.sh 1 "${NEW_HEAD}.md"
    git push --set-upstream origin ${NEW_HEAD}
fi

git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null && git push origin ${CUR_HEAD} || git push --set-upstream origin ${CUR_HEAD}

subject=$(lipsum -w 2)
body=$(lipsum -n 1)
URL=$(gh pr create --title "$subject" --body "$body" 2>&1 | tail -n 1)

if [[ "$CUR_HEAD" == "master" || "$CUR_HEAD" == "main" ]]; then
    git switch "$CUR_HEAD"
fi

if [[ "$*" == *"merge"* ]]; then
    COMMITMSG=$(python3 commitmsg.py)
    echo ${COMMITMSG}
    gh pr merge "$URL" --merge --admin --body "${COMMITMSG}"
    exit
fi

open -a "/Applications/Google Chrome.app" "$URL"
