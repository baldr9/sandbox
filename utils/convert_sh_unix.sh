#!/bin/zsh

# Find all .sh files recursively and convert them
echo "Searching for .sh files to convert..."

# Use a counter to track files
count=0

# Find all .sh files and process them
while IFS= read -r -d '' file; do
  echo "Converting: $file"
  dos2unix "$file"
  ((count++))
done < <(find . -type f -name "*.sh" -print0)

# Summary
if [[ $count -eq 0 ]]; then
  echo "No .sh files found."
else
  echo "Conversion complete! Processed $count file(s)."
fi
