#!/bin/bash

remove_dup()
{
    local inp=$1
    local outp=$2
    awk -F";" '{ printf "%s;%s;", $1, $2; orig=tolower( $2 ); for( i=3; i<NF; ++i ) { if ( tolower( $i ) != orig ) { printf "%s;", $i; } }; printf "\n"; }' $inp > $outp
}

FL=j.man

awk -F";" '{printf "%s;%s;%s;%s\n", $2, $1, $3, $4 }' $FL.csv > $FL.1.csv
sort -f $FL.1.csv > $FL.1.srt.csv
# DEBUG: with number of synonyms
#awk -F";" 'BEGIN { prev_kw=""; delete arr[0]; } { kw=tolower($1); if (tolower( prev_kw ) == tolower( kw ) ) { if( 0 ) { print "EXISTING", $3 }; arr[length(arr)] = $3; } else { if( 0 ) { print "NEW", length( prev_kw ); } if( length( prev_kw ) ) { printf "%s;%d;", prev_kw, length( arr ); for( i = 0; i < length( arr ); ++i ) { printf "%s;", arr[i]; } printf "\n"; } prev_kw=$1; delete arr; arr[0] = $3;} }' $FL.1.srt.csv > $FL.1.srt.flat.csv # DEBUG
awk -F";" 'BEGIN { prev_kw=""; delete arr[0]; } { kw=tolower($1); if (tolower( prev_kw ) == tolower( kw ) ) { if( 0 ) { print "EXISTING", $3 }; arr[length(arr)] = $3; arr[length(arr)] = $4; } else { if( 0 ) { print "NEW", length( prev_kw ); } if( length( prev_kw ) ) { printf "%s;", prev_kw; for( i = 0; i < length( arr ); ++i ) { printf "%s;", arr[i]; } printf "\n"; } prev_kw=$1; delete arr; arr[0] = $3; arr[1] = $4; } }' $FL.1.srt.csv > $FL.1.srt.flat.csv
# enumerate
nl -s";" -nln -w1 $FL.1.srt.flat.csv > $FL.1.srt.flat.nl.csv
# ru
awk -F";" '{ printf "%s;", $1; for( i=3; i<NF; ++i ) { if ( $i ~ ".*[а-яА-Я]+.*" ) { printf "%s;", $i; } }; printf "\n"; }' $FL.1.srt.flat.nl.csv > $FL.1.srt.flat.nl.ru.csv
# en
awk -F";" '{ printf "%s;%s;", $1, $2; for( i=3; i<NF; ++i ) { if ( $i ~ ".*[а-яА-Я]+.*" ) {} else { printf "%s;", $i; } }; printf "\n"; }' $FL.1.srt.flat.nl.csv > $FL.1.srt.flat.nl.en.csv
# remove dup
remove_dup $FL.1.srt.flat.nl.en.csv $FL.1.srt.flat.nl.en.nodup.csv
remove_dup $FL.1.srt.flat.nl.ru.csv $FL.1.srt.flat.nl.ru.nodup.csv

cp $FL.1.srt.flat.nl.en.nodup.csv specializations.en.csv
cp $FL.1.srt.flat.nl.ru.nodup.csv specializations.ru.csv
