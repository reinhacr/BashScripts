#!/bin/bash
# Using bash to read line by line from a list of _ids that have small enough volume, then abstract the index, and then we will write input files and process all these files
# pass list of _ids i.e ./script filename

# Calculate cage COM only once
# Skip first two lines (NR) as that's the header of the xyz file, compute the average. Read these into variables

# My database file looks like so, where i have _id vdw_volume CSD_ID charge metal odd_even_e_count
#5fad73342b6428eefef66bfd 299.061000 ABAJOD 2.0 Ni 0

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

# pass awk the variables and make it do the math
# Don't need to print these but like to see the sanity check for now
#cat coords
#cat temp.xyz
# Get number of lines with wc-l of combined coordinates for xyz file
#read number_coords <<< $( cat just_cage_trimmed temp.xyz | wc -l )
#echo "$number_coords
#combined_file" > header

done < "$filename"
