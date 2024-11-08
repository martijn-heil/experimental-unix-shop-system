#!/bin/bash
barcode_column=$1
description_column=$2
price_column=$3

product="$(csv2nix | head -n2 | nix2csv)" # Ensure we only have one product.
barcode="$(<<< "$product" csvgetcolval -n "$barcode_column")"
description="$(<<< "$product" csvgetcolval -n "$description_column")"
price="$(<<< "$product" csvgetcolval -n "$price_column")"

if [ "$price" = "" ] || [ "$price" = '0,00' ]; then
  price="????"
else
  price_point="$(echo "$price" | sed 's/\,/\./')"
  mooieprijs_point="$(mooieprijs.sh "$price_point")"
  mooieprijs_comma="$(echo "$mooieprijs_point" | point2comma)"
  price="$mooieprijs_comma"
fi

productlabel --barcode "$barcode" --price "$price" --description "$description" --page-height 32mm --page-width 57mm --template "/usr/local/etc/productlabel/template.html"
