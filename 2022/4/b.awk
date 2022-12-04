#!/usr/bin/awk -f
BEGIN { FS = "[,-]" }
{ sum += ($1 <= $4 && $3 <= $2) }
END { print(sum) }
