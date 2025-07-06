@echo off
REM Windows startup script to start WSL cron service
REM Place this in Windows startup folder or use Task Scheduler

REM Start WSL and run cron service
wsl -d Ubuntu -u root service cron start

REM Optional: Run initial update
wsl -d Ubuntu -u rbsdev /home/rbsdev/Project/prompts/scripts/update-manifest.sh