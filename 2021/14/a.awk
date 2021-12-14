#!/usr/bin/awk -f
NR == 1 {
	str = $0

	split($0, chars, "")
	for (i in chars)
		count[chars[i]] += 1
}

/->/ {
	split($0, pair, " -> ")
	map[pair[1]] = pair[2]
}

END {
	for (step = 1; step <= 10; ++step) {
		for (i in map) {
			split(i, rule, "")
			while (index(str, i))
				count[map[i]] += gsub(i, rule[1] tolower(map[i]) rule[2], str)
		}

		str = toupper(str)
	}

	for (i in count) {
		if (count[i] > max || max == "")
			max = count[i]

		if (count[i] < min || min == "")
			min = count[i]
	}

	print max - min
}
