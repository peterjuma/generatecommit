#!/bin/bash

# Get the repository name
repo=$(gh repo view --json nameWithOwner -q ".nameWithOwner")

# List all releases and extract their IDs
release_ids=$(gh api \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  /repos/${repo}/releases | jq '.[].id')

# Confirm deletion
read -p "Are you sure you want to delete all releases from the repository ${repo}? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  # Delete each release by ID
  for release_id in $release_ids; do
    echo "Deleting release with ID: $release_id"
    gh api \
      --method DELETE \
      -H "Accept: application/vnd.github+json" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      /repos/${repo}/releases/${release_id}
  done
  echo "All releases have been deleted."
else
  echo "Operation cancelled."
fi
