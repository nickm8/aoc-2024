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
gh repo create "$REPO_NAME" --private

# Clone the repository first
echo "Cloning repository..."
git clone "https://github.com/$(gh api user -q .login)/$REPO_NAME.git"

# Create README and initial commit
cd "$REPO_NAME"
echo "# Advent of Code 2024 - Day $DAY_NUM" > README.md
git add README.md
git commit -m "Initial commit"
git push
cd ..

# Now add it as a submodule
echo "Adding as submodule..."
git submodule add "https://github.com/$(gh api user -q .login)/$REPO_NAME.git" "$REPO_NAME"

echo "Successfully created and added $REPO_NAME as a submodule"