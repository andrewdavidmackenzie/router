#!/bin/bash
datasets=("heathrow-london")
for d in ${datasets[*]}
do
    echo "Running for road system '"$d"'"
    time cabal run < ../data/$d.in | grep -v "haskell"
done
