#!/bin/bash
# Using bash to read line by line from a list of _ids that have small enough volume and contain Au for the metal, then abstract the index, and then we will write input files and process all these files
# pass list of _ids i.e ./script filename

# Get information for output files, including name of XYZ file to write
filename="$1"
while read -r line; do
    id="$line"
    echo $id > id.txt
    echo "ID read from file - $id"   
    file_index=$(grep  --include=\*.xyz -Ril "${id}") 
    NUMBER=$(echo "$file_index" | tr -dc '0-9') ; echo $NUMBER
    csd_name=$(awk "/$id/"'{print $3}' just_small_sqr_planar)
    echo $csd_name > csd_name.txt 
    # Now write the combined xyz file     
    awk 'NR > 1 {print $1"\t"$2"\t"$3"\t"$4}' sqr_pln${NUMBER}_cleaned.xyz | sed '$d' > coords
    read number_coords <<< $( cat coords | wc -l )
    echo $number_coords > number_coords.txt
    echo $csd_name
    cat number_coords.txt id.txt coords > ./xyz_files_for_melissa/${csd_name}.xyz
done < "$filename"
