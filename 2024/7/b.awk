#!/usr/bin/awk -f
function check(a, ptr, len, val, test) {
	if (ptr > len)
		return (val == test)
	else
		return check(a, ptr+1, len, val+a[ptr], test) + check(a, ptr+1, len, val*a[ptr], test) + check(a, ptr+1, len, val a[ptr], test)

}

BEGIN { total = 0 }

{
	sub(/:/, "")

	for (i = 1; i <= NF; ++i)
		a[i] = $i

	if (check(a, 3, NF, a[2], a[1]) > 0)
		total += a[1]
}

END { print(total) }
