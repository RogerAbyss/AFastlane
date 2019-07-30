#!/bin/sh
# 🚀 App分析

path_in=logs/ProjectName-ProjectName.log
path_out=logs/slowest.log
awk '/Driver Compilation Time/,/Total$/ { print }' $path_in | \
  grep compile | \
  cut -c 55- | \
  sed -e 's/^ *//;s/ (.*%)  compile / /;s/ [^ ]*Bridging-Header.h$//' | \
  sed -e "s|$(pwd)/||" | \
  sort -rn | \
  tee $path_out