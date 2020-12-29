#!/bin/bash
barcode_column=$1
description_column=$2
price_column=$3

product=$(cat /dev/stdin)
barcode=$(echo "$product" | csvcut -q \" -c "$barcode_column" | csvformat -D ';' | tail -n +2 | csvremovequoting)
description=$(echo "$product" | csvcut -q \"  -c "$description_column" | csvformat -D ';' | tail -n +2 | csvremovequoting)
price=$(echo "$product" | csvcut -q \" -c "$price_column" | csvformat -D ';' | tail -n +2 | csvremovequoting)
if [ "$price" = "" ] || [ "$price" = '0,00' ]; then
  price="????"
else
  price_point="$(echo "$price" | comma2point)"
  mooieprijs_point="$(mooieprijs.sh "$price_point")"
  mooieprijs_comma="$(echo "$mooieprijs_point" | point2comma)"
  price="$mooieprijs_comma"
fi

productlabel --barcode "$barcode" --price "$price" --description "$description" --page-height 1.5in --page-width 2in --template "$HOME/etc/productlabel/template.html"
