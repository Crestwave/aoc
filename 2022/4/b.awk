#!/usr/bin/awk -f
BEGIN { FS = "[,-]" }
{ sum += (($1 <= $3 && $2 >= $3) || ($3 <= $1 && $4 >= $1)) }
END { print(sum) }
