#!/usr/bin/awk -f
BEGIN {
	FS = "; "
	max["red"] = 12
	max["green"] = 13
	max["blue"] = 14
}

{
	sub(/Game [0-9]*: /, "")
	for (i = 1; i <= NF; ++i) {
		split($i, set, ", ")
		for (j in set) {
			split(set[j], cube, " ")
			if (max[cube[2]] < cube[1])
				next
		}
	}

	total += NR
}

END { print total}
