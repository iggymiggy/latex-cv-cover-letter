# Professional CV / Resume and Cover Letter LaTeX Templates

A clean, modern LaTeX template for a professional **CV** (also called a **resume/résumé**) and cover letter. ATS-friendly and easy to customize.

**Keywords**: CV, resume, résumé, curriculum vitae, cover letter

## Features

- Professional one-page CV layout
- Matching cover letter template
- **Company-specific customization** - Tailor CV and cover letter for each application
- **Shared code architecture** - Common packages and commands in `templates/common.sty`
- **Shared company variables** - Variables used by both CV and cover letter in `shared.tex`
- Centralized personal information
- Optional sections: Certificates, Open Source, Volunteer Work, Languages, Awards
- Optional certificate links (Credly badges)
- Multi-language date formatting (configurable via babel)
- Paper size is configurable (A4 by default)

## Examples

Each company folder generates customized PDFs with company-specific CV skills and cover letter content/styles.

### Google

<table>
  <tr>
    <td width="50%" valign="top">
      <p align="center">
        <strong>CV</strong><br>
        <a href="examples/companies/google_cv.pdf">
          <img src="examples/companies/google_cv.png" alt="Google CV" width="100%">
        </a><br>
        <a href="examples/companies/google_cv.pdf">View PDF</a>
      </p>
    </td>
    <td width="50%" valign="top">
      <p align="center">
        <strong>Cover Letter</strong><br>
        <a href="examples/companies/google_cover_letter.pdf">
          <img src="examples/companies/google_cover_letter.png" alt="Google Cover Letter" width="100%">
        </a><br>
        <a href="examples/companies/google_cover_letter.pdf">View PDF</a>
      </p>
    </td>
  </tr>
</table>

### Hyperion BioSystems

<table>
  <tr>
    <td width="50%" valign="top">
      <p align="center">
        <strong>CV</strong><br>
        <a href="examples/companies/hyperion_cv.pdf">
          <img src="examples/companies/hyperion_cv.png" alt="Hyperion BioSystems CV" width="100%">
        </a><br>
        <a href="examples/companies/hyperion_cv.pdf">View PDF</a>
      </p>
    </td>
    <td width="50%" valign="top">
      <p align="center">
        <strong>Cover Letter</strong><br>
        <a href="examples/companies/hyperion_cover_letter.pdf">
          <img src="examples/companies/hyperion_cover_letter.png" alt="Hyperion BioSystems Cover Letter" width="100%">
        </a><br>
        <a href="examples/companies/hyperion_cover_letter.pdf">View PDF</a>
      </p>
    </td>
  </tr>
</table>

### Meta

<table>
  <tr>
    <td width="50%" valign="top">
      <p align="center">
        <strong>CV</strong><br>
        <a href="examples/companies/meta_cv.pdf">
          <img src="examples/companies/meta_cv.png" alt="Meta CV" width="100%">
        </a><br>
        <a href="examples/companies/meta_cv.pdf">View PDF</a>
      </p>
    </td>
    <td width="50%" valign="top">
      <p align="center">
        <strong>Cover Letter</strong><br>
        <a href="examples/companies/meta_cover_letter.pdf">
          <img src="examples/companies/meta_cover_letter.png" alt="Meta Cover Letter" width="100%">
        </a><br>
        <a href="examples/companies/meta_cover_letter.pdf">View PDF</a>
      </p>
    </td>
  </tr>
</table>

### NASA

<table>
  <tr>
    <td width="50%" valign="top">
      <p align="center">
        <strong>CV</strong><br>
        <a href="examples/companies/nasa_cv.pdf">
          <img src="examples/companies/nasa_cv.png" alt="NASA CV" width="100%">
        </a><br>
        <a href="examples/companies/nasa_cv.pdf">View PDF</a>
      </p>
    </td>
    <td width="50%" valign="top">
      <p align="center">
        <strong>Cover Letter</strong><br>
        <a href="examples/companies/nasa_cover_letter.pdf">
          <img src="examples/companies/nasa_cover_letter.png" alt="NASA Cover Letter" width="100%">
        </a><br>
        <a href="examples/companies/nasa_cover_letter.pdf">View PDF</a>
      </p>
    </td>
  </tr>
</table>

## Quick Start

### 1. Edit Personal Information

Edit `personal_info.tex` with your name, contact info, and online presence.

### 2. Use Existing Example or Create New Company

Pick one of these workflows. In all cases, you run `pdflatex` to **compile a `.tex` file into a `.pdf`**.

- `pdflatex cv.tex` → creates `cv.pdf` (your CV)
- `pdflatex cover_letter.tex` → creates `cover_letter.pdf` (your cover letter)

**Option A: Use an existing example (Google, Hyperion, Meta, NASA)**

*Using Makefile (recommended):*
```bash
# Build all companies
make

# Build specific company
make google  # or hyperion, meta, nasa

# Build base templates
make templates
```

*Manual compilation:*
```bash
cd companies/nasa  # or google, hyperion, meta
# Edit shared.tex (cvtitle), cv.tex, and cover_letter.tex (company-specific fields)
# Also edit personal_info.tex (your personal details)
pdflatex cv.tex
pdflatex cover_letter.tex
```

**Option B: Create a new company folder (recommended: copy an existing one)**
```bash
cp -R companies/nasa companies/your_company  # or copy google/meta
cd companies/your_company
# Edit shared.tex (cvtitle), cv.tex, and cover_letter.tex (company-specific fields)
# Also edit personal_info.tex (your personal details)

# Build using Makefile (from project root)
make your_company

# Or build manually
pdflatex cv.tex
pdflatex cover_letter.tex
```

**Option C: Compile the base CV (generic)**
```bash
# Using Makefile
make templates

# Or manually
cd templates
pdflatex cv_template.tex  # Builds templates/cv_template.pdf using defaults from base_config.tex
```

**Output file naming:**

- **Using Makefile**: Automatically generates `{company}_cv.pdf` and `{company}_cover_letter.pdf`
  - Example: `make google` → `google_cv.pdf`, `google_cover_letter.pdf`
- **Manual compilation**: Defaults to `cv.pdf` and `cover_letter.pdf`
  - To use company-prefixed names manually, use `-jobname`:
  ```bash
  pdflatex -jobname="google_cv" cv.tex
  pdflatex -jobname="google_cover_letter" cover_letter.tex
  ```

## Project Structure

```
project/
├── personal_info.tex          # Shared personal info
├── document_settings.tex      # Global settings (paper size, font size)
├── templates/                 # Base templates and shared code
│   ├── cv_template.tex       # Base CV template
│   ├── cover_letter_template.tex # Base cover letter template
│   ├── base_config.tex       # Default values for all fields
│   └── common.sty            # Shared packages, commands, and helper macros
└── companies/                 # Company-specific folders
    ├── google/
    │   ├── shared.tex        # Shared variables (cvtitle, etc.)
    │   ├── cv.tex            # CV customizations
    │   └── cover_letter.tex  # Cover letter customizations
    ├── hyperion/
    │   ├── shared.tex
    │   ├── cv.tex
    │   └── cover_letter.tex
    ├── meta/
    │   └── ...
    └── nasa/
        └── ...
```

## Configuration

### Personal Information (`personal_info.tex`)

Edit once, used across all CVs and cover letters:
- Name, email, phone
- LinkedIn, GitHub, portfolio URLs

### Base Configuration (`templates/base_config.tex`)

Contains default values for all fields:
- CV: title, technologies, certificates (4), open source (empty), volunteer (empty), languages (empty), awards (empty)
- Cover letter: company details, letter content, date settings

### Company Files

Each company folder contains three files:

**1. `shared.tex` - Shared variables (used by both CV and cover letter)**
```latex
% Professional title (used in headers of both CV and cover letter)
\renewcommand{\cvtitle}{Space Systems Engineer | Flight Software Specialist}
```

**2. `cv.tex` - CV-specific customizations**
```latex
% Load shared company configuration (variables used by both CV and cover letter)
\loadfile{shared.tex}{}

% CV customizations
\renewcommand{\cvtechnologies}{%
  \section{Skills}
  \cvSubHeadingListStart
    \item{\textbf{Technical Skills}{:} Space Systems, Satellite Operations...}
  \cvSubHeadingListEnd
}

% Certificates with optional links
\renewcommand{\cvcertificates}{%
  \href{https://www.credly.com/badges/YOUR_BADGE_ID}{\textbf{Certificate Name}} & \textcolor{gray}{\textit{Date}} \\
  \textbf{Certificate Without Link} & \textcolor{gray}{\textit{Date}} \\
}

% Optional sections (leave empty to hide)
\renewcommand{\cvopensource}{...}      % Open Source Contributions
\renewcommand{\cvvolunteer}{...}       % Volunteer Work
\renewcommand{\cvlanguages}{...}      % Languages
\renewcommand{\cvawards}{...}         % Awards & Honors
```

**3. `cover_letter.tex` - Cover letter-specific customizations**
```latex
% Load shared company configuration (variables used by both CV and cover letter)
\loadfile{shared.tex}{}

% Company details
\renewcommand{\companyname}{NASA}
\renewcommand{\companyaddress}{300 E Street SW}
\renewcommand{\companyrecipient}{NASA Hiring Team}
\renewcommand{\companycity}{Washington, DC 20546}

% Letter settings
\renewcommand{\letterdatelanguage}{english}  % or "finnish" (must match babel languages)
\renewcommand{\letterdate}{auto}             % or specific date like "January 15, 2024"
\renewcommand{\lettertitle}{Application for Space Systems Engineer Position}
\renewcommand{\letteropening}{Dear NASA Hiring Team,}
\renewcommand{\letterclosing}{Sincerely,}

% Letter body
\renewcommand{\letterbody}{%
  Your letter content here...
}
```

**Key points:**
- Use `\renewcommand` (not `\newcommand`) to override base defaults
- `shared.tex` contains variables used by both CV and cover letter (like `\cvtitle`)
- Only define fields that differ from base - undefined fields use base defaults
- Optional sections are hidden if empty
- Date language must match a language loaded in babel (e.g., `[finnish,english]`)

## CV Sections

**Required:**
- Header (name, title, contact)
- Experience
- Education

**Optional (configurable in `cv.tex`):**
- Technologies/Skills (set `\renewcommand{\cvtechnologies}{}` to hide)
- Certificates (with optional clickable links)
- Open Source Contributions
- Volunteer Work
- Languages
- Awards & Honors

## Cover Letter Sections

- Header (same as CV)
- Company details and date
- Letter title and opening
- Letter body (**company-specific**)
- Closing

**Cover letter body styles (examples in this repo):**
- **Headed sections + horizontal rule**: Google
- **Headed sections (no horizontal rule)**: Meta
- **Plain paragraphs (no section headlines)**: Hyperion
- **Impact bullets (paragraph + 2–3 bullets + paragraphs)**: NASA

**How to customize the body:**
- **Content and layout**: override `\letterbody` directly in `companies/*/cover_letter.tex` - define your letter content inline (no intermediate variables needed)
- **Optional style helpers**: override `\lettersection` in `companies/*/cover_letter.tex` if you want to customize section heading appearance

## Requirements

- LaTeX distribution (TeX Live, MiKTeX, or MacTeX)
- Packages: `xcolor`, `hyperref`, `fontawesome5`, `babel`, `tabularx`, `titlesec`, `fancyhdr`, `enumitem`, `etoolbox`
- Make (optional, for automated builds)

Most packages are included in standard LaTeX distributions.

## Building

### Using Makefile (Recommended)

A `Makefile` is provided for easy building:

```bash
# Build all company CVs and cover letters
make

# Build specific company
make google      # Builds Google CV and cover letter
make hyperion    # Builds Hyperion CV and cover letter
make meta        # Builds Meta CV and cover letter
make nasa        # Builds NASA CV and cover letter

# Build base templates
make templates

# Clean build artifacts (keeps PDFs)
make clean

# Clean everything including PDFs (keeps examples)
make clean-all

# Show help
make help
```

### Manual Building

You can also compile manually using `pdflatex`:

```bash
cd companies/google
pdflatex cv.tex
pdflatex cover_letter.tex
```

Note: LaTeX typically requires two passes to resolve cross-references and generate correct page numbers.

## Architecture

The template uses a modular architecture:

- **`templates/common.sty`**: Shared LaTeX packages, custom commands, and helper macros
  - Helper macros: `\loadfile` (flexible file path resolution), `\ifnotempty` (empty section checking), `\conditionalsection` (conditional section visibility), `\setupcoverletterdate` (date handling)
- **`templates/base_config.tex`**: Default values for all CV and cover letter fields
- **`companies/*/shared.tex`**: Company-specific variables used by both CV and cover letter (e.g., `\cvtitle`)
- **`companies/*/cv.tex`**: CV-specific customizations (technologies, certificates, etc.)
- **`companies/*/cover_letter.tex`**: Cover letter-specific customizations (company details, letter body, etc.)

This architecture reduces code duplication and makes maintenance easier.

## Paper size (A4 vs Letter)

Paper size is configured globally in `document_settings.tex`.

- **Default**: `\papersize` = `a4paper`
- **US/Canada**: set `\papersize` = `letterpaper`

## Customization

- **Colors**: Modify `\textcolor{gray}{}` in templates
- **Sections**: Add, remove, or reorder in template files
- **Layout**: Adjust margins/spacing in template preamble
- **Company-specific**: Customize per company in `cv.tex` and `cover_letter.tex`

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Credits

- Original template by [Sourabh Bajaj](https://github.com/sb2nov/resume)
- Adapted and enhanced with cover letter template
