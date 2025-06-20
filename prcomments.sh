#!/bin/bash

# Check for necessary command line arguments
if [ $# -eq 0 ]; then
    echo "Usage: ./prcomments.sh -n <pr-number> -c <comment count>"
    exit 1
fi

while getopts n:c: flag
do
    case "${flag}" in
        n) prnumber=${OPTARG};;
        c) count=${OPTARG};;
    esac
done

if [ -z "$prnumber" ] || [ -z "$count" ]; then
    echo "Both -n (pull request number) and -c (comment count) must be specified."
    exit 1
fi

# Retrieve the repository name
repo_name=$(gh repo view --json name -q .name)
if [ -z "$repo_name" ]; then
    echo "Failed to retrieve repository name. Ensure you are within a GitHub repository directory."
    exit 1
fi

echo "Repository: $repo_name"
echo "Pull request number: $prnumber"
echo "Number of comments to post: $count"

# Post comments to the pull request using GitHub CLI
for (( i=1; i<=$count; i++ ))
do
    body=$(lipsum -n 1)
    gh pr review $prnumber --comment --body "$body"
done

echo "Comments posted."
