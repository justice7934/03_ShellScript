#!/bin/bash


USERLIST=/root/bin/user.list
# 처음에 비워놓고 시작
> $USERLIST
USERMAX=50
for i in $(seq 1 $USERMAX)
do
    echo "user$i  user$i" >> $USERLIST
done
