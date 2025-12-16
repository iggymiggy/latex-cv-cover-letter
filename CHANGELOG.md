# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- **Automated Example Generation** (#5)
  - `scripts/generate-examples.sh`: Automated script to copy PDFs and regenerate PNG images
  - `make examples`: Generate example files from built companies
  - `make all-examples`: Build all companies and generate examples in one command
  - Ensures examples stay in sync with template changes
  - Uses `pdftoppm` for reliable PNG generation (150 DPI)
  - Validates source PDFs exist before processing

- **Performance Optimizations** (#10)
  - Parallel build support: `make all-parallel` uses all CPU cores
  - Optimized LaTeX compilation flags: `-draftmode` for first pass (faster)
  - `-halt-on-error` flag for faster failure detection
  - Automatic CPU core detection for optimal parallel job count
  - Combined targets: `make all-examples-parallel` for fastest workflow
- **Validation and Linting Scripts** (#9, #10)
  - `scripts/validate.sh`: Validates that all templates and company files compile successfully
  - `scripts/lint.sh`: Checks LaTeX files for common errors and issues
  - `make validate` and `make lint` targets in Makefile
  - Support for `chktex` for advanced linting (optional)
  - Comprehensive documentation in README.md

- **Build Automation** (#8)
  - `Makefile` for automated compilation of all companies and templates
  - `make <company>` to build specific company CV and cover letter
  - `make templates` to build base templates
  - `make clean` and `make clean-all` for cleaning build artifacts
  - Consistent output naming: `{company}_cv.pdf` and `{company}_cover_letter.pdf`

- **Shared Code Architecture** (#1-#4)
  - `templates/common.sty`: Centralized package for shared LaTeX packages, custom commands, and helper macros
  - `\loadfile` helper macro: Flexible file path resolution for loading files from different directories
  - `\ifnotempty` helper macro: Conditional content execution based on empty command check
  - `\conditionalsection` helper macro: Conditional section visibility wrapper
  - `\setupcoverletterdate` helper macro: Centralized date handling for cover letters

- **Shared Company Variables** (#5)
  - `companies/*/shared.tex`: Company-specific variables used by both CV and cover letter
  - Eliminates duplication of `\cvtitle` and other shared variables
  - Both `cv.tex` and `cover_letter.tex` now load `shared.tex`

- **Documentation Improvements** (#11, #12, #13)
  - Comprehensive inline documentation for all custom LaTeX commands in `common.sty`
  - `CHANGELOG.md`: Track all changes and improvements
  - Expanded architecture documentation in README.md with detailed explanations

- **Configuration Validation** (#17)
  - `\validateconfigcv`: Validates required CV fields (personal info, CV title)
  - `\validateconfigcoverletter`: Validates required cover letter fields (personal info, company details, letter body)
  - Automatic validation during compilation with LaTeX warnings
  - Detects placeholder/example values and missing required fields
  - Integrated into base templates; can be called in company files after customizations

- **Version Tracking** (#20)
  - `\templateversion` and `\templateversiondate` commands for version tracking
  - Version information embedded in PDF metadata (visible in PDF properties)
  - Easy to check template version from generated PDFs
  - Follows semantic versioning (MAJOR.MINOR.PATCH)

- **PDF Metadata Customization** (#23)
  - Customizable PDF metadata fields: `\pdfmetatitle`, `\pdfmetaauthor`, `\pdfmetasubject`, `\pdfmetakeywords`
  - Auto-generated defaults from personal information and template version
  - Per-company customization support
  - Better SEO for online CVs and improved file organization

- **Pre-commit Hooks** (#21)
  - Git pre-commit hook automatically runs `make lint` and `make validate`
  - Blocks commits if linting or validation fails
  - Provides clear error messages
  - Helps maintain code quality and catch errors early

- **Section Reordering Helper** (#24)
  - `\cvsectionorder` command to define custom section order per company
  - `\rendercvsections` macro processes the order list and renders sections accordingly
  - Flexible section ordering: reorder, hide, or prioritize sections per application
  - Default order: technologies,experience,education,certificates,opensource,volunteer,languages,awards
  - Companies can override with `\renewcommand{\cvsectionorder}{...}` in their `cv.tex` file

- **Color Theme Customization** (#19)
  - Color theme system with customizable variables: `\cvthemeprimary`, `\cvthemeaccent`, `\cvthemelink`, `\cvthemesection`
  - `\cvcolor{type}{content}` helper macro for applying theme colors
  - Company-specific color themes: Google (blue), Meta (blue), NASA (red/blue), Hyperion (teal)
  - Default theme maintains current gray appearance (backward compatible)
  - Easy per-company customization via `shared.tex` or individual document files
  - Supports any LaTeX color syntax (named, mixed, RGB, custom)

### Changed
- **Date Handling Refactoring** (#6)
  - Refactored `\setupcoverletterdate` to use `\selectlanguage{\letterdatelanguage}` directly
  - Removed hardcoded language strings ("finnish", "english")
  - Now works with any language loaded in babel package
  - More flexible and maintainable date language selection

- **Template Structure**
  - All templates and company files now use `common.sty` instead of duplicated preamble code
  - Reduced code duplication across all template files
  - Consistent use of `\loadfile` for file loading
  - Consistent use of `\conditionalsection` for optional sections

- **Glyphtounicode Usage** (#5)
  - Standardized usage: CV files use `\input{glyphtounicode}`, cover letters do not
  - Added documentation explaining the difference and rationale
  - Ensures ATS-friendly CV parsing while maintaining Unicode support in cover letters

### Fixed
- **Build Artifacts** (#14)
  - Verified `.gitignore` correctly ignores all build artifacts
  - Confirmed no build artifacts are tracked in Git
  - Makefile includes comprehensive `clean` target

## [1.0.0] - Initial Release

### Added
- Professional one-page CV template
- Matching cover letter template
- Company-specific customization system
- Centralized personal information (`personal_info.tex`)
- Base configuration with defaults (`templates/base_config.tex`)
- Optional sections: Certificates, Open Source, Volunteer Work, Languages, Awards
- Multi-language date formatting support (babel)
- ATS-friendly formatting
- Example company customizations (Google, Hyperion, Meta, NASA)

### Features
- Custom LaTeX commands for CV formatting (`\cvItem`, `\cvSubheading`, etc.)
- Cover letter section command (`\lettersection`)
- Flexible file path resolution
- Configurable paper size (A4/Letter)
- Clickable certificate links (Credly badges)
- Font Awesome icons for LinkedIn and GitHub

---

## Notes

- All improvements follow the modular architecture principle
- Backward compatibility maintained throughout refactoring
- All changes tested and validated

