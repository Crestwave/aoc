#!/usr/bin/awk -f
{
	split("", items)
	types = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	len = length($0)

	for (i = 1; i <= len; ++i) {
		c = substr($0, i, 1)
		if (i < len / 2 + 1) {
			items[c] = 1
		} else if (items[c]) {
			sum += match(types, c)
			next
		}
	}
}

END { print(sum) }
