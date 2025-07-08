# Scripts Directory

This directory contains various utility scripts to manage and automate tasks within the project.

## Available Scripts

### `check_links.py`
- **Description**: A Python script used by `validate-rules.sh` to check for broken relative Markdown links within `.clinerules` files. It verifies if the linked files exist on the filesystem.
- **Usage**: `python check_links.py <markdown_file_path>` (Typically called by `validate-rules.sh`)
- **Dependencies**: Python 3

### `cron-update-manifest.sh`
- **Description**: A shell script intended to be run as a cron job. It executes `update-manifest.sh` to keep `rules-manifest.json` synchronized with the `.clinerules` directory at regular intervals.
- **Usage**: Intended for automated execution via cron. See `setup-cron.sh` for setup.
- **Dependencies**: `bash`, `update-manifest.sh`

### `README-automation.md`
- **Description**: Documentation explaining the automation processes and scripts within the project. (This file itself is a documentation file, not an executable script).

### `setup-cron.sh`
- **Description**: Sets up a cron job to periodically run `cron-update-manifest.sh`. This automates the manifest synchronization process on Linux/macOS systems.
- **Usage**: `./setup-cron.sh`
- **Dependencies**: `cron` daemon, `cron-update-manifest.sh`

### `setup-systemd-timer.sh`
- **Description**: Sets up a systemd timer and service unit to periodically run `cron-update-manifest.sh`. This provides an alternative to cron for automated manifest synchronization on Linux systems using systemd.
- **Usage**: `./setup-systemd-timer.sh`
- **Dependencies**: `systemd`

### `update-manifest.sh`
- **Description**: Scans all `.clinerules` Markdown files, extracts their frontmatter metadata, and updates `rules-manifest.json`. It ensures the manifest accurately reflects the current state of the rule files, adding new entries and removing those that no longer exist.
- **Usage**: `./update-manifest.sh`
- **Dependencies**: `bash`, `python3`

### `validate-rules.sh`
- **Description**: Validates the integrity and consistency of `.clinerules` Markdown files and `rules-manifest.json`. It checks for valid frontmatter, required fields, consistency with the manifest, and broken internal Markdown links.
- **Usage**: `./validate-rules.sh`
- **Dependencies**: `bash`, `python3`, `check_links.py`

### `windows-startup.bat`
- **Description**: A batch script for Windows systems. Intended to be run at system startup to perform initial setup or execute background tasks relevant to the project.
- **Usage**: Place in Windows Startup folder or configure as a scheduled task.
- **Dependencies**: Windows Command Prompt

### `wsl-startup.sh`
- **Description**: A shell script for Windows Subsystem for Linux (WSL) environments. Intended to be run at WSL startup to perform initial setup or execute background tasks within the WSL instance.
- **Usage**: Configure WSL to run this script on startup.
- **Dependencies**: `bash` (within WSL environment)
