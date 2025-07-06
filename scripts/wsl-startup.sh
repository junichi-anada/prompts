#!/bin/bash

# wsl-startup.sh - WSL startup script for background services
#
# This script can be called from Windows startup or .bashrc to initialize services

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo -e "${BLUE}=== WSL Startup Script for prompts project ===${NC}"
echo "Project directory: $PROJECT_DIR"

# Function to start cron service if not running
start_cron_if_needed() {
    if ! pgrep -x "cron" > /dev/null; then
        echo "Starting cron service..."
        sudo service cron start
        if [[ $? -eq 0 ]]; then
            echo -e "${GREEN}✅ Cron service started${NC}"
        else
            echo -e "${YELLOW}⚠️ Failed to start cron service${NC}"
        fi
    else
        echo -e "${GREEN}✅ Cron service already running${NC}"
    fi
}

# Function to start systemd user timer if configured
start_systemd_timer_if_configured() {
    if systemctl --user list-unit-files "update-manifest.timer" &>/dev/null; then
        echo "Starting systemd user timer..."
        systemctl --user start update-manifest.timer
        if [[ $? -eq 0 ]]; then
            echo -e "${GREEN}✅ Systemd timer started${NC}"
        else
            echo -e "${YELLOW}⚠️ Failed to start systemd timer${NC}"
        fi
    else
        echo "No systemd timer configured"
    fi
}

# Function to run initial manifest update
run_initial_update() {
    echo "Running initial manifest update..."
    cd "$PROJECT_DIR"
    if ./scripts/update-manifest.sh > /dev/null 2>&1; then
        echo -e "${GREEN}✅ Initial manifest update completed${NC}"
    else
        echo -e "${YELLOW}⚠️ Initial manifest update failed${NC}"
    fi
}

# Main execution
echo ""
echo "Checking and starting services..."

# Check which method is configured and start accordingly
if crontab -l 2>/dev/null | grep -q "update-manifest"; then
    echo "Cron job detected"
    start_cron_if_needed
elif systemctl --user list-unit-files "update-manifest.timer" &>/dev/null; then
    echo "Systemd timer detected"
    start_systemd_timer_if_configured
else
    echo "No scheduled tasks configured"
    echo "Run ./scripts/setup-cron.sh or ./scripts/setup-systemd-timer.sh to set up automatic updates"
fi

# Always run an initial update
run_initial_update

echo ""
echo -e "${GREEN}WSL startup completed for prompts project${NC}"