#!/usr/bin/awk -f
function bin2dec(bin,	i, bit, dec) {
	for (i = 1; i <= length(bin); ++i) {
		bit = substr(bin, i, 1)
		dec = (dec * 2) + bit
	}

	return dec
}

{ input[NR] = $0 }

END {
	for (i in input) {
		oxy[i] = input[i]
		co2[i] = input[i]
	}

	for (i = 1; i <= length($0); ++i) {
		split("", bits)
		for (j in oxy)
			bits[substr(oxy[j], i, 1)] += 1

		if (!bits[0] || !bits[1])
			break

		for (j in oxy)
			if (substr(oxy[j], i, 1) != (bits[1] >= bits[0]))
				delete oxy[j]
	}


	for (i = 1; i <= length($0); ++i) {
		split("", bits)
		for (j in co2)
			bits[substr(co2[j], i, 1)] += 1

		if (!bits[0] || !bits[1])
			break

		for (j in co2)
			if (substr(co2[j], i, 1) != (bits[1] < bits[0]))
				delete co2[j]
	}

	for (i in oxy)
		for (j in co2)
			print bin2dec(oxy[i]) * bin2dec(co2[j])
}
