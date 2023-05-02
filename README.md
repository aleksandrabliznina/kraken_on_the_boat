# Kraken on a BoaT

![pre-logo](https://i.pinimg.com/originals/d3/21/43/d321439e8da4d90cb6372766c5fc7a34.png)

### Retrieving busco data

We would like to fetch all the BTK buscos at some point, but for now, we will just extract a bunch from `/lustre/scratch123/tol/teams/blaxter/users/sk13/minibtk_run/` directory, where are simply compressed.

```
echo -e /lustre/scratch123/tol/teams/blaxter/users/sk13/minibtk_run/*insecta* | tr ' ' '\n' | cut -f 10 -d '/' | cut -f 1,2 -d "_" > list_of_insects_with_busco
```

Which generated a list of 47 insect sample IDs.

### sample IDs to BUSCO sequences

We want a `.fa` file with all the buscos for each species. Have made [fetch_buscos.sh](scripts/fetch_buscos.sh) script for that.

```
for ID in $(cat data/busco_manual/list_of_insects_with_busco); do 
    bash ./scripts/fetch_busco.sh $ID;
done
```

### exploring properties

TODO: load k-mers into python as ID -> set of k-mers
TODO: find intersects of all the possible ID pairs

The point is to grasp some basic ideas about the dataset. How many species specific k-mers are there? How many universal?

