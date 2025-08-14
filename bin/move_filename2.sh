#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi
D_WORK=$1
T_FILE=/tmp/.tmp1
EXT1='els'
EXT2='txt'

ls -l $D_WORK | grep '.$EXT1\$' > $T_FILE
for FILE in `cat $T_FILE1`
do  
    mv $D_WORK/$FILE `echo $D_WORK/$FILE | sed "s/.$EXT1\$/.$EXT2/g"`
done
