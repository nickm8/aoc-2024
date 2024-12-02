#!/bin/bash

# Check if day number is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <day-number>"
    exit 1
fi

DAY_NUM=$1
REPO_NAME="day-$DAY_NUM"

# Create new repository on GitHub
echo "Creating repository $REPO_NAME..."
gh repo create "$REPO_NAME" --private --confirm

# Add as submodule
echo "Adding as submodule..."
git submodule add "git@github.com:$(gh api user -q .login)/$REPO_NAME.git" "$REPO_NAME"

echo "Successfully created and added $REPO_NAME as a submodule"