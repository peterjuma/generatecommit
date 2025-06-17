#!/usr/bin/env bash
#
# create-repo-with-submodule.sh
#
# Usage:
#   ./create-repo-with-submodule.sh <github-namespace> <main-repo> <submodule-repo> [submodule-path] [--private]
#
# Example:
#   ./create-repo-with-submodule.sh peterjuma farm-app farm-engine engines/farm-engine --private
#
# Requirements:
#   • gh CLI authenticated (`gh auth status` must succeed)
#   • git installed
#   • This script is run from an empty working directory
set -euo pipefail

# ------------------------------- arguments -----------------------------------
NS="$1"                   # user or org login, e.g. peterjuma or my-org
MAIN_REPO="$2"            # name of the primary repo to create
SUB_REPO="$3"             # name of the submodule repo to create
SUB_PATH="${4:-$SUB_REPO}"# relative path inside MAIN_REPO where the submodule lives
PRIV_FLAG="${5:-}"        # optional --private switch

if [[ -z "$NS" || -z "$MAIN_REPO" || -z "$SUB_REPO" ]]; then
  echo "Usage: $0 <github-namespace> <main-repo> <submodule-repo> [submodule-path] [--private]"
  exit 1
fi

# ------------------------------- helpers -------------------------------------
function repo_exists() {
  gh repo view "$1/$2" >/dev/null 2>&1
}

# ------------------------------- main logic ----------------------------------
echo "🔐  Checking GitHub authentication…"
gh auth status -h github.com >/dev/null

# 1. Create both repos (idempotently)
for repo in "$MAIN_REPO" "$SUB_REPO"; do
  if repo_exists "$NS" "$repo"; then
    echo "✅  Repo $NS/$repo already exists – skipping creation"
  else
    echo "📦  Creating $NS/$repo"
    gh repo create "$NS/$repo" $PRIV_FLAG --confirm --description "$repo created by script"
  fi
done

# 2. Clone the main repo locally
echo "📥  Cloning $NS/$MAIN_REPO"
git clone "https://github.com/$NS/$MAIN_REPO.git"
cd "$MAIN_REPO"

# 3. Add the submodule
echo "➕  Adding submodule $SUB_REPO at $SUB_PATH"
git submodule add "https://github.com/$NS/$SUB_REPO.git" "$SUB_PATH"

# 4. Push the change
git commit -m "Add $SUB_REPO as git submodule under $SUB_PATH"
git push -u origin main

echo -e "\n🎉  Done!"
echo "Main repo:       https://github.com/$NS/$MAIN_REPO"
echo "Submodule repo:  https://github.com/$NS/$SUB_REPO"
echo "Submodule path:  $SUB_PATH (track with \`git submodule update --remote\` as needed)"
