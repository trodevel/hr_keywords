#!/bin/bash

INP=$1
OUTP=$2

[[ -z $INP ]]  && echo "ERROR: input file is not given" && exit 1
[[ -z $OUTP ]] && echo "ERROR: output file is not given" && exit 1

grep -i "[a-zа-я]\{2,\}" $INP > st_1.txt
sed -e "s/, /\n/g" -e "s/~/\n/g" -e "s/\.$//" -e "s/\.\s\+\([A-ZА-Я0-9]\)/\n\1/g" -e "s/^\s*//g" -e "s/\s*$//g" st_1.txt > st_2.txt
sed -e "s/  / /g" st_2.txt > st_3.txt
sort st_3.txt > st_4.txt
uniq -i st_4.txt > st_5.txt

cp st_5.txt $OUTP
