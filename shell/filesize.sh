#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 2
fi
FILE=$1

FILESIZE=$(wc -c < $FILE)
# echo "$FILE - $FILESIZE"

if [ $FILESIZE -gt 5120 ]; then
    echo "$FILE($FILESIZE)가 5120 byte보다 큰 파일 입니다."
elif [ $FILESIZE -le 5120 ]; then
    echo "$FILE($FILESIZE)가 5120 byte보다 작은 파일 입니다."
else
    echo "[ FAIL ] $FILE($FILESIZE) 사이즈가 잘못되었습니다."
fi
