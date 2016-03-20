#!/bin/bash
datasets=("heathrow-london")
for d in ${datasets[*]} 
do
    echo "Running for road system '"$d"'"
    time ruby router.rb ../data/$d.in
done
