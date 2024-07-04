#!/bin/bash

# Function to delete all local tags
delete_local_tags() {
  echo "Deleting all local tags..."
  git tag -l | xargs -n 1 git tag -d
}

# Function to delete all remote tags
delete_remote_tags() {
  echo "Deleting all remote tags..."
  git ls-remote --tags origin | awk '{print $2}' | grep -E 'refs/tags/' | sed 's:refs/tags/::' | xargs -n 1 -I {} git push origin :refs/tags/{}
}

# Confirm deletion
read -p "Are you sure you want to delete all local and remote tags? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  # Delete local tags
  delete_local_tags
  
  # Delete remote tags
  delete_remote_tags
  
  echo "All local and remote tags have been deleted."
else
  echo "Operation cancelled."
fi
