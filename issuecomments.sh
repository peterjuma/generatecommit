#!/bin/bash

# Check for necessary command line arguments
if [ $# -eq 0 ]; then
    echo "Usage: ./issuecomments.sh -n <issue-number> -c <comment count>"
    exit 1
fi

while getopts n:c: flag
do
    case "${flag}" in
        n) issuenumber=${OPTARG};;
        c) count=${OPTARG};;
    esac
done

if [ -z "$issuenumber" ] || [ -z "$count" ]; then
    echo "Both -n (issue number) and -c (comment count) must be specified."
    exit 1
fi

# Retrieve the repository name
repo_name=$(gh repo view --json name -q .name)
if [ -z "$repo_name" ]; then
    echo "Failed to retrieve repository name. Ensure you are within a GitHub repository directory."
    exit 1
fi

echo "Repository: $repo_name"
echo "Issue number: $issuenumber"
echo "Number of comments to post: $count"

# Post comments to the issue using GitHub CLI
for (( i=1; i<=$count; i++ ))
do
    body=$(lipsum -n 1)
    gh issue comment $issuenumber --body "$body"
done

echo "Comments posted."
