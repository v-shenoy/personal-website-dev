#!/usr/bin/env bash

# Exit immediately if any command fails.
set -e

# Escape sequences for coloured output.
GREEN='\033[1;92m'
NO_COLOUR='\033[0m'
YELLOW='\033[1;93m'

echo -e "$GREEN -- Deploying to GitHub -- $NO_COLOUR"

# Create commit message.
commit_msg="Rebuilding site - $(date)"
if [ -n "$*" ]; then
	commit_msg="$*"
fi

# Build website.
echo -e "$YELLOW -- Building website -- $NO_COLOUR"
hugo

# Commit and push generated content.
cd public
echo -e "$YELLOW -- Committing changes to $(pwd) -- $NO_COLOUR"
git add .
git commit -m "$commit_msg"
git push -u content-repo main

# Commit and push hugo stuff.
cd ..
echo -e "$YELLOW -- Committing changes to $(pwd) -- $NO_COLOUR"
git add .
git commit -m "$commit_msg"
git push -u dev-repo main
