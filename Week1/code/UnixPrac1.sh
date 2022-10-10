wc -l UnixPrac1.sh E.coli.fasta 
#simple wordcount command to count the lines of each files in this practical

tail -78103 E.coli.fasta 
#print command from the bottom but omits the first line

grep -o 'A\|T\|C\|G' E.coli.fasta  | wc -l 
#grep with -o to find all the nucleotides and wc -l to count the words and print the numbers out

grep -o 'ATGC' E.coli.fasta | wc -l 
#grep with -o to find the specific sequence and wc -l to find the number of said sequence found and print the numbers out

export A_COUNT=$(grep -o 'A' E.coli.fasta | wc -l )
export T_COUNT=$(grep -o 'T' E.coli.fasta | wc -l )
export C_COUNT=$(grep -o 'C' E.coli.fasta | wc -l )
export G_COUNT=$(grep -o 'G' E.coli.fasta | wc -l )
export AT_COUNT=$(( $A_COUNT + $T_COUNT))
export CG_COUNT=$(( $C_COUNT + $G_COUNT))
bc -l <<< "scale=2; (($AT_COUNT / $CG_COUNT))"
#ATCG