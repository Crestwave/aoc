#!/usr/bin/awk -f
{ arr[NR] = $0 }

END {
	for (i = 3; i <= NR; ++i) {
		j = arr[i-2] + arr[i-1] + arr[i]
		if (j > k && k != "")
			n += 1

		k = j
	}

	print n
}
