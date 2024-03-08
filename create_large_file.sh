#!/bin/bash

# Check if the file size argument is provided
if [ $# -ne 1 ]; then
  echo "Usage: $0 <file_size_in_MB>"
  exit 1
fi

# Parse the file size argument from the command line
file_size_MB=$1

# Calculate the count based on the desired file size in MB
count=$((file_size_MB * 1024))

# Generate the random file
dd if=/dev/urandom of=randomfile bs=1M count=$count
