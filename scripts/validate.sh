#!/bin/bash
# Template Validation Script
# Validates that all company CVs and cover letters compile successfully
# Author: iggymiggy
# License: MIT

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get script directory and project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$PROJECT_ROOT"

# LaTeX compiler
LATEX="pdflatex"
LATEX_FLAGS="-interaction=nonstopmode -halt-on-error"

# Company directories
COMPANIES=(google hyperion meta nasa)

# Counters
TOTAL=0
PASSED=0
FAILED=0
FAILED_FILES=()

echo "=========================================="
echo "LaTeX Template Validation"
echo "=========================================="
echo ""

# Function to validate a LaTeX file
validate_file() {
    local file="$1"
    local file_type="$2"
    local company="$3"
    
    TOTAL=$((TOTAL + 1))
    
    echo -n "Validating $file_type for $company... "
    
    # Change to the directory containing the file
    local dir=$(dirname "$file")
    local filename=$(basename "$file")
    local output_name="${filename%.tex}"
    
    # Create temporary directory for build artifacts (within workspace)
    local temp_dir="$PROJECT_ROOT/.validate_temp_$$"
    mkdir -p "$temp_dir" 2>/dev/null || true
    
    # Try to compile (run twice for cross-references)
    # Use -output-directory to write build artifacts to temp directory
    if (cd "$PROJECT_ROOT/$dir" && \
        $LATEX $LATEX_FLAGS -output-directory="$temp_dir" "$filename" > "$temp_dir/${output_name}_pass1.log" 2>&1 && \
        $LATEX $LATEX_FLAGS -output-directory="$temp_dir" "$filename" > "$temp_dir/${output_name}_pass2.log" 2>&1); then
        echo -e "${GREEN}✓ PASSED${NC}"
        PASSED=$((PASSED + 1))
    else
        echo -e "${RED}✗ FAILED${NC}"
        FAILED=$((FAILED + 1))
        FAILED_FILES+=("$file")
        # Show error log from temp directory
        if [ -f "$temp_dir/${output_name}_pass2.log" ]; then
            echo "  Error log:"
            grep -A 5 "Error\|Fatal" "$temp_dir/${output_name}_pass2.log" 2>/dev/null | head -10 || true
        elif [ -f "$temp_dir/${output_name}_pass1.log" ]; then
            echo "  Error log:"
            grep -A 5 "Error\|Fatal" "$temp_dir/${output_name}_pass1.log" 2>/dev/null | head -10 || true
        fi
    fi
    
    # Clean up temp directory
    rm -rf "$temp_dir" 2>/dev/null || true
}

# Validate templates
echo "Validating base templates..."
echo "----------------------------------------"
validate_file "templates/cv_template.tex" "CV template" "base"
validate_file "templates/cover_letter_template.tex" "Cover letter template" "base"
echo ""

# Validate company files
echo "Validating company files..."
echo "----------------------------------------"
for company in "${COMPANIES[@]}"; do
    if [ -f "companies/$company/cv.tex" ]; then
        validate_file "companies/$company/cv.tex" "CV" "$company"
    fi
    
    if [ -f "companies/$company/cover_letter.tex" ]; then
        validate_file "companies/$company/cover_letter.tex" "Cover letter" "$company"
    fi
done

echo ""
echo "=========================================="
echo "Validation Summary"
echo "=========================================="
echo "Total files: $TOTAL"
echo -e "${GREEN}Passed: $PASSED${NC}"
if [ $FAILED -gt 0 ]; then
    echo -e "${RED}Failed: $FAILED${NC}"
    echo ""
    echo "Failed files:"
    for file in "${FAILED_FILES[@]}"; do
        echo "  - $file"
    done
    exit 1
else
    echo -e "${GREEN}All files compiled successfully!${NC}"
    exit 0
fi

