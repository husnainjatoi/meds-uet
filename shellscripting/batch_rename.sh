#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Error: Invalid number of arguments."
    echo "Usage: $0 <prefix> <suffix> <directory>"
    exit 1
fi

prefix=$1
suffix=$2
dir=$3

if [ -z "$prefix" ]; then
    echo "Error: Prefix cannot be empty!"
    exit 1

elif [ -z "$suffix" ]; then
    echo "Error: Suffix cannot be empty!"
    exit 1

elif [ ! -d "$dir" ]; then
    echo "Error: Invalid directory!"
    exit 1
else
    cd "$dir"
fi


for item in "${prefix}_old_"*.sv; do
    number=$(echo "$item" | cut -d '_' -f3)

    mv "$item" "${suffix}_new_${number}"
    echo "$item renamed to: ${suffix}_new_${number}"
done