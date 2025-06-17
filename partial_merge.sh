#!/bin/bash

CUR_HEAD=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)
git pull --all --rebase

# Function to delete branches if they exist
delete_branch_if_exists() {
    local branch_name=$1

    # Check if the branch exists locally
    if git show-ref --verify --quiet refs/heads/$branch_name; then
        git branch -D $branch_name
    fi

    # Check if the branch exists remotely
    if git ls-remote --exit-code --heads origin $branch_name >/dev/null 2>&1; then
        git push origin --delete $branch_name
    fi
}

if [[ "$CUR_HEAD" == "master" || "$CUR_HEAD" == "main" ]]; then
    # Delete existing branches locally and remotely
    delete_branch_if_exists feature1
    delete_branch_if_exists feature2

    # Create feature1 branch from main
    git checkout -b feature1

    # Add two commits to feature1
    echo "Feature 1 - Commit 1" >> feature1.md
    git add feature1.md && git commit -m "Feature 1 - Commit 1"

    echo "Feature 1 - Commit 2" >> feature1.md
    git add feature1.md && git commit -m "Feature 1 - Commit 2"

    # Push feature1 branch
    git push --set-upstream origin feature1

    # Create feature2 branch from feature1
    git checkout -b feature2 feature1

    # Add two commits to feature2
    echo "Feature 2 - Commit 1" >> feature2.md
    git add feature2.md && git commit -m "Feature 2 - Commit 1"

    echo "Feature 2 - Commit 2" >> feature2.md
    git add feature2.md && git commit -m "Feature 2 - Commit 2"

    # Push feature2 branch
    git push --set-upstream origin feature2
fi

# Create pull requests for both branches
PR1_URL=$(gh pr create --title "Feature 1 Changes" --body "Adding feature 1 changes" --base main --head feature1)
PR2_URL=$(gh pr create --title "Feature 2 Changes" --body "Adding feature 2 changes" --base main --head feature2)

# Open PRs in browser
open -a "/Applications/Google Chrome.app" "$PR1_URL"
open -a "/Applications/Google Chrome.app" "$PR2_URL"

# Switch back to the original branch
git switch "$CUR_HEAD"
