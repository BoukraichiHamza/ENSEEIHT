#!/bin/bsh
iarg=0
while [ $# -gt 0 ]
do
  echo $iarg
  let iarg=$iarg+1
  echo "Argument num $iarg:$1"
  shift
done

