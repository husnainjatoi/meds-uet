#!/bin/bash

set -euo pipefail

log(){
	echo "[$(date +%H:%M:%S)] $*"
}

if [ $# -lt 1 ]; then
	echo "Directory Path cannot be empty!"
	echo "Usage: ./organizer.sh <dir_path>"
	exit 1
fi

dir_path=$1

if [ -d "$dir_path" ]; then
	cd "$dir_path"

else
 	echo "Error: Directory doesn't exist!"
	exit 1
fi

for file in *; do

case $file in
	*.sv) mkdir -p "verilog/"
	      mv "$file" ./verilog 
	      log "Moved .sv file: $file" ;;
	      
	*.c) mkdir -p "c_code/"
	     mv "$file" ./c_code 
	     log "Moved .c file: $file"  ;;
	
	*.txt) mkdir -p "docs/"
	       mv "$file" ./docs 
	       log "Moved .txt file: $file"  ;;
	  
esac
done

echo "Sorting Completed!"
