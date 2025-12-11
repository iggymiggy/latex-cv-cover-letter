# Professional CV and Cover Letter LaTeX Templates

A clean, modern LaTeX template for CV and cover letter. ATS-friendly and easy to customize.

## Features

- Professional one-page CV layout
- Matching cover letter template
- **Company-specific customization** - Tailor CV and cover letter for each application
- Centralized personal information (`personal_info.tex`)
- Separate PDFs for each company application
- Bilingual date formatting (configurable)
- ATS-friendly PDF output

## Files

- `templates/` - Base templates
  - `cv_template.tex` - CV template (can be used standalone or copied to company folders)
  - `cover_letter_template.tex` - Cover letter template
  - `base_config.tex` - **Base/default configuration** (default values for CV and cover letter fields)
- `personal_info.tex` - Personal information (edit this)
- `companies/` - Company-specific folders (examples included)
  - `nasa/` - NASA application example (contains `cv.tex`, `cover_letter.tex`, `config.tex`)
  - `google/` - Google application example
  - `meta/` - Meta application example
- `examples/` - Example PDF outputs

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

### For Multiple Companies (Recommended)

**Use existing examples or create new company folders:**

**Option 1: Use existing examples (NASA, Google, Meta already set up)**
1. Edit `personal_info.tex` with your personal information
2. Go to an example folder: `cd companies/nasa` (or `google`, `meta`)
3. Customize `config.tex` with your company-specific details
4. Customize CV and cover letter content in the folder
5. Compile:
   ```bash
   pdflatex cv.tex
   pdflatex cover_letter.tex
   ```
   
   **Note:** LaTeX outputs PDFs with the same name as the input file (`cv.pdf`, `cover_letter.pdf`). To use custom names like `nasa_cv.pdf`, you need to use the `-jobname` flag:
   ```bash
   pdflatex -jobname="nasa_cv" cv.tex
   pdflatex -jobname="nasa_cover_letter" cover_letter.tex
   ```
   However, this requires command-line flags and cannot be done automatically within LaTeX itself.

**Option 2: Create a new company folder**
1. Edit `personal_info.tex` with your personal information
2. Create folder: `mkdir -p companies/your_company`
3. Copy templates: `cp templates/*.tex companies/your_company/`
4. Rename files: `cd companies/your_company && mv cv_template.tex cv.tex && mv cover_letter_template.tex cover_letter.tex`
5. Create company config: `cp companies/nasa/config.tex companies/your_company/config.tex`
6. Customize `config.tex`:
   - **Override only what's different** - use `\renewcommand` to override base defaults
   - If you don't define a field, the base template default will be used
   - Company details (recipient, address)
   - CV customizations (title, technologies, certificates, open source)
   - Cover letter content (sections, opening, closing)
7. Customize CV and cover letter content in the `.tex` files if needed
8. Compile: `pdflatex cv.tex` and `pdflatex cover_letter.tex`

**Option 3: Use base template standalone (generic CV)**
1. Edit `personal_info.tex` with your personal information
2. Compile from `templates/` folder: `pdflatex cv_template.tex`
3. Uses all defaults from `base_config.tex` - no company-specific customization

**Example workflow:**
```bash
# Create new company
mkdir -p companies/my_company
cd companies/my_company
cp ../../templates/*.tex .
mv cv_template.tex cv.tex
mv cover_letter_template.tex cover_letter.tex
cp ../nasa/config.tex config.tex

# Customize files
# Edit cv.tex, cover_letter.tex, config.tex

# Compile (outputs cv.pdf, cover_letter.pdf)
pdflatex cv.tex
pdflatex cover_letter.tex

# To use custom names, use -jobname flag:
# pdflatex -jobname="my_company_cv" cv.tex
```

**Repeat for each company** - each folder in `companies/` produces its own set of PDFs tailored to that company.

**PDF Output Names:**
By default, LaTeX creates PDFs with the same name as the input file:
- `cv.tex` → `cv.pdf`
- `cover_letter.tex` → `cover_letter.pdf`

To use custom names (e.g., `nasa_cv.pdf`), you must use the `-jobname` command-line flag:
```bash
pdflatex -jobname="nasa_cv" cv.tex
```
**Note:** LaTeX cannot automatically set output filenames based on variables - this requires command-line flags and cannot be done purely within LaTeX.

**Using LaTeX Workshop (VS Code/Cursor):**
- Install "LaTeX Workshop" extension
- Open files in your company folder
- Save `.tex` file to auto-compile
- Output will be `cv.pdf` and `cover_letter.pdf` (same as input filenames)

## Structure

**CV Template Sections:**
- Header (name, title, contact info)
- Technologies/Skills
- Experience
- Education
- Certificates

**Cover Letter Template Sections:**
- Header (same as CV)
- Company details and date
- Letter title and opening
- About Me
- Why [Company Name]? (uses company name from company config)
- Why Me?
- Closing

All sections can be modified or removed as needed.

## Configuration

### Personal Information

Edit `personal_info.tex` with your name, contact info, and online presence. This is shared across all CVs and cover letters.

### Base Template and Company Overrides

**Base Configuration (`templates/base_config.tex`):**
- Contains default values for all CV and cover letter fields
- Includes CV defaults: title, technologies, certificates (4), open source (empty)
- Includes cover letter defaults: company details, letter content, date settings
- Can be used standalone to generate a generic CV/cover letter
- If you compile `cv_template.tex` from `templates/` folder, it uses these defaults

**Company-Specific Configuration (`companies/*/config.tex`):**
- Uses `\renewcommand` to override specific fields from `base_config.tex`
- **Only override what's different** - if a field is not defined, the base default is used
- Allows partial customization - you don't need to redefine everything

**Example Workflow:**
1. Base config has 4 default certificates and empty open source section
2. NASA config: Overrides with 7 certificates, keeps open source empty
3. Google config: Overrides with 4 certificates, adds 1 open source project
4. Meta config: Overrides with 1 certificate, adds 2 open source projects
5. New company: Doesn't define certificates → uses base default (4 certs)

Each company configuration file (e.g., `companies/nasa/config.tex`) can contain:

**Company Details:**
- Recipient name/department
- Company name, address, city

**CV Customizations:**
- Technologies/Skills section (emphasize relevant skills for the role)
- Example: For NASA, emphasize space systems, embedded systems, real-time systems
- Example: For Google, emphasize cloud, ML/AI, distributed systems

**Cover Letter Settings:**
- Date language and format (Finnish/English, auto or manual)
- Opening salutation
- Closing salutation
- Letter title/subject
- Attachment line text

**Cover Letter Content:**
- About Me section
- Why [Company Name]? section
- Why Me? section

**Important:** Use `\renewcommand` (not `\newcommand`) to override base defaults:
```latex
% Override base default title
\renewcommand{\cvtitle}{Space Systems Engineer | Flight Software Specialist}

% Override base default technologies
\renewcommand{\cvtechnologies}{%
\textbf{Space Systems:} Satellite Operations, Mission Control \\
\textbf{Cloud:} AWS, Azure \\
% ... customize for the company/role
}

% Override base default certificates (or leave undefined to use base default)
\renewcommand{\cvcertificates}{%
\textbf{Certificate 1} & \textcolor{gray}{\textit{Date}} \\
\textbf{Certificate 2} & \textcolor{gray}{\textit{Date}} \\
}

% Override base default open source (base is empty by default)
\renewcommand{\cvopensource}{%
\resumeSubheading
{Project Name}{\textcolor{gray}{GitHub}}
{Role}{\textcolor{gray}{Date}}
\resumeItemListStart
  \resumeItemSimple{}
    {Description of contribution.}
\resumeItemListEnd
}
```

**Date Formatting:**
```latex
\renewcommand{\letterdatelanguage}{finnish}  % or "english"
\renewcommand{\letterdate}{auto}  % or set manually
```

You can modify the date formatting for other languages by editing the babel configuration in the cover letter template.

## Requirements

- LaTeX distribution (TeX Live, MiKTeX, or MacTeX)
- Required packages: `xcolor`, `hyperref`, `fontawesome5`, `babel`, `tabularx`, `titlesec`, `fancyhdr`, `enumitem`, `etoolbox`

Most packages are included in standard LaTeX distributions. If you get package errors, install them via your distribution's package manager.

## Workflow: Multiple Company Applications

This template is designed for applying to multiple companies. Each company gets its own folder with customized CV and cover letter:

```
project/
├── personal_info.tex          # Shared personal info
├── templates/                 # Base templates
└── companies/                 # Company-specific folders
    ├── nasa/                  # NASA application
    │   ├── cv.tex             # CV customized for NASA
    │   ├── cover_letter.tex
    │   ├── config.tex         # NASA-specific config
    │   ├── cv.pdf             # NASA-specific CV PDF
    │   └── cover_letter.pdf
    ├── google/                # Google application
    │   ├── cv.tex             # CV customized for Google
    │   ├── cover_letter.tex
    │   ├── config.tex         # Google-specific config
    │   └── ...
    └── meta/                  # Meta application
        └── ...
```

**Benefits:**
- Different PDFs for each company
- CV can emphasize different skills/experiences per company
- Cover letter content tailored to each company
- Easy to manage multiple applications
- Version control friendly (each company is separate)

## Customization

- **Colors**: Secondary text (locations, dates) uses gray. Modify `\textcolor{gray}{}` in templates to change.
- **Sections**: Add, remove, or reorder sections by editing the template files.
- **Layout**: Margins and spacing are set in the preamble of each template.
- **Fonts**: Uses standard LaTeX fonts. Custom fonts require additional setup.
- **Company-specific**: Customize CV skills and cover letter content per company in `config.tex`

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Credits

- Original CV template by [Sourabh Bajaj](https://github.com/sb2nov/resume)
- Adapted and enhanced with cover letter template
