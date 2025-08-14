#!/bin/bash

START=200
END=230
NET=172.16.6
BACKUP="position.txt.bak"

cp -f position.txt "$BACKUP"
for i in $(seq $START $END)
do
    # echo "$NE.$i"
    ping -c 1 -W 0.5 $NET.$i >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "[  OK  ] $NET.$i"
        sed -i "s/$i/OOO/" position.txt
    else
        echo "[ FAIL ] $NET.$i"
        sed -i "s/$i/XXX/" position.txt
    fi
done

echo "=== 핑 테스트 완료! 자리 배치도 확인 ==="
cat position.txt

# 원본 복구
mv -f "$BACKUP" position.txt
cat position.txt
