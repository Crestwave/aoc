#!/usr/bin/awk -f
function check(a, p	, i) {
	m = a[1]-a[2] > 0 ? 1 : -1
	for (i = 1; i < p; ++i)
		if (((a[i]-a[i+1])*m > 3 || ((a[i]-a[i+1])*m <= 0)))
			return 0
	return 1
}

{
	for (n = 1; n <= NF; ++n) {
		p = 0
		for (i in a)
			delete a[i]

		for (i = 1; i <= NF; ++i)
			if (i != n)
				a[++p] = $(i)

		if (check(a, p)) {
			total += 1
			next
		}
	}
}

END { print total }
