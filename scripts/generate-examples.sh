#!/bin/bash
# Automated Example Generation Script
# Copies PDFs from companies/*/ to examples/companies/ and regenerates PNG images
# Author: iggymiggy
# License: MIT

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get script directory and project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$PROJECT_ROOT"

# Check if pdftoppm is available
if ! command -v pdftoppm &> /dev/null; then
    echo -e "${RED}✗ Error: pdftoppm is not installed${NC}"
    echo "Please install poppler-utils:"
    echo "  macOS: brew install poppler"
    echo "  Linux: sudo apt-get install poppler-utils"
    exit 1
fi

# Ensure examples directory exists
EXAMPLES_DIR="$PROJECT_ROOT/examples/companies"
mkdir -p "$EXAMPLES_DIR"

echo "=========================================="
echo "Generating Example Files"
echo "=========================================="
echo ""

# Counter
UPDATED=0
SKIPPED=0
FAILED=0

# Function to copy PDF and generate PNG
process_company_file() {
    local company="$1"
    local file_type="$2"  # "cv" or "cover_letter"
    local source_pdf="companies/$company/${company}_${file_type}.pdf"
    local dest_pdf="$EXAMPLES_DIR/${company}_${file_type}.pdf"
    local dest_png="$EXAMPLES_DIR/${company}_${file_type}.png"
    
    # Check if source PDF exists
    if [ ! -f "$source_pdf" ]; then
        echo -e "  ${YELLOW}⚠ Source PDF not found: $source_pdf${NC}"
        echo -e "    ${YELLOW}Run 'make $company' first to build the PDF${NC}"
        FAILED=$((FAILED + 1))
        return 1
    fi
    
    # Copy PDF
    if cp "$source_pdf" "$dest_pdf" 2>/dev/null; then
        echo -e "  ${GREEN}✓${NC} Copied PDF: ${company}_${file_type}.pdf"
    else
        echo -e "  ${RED}✗${NC} Failed to copy PDF: $source_pdf"
        FAILED=$((FAILED + 1))
        return 1
    fi
    
    # Generate PNG from PDF using pdftoppm (NOT sips!)
    # pdftoppm creates {prefix}-1.png for single page PDFs
    local temp_prefix="${dest_png%.png}_temp"
    if pdftoppm -png -r 150 -singlefile "$dest_pdf" "$temp_prefix" > /dev/null 2>&1; then
        # pdftoppm creates {prefix}-1.png, rename to desired name
        if [ -f "${temp_prefix}-1.png" ]; then
            mv "${temp_prefix}-1.png" "$dest_png"
            echo -e "  ${GREEN}✓${NC} Generated PNG: ${company}_${file_type}.png"
            UPDATED=$((UPDATED + 1))
        else
            echo -e "  ${RED}✗${NC} PNG generation failed: expected ${temp_prefix}-1.png"
            FAILED=$((FAILED + 1))
            return 1
        fi
    else
        echo -e "  ${RED}✗${NC} Failed to generate PNG from: $dest_pdf"
        FAILED=$((FAILED + 1))
        return 1
    fi
}

# Static list of example companies (user-added companies are not examples)
EXAMPLE_COMPANIES=("google" "hyperion" "meta" "nasa" "microsoft")

# Verify example companies exist
COMPANIES=()
for company in "${EXAMPLE_COMPANIES[@]}"; do
    if [ -d "companies/$company" ]; then
        COMPANIES+=("$company")
    else
        echo -e "  ${YELLOW}⚠ Example company directory not found: companies/$company${NC}"
    fi
done

if [ ${#COMPANIES[@]} -eq 0 ]; then
    echo -e "${YELLOW}⚠ No example company directories found${NC}"
    exit 0
fi

# Process each company
for company in "${COMPANIES[@]}"; do
    echo -e "${BLUE}Processing: $company${NC}"
    
    # Process CV
    process_company_file "$company" "cv"
    
    # Process cover letter
    process_company_file "$company" "cover_letter"
    
    echo ""
done

# Summary
echo "=========================================="
echo "Summary"
echo "=========================================="
echo -e "${GREEN}✓ Updated: $UPDATED files${NC}"
if [ $FAILED -gt 0 ]; then
    echo -e "${RED}✗ Failed: $FAILED files${NC}"
    echo ""
    echo "Note: Some files may need to be built first with 'make <company>'"
    exit 1
else
    echo -e "${GREEN}✓ All example files generated successfully!${NC}"
    exit 0
fi

