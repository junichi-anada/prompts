#!/bin/bash

# setup-cron.sh - Setup cron job for update-manifest.sh
#
# This script sets up a cron job to run update-manifest.sh periodically

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the absolute path to the project directory
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT_PATH="$PROJECT_DIR/scripts/update-manifest.sh"

echo -e "${BLUE}=== Setting up cron job for update-manifest.sh ===${NC}"
echo "Project directory: $PROJECT_DIR"
echo "Script path: $SCRIPT_PATH"
echo ""

# Check if script exists and is executable
if [[ ! -x "$SCRIPT_PATH" ]]; then
    echo -e "${YELLOW}ERROR: $SCRIPT_PATH is not executable${NC}"
    echo "Please run: chmod +x $SCRIPT_PATH"
    exit 1
fi

# Create a wrapper script that changes to the correct directory
WRAPPER_SCRIPT="$PROJECT_DIR/scripts/cron-update-manifest.sh"
cat > "$WRAPPER_SCRIPT" << EOF
#!/bin/bash
# Auto-generated wrapper script for cron job
cd "$PROJECT_DIR"
"$SCRIPT_PATH" >> "$PROJECT_DIR/logs/update-manifest.log" 2>&1
EOF

chmod +x "$WRAPPER_SCRIPT"

# Create logs directory if it doesn't exist
mkdir -p "$PROJECT_DIR/logs"

# Show current crontab
echo "Current crontab for user $USER:"
crontab -l 2>/dev/null || echo "No crontab found"
echo ""

# Prompt user for frequency
echo "Choose update frequency:"
echo "1) Every 5 minutes (for testing)"
echo "2) Every 30 minutes"
echo "3) Every hour"
echo "4) Every 2 hours"
echo "5) Every 6 hours"
echo "6) Daily at 9 AM"
echo "7) Custom"

read -p "Enter your choice (1-7): " choice

case $choice in
    1)
        CRON_SCHEDULE="*/5 * * * *"
        DESCRIPTION="every 5 minutes"
        ;;
    2)
        CRON_SCHEDULE="*/30 * * * *"
        DESCRIPTION="every 30 minutes"
        ;;
    3)
        CRON_SCHEDULE="0 * * * *"
        DESCRIPTION="every hour"
        ;;
    4)
        CRON_SCHEDULE="0 */2 * * *"
        DESCRIPTION="every 2 hours"
        ;;
    5)
        CRON_SCHEDULE="0 */6 * * *"
        DESCRIPTION="every 6 hours"
        ;;
    6)
        CRON_SCHEDULE="0 9 * * *"
        DESCRIPTION="daily at 9 AM"
        ;;
    7)
        read -p "Enter custom cron schedule (e.g., '0 */4 * * *'): " CRON_SCHEDULE
        DESCRIPTION="custom schedule: $CRON_SCHEDULE"
        ;;
    *)
        echo "Invalid choice. Using default: every hour"
        CRON_SCHEDULE="0 * * * *"
        DESCRIPTION="every hour"
        ;;
esac

# Create the cron job entry
CRON_ENTRY="$CRON_SCHEDULE $WRAPPER_SCRIPT"

# Add to crontab
echo "Adding cron job: $DESCRIPTION"
echo "Cron entry: $CRON_ENTRY"

# Get current crontab, add new entry, and install
(crontab -l 2>/dev/null; echo "$CRON_ENTRY") | crontab -

echo -e "${GREEN}✅ Cron job added successfully!${NC}"
echo ""
echo "The script will run $DESCRIPTION"
echo "Logs will be saved to: $PROJECT_DIR/logs/update-manifest.log"
echo ""
echo "To view logs: tail -f $PROJECT_DIR/logs/update-manifest.log"
echo "To remove the cron job: crontab -e (then delete the line)"
echo "To list current cron jobs: crontab -l"
echo ""
echo -e "${YELLOW}Note: Make sure cron service is running in WSL${NC}"
echo "Check with: sudo service cron status"
echo "Start with: sudo service cron start"