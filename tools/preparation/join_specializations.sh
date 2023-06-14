#!/bin/bash

join -t";" specializations.rus.uniq.i85.srt.man.en.nl.txt specializations.rus.uniq.i85.srt.man.nl.txt > j_3.csv
join -t";" j_3.csv specializations.rus.uniq.i85.srt.man.nl.ru.txt > j.csv
