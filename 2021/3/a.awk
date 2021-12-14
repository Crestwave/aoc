#!/usr/bin/awk -f
function bin2dec(bin,	i, bit, dec) {
	for (i = 1; i <= length(bin); ++i) {
		bit = substr(bin, i, 1)
		dec = (dec * 2)+bit
	}

	return dec
}

BEGIN { FS = "" }

{
	for (i = 1; i <= NF; ++i)
		a[i] += $i
}

END {
	for (i in a) {
		j = j (a[i] >= (NR / 2))
		k = k (a[i] <= (NR / 2))
	}

	print bin2dec(j) * bin2dec(k)
}
