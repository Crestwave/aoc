#!/usr/bin/awk -f
{
	t["one"] = 1
	t["two"] = 2
	t["three"] = 3
	t["four"] = 4
	t["five"] = 5
	t["six"] = 6
	t["seven"] = 7
	t["eight"] = 8
	t["nine"] = 9

	do
		for (k in t)
			if ($0 ~ "^[0-9]*" k)
				sub(k, t[k] k)
	while (sub(/[^0-9]/, ""))

	total += substr($0, 1, 1) substr($0, length($0 - 1))
}

END { print total }
