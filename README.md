# Professional CV and Cover Letter LaTeX Templates

A clean, modern LaTeX template for CV and cover letter. ATS-friendly and easy to customize.

## Features

- Professional one-page CV layout
- Matching cover letter template
- **Company-specific customization** - Tailor CV and cover letter for each application
- Centralized personal information
- Optional sections: Certificates, Open Source, Volunteer Work, Languages, Awards
- Optional certificate links (Credly badges)
- Bilingual date formatting (configurable)

## Examples

Each company folder generates customized PDFs with company-specific CV skills and cover letter content.

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

**Option A: Use an existing example (NASA, Google, Meta)**
```bash
cd companies/nasa  # or google, meta
# Edit config.tex (company-specific fields) and personal_info.tex (your personal details)
pdflatex cv.tex
pdflatex cover_letter.tex
```

**Option B: Create a new company folder (recommended: copy an existing one)**
```bash
cp -R companies/nasa companies/your_company  # or copy google/meta
cd companies/your_company
# Edit config.tex (company-specific fields) and personal_info.tex (your personal details)
pdflatex cv.tex
pdflatex cover_letter.tex
```

**Option C: Compile the base CV (generic)**
```bash
cd templates
pdflatex cv_template.tex  # Builds templates/cv_template.pdf using defaults from base_config.tex
```

**Optional: custom output filenames**

By default, LaTeX names the PDF after the input file (`cv.tex` → `cv.pdf`). If you want `google_cv.pdf` etc., use `-jobname`:

```bash
pdflatex -jobname="google_cv" cv.tex
pdflatex -jobname="google_cover_letter" cover_letter.tex
```

## Project Structure

```
project/
├── personal_info.tex          # Shared personal info
├── templates/                 # Base templates
│   ├── cv_template.tex
│   ├── cover_letter_template.tex
│   └── base_config.tex       # Default values
└── companies/                 # Company-specific folders
    ├── google/
    │   ├── cv.tex
    │   ├── cover_letter.tex
    │   └── config.tex        # Overrides base defaults
    ├── hyperion/
    ├── meta/
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

### Company Configuration (`companies/*/config.tex`)

Override only what's different using `\renewcommand`:

```latex
% Company details
\renewcommand{\companyname}{NASA}
\renewcommand{\companyaddress}{300 E Street SW}

% CV customizations
\renewcommand{\cvtitle}{Space Systems Engineer | Flight Software Specialist}
\renewcommand{\cvtechnologies}{%
  \section{Skills}
  \resumeSubHeadingListStart
    \item{\textbf{Technical Skills}{:} Space Systems, Satellite Operations...}
  \resumeSubHeadingListEnd
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

**Key points:**
- Use `\renewcommand` (not `\newcommand`) to override base defaults
- Only define fields that differ from base - undefined fields use base defaults
- Optional sections are hidden if empty

## CV Sections

**Required:**
- Header (name, title, contact)
- Experience
- Education

**Optional (configurable in `config.tex`):**
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
- About Me
- Why [Company Name]?
- Why Me?
- Closing

## Requirements

- LaTeX distribution (TeX Live, MiKTeX, or MacTeX)
- Packages: `xcolor`, `hyperref`, `fontawesome5`, `babel`, `tabularx`, `titlesec`, `fancyhdr`, `enumitem`, `etoolbox`

Most packages are included in standard LaTeX distributions.

## Customization

- **Colors**: Modify `\textcolor{gray}{}` in templates
- **Sections**: Add, remove, or reorder in template files
- **Layout**: Adjust margins/spacing in template preamble
- **Company-specific**: Customize per company in `config.tex`

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Credits

- Original CV template by [Sourabh Bajaj](https://github.com/sb2nov/resume)
- Adapted and enhanced with cover letter template
