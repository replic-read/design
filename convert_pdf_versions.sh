# Bash script that goes recursively over all pdf-files in ./content and converts them to PDF-Version 1.5
find ./content/ -type f -name "*.pdf" | while IFS= read -r line ; do gs -q -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 -o $line.converted $line; done

find ./content/ -type f -name "*.pdf" | while IFS= read -r line ; do mv $line.converted $line; done