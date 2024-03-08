#!/bin/bash

# Function to display script usage
usage() {
    echo "Usage: $0 [-a | -d] [-b <branch_name>]"
    echo "Options:"
    echo "  -a : Add branch protection rules"
    echo "  -d : Delete branch protection rules"
    echo "  -b <branch_name> : Specify the branch name (optional)"
    exit 1
}

# Default values
operation=""
branch_name=""

# Parse the options and arguments
while getopts ":adb:" opt; do
    case $opt in
        a)
            operation="add"
            ;;
        d)
            operation="delete"
            ;;
        b)
            branch_name=$OPTARG
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            usage
            ;;
    esac
done

# Get the default branch if no branch name is provided
if [ -z "$branch_name" ]; then
    default_branch=$(gh repo view --json defaultBranchRef -q ".defaultBranchRef.name")
    branch_name="$default_branch"
fi

# Get current repository name using gh cli
repo_name=$(gh repo view --json nameWithOwner -q ".nameWithOwner")
account_type=$(gh repo view --json isInOrganization -q ".isInOrganization")

# API URL
API_URL="https://api.github.com/repos/${repo_name}/branches/${branch_name}/protection"

# JSON payload for different scenarios
JSONUSER='{
  "required_status_checks": {
    "strict": true,
    "contexts": ["build"]
  },
  "enforce_admins": true,
  "required_pull_request_reviews": {
    "dismiss_stale_reviews": true,
    "require_code_owner_reviews": true,
    "required_approving_review_count": 1,
    "require_last_push_approval": true
  },
  "restrictions": null,
  "required_linear_history": true,
  "allow_force_pushes": true,
  "allow_deletions": true,
  "block_creations": true,
  "required_conversation_resolution": true,
  "lock_branch": true,
  "allow_fork_syncing": true
}'

JSONORG='{
  "required_status_checks": {
    "strict": true,
    "contexts": ["build"]
  },
  "enforce_admins": true,
  "required_pull_request_reviews": {
    "dismissal_restrictions": {
      "users": ["peterjuma"],
      "teams": ["reviewers"]
    },
    "dismiss_stale_reviews": true,
    "require_code_owner_reviews": true,
    "required_approving_review_count": 2,
    "require_last_push_approval": true,
    "bypass_pull_request_allowances": {
      "users": ["peterjuma"],
      "teams": ["reviewers"]
    }
  },
  "restrictions": {
    "users": ["peterjuma"],
    "teams": ["reviewers"],
    "apps": ["PJApp"]
  },
  "required_linear_history": true,
  "allow_force_pushes": true,
  "allow_deletions": true,
  "block_creations": true,
  "required_conversation_resolution": true,
  "lock_branch": true,
  "allow_fork_syncing": true
}'

# Set the JSON payload based on the account type
if [ "${account_type}" = "false" ]; then
    JSON=${JSONUSER}
else
    JSON=${JSONORG}
fi

# Add or delete branch protection based on the operation
if [ "$operation" = "add" ]; then
    echo "Adding branch protection rules for $branch_name in repository $repo_name"
    response=$(curl -L \
      -X PUT \
      -H "Accept: application/vnd.github+json" \
      -H "Authorization: Bearer $TOKEN" \
      -d "${JSON}" ${API_URL}
    )
    echo "Branch protection rules added for $branch_name in repository $repo_name"
    echo "Response: $response"
elif [ "$operation" = "delete" ]; then
    echo "Deleting branch protection rules for $branch_name in repository $repo_name"
    gh api \
      --method DELETE \
      -H "Accept: application/vnd.github+json" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      /repos/${repo_name}/branches/${branch_name}/protection
    echo "Branch protection rules deleted for $branch_name in repository $repo_name"
else
    echo "Specify either -a to add rules or -d to delete rules."
    usage
fi
