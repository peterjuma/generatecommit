#!/bin/bash

# Create a release on GitHub using the GitHub API.
# This script assumes you have a GitHub token set in the TOKEN environment variable.

# Get the repo name
repo=$(gh repo view --json nameWithOwner -q ".nameWithOwner") 

# Add 3 commits
for i in {0..1}; do
    sh pr.sh --merge 
    npm version minor
    git push --tags
done

# Tag the commit 
newtag=$(npm version major)

# Push the tag
git push --tags

# Create a release
release_url=$(gh release create $newtag --generate-notes --title "Release $newtag" --latest)

# Open the release in the browser
open -a "/Applications/Google Chrome.app" "$release_url"
