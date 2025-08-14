#!/bin/bash

echo -n "Enter A : "
read A
echo -n "Operator : "
read Op
echo -n "Enter B : "
read B

echo -n "$A $Op $B = "
case $Op in 
    '+')    expr $A + $B ;;
    '-')    expr $A - $B ;;
    '*'|'x')  expr $A \* $B ;;
    '/')    expr $A / $B ;;
    '%')    expr $A % $B ;;
    *)      echo "[ FAIL ] 문자를 잘못 입력 하였습니다."
            exit 1
esac