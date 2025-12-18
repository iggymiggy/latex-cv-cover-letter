# Makefile for LaTeX CV and Cover Letter Templates
# Author: iggymiggy
# License: MIT

# LaTeX compiler
LATEX = pdflatex
# Optimized flags: nonstopmode, draftmode for first pass (faster)
# First pass: allow errors (they're often resolved in second pass)
# Final pass: nonstopmode (errors will be visible in log, but won't stop build)
LATEX_FLAGS_FIRST = -interaction=nonstopmode -draftmode
LATEX_FLAGS_FINAL = -interaction=nonstopmode

# Auto-detect company directories
COMPANIES = $(shell find companies -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort)

# Number of parallel jobs (use all CPU cores by default)
PARALLEL_JOBS = $(shell sysctl -n hw.ncpu 2>/dev/null || echo 4)

# Default target
.PHONY: all clean help validate lint examples $(COMPANIES)

# Build all companies (parallel by default for performance)
all:
	@echo "Building all companies in parallel (using $(PARALLEL_JOBS) jobs)..."
	@$(MAKE) -j$(PARALLEL_JOBS) $(COMPANIES)
	@echo "✓ All companies built successfully"

# Sequential build (if needed for debugging)
all-sequential:
	@echo "Building all companies sequentially..."
	@$(MAKE) $(COMPANIES)
	@echo "✓ All companies built successfully"

# Build templates
templates: templates/cv_template.pdf templates/cover_letter_template.pdf

# Build specific company (optimized: draftmode for first pass, final for second)
$(COMPANIES):
	@echo "Building CV and cover letter for $@..."
	@cd companies/$@ && \
	 ($(LATEX) $(LATEX_FLAGS_FIRST) -jobname="$@_cv" cv.tex > /dev/null 2>&1 || true; \
	  $(LATEX) $(LATEX_FLAGS_FINAL) -jobname="$@_cv" cv.tex > /dev/null 2>&1 || true; \
	  test -f "$@_cv.pdf" && \
	  $(LATEX) $(LATEX_FLAGS_FIRST) -jobname="$@_cover_letter" cover_letter.tex > /dev/null 2>&1 || true; \
	  $(LATEX) $(LATEX_FLAGS_FINAL) -jobname="$@_cover_letter" cover_letter.tex > /dev/null 2>&1 || true; \
	  test -f "$@_cover_letter.pdf" && \
	  echo "✓ $@ built successfully: $@_cv.pdf, $@_cover_letter.pdf") || \
	 (echo "✗ $@ build failed. Check compilation errors above." && exit 1)

# Build CV template (optimized)
templates/cv_template.pdf: templates/cv_template.tex
	@echo "Building CV template..."
	@cd templates && $(LATEX) $(LATEX_FLAGS_FIRST) cv_template.tex > /dev/null 2>&1 || true
	@cd templates && $(LATEX) $(LATEX_FLAGS_FINAL) cv_template.tex > /dev/null 2>&1 || true

# Build cover letter template (optimized)
templates/cover_letter_template.pdf: templates/cover_letter_template.tex
	@echo "Building cover letter template..."
	@cd templates && $(LATEX) $(LATEX_FLAGS_FIRST) cover_letter_template.tex > /dev/null 2>&1 || true
	@cd templates && $(LATEX) $(LATEX_FLAGS_FINAL) cover_letter_template.tex > /dev/null 2>&1 || true

# Clean build artifacts (keeps PDFs)
clean:
	@echo "Cleaning build artifacts..."
	@find . -name "*.aux" -delete
	@find . -name "*.log" -delete
	@find . -name "*.out" -delete
	@find . -name "*.synctex.gz" -delete
	@find . -name "*.fdb_latexmk" -delete
	@find . -name "*.fls" -delete
	@find . -name "*.toc" -delete
	@find . -name "*.lof" -delete
	@find . -name "*.lot" -delete
	@find . -name "*.bbl" -delete
	@find . -name "*.blg" -delete
	@find . -name "*.bcf" -delete
	@find . -name "*.run.xml" -delete
	@find . -name "*.idx" -delete
	@find . -name "*.ilg" -delete
	@find . -name "*.ind" -delete
	@find . -name "*.nav" -delete
	@find . -name "*.snm" -delete
	@find . -name "*.vrb" -delete
	@echo "✓ Build artifacts cleaned"

# Clean everything including PDFs (except examples)
clean-all: clean
	@echo "Cleaning PDFs (keeping examples)..."
	@find companies -name "*.pdf" -delete
	@find templates -name "*.pdf" -delete
	@find . -maxdepth 1 -name "*.pdf" -delete
	@echo "✓ All files cleaned (examples preserved)"

# Validate all templates (compile check)
validate:
	@echo "Validating all templates..."
	@./scripts/validate.sh

# Lint LaTeX files
lint:
	@echo "Linting LaTeX files..."
	@./scripts/lint.sh

# Generate example files (copy PDFs and regenerate PNGs)
examples:
	@echo "Generating example files..."
	@./scripts/generate-examples.sh

# Build all and generate examples
all-examples: all examples
	@echo "✓ All companies built and examples generated"

# Help
help:
	@echo "LaTeX CV and Cover Letter Build System"
	@echo ""
	@echo "Usage:"
	@echo "  make                      Build all company CVs and cover letters (parallel)"
	@echo "  make all-sequential       Build all companies sequentially (for debugging)"
	@echo "  make <company>             Build specific company (auto-detected from companies/)"
	@echo "  make templates            Build base templates"
	@echo "  make examples             Generate example PDFs and PNGs from built companies"
	@echo "  make all-examples         Build all companies and generate examples"
	@echo "  make validate             Validate all templates compile successfully"
	@echo "  make lint                 Lint LaTeX files for common errors"
	@echo "  make clean                Remove build artifacts (keeps PDFs)"
	@echo "  make clean-all            Remove everything including PDFs (keeps examples)"
	@echo "  make help                 Show this help message"
	@echo ""
	@echo "Output format:"
	@echo "  Company files:    {company}_cv.pdf, {company}_cover_letter.pdf"
	@echo "  Template files:   cv_template.pdf, cover_letter_template.pdf"
	@echo ""
	@echo "Examples:"
	@echo "  make google       Builds google_cv.pdf and google_cover_letter.pdf"
	@echo "  make all          Build all companies"
	@echo "  make validate     Check all files compile"
	@echo "  make lint         Check for LaTeX errors"
	@echo "  make clean        Clean build artifacts"

