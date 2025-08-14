#!/bin/bash

cat <<EOF
====================================================
  (1). who      (2). date     (3). pwd              
====================================================
EOF
echo -n "번호를 선택하세요 (1-3): "
read NUM
# echo $NUM
echo

case "$NUM" in
    1) who ;;
    2) date ;;
    3) pwd ;;
    *) echo "[ FAIL ] 번호를 잘못 입력 하였습니다."
        exit 1 ;;
esac
echo