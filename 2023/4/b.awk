#!/usr/bin/awk -f
{
	mult[NR] += 1
	sub(/Card[ ]*[0-9]*: /, "")
	split($0, card, "|")
	card[2] = card[2] " "
	$0 = card[1]
	num = 0

	for (i = 1; i <= NF; ++i)
		if (match(card[2], "[^0-9]+" $i "[^0-9]+"))
			++num

	for (i = 1; i <= num; ++i)
		mult[NR + i] += 1 * mult[NR]

	total += mult[NR]
}

END { print total }
