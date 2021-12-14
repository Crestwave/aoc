#!/usr/bin/awk -f
NR == 1 {
	str = $0
	split($0, chars, "")
	for (i in chars)
		count[chars[i]] += 1
}

/->/ {
	split($0, rule, " -> ")
	map[rule[1]] = rule[2]
}

END {
	for (i in map) {
		split(i, rule, "")
		while (index(str, i))
			pair[i] += gsub(i, rule[1] "." rule[2], str)
	}

	for (step = 1; step <= 40; ++step) {
		for (i in pair)
			state[i] = pair[i]

		for (i in map) {
			split(i, rule, "")

			count[map[i]] += pair[i]
			state[i] -= pair[i]
			state[rule[1] map[i]] += pair[i]
			state[map[i] rule[2]] += pair[i]
		}

		for (i in state)
			pair[i] = state[i]
	}

	for (i in count) {
		if (count[i] > max || max == "")
			max = count[i]

		if (count[i] < min || min == "")
			min = count[i]
	}

	print max - min
}
