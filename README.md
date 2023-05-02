# Kraken on a BoaT

![pre-logo](https://i.pinimg.com/originals/d3/21/43/d321439e8da4d90cb6372766c5fc7a34.png)

### Retrieving busco data

We would like to fetch all the BTK buscos at some point, but for now, we will just extract a bunch from `/lustre/scratch123/tol/teams/blaxter/users/sk13/minibtk_run/` directory, where are simply compressed.

```
echo -e /lustre/scratch123/tol/teams/blaxter/users/sk13/minibtk_run/*insecta* | tr ' ' '\n' | cut -f 10 -d '/' | cut -f 1,2 -d "_" > list_of_insects_with_busco
```

Which generated a list of 47 insect sample IDs.

### sample IDs to BUSCO sequences

We want a `.fa` file with all the buscos for each species

```
#!/bin/bash

set -e

SAMPLE="$1"
#SAMPLE='GCA_000143395.3'

mkdir "$SAMPLE" && cd "$SAMPLE"

cp /lustre/scratch123/tol/teams/blaxter/users/sk13/minibtk_run/"$SAMPLE"_* . 

for file in *.tar.gz; do
    # tar -xzf $file
    for busco_seq in fragmented_busco_sequences.tar.gz multi_copy_busco_sequences.tar.gz single_copy_busco_sequences.tar.gz; do
       tar -xzf $(basename $file .busco.tar.gz)/busco/$SAMPLE_*/$SAMPLE_*.fna/run_*_odb10/busco_sequences/$busco_seq
    done
    cat *_busco_sequences/*.fna >> "$SAMPLE"_all_busco.fa

    rm -r fragmented_busco_sequences multi_copy_busco_sequences single_copy_busco_sequences
    rm $file
    rm -r $(basename $file .busco.tar.gz)
done

cd ..
```

