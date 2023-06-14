#!/bin/bash

INP=../raw_resources/languages.csv
FLA=../resources/languages_all.csv
FL_C=../resources/language_codes.csv
FL=../resources/languages.en.csv

tail -n +2 $INP | tr "\t" ";" | awk -F";" '{ printf "%s;%s\n", $2, $1; }' | nl -s";" -nln -w1 | grep -vw "as\|or\|is" | awk -F";" '{printf "%s;%s;%s\n", $1, $2, $3; }' > $FLA
awk -F";" '{printf "%s;%s\n", $1, $2; }' $FLA > $FL_C
awk -F";" '{printf "%s;%s\n", $1, $3; }' $FLA > $FL
