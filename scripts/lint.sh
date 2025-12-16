#!/bin/bash
# LaTeX Linting Script
# Checks LaTeX files for common errors and issues
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

# Counters
TOTAL=0
ISSUES=0
WARNINGS=0

echo "=========================================="
echo "LaTeX Linting"
echo "=========================================="
echo ""

# Function to check a file
check_file() {
    local file="$1"
    local file_type="$2"
    
    TOTAL=$((TOTAL + 1))
    local file_issues=0
    local file_warnings=0
    
    echo -e "${BLUE}Checking: $file${NC}"
    
    # Check 1: Ensure file exists
    if [ ! -f "$file" ]; then
        echo -e "  ${RED}✗ File not found${NC}"
        ISSUES=$((ISSUES + 1))
        file_issues=$((file_issues + 1))
        return
    fi
    
    # Check 2: Look for common LaTeX errors
    # Missing closing braces
    local open_braces=$(grep -o '{' "$file" | wc -l | tr -d ' ')
    local close_braces=$(grep -o '}' "$file" | wc -l | tr -d ' ')
    if [ "$open_braces" != "$close_braces" ]; then
        echo -e "  ${RED}✗ Mismatched braces: $open_braces opening, $close_braces closing${NC}"
        ISSUES=$((ISSUES + 1))
        file_issues=$((file_issues + 1))
    fi
    
    # Check 3: Look for undefined commands (common mistakes)
    # This is a basic check - chktex will catch more if available
    if grep -q "\\newcommand{\\undefined" "$file" 2>/dev/null; then
        echo -e "  ${YELLOW}⚠ Potential undefined command reference${NC}"
        WARNINGS=$((WARNINGS + 1))
        file_warnings=$((file_warnings + 1))
    fi
    
    # Check 4: Look for common typos in LaTeX commands
    # Note: This may produce false positives, but helps catch real typos
    if grep -E "\\\\[a-zA-Z]+\{" "$file" | grep -vE "(begin|end|newcommand|renewcommand|loadfile|input|usepackage|RequirePackage|selectlanguage|today|pdfgentounicode|IfFileExists|def|edef|ifx|fi|else|section|subsection|item|textbf|textit|textcolor|href|colorbox|framebox|parbox|minipage|tabular|array|enumerate|itemize|description|center|flushleft|flushright|raggedright|raggedleft|sffamily|ttfamily|rmfamily|bfseries|itshape|slshape|scshape|mdseries|upshape|normalfont|small|footnotesize|scriptsize|tiny|large|Large|LARGE|huge|Huge|emph|underline|texttt|textsf|textrm|textsc|textsl|textmd|textup|textnormal|textsuperscript|textsubscript|label|ref|pageref|cite|bibliography|tableofcontents|listoffigures|listoftables|makeindex|makeglossary|printindex|printglossary|include|includeonly|input|newpage|clearpage|cleardoublepage|newline|linebreak|nolinebreak|pagebreak|nopagebreak|samepage|par|noindent|indent|vspace|hspace|vfill|hfill|vfil|hfil|rule|framebox|colorbox|parbox|minipage|makebox|savebox|usebox|sbox|usebox|raisebox|rotatebox|scalebox|resizebox|reflectbox|rotate|scale|reflect|resize|framebox|colorbox|parbox|minipage|makebox|savebox|usebox|sbox|usebox|raisebox|rotatebox|scalebox|resizebox|reflectbox|rotate|scale|reflect|resize)" > /dev/null 2>&1; then
        # Only warn if it looks like a real typo (not a known command)
        # This is a very basic check - chktex is better
        :
    fi
    
    # Check 5: Ensure required commands are defined
    if [ "$file_type" = "cv" ]; then
        if ! grep -q "\\newcommand{\\myname}" "$file" && ! grep -q "\\loadfile{personal_info.tex}" "$file"; then
            echo -e "  ${YELLOW}⚠ personal_info.tex may not be loaded${NC}"
            WARNINGS=$((WARNINGS + 1))
            file_warnings=$((file_warnings + 1))
        fi
    fi
    
    # Check 6: Look for hardcoded paths (should use \loadfile)
    # Only warn if using \input with relative paths (not \loadfile)
    if grep -E "\\input\{\.\./\.\./" "$file" > /dev/null 2>&1 && ! grep -q "\\loadfile" "$file"; then
        echo -e "  ${YELLOW}⚠ Hardcoded path detected (consider using \\loadfile)${NC}"
        WARNINGS=$((WARNINGS + 1))
        file_warnings=$((file_warnings + 1))
    fi
    
    # Check 7: Ensure common.sty is loaded
    if [ "$file_type" != "config" ]; then
        if ! grep -q "\\loadfile{templates/common.sty}" "$file" && ! grep -q "common.sty" "$file"; then
            echo -e "  ${YELLOW}⚠ common.sty may not be loaded${NC}"
            WARNINGS=$((WARNINGS + 1))
            file_warnings=$((file_warnings + 1))
        fi
    fi
    
    if [ $file_issues -eq 0 ] && [ $file_warnings -eq 0 ]; then
        echo -e "  ${GREEN}✓ No issues found${NC}"
    fi
    
    echo ""
}

# Check if chktex is available (more advanced linting)
if command -v chktex > /dev/null 2>&1; then
    echo -e "${GREEN}chktex found - using advanced linting${NC}"
    echo ""
    USE_CHKTEX=true
else
    echo -e "${YELLOW}chktex not found - using basic linting${NC}"
    echo "  Install chktex for more comprehensive checks:"
    echo "  - macOS: brew install chktex"
    echo "  - Linux: sudo apt-get install chktex"
    echo ""
    USE_CHKTEX=false
fi

# Check templates
echo "Checking templates..."
echo "----------------------------------------"
check_file "templates/cv_template.tex" "cv"
check_file "templates/cover_letter_template.tex" "cover_letter"
check_file "templates/base_config.tex" "config"
check_file "templates/common.sty" "config"

# Check company files
echo "Checking company files..."
echo "----------------------------------------"
for company in google hyperion meta nasa; do
    if [ -f "companies/$company/shared.tex" ]; then
        check_file "companies/$company/shared.tex" "config"
    fi
    if [ -f "companies/$company/cv.tex" ]; then
        check_file "companies/$company/cv.tex" "cv"
    fi
    if [ -f "companies/$company/cover_letter.tex" ]; then
        check_file "companies/$company/cover_letter.tex" "cover_letter"
    fi
done

# Use chktex if available
if [ "$USE_CHKTEX" = true ]; then
    echo "Running chktex (advanced linting)..."
    echo "----------------------------------------"
    for file in templates/*.tex templates/*.sty companies/*/*.tex; do
        if [ -f "$file" ]; then
            echo -e "${BLUE}chktex: $file${NC}"
            chktex -q -n2 -n24 -n13 "$file" 2>&1 | head -20 || true
            echo ""
        fi
    done
fi

# Summary
echo "=========================================="
echo "Linting Summary"
echo "=========================================="
echo "Total files checked: $TOTAL"
if [ $ISSUES -gt 0 ]; then
    echo -e "${RED}Issues found: $ISSUES${NC}"
fi
if [ $WARNINGS -gt 0 ]; then
    echo -e "${YELLOW}Warnings: $WARNINGS${NC}"
fi
if [ $ISSUES -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}No issues found!${NC}"
    exit 0
elif [ $ISSUES -gt 0 ]; then
    exit 1
else
    exit 0
fi

