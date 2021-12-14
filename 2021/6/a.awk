#!/usr/bin/awk -f
{ ptr = split($0, fish, ",") }

END {
	for (day = 0; day < 80; ++day) {
		for (i in fish) {
			if (fish[i] == 0) {
				fish[i] = 7
				fish[++ptr] = 8
			}

			fish[i] -= 1
		}
	}

	print ptr
}
