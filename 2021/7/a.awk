#!/usr/bin/awk -f
{ split($0, input, ",") }

END {
	for (i in input)
		if (input[i] > max)
			max = input[i]

	for (i = 0; i <= max; ++i) {
		total = 0

		for (j in input)
			total += (input[j] > i) ? input[j] - i : i - input[j]

		if (total < min || ! min)
			min = total
	}

	print min
}
