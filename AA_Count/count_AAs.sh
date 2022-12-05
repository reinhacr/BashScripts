#/bin/bash
# originally generated individual fasta files from one long combined file with csplit. 
# csplit combined_all_plus_new_hhh_only_uniq.txt '/^>/' "{1000}" --suffix-format="%d.fasta"
# Get information for output files, including name of XYZ file to write
filename="$1"
while read -r line; do
    file="$line"
    echo "Processing - $file"  
# read file
    rm -rf ${file}.txt
    cp $file ${file}.orig
    head -n1 ${file} > ${file}_header
    cut -c 2-5 ${file}_header > pdb_code
    pdb_name=$(cut -c 2-5 ${file}_header)
    echo $pdb_name
    cat pdb_code 
    sed '1d' ${file} > ${file}_without_first_line
    cat ${file}_without_first_line
# put all the amino acid counts into file
    fgrep -o A ${file}_without_first_line | wc -l >> ${file}.txt
    fgrep -o C ${file}_without_first_line | wc -l >> ${file}.txt
    fgrep -o D ${file}_without_first_line | wc -l >> ${file}.txt
    fgrep -o E ${file}_without_first_line | wc -l >> ${file}.txt
    fgrep -o F ${file}_without_first_line | wc -l >> ${file}.txt
    fgrep -o G ${file}_without_first_line | wc -l >> ${file}.txt
    fgrep -o H ${file}_without_first_line | wc -l >> ${file}.txt
    fgrep -o I ${file}_without_first_line | wc -l >> ${file}.txt
    fgrep -o K ${file}_without_first_line | wc -l >> ${file}.txt
    fgrep -o L ${file}_without_first_line | wc -l >> ${file}.txt
    fgrep -o M ${file}_without_first_line | wc -l >> ${file}.txt
    fgrep -o N ${file}_without_first_line | wc -l >> ${file}.txt
    fgrep -o P ${file}_without_first_line | wc -l >> ${file}.txt
    fgrep -o Q ${file}_without_first_line | wc -l >> ${file}.txt
    fgrep -o R ${file}_without_first_line | wc -l >> ${file}.txt
    fgrep -o S ${file}_without_first_line | wc -l >> ${file}.txt
    fgrep -o T ${file}_without_first_line | wc -l >> ${file}.txt
    fgrep -o V ${file}_without_first_line | wc -l >> ${file}.txt
    fgrep -o W ${file}_without_first_line | wc -l >> ${file}.txt
    fgrep -o Y ${file}_without_first_line | wc -l >> ${file}.txt
# same thing but store as variable- probably easy way to combine this with first block of code
    y_count=$(fgrep -o Y ${file}_without_first_line | wc -l)
    w_count=$(fgrep -o W ${file}_without_first_line | wc -l)
    f_count=$(fgrep -o F ${file}_without_first_line | wc -l)
    a_count=$(fgrep -o A ${file}_without_first_line | wc -l)
    l_count=$(fgrep -o L ${file}_without_first_line | wc -l)
    i_count=$(fgrep -o I ${file}_without_first_line | wc -l)
    m_count=$(fgrep -o M ${file}_without_first_line | wc -l)
    v_count=$(fgrep -o V ${file}_without_first_line | wc -l)
    p_count=$(fgrep -o P ${file}_without_first_line | wc -l)
    g_count=$(fgrep -o G ${file}_without_first_line | wc -l)
    n_count=$(fgrep -o N ${file}_without_first_line | wc -l)
    q_count=$(fgrep -o Q ${file}_without_first_line | wc -l)
    s_count=$(fgrep -o S ${file}_without_first_line | wc -l)
    t_count=$(fgrep -o T ${file}_without_first_line | wc -l)
    c_count=$(fgrep -o C ${file}_without_first_line | wc -l)
    h_count=$(fgrep -o H ${file}_without_first_line | wc -l)
# Do estimated charge and all other metrics. 
    d_count=$(fgrep -o D ${file}_without_first_line | wc -l)
    e_count=$(fgrep -o E ${file}_without_first_line | wc -l)
    r_count=$(fgrep -o R ${file}_without_first_line | wc -l)
    k_count=$(fgrep -o K ${file}_without_first_line | wc -l)
    echo "d,$d_count,e,$e_count,r,$r_count,k,$k_count"
    charge=$(( $r_count + $k_count - $e_count - $d_count))
    number_charged=$(( $r_count + $k_count + $e_count + $d_count))
    echo $charge > charge_${file}
    echo "your total charge is $charge"
    hydrophobic=$(( $v_count + $p_count + $g_count + $m_count + $i_count + $l_count + $a_count))
    polar_uncharged=$(( $c_count + $t_count + $s_count + $q_count + $n_count))
    aromatics=$(( $y_count + $w_count + $f_count))
    total_AA=$(wc -m  ${file}_without_first_line | awk '{print $1}')
    wc -m  ${file}_without_first_line | awk '{print $1}' > total_AA_${file}
    echo "$aromatics,$total_AA"
    echo $(bc <<<"scale=4 ; $aromatics / $total_AA") > percent_aromatics
    echo $(bc <<<"scale=4 ; $hydrophobic / $total_AA") > percent_hydrophobic
    echo $(bc <<<"scale=4 ; $number_charged / $total_AA") > percent_charged
    echo $(bc <<<"scale=4 ; $polar_uncharged / $total_AA") > percent_polar_noncharged
    echo $(bc <<<"scale=4 ; $y_count / $total_AA") > fraction_Y
    echo $(bc <<<"scale=4 ; $w_count / $total_AA") > fraction_W
    echo $(bc <<<"scale=4 ; $f_count / $total_AA") > fraction_F
    echo $(bc <<<"scale=4 ; $d_count / $total_AA") > fraction_D
    echo $(bc <<<"scale=4 ; $e_count / $total_AA") > fraction_E
    echo $(bc <<<"scale=4 ; $r_count / $total_AA") > fraction_R
    echo $(bc <<<"scale=4 ; $k_count / $total_AA") > fraction_K
    echo $(bc <<<"scale=4 ; $i_count / $total_AA") > fraction_I
    echo $(bc <<<"scale=4 ; $a_count / $total_AA") > fraction_A
    echo $(bc <<<"scale=4 ; $c_count / $total_AA") > fraction_C
    echo $(bc <<<"scale=4 ; $g_count / $total_AA") > fraction_G
    echo $(bc <<<"scale=4 ; $h_count / $total_AA") > fraction_H
    echo $(bc <<<"scale=4 ; $n_count / $total_AA") > fraction_N
    echo $(bc <<<"scale=4 ; $p_count / $total_AA") > fraction_P
    echo $(bc <<<"scale=4 ; $q_count / $total_AA") > fraction_Q
    echo $(bc <<<"scale=4 ; $s_count / $total_AA") > fraction_S
    echo $(bc <<<"scale=4 ; $t_count / $total_AA") > fraction_T    
    echo $(bc <<<"scale=4 ; $m_count / $total_AA") > fraction_M
    echo $(bc <<<"scale=4 ; $l_count / $total_AA") > fraction_L
    echo $(bc <<<"scale=4 ; $v_count / $total_AA") > fraction_V
    cat percent_aromatics
# calculate total AAs
    paste AA_master_list.txt ${file}.txt > AA_breakdown_${file}
    paste pdb_code fraction_Y fraction_W fraction_F > aromatic_metrics_${pdb_name}
    paste pdb_code fraction_E fraction_D fraction_R fraction_K > charged_metrics_${pdb_name}
    paste pdb_code fraction_I fraction_A fraction_L fraction_V > aliphatic_metrics_${pdb_name}
    paste pdb_code total_AA_${file} charge_${file} percent_aromatics percent_charged percent_hydrophobic percent_polar_noncharged > ${pdb_name}_metrics 
    paste pdb_code total_AA_${file} charge_${file} fraction_A fraction_C fraction_D fraction_E fraction_F fraction_G fraction_H fraction_I fraction_K fraction_L fraction_M fraction_N fraction_P fraction_Q fraction_R fraction_S fraction_T fraction_V fraction_W fraction_Y > ${pdb_name}_all_metrics
    cat ${file}_header total_AA_${file} charge_${file} percent_aromatics AA_breakdown_${file} > ${file}_master
done < "$filename"
rm -rf *_without_first_line
rm -rf *_header
rm -rf AA_breakdown_*
rm -rf total_AAs_*
rm -rf charge_*
rm -rf total_AA_*
