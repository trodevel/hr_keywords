#!/bin/bash

INP=../raw_resources/languages.csv
FL=../resources/languages.csv

tail -n +2 $INP | tr "\t" ";" | awk -F";" '{ printf "%s;%s\n", $2, $1; }' | nl -s";" -nln -w1 | grep -vw "as\|or\|is" | awk -F";" '{printf "%s;%s;%s\n", $1, $2, $3; }' > $FL
