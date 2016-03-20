#!/bin/bash
#check lua is installed and warn if not
datasets=("heathrow-london")
for d in ${datasets[*]}
do
    echo "Running for road system '"$d"'"
    time java -cp ./out/production/** net.mackenzie_serres.router.Main ../data/$d.in
done
