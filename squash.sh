#!/bin/bash

branch_name=`git rev-parse --symbolic-full-name --abbrev-ref HEAD`
number_of_commits=$(git rev-list --count $branch_name)

# Switch to the branch you want to squash commits in
git checkout $branch_name

# Rebase the branch interactively and squash the commits
git rebase -i HEAD~$number_of_commits

# In the interactive rebase editor, change "pick" to "squash" or "s" for all commits except the first one
# Save and exit the editor

# If prompted, modify the commit message as desired

# Force push the changes to the branch
# git push origin $branch_name --force
