# Call ./drawio_to_pdf.sh for every .drawio file inside content/drawio/
find ./../content/drawio/ -type f -name "*.drawio" | while IFS= read -r line ; do ./drawio_to_pdf.sh $line; done