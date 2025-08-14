#!/bin/bash

# HOSTS=/etc/hosts
HOSTS=/root/bin/hosts
/bin/cp /etc/hosts $HOSTS


START=200
END=230
NET=172.16.6

# 등록된 상태를 다시 등록하지 않도록
if grep -q -w linux230 "$HOSTS" ; then
    echo "[ INFO ] 내용이 이미 등록 되어있습니다."
    exit
fi

# 자신의 IP확인
IP=$(ip addr show ens192 | grep 'inet ' | awk '{print $2}' | awk -F/ '{print $1}' | awk -F. '{print $4}')

for i in $(seq $START $END)
do
    # 자신의 IP와 같다면 skip = continue
    [ "$IP"  -eq "$i" ] && continue
    echo "$NET.$i   linux$i.example.com     linux$i" >> $HOSTS

done
