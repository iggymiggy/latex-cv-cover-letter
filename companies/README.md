# Company-Specific Configurations

Each company folder contains:
- `cv.tex` - CV with company-specific customizations (title, technologies, certificates, etc.)
- `cover_letter.tex` - Cover letter with company details and letter content

## Structure

**`cv.tex`** should define:
- **CV Customizations**: `\cvtitle`, `\cvtechnologies`, `\cvcertificates`, `\cvopensource`, `\cvvolunteer`, `\cvlanguages`, `\cvawards`

**`cover_letter.tex`** should define:
- **Company Details**: `\companyrecipient`, `\companyname`, `\companyaddress`, `\companycity`
- **Letter Settings**: `\lettertitle`, `\letteropening`, `\letterclosing`, `\letterdate`, `\letterdatelanguage`, `\letterattachment`
- **Letter Body**: `\letterbody` - define your letter content directly here

## Usage

1. Copy an existing company folder (e.g., `cp -R companies/nasa companies/your_company`)
2. Edit `cv.tex` for CV customizations
3. Edit `cover_letter.tex` for company details and letter content
4. Compile: `pdflatex cv.tex` and `pdflatex cover_letter.tex`

## Examples

See `companies/google/`, `companies/meta/`, `companies/nasa/`, `companies/hyperion/` for different CV and cover letter styles.
