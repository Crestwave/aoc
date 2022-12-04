#!/usr/bin/awk -f
BEGIN { FS = "," }

{
	split($1, a, "-")
	split($2, b, "-")

	if ((a[1] <= b[1] && a[2] >= b[1]) || (b[1] <= a[1] && b[2] >= a[1]))
		sum += 1
}

END { print(sum) }
