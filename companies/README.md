# Company-Specific Cover Letter Configurations

Each file in this folder contains company-specific information and letter content for a cover letter.

## Structure

Each company file should define:

- **Company Details**: `\companyrecipient`, `\companyname`, `\companyaddress`, `\companycity`
- **Letter Title**: `\lettertitle`
- **Letter Content**: `\letteraboutme`, `\letterwhycompany`, `\letterwhyme`

## Usage

1. Create a new file for each company (e.g., `google.tex`, `microsoft.tex`)
2. Copy `nasa.tex` as a template
3. Edit the company details and letter content
4. In `cover_letter_template.tex`, change the `\input{companies/nasa}` line to your company file
5. Compile the cover letter

## Example

See `nasa.tex` for a complete example.

