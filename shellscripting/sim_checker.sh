#!/bin/bash

if [ $# -lt 1 ]; then
    echo "ERROR: file name required!"
    echo "Usage: ./sim_checker <file_name>"
    exit 1

elif [ ! -f $1 ]; then
    echo "ERROR: please enter a valid file name!"
    echo "Usage: ./sim_checker <file_name>"
    exit 1

else 
    file=$1
fi

error_count=$(grep -ic "error" $file)
echo "Number of errors found: $error_count"

warning_count=$(grep -ic "warning" $file)
echo "Number of warnings found: $warning_count"

pass_count=$(grep -ic "pass" $file)
echo "Number of passed tests found: $pass_count"

if [ $error_count -gt 0 ]; then
    echo "Simulation failed with errors."
    exit 1
elif [ $warning_count -gt 0 ]; then
    echo "Simulation completed with warnings."
else
    echo "Simulation completed successfully with no errors or warnings."
fi