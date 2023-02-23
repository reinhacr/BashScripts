#!/bin/bash
# shell script as a wrapper for using find_geo on every metal center of interest, and then extracting the information. 
# First we need to read the PDB. Checked that downloading the PDB from online should work
# Follow the below syntax
filename="$1"
while read -r line; do
    id="$line"
    echo "ID read from file - $id"
    mkdir $id
    cd ./$id
    python ../findgeo.py -o -t 2.6 -c $id
    echo "$id metal center done"
    cd ../
done < "$filename"
