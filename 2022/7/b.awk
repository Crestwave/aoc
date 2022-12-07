#!/usr/bin/awk -f
/cd \// {
	p = 0
	s[p] = $3
}

/cd [a-z]/ { s[++p] = $3 }
/cd \.\./ { delete s[p--] }

/^[0-9]/ {
	str = ""
	for (i = 0; i <= p; ++i) {
		str = str "/" s[i]
		a[str] += $1
	}
}

END {
	target = 30000000 - (70000000 - a["//"])
	min = a["//"]

	for (i in a)
		if (a[i] >= target && a[i] < min)
			min = a[i]

	print(min)
}
