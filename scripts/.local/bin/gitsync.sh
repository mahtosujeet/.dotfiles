#!/bin/bash

# --- Configuration ---
TARGET_DIRS=(
    "$HOME/Documents/myebooks"
    "$HOME/Documents/excalidraw"
)

TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Function to send a persistent error notification
notify_error() {
    notify-send "Git Sync Error" "$1" -i dialog-error -u critical
}

echo "=== Sync Started: $TIMESTAMP ==="

# 1. Network Check
# If we can't ping Google, exit with an error so systemd retries later.
if ! ping -c 1 -W 2 8.8.8.8 >/dev/null 2>&1; then
    echo "Network still unreachable. Exiting for retry..."
    exit 1
fi

# 2. Iterate through directories
for DIR in "${TARGET_DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        DIR_NAME=$(basename "$DIR")
        echo "Processing: $DIR_NAME"
        cd "$DIR" || continue

        # 3. Add and Commit local changes
        # Check if 'git status' is not empty
        if [ -n "$(git status --short)" ]; then
            echo "  - Changes detected. Committing..."
            git add .
            git commit -m "Auto-sync: $TIMESTAMP"
        else
            echo "  - No local changes to commit."
        fi

        # 4. Pull with Rebase
        echo "  - Pulling from remote..."
        CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
        if ! git pull --rebase origin "$CURRENT_BRANCH"; then
            echo "  [ERROR] Merge conflict in $DIR_NAME"
            notify_error "Conflict in $DIR_NAME! Manual fix required."
            exit 1 
        fi

        # 5. Push to Remote
        # Check if local is ahead of remote
        if [[ "$(git status -sb)" == *"ahead"* ]]; then
            echo "  - Pushing changes..."
            if git push origin "$CURRENT_BRANCH"; then
                echo "  - Success: $DIR_NAME is synced."
            else
                echo "  [ERROR] Push failed."
                notify_error "Failed to push $DIR_NAME."
            fi
        else
            echo "  - Already up to date."
        fi
    else
        echo "  [SKIP] Directory $DIR does not exist."
    fi
done

echo "=== Sync Complete ==="
exit 0
