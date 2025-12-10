# Professional CV and Cover Letter LaTeX Templates

A clean, modern LaTeX template for CV and cover letter. ATS-friendly and easy to customize.

## Features

- Professional one-page CV layout
- Matching cover letter template
- Centralized configuration (`personal_info.tex`)
- Bilingual date formatting (configurable)
- ATS-friendly PDF output

## Files

- `cv_template.tex` - CV template
- `cover_letter_template.tex` - Cover letter template
- `personal_info.tex` - Personal information (edit this)
- `examples/` - Example PDF outputs
  - [example_cv.pdf](examples/example_cv.pdf) - Example CV output
  - [example_cover_letter.pdf](examples/example_cover_letter.pdf) - Example cover letter output

## Quick Start

1. Edit `personal_info.tex` with your information
2. Replace example content in `cv_template.tex` (experience, education, etc.)
3. Replace example content in `cover_letter_template.tex` (letter sections)
4. Compile with `pdflatex`

**Using LaTeX Workshop (VS Code/Cursor):**
- Install "LaTeX Workshop" extension
- Save `.tex` file to auto-compile

**Command line:**
```bash
pdflatex cv_template.tex
pdflatex cover_letter_template.tex
```

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
- Why [Company Name]? (uses company name from personal_info.tex)
- Why Me?
- Closing

All sections can be modified or removed as needed.

## Configuration

### Date Formatting

Set language in `personal_info.tex`:
```latex
\newcommand{\letterdatelanguage}{finnish}  % or "english"
\newcommand{\letterdate}{auto}  % or set manually
```

You can modify the date formatting for other languages by editing the babel configuration in `cover_letter_template.tex`.

## Requirements

- LaTeX distribution (TeX Live, MiKTeX, or MacTeX)
- Required packages: `xcolor`, `hyperref`, `fontawesome5`, `babel`, `tabularx`, `titlesec`, `fancyhdr`, `enumitem`, `etoolbox`

Most packages are included in standard LaTeX distributions. If you get package errors, install them via your distribution's package manager.

## Customization

- **Colors**: Secondary text (locations, dates) uses gray. Modify `\textcolor{gray}{}` in templates to change.
- **Sections**: Add, remove, or reorder sections by editing the template files.
- **Layout**: Margins and spacing are set in the preamble of each template.
- **Fonts**: Uses standard LaTeX fonts. Custom fonts require additional setup.

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Credits

- Original CV template by [Sourabh Bajaj](https://github.com/sb2nov/resume)
- Adapted and enhanced with cover letter template
