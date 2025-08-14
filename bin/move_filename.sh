#!/bin/bash

D_WORK=/test
T_FILE1=/tmp/.tmp1

ls -l $D_WORK | grep '.txt$' > $T_FILE1
for FILE in `cat $T_FILE1`
do
    mv $D_WORK/$FILE `echo $D_WORK/$T_FILE | sed 's/.txt$/.els/g'`
done