#!/usr/bin/awk -f
/^$/ { i += 1 }
{ arr[i] += $1 }

END {
	for (i in arr)
		if (arr[i] > max)
			max = arr[i]

	print(max)
}
