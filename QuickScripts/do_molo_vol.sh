for i in $(seq 1 8188); do
echo "/Applications/MoloVol.app/Contents/MacOS/MoloVol -r 1.1 -g 0.1 -fs sqr_pln${i}_cleaned.xyz > ./results/${i}.out" > command_${i}.txt
done
cat command_{1..8188}.txt > work_list
rm -rf command_*.txt
