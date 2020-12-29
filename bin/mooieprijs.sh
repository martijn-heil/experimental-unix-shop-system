#!/bin/bash
# Only works with positive numbers

function round {
  echo $(printf %.$2f $(echo "scale=$2;(((10^$2)*$1)+0.5)/(10^$2)" | bc))
}

if (( $(echo "$1 <= 0.05" | bc -l) )); then
  echo "0.05"
  exit 0
fi

rounded_price="$(round "$1" 2)"

times05="$(echo "$rounded_price / 0.05" | bc -l)"
times05rounded="$(round "$times05" 0)"
echo "$times05rounded * 0.05" | bc -l | sed 's/^\./0./'
