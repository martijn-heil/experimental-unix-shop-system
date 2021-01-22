#!/bin/bash
DATA_DIR="/usr/local/var/artikelen"
productfile="$(wslpath "$1")"
< "$productfile" xls2csv > "$DATA_DIR/megawin.csv"
< "$DATA_DIR/megawin.csv" megawincsv2nincsv > "$DATA_DIR/artikelbestand.csv"
