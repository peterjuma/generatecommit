#!/bin/bash

# Display usage help message
display_help() {
    echo "Usage: $0 <PR_NUMBER> <STATE>"
    echo "STATE can be one of: error, failure, pending, success"
}

# Ensure two arguments are provided
if [ "$#" -ne 2 ]; then
    display_help
    exit 1
fi

pr_number=$1
state=$2

# Check if the state is valid
valid_states=("error" "failure" "pending" "success")
if ! [[ " ${valid_states[@]} " =~ " ${state} " ]]; then
    echo "Invalid state provided."
    display_help
    exit 1
fi

# Get current repository name using gh cli
repo_name=$(gh repo view --json nameWithOwner -q ".nameWithOwner")

default_branch=$(gh repo view --json defaultBranchRef -q ".defaultBranchRef.name")

head_sha=$(gh api \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  /repos/"$repo_name"/pulls/"$pr_number" -q ".head.sha")

contexts=$(gh api \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  /repos/"$repo_name"/branches/"$default_branch"/protection -q ".required_status_checks.contexts[0]")

gh api \
  --method POST \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  /repos/"$repo_name"/statuses/"$head_sha" \
  -F state="$state" \
  -F description="The build $state!" \
  -F context="$contexts"
