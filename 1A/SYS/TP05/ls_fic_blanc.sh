#!/bin/sh
for f in *
do
  if [ -f "$f" ]
  then
    echo $f | tr ' ' '_'
  fi
done
