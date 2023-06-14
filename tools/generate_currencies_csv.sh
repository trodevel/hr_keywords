#!/bin/bash

# source: https://en.wikipedia.org/wiki/ISO_4217

INP=../raw_resources/currencies.csv
FL=../resources/currencies.csv

awk -F"\t" '{ printf "%s;%s\n", $2, $1; }' $INP | sed "s/= [0]*/= /"> $FL
