#!/bin/bash

# validate-rules.sh - Validate .clinerules files and rules-manifest.json consistency
# 
# This script performs the following validations:
# 1. Check all rule files have valid YAML frontmatter
# 2. Verify required fields in frontmatter
# 3. Ensure all files are registered in rules-manifest.json
# 4. Check for orphaned entries in rules-manifest.json
# 5. Validate version consistency
# 6. Report any issues found

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counters
TOTAL_FILES=0
VALID_FILES=0
ERRORS=0
WARNINGS=0

# Base directory
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RULES_DIR="$BASE_DIR/.clinerules"
MANIFEST_FILE="$BASE_DIR/rules-manifest.json"

# Required frontmatter fields
REQUIRED_FIELDS=("description" "author" "version")
OPTIONAL_FIELDS=("title" "date" "tags" "globs")

echo "=== Validating .clinerules files ==="
echo "Base directory: $BASE_DIR"
echo ""

# Function to extract frontmatter
extract_frontmatter() {
    local file=$1
    local in_frontmatter=false
    local frontmatter=""
    
    while IFS= read -r line || [[ -n "$line" ]]; do
        if [[ "$line" == "---" ]]; then
            if [[ "$in_frontmatter" == true ]]; then
                break
            else
                in_frontmatter=true
                continue
            fi
        fi
        
        if [[ "$in_frontmatter" == true ]]; then
            frontmatter+="$line"$'\n'
        fi
    done < "$file"
    
    echo "$frontmatter"
}

# Function to validate YAML frontmatter
validate_frontmatter() {
    local file=$1
    local relative_path="${file#$BASE_DIR/}"
    local errors_found=false
    
    echo -n "Checking $relative_path... "
    
    # Check if file starts with ---
    if ! head -n1 "$file" | grep -q "^---$"; then
        echo -e "${RED}ERROR${NC}: No frontmatter found"
        ((ERRORS++))
        return 1
    fi
    
    # Extract frontmatter
    local frontmatter=$(extract_frontmatter "$file")
    
    if [[ -z "$frontmatter" ]]; then
        echo -e "${RED}ERROR${NC}: Empty frontmatter"
        ((ERRORS++))
        return 1
    fi
    
    # Check required fields
    for field in "${REQUIRED_FIELDS[@]}"; do
        if ! echo "$frontmatter" | grep -q "^${field}:"; then
            echo -e "${RED}ERROR${NC}: Missing required field: $field"
            ((ERRORS++))
            errors_found=true
        fi
    done
    
    # Extract field values for additional validation
    local version=$(echo "$frontmatter" | grep "^version:" | sed 's/version:[[:space:]]*//;s/"//g;s/'\''//g')
    local author=$(echo "$frontmatter" | grep "^author:" | sed 's/author:[[:space:]]*//;s/"//g;s/'\''//g')
    
    # Validate version format
    if [[ -n "$version" ]]; then
        if ! [[ "$version" =~ ^[0-9]+\.[0-9]+$ ]]; then
            echo -e "${YELLOW}WARNING${NC}: Invalid version format '$version' (expected X.Y)"
            ((WARNINGS++))
            errors_found=true
        fi
    fi
    
    # Check for placeholder author
    if [[ "$author" == "Your Name/Handle" ]]; then
        echo -e "${YELLOW}WARNING${NC}: Placeholder author found"
        ((WARNINGS++))
        errors_found=true
    fi
    
    if [[ "$errors_found" == false ]]; then
        echo -e "${GREEN}OK${NC}"
        ((VALID_FILES++))
    else
        echo ""  # Add newline if errors were found
    fi
    
    return 0
}

# Function to check manifest consistency
check_manifest() {
    echo ""
    echo "=== Checking rules-manifest.json consistency ==="
    
    if [[ ! -f "$MANIFEST_FILE" ]]; then
        echo -e "${RED}ERROR${NC}: rules-manifest.json not found!"
        ((ERRORS++))
        return 1
    fi
    
    # Extract all paths from manifest
    local manifest_paths=$(python3 -c "import json; data=json.load(open('$MANIFEST_FILE')); print('\n'.join([r['path'] for r in data['rules']]))" 2>/dev/null)
    
    if [[ -z "$manifest_paths" ]]; then
        echo -e "${RED}ERROR${NC}: Could not parse rules-manifest.json"
        ((ERRORS++))
        return 1
    fi
    
    # Check for orphaned entries in manifest
    echo "Checking for orphaned manifest entries..."
    while IFS= read -r path; do
        if [[ ! -f "$BASE_DIR/$path" ]]; then
            echo -e "${RED}ERROR${NC}: File not found: $path (registered in manifest)"
            ((ERRORS++))
        fi
    done <<< "$manifest_paths"
    
    # Check for unregistered files
    echo "Checking for unregistered rule files..."
    if [[ -d "$RULES_DIR" ]]; then
        while IFS= read -r -d '' file; do
            local relative_path="${file#$BASE_DIR/}"
            if ! echo "$manifest_paths" | grep -q "^${relative_path}$"; then
                echo -e "${YELLOW}WARNING${NC}: File not in manifest: $relative_path"
                ((WARNINGS++))
            fi
        done < <(find "$RULES_DIR" -name "*.md" -type f -print0)
    fi
    
    # Validate version consistency
    echo "Checking version consistency..."
    while IFS= read -r path; do
        if [[ -f "$BASE_DIR/$path" ]]; then
            local file_version=$(extract_frontmatter "$BASE_DIR/$path" | grep "^version:" | sed 's/version:[[:space:]]*//;s/"//g;s/'\''//g')
            local manifest_version=$(python3 -c "import json; data=json.load(open('$MANIFEST_FILE')); result=[r['version'] for r in data['rules'] if r['path']=='$path']; print(result[0] if result else '')")
            
            if [[ "$file_version" != "$manifest_version" ]]; then
                echo -e "${YELLOW}WARNING${NC}: Version mismatch for $path"
                echo "  File: $file_version, Manifest: $manifest_version"
                ((WARNINGS++))
            fi
        fi
    done <<< "$manifest_paths"
}

# Main validation loop
echo "=== Validating individual rule files ==="
# Check if there are any .md files
if [[ -d "$RULES_DIR" ]]; then
    file_count=$(find "$RULES_DIR" -name "*.md" -type f | wc -l)
    echo "Found $file_count rule files to validate"
    
    while IFS= read -r -d '' file; do
        ((TOTAL_FILES++))
        validate_frontmatter "$file" || true
    done < <(find "$RULES_DIR" -name "*.md" -type f -print0)
else
    echo "Warning: $RULES_DIR directory not found"
fi

# Check manifest consistency
check_manifest

# Summary
echo ""
echo "=== Validation Summary ==="
echo "Total files checked: $TOTAL_FILES"
echo "Valid files: $VALID_FILES"
echo -e "Errors: ${RED}$ERRORS${NC}"
echo -e "Warnings: ${YELLOW}$WARNINGS${NC}"

# Exit code based on errors
if [[ $ERRORS -gt 0 ]]; then
    echo ""
    echo -e "${RED}Validation failed with $ERRORS error(s)${NC}"
    exit 1
else
    echo ""
    echo -e "${GREEN}Validation passed!${NC}"
    if [[ $WARNINGS -gt 0 ]]; then
        echo -e "${YELLOW}Please review $WARNINGS warning(s)${NC}"
    fi
    exit 0
fi