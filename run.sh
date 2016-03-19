#!/bin/bash
#languages=("c" "go" "haskell" "java" "lua" "ruby")
languages=("c" "go" "java" "lua" "haskell")
home=`pwd`
for l in ${languages[*]}
do
    echo "--------------- Running for language '"$l"' ----------------------"
    cd $home/$l
    make > /dev/null
    ./run.sh
done

cd $home
