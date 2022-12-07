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
	for (i in a)
		if (a[i] <= 100000)
			sum += a[i]

	print(sum)
}
