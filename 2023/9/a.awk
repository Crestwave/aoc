#!/usr/bin/awk -f
{
	split("", data)
	ptr = 1
	for (i = 1; i <= NF; ++i)
		data[ptr, i] = $i

	data[ptr] = NF

	while (1) {
		zero = 1
		for (i = 2; i <= data[ptr]; ++i) {
			data[ptr+1, i-1] = data[ptr, i] - data[ptr, i-1]
			if (data[ptr+1, i-1] != 0)
				zero = 0
		}

		data[++ptr] = i - 2

		if (zero)
			break
	}

	for (i = ptr; i >= 1; --i)
		data[i, ++data[i]] = data[i, data[i]] + data[i+1, data[i+1]]

	total += data[1, data[1]]
}

END { print total }
