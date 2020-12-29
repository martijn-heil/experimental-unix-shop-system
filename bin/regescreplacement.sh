#!/bin/bash

# Define sample multi-line literal.
replace=$(cat /dev/stdin)

# Escape it for use as a Sed replacement string.
IFS= read -d '' -r < <(sed -e ':a' -e '$!{N;ba' -e '}' -e 's/[&/\]/\\&/g; s/\n/\\&/g' <<<"$replace")
replaceEscaped=${REPLY%$'\n'}
echo "$replaceEscaped"

# If ok, outputs $replace as is.
#sed -n "s/\(.*\) \(.*\)/$replaceEscaped/p" <<<"foo bar"
