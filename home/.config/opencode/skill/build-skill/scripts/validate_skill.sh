#!/usr/bin/env bash
#
# validate_skill.sh - Validate skill structure and frontmatter
#
# Usage: validate_skill.sh <skill-dir> [--json|--quiet]
#
# Exit codes:
#   0 = Valid (may have warnings)
#   1 = Error (invalid skill)
#   2 = Warning only

set -euo pipefail

# Colors
if [[ -t 1 ]]; then
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    RED='\033[0;31m'
    NC='\033[0m'
else
    GREEN='' YELLOW='' RED='' NC=''
fi

usage() {
    cat << 'EOF'
Usage: validate_skill.sh <skill-dir> [options]

Options:
  --json     Output as JSON
  --quiet    Suppress output, exit code only

Examples:
  validate_skill.sh ./my-skill
  validate_skill.sh ./my-skill --json
EOF
    exit 1
}

# Parse arguments
SKILL_DIR=""
OUTPUT_FORMAT="text"
QUIET=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        --json)
            OUTPUT_FORMAT="json"
            shift
            ;;
        --quiet)
            QUIET=true
            shift
            ;;
        -h|--help)
            usage
            ;;
        -*)
            echo "Unknown option: $1" >&2
            usage
            ;;
        *)
            if [[ -z "$SKILL_DIR" ]]; then
                SKILL_DIR="$1"
            else
                echo "Too many arguments" >&2
                usage
            fi
            shift
            ;;
    esac
done

if [[ -z "$SKILL_DIR" ]]; then
    usage
fi

# Resolve skill directory
if [[ ! -d "$SKILL_DIR" ]]; then
    echo -e "${RED}Error${NC}: Directory not found: $SKILL_DIR" >&2
    exit 1
fi

SKILL_DIR="$(cd "$SKILL_DIR" && pwd)"
SKILL_NAME="$(basename "$SKILL_DIR")"
SKILL_MD="$SKILL_DIR/SKILL.md"

# Validation state
ERRORS=()
WARNINGS=()

add_error() {
    ERRORS+=("$1")
}

add_warning() {
    WARNINGS+=("$1")
}

# Check SKILL.md exists
if [[ ! -f "$SKILL_MD" ]]; then
    add_error "SKILL.md not found"
else
    # Check frontmatter
    FIRST_LINE=$(head -1 "$SKILL_MD")
    if [[ "$FIRST_LINE" != "---" ]]; then
        add_error "SKILL.md must start with '---' (found: '$FIRST_LINE')"
    fi
    
    # Extract frontmatter
    FRONTMATTER=$(sed -n '1,/^---$/p' "$SKILL_MD" | tail -n +2 | head -n -1)
    
    if [[ -z "$FRONTMATTER" ]]; then
        add_error "No frontmatter found"
    else
        # Check name field
        NAME_VALUE=$(echo "$FRONTMATTER" | grep -E '^name:' | sed 's/^name:\s*//' | tr -d '"' | tr -d "'" || true)
        
        if [[ -z "$NAME_VALUE" ]]; then
            add_error "Missing 'name:' field in frontmatter"
        else
            # Validate name format
            if [[ ! "$NAME_VALUE" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
                add_error "Invalid name format: '$NAME_VALUE' (must be lowercase with hyphens)"
            fi
            
            # Check name matches directory
            if [[ "$NAME_VALUE" != "$SKILL_NAME" ]]; then
                add_error "Name mismatch: name='$NAME_VALUE' but directory='$SKILL_NAME'"
            fi
        fi
        
        # Check description field
        DESC_VALUE=$(echo "$FRONTMATTER" | grep -E '^description:' | sed 's/^description:\s*//' || true)
        
        if [[ -z "$DESC_VALUE" ]]; then
            add_error "Missing 'description:' field in frontmatter"
        elif [[ ${#DESC_VALUE} -lt 30 ]]; then
            add_warning "Description is short (${#DESC_VALUE} chars, recommend 50+)"
        fi
    fi
    
    # Check file size
    LINE_COUNT=$(wc -l < "$SKILL_MD")
    if [[ $LINE_COUNT -gt 500 ]]; then
        add_warning "SKILL.md is large ($LINE_COUNT lines, recommend <200)"
    fi
fi

# Check for broken internal links
if [[ -f "$SKILL_MD" ]]; then
    while IFS= read -r link; do
        # Extract path from markdown link
        path=$(echo "$link" | sed -E 's/.*\]\(([^)]+)\).*/\1/' | sed 's/#.*//')
        
        # Skip external links
        if [[ "$path" =~ ^https?:// ]] || [[ "$path" =~ ^mailto: ]]; then
            continue
        fi
        
        # Resolve relative to skill dir
        full_path="$SKILL_DIR/$path"
        
        if [[ ! -e "$full_path" ]]; then
            add_warning "Broken link: $path"
        fi
    done < <(grep -oE '\[[^]]+\]\([^)]+\)' "$SKILL_MD" 2>/dev/null || true)
fi

# Output results
EXIT_CODE=0

if [[ ${#ERRORS[@]} -gt 0 ]]; then
    EXIT_CODE=1
elif [[ ${#WARNINGS[@]} -gt 0 ]]; then
    EXIT_CODE=2
fi

if $QUIET; then
    exit $EXIT_CODE
fi

if [[ "$OUTPUT_FORMAT" == "json" ]]; then
    # JSON output
    echo "{"
    echo "  \"skill\": \"$SKILL_NAME\","
    echo "  \"valid\": $([ $EXIT_CODE -eq 0 ] && echo true || echo false),"
    echo "  \"errors\": ["
    for i in "${!ERRORS[@]}"; do
        echo -n "    \"${ERRORS[$i]}\""
        [[ $i -lt $((${#ERRORS[@]} - 1)) ]] && echo "," || echo ""
    done
    echo "  ],"
    echo "  \"warnings\": ["
    for i in "${!WARNINGS[@]}"; do
        echo -n "    \"${WARNINGS[$i]}\""
        [[ $i -lt $((${#WARNINGS[@]} - 1)) ]] && echo "," || echo ""
    done
    echo "  ]"
    echo "}"
else
    # Text output
    echo "Validating: $SKILL_NAME"
    echo ""
    
    if [[ ${#ERRORS[@]} -gt 0 ]]; then
        echo -e "${RED}Errors:${NC}"
        for err in "${ERRORS[@]}"; do
            echo "  - $err"
        done
        echo ""
    fi
    
    if [[ ${#WARNINGS[@]} -gt 0 ]]; then
        echo -e "${YELLOW}Warnings:${NC}"
        for warn in "${WARNINGS[@]}"; do
            echo "  - $warn"
        done
        echo ""
    fi
    
    if [[ $EXIT_CODE -eq 0 ]]; then
        echo -e "${GREEN}Valid${NC}"
    elif [[ $EXIT_CODE -eq 2 ]]; then
        echo -e "${YELLOW}Valid with warnings${NC}"
    else
        echo -e "${RED}Invalid${NC}"
    fi
fi

exit $EXIT_CODE
