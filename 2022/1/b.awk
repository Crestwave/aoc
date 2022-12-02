#!/usr/bin/awk -f
/^$/ { i += 1 }
{ arr[i] += $1 }

END {
	for (i in arr) {
		if (arr[i] > max[0]) {
			max[2] = max[1]
			max[1] = max[0]
			max[0] = arr[i]
		} else if (arr[i] > max[1]) {
			max[2] = max[1]
			max[1] = arr[i]
		} else if (arr[i] > max[2]) {
			max[2] = arr[i]
		}
	}

	print(max[0] + max[1] + max[2])
}
