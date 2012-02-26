#!/bin/sh

for file in *.sh
do
    if [ $file != "$0" ]
    then
        ln -fs ${PWD}/${file} ~/bin
        chmod +x ~/bin/${file}
    fi
done
