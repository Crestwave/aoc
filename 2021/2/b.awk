#!/usr/bin/awk -f
/down/ { i += $2 }
/up/ { i -= $2 }
/forward/ {
	x += $2
	y += i * $2
}

END { print x * y }
