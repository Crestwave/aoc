#!/usr/bin/awk -f
BEGIN { FS = "; " }

{
	split("", max)
	sub(/Game [0-9]*: /, "")

	for (i = 1; i <= NF; ++i) {
		split($i, set, ", ")
		for (j in set) {
			split(set[j], cube, " ")
			if (cube[1] > max[cube[2]])
				max[cube[2]] = cube[1]
		}
	}

	total += max["red"] * max["green"] * max["blue"]
}

END { print total }
