#!/bin/bash

# Check if at least one argument was passed
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <owner_name>"
    exit 1
fi

REPO_NAME=$(cat /usr/share/dict/web2a | sort -R | head -1 | sed 's/ //g')

NWO=$1/$REPO_NAME

# Create the repo
gh repo create "$NWO" --public

# Clone the repo
gh repo clone "$NWO"

# Navigate into the extracted directory name
cd "$REPO_NAME" || exit 1

# Display the current directory
echo "$(pwd)"

# Copy required files
cp ~/Git/generatecommit/gitignore .gitignore
cp ~/Git/generatecommit/*.py .
cp ~/Git/generatecommit/*.sh .

# Execute the commits script
sh commits.sh 

# I assume 'gp' is an alias or a function you've previously defined. If not, replace this line.
git push 

git checkout -b "$(cat /usr/share/dict/web2a | sort -R | head -1 | sed 's/ //g')"

sh commits.sh  3

sh pr.sh