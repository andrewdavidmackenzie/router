#!/bin/bash
#check lua is installed and warn if not
datasets=("heathrow-london")
for d in ${datasets[*]} 
do
    echo "Running for road system '"$d"'"
    time lua main.lua ../data/$d.in
done
