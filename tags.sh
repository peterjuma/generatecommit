#!/bin/bash

create_tag() {
  create_pr
  local tag=$1
  echo "Creating tag: $tag"
  git tag $tag
  git push --tags
}

create_pr() {
  for i in {0..3}; do
    sh pr.sh --merge 
  done
}

# Create a series of tags with SemVer
create_tag "v1.0.0"
create_tag "v1.1.0"
create_tag "v2.0.0"
create_tag "v2.1.0"
create_tag "v2.1.1"
create_tag "v3.0.0-alpha.1"
create_tag "v3.0.0-beta.1"
create_tag "v3.0.0"
create_tag "version-1"
create_tag "v1.0.0.0"
create_tag "v1.0.0-zeta"

git push --tags
