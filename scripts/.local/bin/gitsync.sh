#!/bin/bash

# --- Configuration ---
# Add the full paths to the directories you want to sync
TARGET_DIRS=(
    "$HOME/Documents/notes"
    "$HOME/projects/my-cool-app"
    "$HOME/.dotfiles"
)

# Current timestamp for the commit message
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

echo "Starting Git Auto-Sync at $TIMESTAMP..."

for DIR in "${TARGET_DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        echo "---------------------------------------"
        echo "Syncing: $DIR"
        cd "$DIR" || continue

        # Check if it's a git repository
        if [ ! -d ".git" ]; then
            echo "Error: $DIR is not a Git repository. Skipping."
            continue
        fi

        # Pull latest changes to avoid conflicts
        git pull --rebase

        # Check for changes (staged, unstaged, or untracked)
        if [[ -n $(git status -s) ]]; then
            git add .
            git commit -m "Auto-sync: $TIMESTAMP"
            
            # Push to the current branch
            BRANCH=$(git rev-parse --abbrev-ref HEAD)
            git push origin "$BRANCH"
            echo "Success: Changes pushed to $BRANCH."
        else
            echo "No changes detected. Skipping push."
        fi
    else
        echo "Warning: Directory $DIR does not exist."
    fi
done

echo "---------------------------------------"
echo "Sync complete."
