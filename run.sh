#!/bin/bash
#languages=("c" "go" "haskell" "java" "lua" "ruby")
languages=("c" "java" "lua")
home=`pwd`
for l in ${languages[*]}
do
    echo "--------------- Running for language '"$l"' ----------------------"
    cd $home/$l
    make
    ./run.sh
done

cd $home
