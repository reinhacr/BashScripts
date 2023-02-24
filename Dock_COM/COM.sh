#!/bin/bash
# Bash code to calculate R between average coordinate of cage and average coordinate of TMC, and then translate TMC coordinates to superimpose averaged coordinates and finally create combined file
# calculate averaged coordinate of cage
# I have a much more streamlined version of this code now which cleans up its temporary files and passes in tmc names/etc from arguments passed to code
awk 'NR > 2 {print $1"\t"$2"\t"$3"\t"$4}' just_cage.xyz > just_cage_trimmed
awk '{for(i=1;i<=NF;i++) {sum[i] += $i; sumsq[i] += ($i)^2}}
END {for (i=1;i<=NF;i++) {
 printf "%f \n", sum[i]/NR}
 }' just_cage_trimmed | xargs -n4 > cut
read xcage <<< $( awk '{print $2}' cut )
read ycage <<< $( awk '{print $3}' cut ) 
read zcage <<< $( awk '{print $4}' cut )
echo $xcage
echo $ycage
echo $zcage

# Now for the TMC of interest
awk 'NR > 1 {print $1"\t"$2"\t"$3"\t"$4}' sqr_pln9_cleaned.xyz | sed '$d' > coords
awk '{for(i=1;i<=NF;i++) {sum[i] += $i; sumsq[i] += ($i)^2}}
END {for (i=1;i<=NF;i++) {
 printf "%f \n", sum[i]/NR}
 }' coords | xargs -n4 > molecule
read xcoords <<< $( awk '{print $2}' molecule )
read ycoords <<< $( awk '{print $3}' molecule )
read zcoords <<< $( awk '{print $4}' molecule )
echo $xcoords
echo $ycoords
echo $zcoords

# Use awk to put it together, assign variables with -v, using awk since it can do floating point operations
awk -v xcage="$xcage" -v xcoords="$xcoords" -v ycage="$ycage" -v ycoords="$ycoords" -v zcage="$zcage" -v zcoords="$zcoords" 'NR > 1 {print $1"\t"($2+(xcage-xcoords))"\t"($3+(ycage-ycoords))"\t"($4+(zcage-zcoords))}' coords > new_sqr_pln9.xyz
cat sqr_pln9_cleaned.xyz
cat new_sqr_pln9.xyz
cat just_cage_trimmed new_sqr_pln9.xyz | wc -l
read number_coords <<< $( cat just_cage_trimmed new_sqr_pln9.xyz | wc -l )
echo "$number_coords
combined_file" > header
cat header just_cage_trimmed new_sqr_pln9.xyz > docked_test.xyz 
