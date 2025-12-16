# Makefile for LaTeX CV and Cover Letter Templates
# Author: iggymiggy
# License: MIT

# LaTeX compiler
LATEX = pdflatex
LATEX_FLAGS = -interaction=nonstopmode

# Company directories
COMPANIES = google hyperion meta nasa

# Default target
.PHONY: all clean help $(COMPANIES)

# Build all companies
all: $(COMPANIES)

# Build templates
templates: templates/cv_template.pdf templates/cover_letter_template.pdf

# Build specific company
$(COMPANIES):
	@echo "Building CV and cover letter for $@..."
	@cd companies/$@ && $(LATEX) $(LATEX_FLAGS) cv.tex > /dev/null 2>&1 || true
	@cd companies/$@ && $(LATEX) $(LATEX_FLAGS) cv.tex > /dev/null 2>&1 || true
	@cd companies/$@ && $(LATEX) $(LATEX_FLAGS) cover_letter.tex > /dev/null 2>&1 || true
	@cd companies/$@ && $(LATEX) $(LATEX_FLAGS) cover_letter.tex > /dev/null 2>&1 || true
	@echo "✓ $@ built successfully"

# Build CV template
templates/cv_template.pdf: templates/cv_template.tex
	@echo "Building CV template..."
	@cd templates && $(LATEX) $(LATEX_FLAGS) cv_template.tex > /dev/null 2>&1 || true
	@cd templates && $(LATEX) $(LATEX_FLAGS) cv_template.tex > /dev/null 2>&1 || true

# Build cover letter template
templates/cover_letter_template.pdf: templates/cover_letter_template.tex
	@echo "Building cover letter template..."
	@cd templates && $(LATEX) $(LATEX_FLAGS) cover_letter_template.tex > /dev/null 2>&1 || true
	@cd templates && $(LATEX) $(LATEX_FLAGS) cover_letter_template.tex > /dev/null 2>&1 || true

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

# Help
help:
	@echo "LaTeX CV and Cover Letter Build System"
	@echo ""
	@echo "Usage:"
	@echo "  make              Build all company CVs and cover letters"
	@echo "  make <company>    Build specific company (google, hyperion, meta, nasa)"
	@echo "  make templates    Build base templates"
	@echo "  make clean        Remove build artifacts (keeps PDFs)"
	@echo "  make clean-all    Remove everything including PDFs (keeps examples)"
	@echo "  make help         Show this help message"
	@echo ""
	@echo "Examples:"
	@echo "  make google       Build Google CV and cover letter"
	@echo "  make all          Build all companies"
	@echo "  make clean        Clean build artifacts"

