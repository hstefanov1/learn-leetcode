#!/bin/bash
# Usage: ./measure.sh <runs> <command> [args...]
# Example: ./measure.sh 5 ./solution.sh

set -e
clear

if [ $# -lt 2 ]; then
  echo
  echo "Usage: $0 <runs> <command> [args...]"
  echo
  exit 1
fi

# Colorful prints/echo's
red() { printf "\033[1;31m%s\033[0m\n" "$1"; }
blue() { printf "\033[1;34m%s\033[0m\n" "$1"; }
green() { printf "\033[0;32m%s\033[0m\n" "$1"; }
yellow() { printf "\033[1;33m%s\033[0m\n" "$1"; }

error() {
  echo
  red "ERROR: $1"
  echo
  red ":: BASH ABORTED ::"
  echo
  exit 1
}

case $1 in '' | *[!0-9]* | 0)
  error "<runs> must be a positive integer"
  ;;
esac

if [ ! -f "$2" ]; then
  error "command not found \"$2\""
fi

total=0
runs=$1
shift
TIMEFORMAT=%3R # real time in seconds, 3 decimals (e.g., 0.015)

for ((i = 1; i <= runs; i++)); do

  # run the command silently
  # capture only the output of `time`
  elapsed=$({ time "$@" >/dev/null 2>&1; } 2>&1)

  # "0.015" -> "0015" -> 15 ms (10# avoids octal issues with leading zeros)
  ms=$((10#${elapsed//[.,]/}))

  total=$((total + ms))
  blue "Run $i: $ms ms"
done
echo

# average with two decimals
avg100=$((total * 100 / runs))
yellow "Total:   $total ms"
printf "\033[0;33mAverage: %d.%02d ms (%d runs)\033[0m\n" $((avg100 / 100)) $((avg100 % 100)) "$runs"
echo
green "::: BASH COMPLETED :::"
echo
