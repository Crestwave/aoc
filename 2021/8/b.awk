#!/usr/bin/awk -f
{
	# Parse input
	split($0, input, " \\| ")
	split(input[1], signal, " ")

	# Clear the arrays since AWK lacks local variables
	# `delete arr` is not POSIX-compatible
	split("", trans)
	split("", count)

	# Count the number of occurences for each letter,
	# and get the pattern of number 4
	for (i in signal) {
		split(signal[i], chars, "")

		for (c in chars)
			count[chars[c]] += 1

		if (length(signal[i]) == 4)
			map = signal[i]
	}

	split(map, chars, "")

	# With 4's pattern, we can distinguish between the
	# 2 letters that have 8 characters, as well as the
	# 2 letters that have 7 characters.
	for (c in chars) {
		if (count[chars[c]] == 8) {
			trans[chars[c]] = "C"
			delete count[chars[c]]
		} else if (count[chars[c]] == 7) {
			trans[chars[c]] = "D"
			delete count[chars[c]]
		}
	}

	# Now that we no longer have any duplicate counts,
	# map the remaining letters to the translation array,
	for (i in count) {
		if (count[i] == 8)
			trans[i] = "A"
		else if (count[i] == 6)
			trans[i] = "B"
		else if (count[i] == 7)
			trans[i] = "G"
		else if (count[i] == 4)
			trans[i] = "E"
		else if (count[i] == 9)
			trans[i] = "F"
	}

	# Translate the output values
	for (c in trans)
		gsub(c, trans[c], input[2])

	split(input[2], output, " ")
	val = ""

	# Now that we have the correct segments
	# (e.g., GADBF for 5), we can translate it
	# to the actual number and build the value.
	for (i in output) {
		# Using regex because the segments aren't sorted and
		# POSIX AWK does not have a sort function or sets.
		if (output[i] ~ /^[ABCEFG]{6,}$/)
			val = val 0
		else if (output[i] ~ /^[CF]{2,}$/)
			val = val 1
		else if (output[i] ~ /^[ACDEG]{5,}$/)
			val = val 2
		else if (output[i] ~ /^[ACDFG]{5,}$/)
			val = val 3
		else if (output[i] ~ /^[BCDF]{4,}$/)
			val = val 4
		else if (output[i] ~ /^[ABDFG]{5,}$/)
			val = val 5
		else if (output[i] ~ /^[ABDEFG]{6,}$/)
			val = val 6
		else if (output[i] ~ /^[ACF]{3,}$/)
			val = val 7
		else if (output[i] ~ /^[ABCDEFG]{7,}$/)
			val = val 8
		else if (output[i] ~ /^[ABCDFG]{6,}$/)
			val = val 9
	}

	total += int(val)
}

END {
	print total
}
