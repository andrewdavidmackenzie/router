#!/bin/bash
datasets=("heathrow-london")
for d in ${datasets[*]}
do
    echo "Running for road system '"$d"'"
    cabal run < ../data/$d.in | grep -v "Preprocessing executable"
done
