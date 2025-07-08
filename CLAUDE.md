# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a fork of the `cline/prompts` repository that serves as a centralized source for custom `.clinerules` files. The repository maintains AI assistant behavioral rules that can be selectively copied to other projects. All custom rules are maintained on the `my-rules` branch.

## Common Development Commands

### Rule Maintenance and Validation
```bash
# Update the rules manifest to sync with actual files
./scripts/update-manifest.sh

# Validate all rules for consistency and broken links
./scripts/validate-rules.sh

# Setup automated manifest updates (choose one)
./scripts/setup-cron.sh          # For cron-based systems
./scripts/setup-systemd-timer.sh  # For systemd-based Linux
```

### Syncing with Upstream
```bash
# Add upstream remote (if not already added)
git remote add upstream https://github.com/cline/prompts.git

# Sync with upstream
git checkout main
git fetch upstream
git merge upstream/main
```

### Working with Rules
```bash
# Always work on the my-rules branch
git checkout my-rules

# Create a feature branch for updates
git checkout -b feature/update-[rule-name]

# Copy rules to other projects
cp .clinerules/coding/javascript-coding-guidelines.md /path/to/project/.clinerules/

# Download rules via GitHub API
curl -o /path/to/project/.clinerules/[rule-file].md \
  "https://raw.githubusercontent.com/junichi-anada/prompts/my-rules/.clinerules/[path-to-rule]"
```

## High-Level Architecture

### Directory Structure
- `.clinerules/` - Contains all rule files organized by category:
  - `coding/` - Programming language and framework guidelines
  - `core-behavior/` - Core behavioral rules for Cline
  - `database/` - Database-related best practices
  - `role/` - Role-specific rules (IT trainer, waterfall documenter, etc.)
  - `tool/` - Tool-specific guidelines (Docker, GitHub Actions, etc.)
  - `workflows/` - Workflow definitions (ACT mode, PLAN mode, etc.)
- `scripts/` - Automation and maintenance scripts
- `rules-manifest.json` - Central registry of all rules with metadata

### Rule File Structure
All rule files follow this pattern:
1. YAML frontmatter with metadata (description, author, version, tags, globs)
2. Markdown content with clear sections and examples
3. Use directive language: MUST, SHOULD, MAY, MUST NOT, NEVER
4. Include practical examples and `<thinking>` blocks for complex logic

### Workflow for Creating/Updating Rules

#### Creating New Rules
1. Use PLAN mode to confirm requirements
2. Create the .md file with proper frontmatter
3. Update `rules-manifest.json` with the new rule entry
4. Run `./scripts/validate-rules.sh` to verify consistency
5. Commit to a feature branch

#### Updating Existing Rules
1. Create feature branch from `my-rules`
2. Update the rule file(s)
3. Update version in both the rule's frontmatter and `rules-manifest.json`
4. Run `./scripts/update-manifest.sh` to ensure manifest is in sync
5. Create PR to `my-rules` branch (not `main`)
6. Use conventional commit format: `feat(rules): [description in Japanese/English]`

### Important Conventions
- File naming: Use kebab-case (e.g., `javascript-coding-guidelines.md`)
- Always update `rules-manifest.json` when adding/modifying rules
- Include version numbers in rule frontmatter
- Use clear, directive language in rules
- Provide concrete examples and code snippets
- Test rules in actual projects before committing

### Branch Management
- **main**: Syncs with upstream repository - do NOT commit custom rules here
- **my-rules**: All custom rules and modifications go here
- Feature branches: Create from `my-rules` for new rules or updates

### Key Files to Reference
- `.clinerules/workflows/create-clinerule.md` - Template for creating new rules
- `.clinerules/core-behavior/writing/writing-effective-clinerules.md` - Guidelines for writing rules
- `README.md` - Detailed workflow documentation in Japanese