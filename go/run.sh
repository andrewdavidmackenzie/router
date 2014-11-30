#!/bin/bash
#check go is installed and warn if not
datasets=("heathrow-london")
for d in ${datasets[*]} 
do
    echo "Running for road system '"$d"'"
    ./router ../data/$d.in
done