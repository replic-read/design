# Create PDF's from the .drawio files and save them in ./content/generated/
find ./content/drawio/ -type f -name "*.drawio" | while IFS= read -r line ; do drawio --export --format pdf --output ./content/generated/pdf/$(basename -- "$line" .drawio).pdf --crop --border 16 $line; done

# Convert all PDF's in ./content/ to PDF-1.5
find ./content/ -type f -name "*.pdf" | while IFS= read -r line ; do gs -q -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 -o $line.converted $line; done
find ./content/ -type f -name "*.pdf" | while IFS= read -r line ; do mv $line.converted $line; done
