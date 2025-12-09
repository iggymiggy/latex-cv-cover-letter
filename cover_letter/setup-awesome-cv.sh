#!/bin/bash
# Download Awesome-CV files for cover letter

echo "📥 Downloading Awesome-CV files..."

# Create fonts directory
mkdir -p fonts

# Download class file
curl -s https://raw.githubusercontent.com/posquit0/Awesome-CV/master/awesome-cv.cls -o awesome-cv.cls

# Download fonts
FONTS=(
  FontAwesome.otf
  Roboto-Bold.ttf Roboto-BoldItalic.ttf Roboto-Italic.ttf
  Roboto-Light.ttf Roboto-LightItalic.ttf Roboto-Medium.ttf
  Roboto-MediumItalic.ttf Roboto-Regular.ttf Roboto-Thin.ttf Roboto-ThinItalic.ttf
  SourceSansPro-Bold.otf SourceSansPro-BoldIt.otf SourceSansPro-It.otf
  SourceSansPro-Light.otf SourceSansPro-LightIt.otf SourceSansPro-Regular.otf
  SourceSansPro-Semibold.otf SourceSansPro-SemiboldIt.otf
)

for font in "${FONTS[@]}"; do
  curl -s https://raw.githubusercontent.com/posquit0/Awesome-CV/master/fonts/$font -o fonts/$font
done

# Download example cover letter
curl -s https://raw.githubusercontent.com/posquit0/Awesome-CV/master/examples/coverletter.tex -o coverletter-example.tex

echo "✅ Done! Files structure:"
echo "  awesome-cv.cls"
echo "  fonts/ (19 font files)"
echo "  coverletter-example.tex"