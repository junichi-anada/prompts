# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-07-08

### Added
- Created `CHANGELOG.md` to document project changes.
- Created `scripts/README.md` to document the purpose and usage of utility scripts.
- Added `scripts/check_links.py` for validating internal Markdown links.

### Changed
- Enhanced `scripts/update-manifest.sh` to fully synchronize `rules-manifest.json` with the file system, including automatic removal of orphaned entries.
- Improved `scripts/validate-rules.sh` to include checks for valid frontmatter, required fields, consistency with `rules-manifest.json`, and broken internal Markdown links.

### Fixed
- Corrected missing frontmatter in `.clinerules/core-behavior/custom-instructions.md` and `.clinerules/tool/Ai-memory-management.md`.
- Updated `rules-manifest.json` to include previously unlisted rule files and remove entries for deleted files.

### Removed
- Eliminated duplicate file: `.clinerules/coding/laravel11-coding-guidelines.md` (redundant with `.clinerules/coding/framework/laravel11-coding-guidelines.md`).
