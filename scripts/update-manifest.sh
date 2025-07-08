#!/bin/bash

# update-manifest.sh - Update rules-manifest.json based on .clinerules files
# 
# This script performs the following operations:
# 1. Scans all .clinerules/*.md files
# 2. Extracts metadata from YAML frontmatter
# 3. Updates or adds entries in rules-manifest.json
# 4. Deletes entries for which files are not found in the file system (syncs the manifest with the file system)
# 5. Creates backup before updating

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Base directory
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RULES_DIR="$BASE_DIR/.clinerules"
MANIFEST_FILE="$BASE_DIR/rules-manifest.json"
BACKUP_FILE="$BASE_DIR/rules-manifest.json.backup"

# Counters
TOTAL_FILES=0
NEW_ENTRIES=0
UPDATED_ENTRIES=0
ERRORS=0

echo "=== Updating rules-manifest.json ==="
echo "Base directory: $BASE_DIR"
echo ""

# Function to extract frontmatter field
extract_field() {
    local file=$1
    local field=$2
    local frontmatter=$(sed -n '/^---$/,/^---$/p' "$file" | sed '1d;$d')
    
    # Try different patterns for the field
    local value=$(echo "$frontmatter" | grep "^${field}:" | head -1 | sed "s/^${field}:[[:space:]]*//" | sed 's/^["'\'']\(.*\)["'\'']$/\1/')
    
    # Special handling for arrays (tags, globs)
    if [[ "$field" == "tags" ]] || [[ "$field" == "globs" ]]; then
        # Check if it's already an array format
        if echo "$value" | grep -q '^\['; then
            # Remove the outer quotes if present
            value=$(echo "$value" | sed 's/^"\[\(.*\)\]"$/[\1]/')
        else
            # Convert single value to array format
            if [[ -n "$value" ]]; then
                value="[\"$value\"]"
            else
                value="[]"
            fi
        fi
    fi
    
    echo "$value"
}

# Function to extract tags array from frontmatter
extract_tags_array() {
    local file=$1
    local frontmatter=$(sed -n '/^---$/,/^---$/p' "$file" | sed '1d;$d')
    
    # Look for tags line and everything after it until the next field or end
    local tags_section=$(echo "$frontmatter" | sed -n '/^tags:/,/^[a-zA-Z_-]*:/p' | sed '$d')
    
    if [[ -z "$tags_section" ]]; then
        # Try to get just the tags line if it's the last field
        tags_section=$(echo "$frontmatter" | sed -n '/^tags:/,$p')
    fi
    
    # Check if it's an inline array
    if echo "$tags_section" | head -1 | grep -q '\['; then
        # Extract inline array
        echo "$tags_section" | head -1 | sed 's/^tags:[[:space:]]*//'
    else
        # Extract YAML array format
        local tags_array="["
        local first=true
        while IFS= read -r line; do
            if [[ "$line" =~ ^[[:space:]]*-[[:space:]](.+) ]]; then
                local tag="${BASH_REMATCH[1]}"
                # Remove quotes if present
                tag=$(echo "$tag" | sed 's/^["'\'']\(.*\)["'\'']$/\1/')
                if [[ "$first" == true ]]; then
                    tags_array+="\"$tag\""
                    first=false
                else
                    tags_array+=", \"$tag\""
                fi
            fi
        done <<< "$tags_section"
        tags_array+="]"
        
        if [[ "$tags_array" == "[]" ]]; then
            # Fallback to simple extraction
            extract_field "$file" "tags"
        else
            echo "$tags_array"
        fi
    fi
}

# Create backup
if [[ -f "$MANIFEST_FILE" ]]; then
    echo "Creating backup: $BACKUP_FILE"
    cp "$MANIFEST_FILE" "$BACKUP_FILE"
else
    echo -e "${YELLOW}WARNING${NC}: rules-manifest.json not found. Creating new file."
    echo '{"version": "1.0.0", "rules": []}' > "$MANIFEST_FILE"
fi

# Create temporary Python script for JSON manipulation
cat > /tmp/update_manifest.py << 'EOF'
import json
import sys

def main():
    manifest_file = sys.argv[1]
    
    # Load existing manifest to preserve top-level fields like 'version'
    with open(manifest_file, 'r', encoding='utf-8') as f:
        manifest = json.load(f)
    
    # Read all new/updated rules from stdin
    new_rules = []
    for line in sys.stdin:
        line = line.strip()
        if not line:
            continue
        
        try:
            rule_data = json.loads(line)
            new_rules.append(rule_data)
        except json.JSONDecodeError as e:
            print(f"Error parsing rule data: {e}", file=sys.stderr)
            continue
    
    # Sort rules by path for consistency
    new_rules.sort(key=lambda r: r['path'])
    
    # Replace the rules in the manifest
    manifest['rules'] = new_rules
    
    # Write the completely updated manifest
    with open(manifest_file, 'w', encoding='utf-8') as f:
        json.dump(manifest, f, indent='\t', ensure_ascii=False)
    
    # Print summary
    print(f"\nManifest updated successfully.")
    print(f"Total rules in manifest: {len(new_rules)}")


if __name__ == '__main__':
    main()
EOF

# Process all rule files
echo -e "\n${BLUE}=== Scanning rule files ===${NC}"

# Temporary file to collect rule data
TEMP_RULES="/tmp/rules_data.jsonl"
> "$TEMP_RULES"

# Find and process all .md files
while IFS= read -r -d '' file; do
    ((TOTAL_FILES++))
    relative_path="${file#$BASE_DIR/}"
    
    echo -n "Processing $relative_path... "
    
    # Check if file has frontmatter
    if ! head -n1 "$file" | grep -q "^---$"; then
        echo -e "${RED}ERROR${NC}: No frontmatter found"
        ((ERRORS++))
        continue
    fi
    
    # Extract metadata
    description=$(extract_field "$file" "description")
    author=$(extract_field "$file" "author")
    version=$(extract_field "$file" "version")
    tags=$(extract_tags_array "$file")
    
    # Validate required fields
    if [[ -z "$description" ]] || [[ -z "$author" ]] || [[ -z "$version" ]]; then
        echo -e "${RED}ERROR${NC}: Missing required fields"
        ((ERRORS++))
        continue
    fi
    
    # Create JSON object for this rule
    rule_json=$(python3 -c "
import json
rule = {
    'path': '$relative_path',
    'version': '$version',
    'description': '''$description''',
    'tags': $tags,
    'author': '''$author'''
}
print(json.dumps(rule, ensure_ascii=False))
" 2>/dev/null)
    
    if [[ $? -eq 0 ]]; then
        echo "$rule_json" >> "$TEMP_RULES"
        echo -e "${GREEN}OK${NC}"
    else
        echo -e "${RED}ERROR${NC}: Failed to create JSON"
        ((ERRORS++))
    fi
done < <(find "$RULES_DIR" -name "*.md" -type f -print0)

# Update manifest with collected data
echo -e "\n${BLUE}=== Updating manifest file ===${NC}"
python3 /tmp/update_manifest.py "$MANIFEST_FILE" < "$TEMP_RULES"

# Cleanup
rm -f /tmp/update_manifest.py "$TEMP_RULES"

# Summary
echo -e "\n${BLUE}=== Update Summary ===${NC}"
echo "Total files processed: $TOTAL_FILES"
echo -e "Errors: ${RED}$ERRORS${NC}"

if [[ $ERRORS -gt 0 ]]; then
    echo -e "\n${YELLOW}WARNING${NC}: Update completed with errors. Review the log above."
    exit 1
else
    echo -e "\n${GREEN}Update completed successfully!${NC}"
    
    # Run validation
    if [[ -x "$BASE_DIR/scripts/validate-rules.sh" ]]; then
        echo -e "\n${BLUE}=== Running validation ===${NC}"
        "$BASE_DIR/scripts/validate-rules.sh"
    fi
    
    exit 0
fi