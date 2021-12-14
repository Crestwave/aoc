#!/usr/bin/awk -f
{ split($0, input, ",") }

END {
	for (i in input)
		if (input[i] > max)
			max = input[i]

	for (i = 0; i <= max; ++i) {
		total = 0

		for (j in input) {
			steps = (input[j] > i) ? input[j] - i : i - input[j]
			total += (steps * (steps + 1)) / 2
		}

		if (total < min || ! min)
			min = total
	}

	print min
}
