#!/usr/bin/awk -f
{
	group = ((NR - 1) % 3) + 1
	types = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	len = length($0)

	if (group == 1)
		split("", items)

	for (i = 1; i <= len; ++i) {
		c = substr($0, i, 1)
		if (items[c] == group - 1) {
			items[c] = group
			if (group == 3)
				sum += match(types, c)
		}
	}
}

END { print(sum) }
