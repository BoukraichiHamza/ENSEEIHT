#!/bin/bash
usag="$0 [-dfx] [folder]"
if [ $# -gt 2 ]
then
  echo "Erreur : $usage"
  exit 1
fi

folder="."
if [ -d "$2" ]
then
    folder="$2"
fi
echo "$folder"
case $1 in
  -d) find "$folder" -type d | ls -l
    ;;
  -f) find "$folder" -type f | ls -l
    ;;
  -x) find "$folder" -type x | ls -l
    ;;
  *) echo "Commande inconnue"
esac
