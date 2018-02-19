#!/bin/bash
if [ ! $# -gt 1 ]
then
  echo "rec_motif_fichiers.sh  <motif>  <ficfier1>  [<fichier2>] ..."
  exit 1
fi
motif="$1"
shift

while [ $# -gt 0 ] 
do
  if [ -f "$1" ]
  then
    echo "############### $1 ###############" 
    grep -n "$motif" "$1"  
  else
    echo "$1 n'est pas un fichier"
  fi
  shift
done
