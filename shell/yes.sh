#!/bin/bash

echo -n "(yes/no)중 입력하시오: "
read YESNO

case $YESNO in
    yes|YES|Yes|y|Y) echo "[ INFO ] YES!" ;;
    no|NO|No|n|N) echo "[ INFO ] No!" ;;
    *) echo "[ FAIL ] 잘못된 입력입니다." ;;
esac