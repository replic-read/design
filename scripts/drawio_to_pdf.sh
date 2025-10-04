output_name="$(basename -- "$1" .drawio).pdf"
output_file="./../content/generated/pdf/$output_name"

# Export the file to pdf
drawio --export --format pdf --output $output_file --crop --border 16 $1

# Convert pdf to new pdf with version 1.5
gs -q -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 -o $output_file.converted $output_file
# Rename new pdf to old name, i.e. replace the old one
mv $output_file.converted $output_file

# Add new pdf to git
git add $output_file