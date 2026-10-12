#!/bin/bash

set -e
clear
echo

FILENAME="words.txt"
if [ ! -f "$FILENAME" ]; then
  printf "ERROR: File \"%s\" not found\n\n" "$FILENAME"
  exit 1
fi

while IFS= read -r line; do
  for word in $line; do
    printf "%s\n" "$word"
  done
done <"$FILENAME" | sort | uniq -c | sort -nr | awk '{print $2, $1}'
