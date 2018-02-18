#!/bin/bash
datasets=("heathrow-london")
for d in ${datasets[*]} 
do
    echo "Running for road system '"$d"'"
    time ./target/debug/router ../data/$d.in
done
