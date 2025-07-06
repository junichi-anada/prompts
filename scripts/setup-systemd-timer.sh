#!/bin/bash

# setup-systemd-timer.sh - Setup systemd timer for update-manifest.sh
#
# This script sets up a systemd user timer to run update-manifest.sh periodically

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get the absolute path to the project directory
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT_PATH="$PROJECT_DIR/scripts/update-manifest.sh"

echo -e "${BLUE}=== Setting up systemd timer for update-manifest.sh ===${NC}"
echo "Project directory: $PROJECT_DIR"
echo "Script path: $SCRIPT_PATH"
echo ""

# Check if script exists and is executable
if [[ ! -x "$SCRIPT_PATH" ]]; then
    echo -e "${RED}ERROR: $SCRIPT_PATH is not executable${NC}"
    echo "Please run: chmod +x $SCRIPT_PATH"
    exit 1
fi

# Create systemd user directory
SYSTEMD_USER_DIR="$HOME/.config/systemd/user"
mkdir -p "$SYSTEMD_USER_DIR"

# Create logs directory
mkdir -p "$PROJECT_DIR/logs"

# Service file name
SERVICE_NAME="update-manifest"

# Create systemd service file
SERVICE_FILE="$SYSTEMD_USER_DIR/${SERVICE_NAME}.service"
cat > "$SERVICE_FILE" << EOF
[Unit]
Description=Update rules-manifest.json for prompts project
After=default.target

[Service]
Type=oneshot
WorkingDirectory=$PROJECT_DIR
ExecStart=$SCRIPT_PATH
StandardOutput=append:$PROJECT_DIR/logs/update-manifest.log
StandardError=append:$PROJECT_DIR/logs/update-manifest.log

[Install]
WantedBy=default.target
EOF

echo "Created service file: $SERVICE_FILE"

# Prompt user for frequency
echo ""
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
        TIMER_SCHEDULE="*:0/5"
        DESCRIPTION="every 5 minutes"
        ;;
    2)
        TIMER_SCHEDULE="*:0/30"
        DESCRIPTION="every 30 minutes"
        ;;
    3)
        TIMER_SCHEDULE="hourly"
        DESCRIPTION="every hour"
        ;;
    4)
        TIMER_SCHEDULE="0/2:00:00"
        DESCRIPTION="every 2 hours"
        ;;
    5)
        TIMER_SCHEDULE="0/6:00:00"
        DESCRIPTION="every 6 hours"
        ;;
    6)
        TIMER_SCHEDULE="09:00:00"
        DESCRIPTION="daily at 9 AM"
        ;;
    7)
        echo "For custom schedules, please refer to systemd.time(7) manual"
        read -p "Enter OnCalendar value (e.g., '*:0/15' for every 15 minutes): " TIMER_SCHEDULE
        DESCRIPTION="custom schedule: $TIMER_SCHEDULE"
        ;;
    *)
        echo "Invalid choice. Using default: every hour"
        TIMER_SCHEDULE="hourly"
        DESCRIPTION="every hour"
        ;;
esac

# Create systemd timer file
TIMER_FILE="$SYSTEMD_USER_DIR/${SERVICE_NAME}.timer"
cat > "$TIMER_FILE" << EOF
[Unit]
Description=Timer for update-manifest service
Requires=${SERVICE_NAME}.service

[Timer]
OnCalendar=$TIMER_SCHEDULE
Persistent=true

[Install]
WantedBy=timers.target
EOF

echo "Created timer file: $TIMER_FILE"

# Reload systemd user daemon
echo ""
echo "Reloading systemd user daemon..."
systemctl --user daemon-reload

# Enable and start the timer
echo "Enabling and starting the timer..."
systemctl --user enable "${SERVICE_NAME}.timer"
systemctl --user start "${SERVICE_NAME}.timer"

# Check status
echo ""
echo -e "${GREEN}✅ Systemd timer setup completed!${NC}"
echo ""
echo "Timer status:"
systemctl --user status "${SERVICE_NAME}.timer" --no-pager -l

echo ""
echo "The service will run $DESCRIPTION"
echo "Logs will be saved to: $PROJECT_DIR/logs/update-manifest.log"
echo ""
echo "Useful commands:"
echo "  View timer status: systemctl --user status ${SERVICE_NAME}.timer"
echo "  View service status: systemctl --user status ${SERVICE_NAME}.service"
echo "  View logs: journalctl --user -u ${SERVICE_NAME}.service -f"
echo "  View file logs: tail -f $PROJECT_DIR/logs/update-manifest.log"
echo "  Stop timer: systemctl --user stop ${SERVICE_NAME}.timer"
echo "  Disable timer: systemctl --user disable ${SERVICE_NAME}.timer"
echo "  List all timers: systemctl --user list-timers"
echo ""
echo -e "${YELLOW}Note: systemd user services may not start automatically on WSL boot${NC}"
echo "You may need to run: systemctl --user start ${SERVICE_NAME}.timer"