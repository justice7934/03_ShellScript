#!/bin/bash

BASEDIR=/test
mkdir -p $BASEDIR && cd $BASEDIR && rm -rf $BASEDIR/*

for i in {1..5}
do
    # echo $i
    mkdir -p $BASEDIR/$j
    for j in $(seq 1 4)
    do
        mkdir -p $BASEDIR/$i/$j
    done
    
done

tree $BASEDIR