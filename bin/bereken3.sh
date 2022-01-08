#!/bin/bash
# Usage: bereken3.sh <csv_file> <btw_column_name> <excl_btw_price_column_name>
paste -d, <(< "$1" csvcut -d ';' -C "$2,$3" | tail -n +2) <(< "$1" csvcut -d ';' -c "$2,$3" | csvquote | csvremovequoting | ./berekenprijs.awk) | csvquote -u
