#!/usr/bin/awk -f
BEGIN { total = 0 }
{
	m = $1-$2 > 0 ? 1 : -1
	for (i = 1; i < NF; ++i)
		if ((($(i)-$(i+1))*m > 3 || (($(i)-$(i+1))*m <= 0)))
			next
	total += 1
}
END { print total }
