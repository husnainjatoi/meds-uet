#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Directory input required!"
	echo "Usage: ./file_stats.sh <dir_path>"
	exit 1
fi

dir=$1

if [ ! -d "$dir" ]; then
    echo "Error: Directory '$dir' does not exist." 
    exit 1
else
	cd "$dir"
fi

file_count=0
dir_count=0
max_size=0
max_file_name=""
latest_time=0
latest_file_name=""

shopt -s nullglob

for item in *; do

if [ -f "$item" ]; then
	((file_count++))
	
	curr_size=$(wc -c < "$item")
	if [ "$curr_size" -gt "$max_size" ]; then
		max_size=$curr_size
		max_file_name="$item"
	fi

	curr_time=$(stat -c %Y "$item")
	if [ "$curr_time" -gt "$latest_time" ]; then
		latest_time=$curr_time
		latest_file_name="$item"
	fi
fi

if [ -d "$item" ]; then
	((dir_count++))
fi

done

readable_time=$(date -d @"$latest_time")

echo "--------Directory Stats--------"
echo "Total files: $file_count"
echo "Total Directories: $dir_count"

if [ $file_count -gt 0 ]; then
	echo "Largest file: $max_file_name ($max_size bytes)"
	echo "Recently modified file: $latest_file_name ($readable_time)"
else 
	echo "Largest File: N/A"
	echo "Recently modified file: N/A"
fi
