#!/bin/bash
datasets=("heathrow-london")
cd src
for d in ${datasets[*]} 
do
    echo "Running for road system '"$d"'"
    timE ./router ../../data/$d.in
done
cd -
