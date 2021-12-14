#!/usr/bin/awk -f
{
	split($0, input, ",")
	for (i in input)
		fish[input[i]] += 1
}

END {
	for (day = 0; day < 256; ++day) {
		for (i = 0; i <= 8; ++i)
			state[i] = 0

		for (i in fish) {
			if (i == 0) {
				state[8] += fish[i]
				state[6] += fish[i]
			} else {
				state[i-1] += fish[i]
			}
		}

		for (i in state)
			fish[i] = state[i]
	}


	for (i in fish)
		total += fish[i]

	print total
}
