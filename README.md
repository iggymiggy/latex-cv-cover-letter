# Professional CV / Resume & Cover Letter LaTeX Templates

[![CI](https://github.com/iggymiggy/latex-cv-cover-letter/actions/workflows/ci.yml/badge.svg)](https://github.com/iggymiggy/latex-cv-cover-letter/actions/workflows/ci.yml)
[![Version](https://img.shields.io/badge/version-1.1.0-blue.svg)](templates/common.sty)

A minimal LaTeX starter kit for building **one‑page CVs and matching cover letters**, plus a few **example company layouts** you can copy and adapt.

> **TL;DR**
>
> - Clone this repo.
> - Copy `personal_info.example.tex` → `personal_info.tex` and fill in your details.
> - Copy one of the example folders under `companies/` (e.g. `google/` → `my-company/`) and customize `shared.tex`, `cv.tex`, and `cover_letter.tex`.
> - Build with Docker (`docker-compose run latex make my-company`) or with local TeX (`make my-company`).
> - You’ll get a 1‑page CV and matching cover letter in `companies/my-company/`.

This repo is **small and focused**:

- Single‑page CV layout + matching cover letter.
- All personal data lives in `personal_info.tex` / `templates/base_config.tex`.
- Each `companies/<name>/` folder is an **example layout** you can copy and adapt.
- The idea is to **customize per company**, not send one generic CV everywhere.

---

## Table of contents

- [Overview](#overview)
- [Quick start](#quick-start)
- [Customizing per company](#customizing-per-company)
- [Build & tools](#build--tools)
- [Project layout](#project-layout)
- [Validation & quality checks](#validation--quality-checks)
- [FAQ](#faq)
- [License](#license)

## Overview

- **One‑page CV layout** with a matching **cover letter**.
- **ATS‑friendly**: clean structure, simple typography.
- **Company‑specific variants** via `companies/<name>/` folders.
- **Shared templates** in `templates/` so you don’t repeat yourself.

---

## Quick start

### 1. Add your personal info

```bash
# From the repo root
cp personal_info.example.tex personal_info.tex
```

Edit `personal_info.tex` and fill in:

- **Email** (required)
- (Optional) Name
- (Optional) Phone
- (Optional) Location (city, state/country - e.g., "San Francisco, CA" or "Helsinki, Finland")
- (Optional) LinkedIn / GitHub / Portfolio / Twitter / Website URLs

**Contact info layout:** The header displays contact information in a configurable 2-line format with FontAwesome icons:
- **Line 1:** Social links (LinkedIn, GitHub, Portfolio, Twitter, Website) - only shown if provided and included in `\headerorder`
- **Line 2:** Contact info (Email, Phone, Location) - only shown if provided and included in `\headerorder`

**Customizing header fields:** You can control which fields appear and in what order by overriding `\headerorder` in your company-specific `cv.tex` or `cover_letter.tex`:

```latex
% Show only LinkedIn, GitHub, Email, Phone
\renewcommand{\headerorder}{linkedin,github,email,phone}

% Show all fields
\renewcommand{\headerorder}{linkedin,github,portfolio,twitter,website,email,phone,location}
```

Available fields: `linkedin`, `github`, `portfolio`, `twitter`, `website`, `email`, `phone`, `location`

`personal_info.tex` is **ignored by git** (see `.gitignore`), so your private data will not be committed.

### 2. Create a company‑specific CV & cover letter

1. Pick an example folder and copy it:

   ```bash
   cp -r companies/microsoft companies/my-company
   ```

2. In `companies/my-company/`, edit:
   - `shared.tex` – your title and brand colors.
   - `cv.tex` – your 1‑page CV for this company.
   - `cover_letter.tex` – a focused, company‑specific letter.

3. Build your documents.

   **Option A – Docker (recommended, no local TeX install):**

   ```bash
   # From repo root, first time:
   docker-compose build

   # Build CV + cover letter for one company:
   docker-compose run latex make my-company
   ```

   **Option B – local TeX + make:**

```bash
   # From repo root
   make my-company      # or: make   # build all companies
   ```

4. Find the outputs in:

```text
companies/my-company/
  my-company_cv.pdf
  my-company_cover_letter.pdf
```

---

## Customizing per company

Every company lives in its own folder under `companies/`:

```text
companies/
  google/
    shared.tex
    cv.tex
    cover_letter.tex
  hyperion/
  meta/
  nasa/
  microsoft/
  my-company/
```

For each `companies/<name>/` folder:

- **`shared.tex`** – shared config (title, colors, links, etc.).
- **`cv.tex`** – your 1‑page CV for this company.
  - Define sections by overriding commands such as:

    ```latex
    \renewcommand{\cvtechnologies}{ ... }
    \renewcommand{\cvexperience}{ ... }
    \renewcommand{\cveducation}{ ... }
    \renewcommand{\cvcertificates}{ ... }
    \renewcommand{\cvopensource}{ ... }
    \renewcommand{\cvvolunteer}{ ... }
    \renewcommand{\cvlanguages}{ ... }
    \renewcommand{\cvawards}{ ... }
    ```

  - Control section order with:

    ```latex
    \renewcommand{\cvsectionorder}{%
      technologies,experience,education,certificates,opensource,volunteer,languages,awards
    }
    ```

- **`cover_letter.tex`** – company‑specific letter:
  - Set `\companyname`, `\companyaddress`, `\companycity`.
  - Set `\lettertitle`, `\letteropening`, `\letterclosing`, and `\letterbody`.
  - Use `\lettersection{...}` for structured sections (see `companies/google/`).

> **Idea:** keep your core profile in one place, then adjust only the company‑specific parts per folder. That way you can quickly generate tailored CV + cover letters for each application.

---

## Build & tools

You can build with:

- **Docker (recommended)** – uses the included TeX image, no local TeX install.
- **Local TeX + make** – if you already have TeX Live / MiKTeX and `make`.

From the repo root:

```bash
# Build all company CVs & cover letters (in parallel)
make

# Build a single company
make my-company

# Build just the base templates
make templates

# Run checks
make validate   # compile all CVs/CLs and run validation
make lint       # run LaTeX linters
make clean      # remove build artifacts
```

To use Docker:

```bash
# One-time: build the image (downloads TeX Live, etc.)
docker-compose build

# Then run make inside the container
docker-compose run latex make
```

---

## Project layout

```text
.
├── personal_info.example.tex   # Template for your details (tracked)
├── personal_info.tex           # Your details (git‑ignored)
├── document_settings.tex       # Global page setup (paper size, margins)
├── templates/
│   ├── cv_template.tex         # Base CV layout
│   ├── cover_letter_template.tex
│   ├── base_config.tex         # Default content + section hooks
│   └── common.sty              # Shared packages, colors, macros
└── companies/
    ├── google/                 # Example company (copy & tweak)
    ├── hyperion/
    ├── meta/
    ├── nasa/
    ├── microsoft/
    └── my-company/             # Your custom folder

---

## Visual examples

The repo includes pre-built example PDFs and PNG previews under `examples/companies/`:

- **Google**
  - CV: `examples/companies/google_cv.png`
  - Cover letter: `examples/companies/google_cover_letter.png`
- **Hyperion**
  - CV: `examples/companies/hyperion_cv.png`
  - Cover letter: `examples/companies/hyperion_cover_letter.png`
- **Meta**
  - CV: `examples/companies/meta_cv.png`
  - Cover letter: `examples/companies/meta_cover_letter.png`
- **Microsoft**
  - CV: `examples/companies/microsoft_cv.png`
  - Cover letter: `examples/companies/microsoft_cover_letter.png`
- **NASA**
  - CV: `examples/companies/nasa_cv.png`
  - Cover letter: `examples/companies/nasa_cover_letter.png`

You can open these images directly in GitHub or your file browser to quickly see how each layout looks before copying a company folder.
```

---

## Validation & quality checks

- `make validate` – compiles all CVs/CLs and runs built‑in config checks:
  - ensures required fields (`\myemail` is the only required field) are set,
  - warns on obvious placeholder values (e.g. `example@example.com`),
  - all other fields (name, phone, location, LinkedIn, GitHub, portfolio) are optional,
  - hides optional sections cleanly when left empty.

- `make lint` – runs LaTeX linters via `scripts/lint.sh` to catch common issues.

GitHub Actions (`.github/workflows/ci.yml`) uses the same Docker image, and on every push/PR it:

- builds all company CVs and cover letters,
- runs `make validate` and `make lint`.

---

## FAQ

**Do I have to use Docker?**  
No. Docker is recommended for convenience, but you can also install TeX locally and run `make` directly.

**Why one CV per company?**  
The template is designed around focused, 1‑page CVs, tailored per application. You can add more pages if you really need them, but shorter is usually better.

**How do I change colors or fonts?**  
Edit `companies/<name>/shared.tex` to set `\cvthemeprimary`, `\cvthemesection`, `\cvthemelink`, etc. Global page setup and fonts are configured in `document_settings.tex`.

**Can I customize which contact fields appear in the header?**  
Yes. Override `\headerorder` in your company `cv.tex` or `cover_letter.tex` to control which fields appear and in what order:

```latex
% Show only LinkedIn, GitHub, Email, Phone
\renewcommand{\headerorder}{linkedin,github,email,phone}

% Show all fields
\renewcommand{\headerorder}{linkedin,github,portfolio,twitter,website,email,phone,location}
```

Available fields: `linkedin`, `github`, `portfolio`, `twitter`, `website`, `email`, `phone`, `location`. Fields are automatically placed on line 1 (social) or line 2 (contact) based on their type.

**Can I localize section titles (Skills, Education, etc.)?**  
Yes. Override the title macros in your company files, for example:

```latex
\renewcommand{\cvsectiontitleexperience}{Työkokemus}
\renewcommand{\cvsectiontitleeducation}{Koulutus}
\renewcommand{\cvsectiontitlelanguages}{Kielitaito}
```

These affect the CV section headers; the cover letter date language is controlled separately via `\letterdatelanguage` in `templates/base_config.tex`.

---

## License

MIT – see [`LICENSE`](LICENSE).


