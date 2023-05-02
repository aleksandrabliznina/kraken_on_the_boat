#!/bin/bash

set -e

SAMPLE="$1"
#SAMPLE='GCA_000143395.3'

mkdir "$SAMPLE" && cd "$SAMPLE"

cp /lustre/scratch123/tol/teams/blaxter/users/sk13/minibtk_run/"$SAMPLE"_* . 

for file in *.tar.gz; do
    tar -xzf $file
    for busco_seq in fragmented_busco_sequences.tar.gz multi_copy_busco_sequences.tar.gz single_copy_busco_sequences.tar.gz; do
       tar -xzf $(basename $file .busco.tar.gz)/busco/$SAMPLE_*/$SAMPLE_*.fna/run_*_odb10/busco_sequences/$busco_seq
    done
    cat *_busco_sequences/*.fna >> "$SAMPLE"_all_busco.fa

    rm -r fragmented_busco_sequences multi_copy_busco_sequences single_copy_busco_sequences
    rm $file
    rm -r $(basename $file .busco.tar.gz)
done

cd ..