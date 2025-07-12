#!/bin/bash

# Check arguments
if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <input-file> <output-file>"
  exit 1
fi
input_file="$1"
output_file="$2"
# Check if input file exists
if [[ ! -f "$input_file" ]]; then
  echo "Error: Input file '$input_file' not found."
  exit 2
fi
# Expand environment variables using envsubst
envsubst < "$input_file" > "$output_file"