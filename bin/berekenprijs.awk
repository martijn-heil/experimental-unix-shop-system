#!/bin/awk -f
BEGIN {
  FS=","
  OFS=","
}

{
  # Replace 0x1F (ASCII: 'Unit Separator') with .
  # This script expects as input a CSV file escaped by use of csvquote,
  # and then processed by csvremovequoting.
  #
  # csvquote replaces every comma inside a field with the 'Unit Seperator' non-printable character
  # Because fractional numbers are written with a comma instead of a decimal point, we replace the
  # Unit Seperator character with a decimal point for in our maths and final output.
  #
  # Field $1 is the BTW percentage.
  # Field $2 is the price
  #
  # Outputs a single column of resultant prices.
  gsub("\x1F", ".", $2); gsub("\x1F", ".", $1); printf "%.2f\n", ($1 / 100 + 1) * $2;
}
