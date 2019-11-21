#!/bin/bash
str=AirBar
strings -a -t d $1 | grep $str > tmp
#wc -c $1 >> tmp
INFILE=$1
export INFILE
rm -rf output
mkdir -p output
extract () {
#  echo "dd if=\"$INFILE\" of=\"$1\" count=$2 skip=$3"
  dd bs=1 if="$INFILE" of=output/"$1" count=$2 skip=$3
}
export -f extract
cat tmp | awk 'BEGIN {diff=0;prev=0;offset=0};{offset=$1;diff=offset-prev; prev=$1;$1=""; fname=$0; print "Name:",fname,"\nSize:",diff; system("extract \""fname"\" " diff " " offset);print ""};' 
rm tmp
