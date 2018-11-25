#!/bin/bash
datasets=("heathrow-london")
cd src
for d in ${datasets[*]} 
do
    echo "Running for road system '"$d"'"
    time ./router ../../data/$d.in
done
