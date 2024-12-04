#!/usr/bin/awk -f
BEGIN { input = "" }
{ input = input $0 }
END {
	b = 1
	while (length(input)) {
		if (b) {
			if (input ~ /^don't\(\).*/) {
				b = 0
			} else if (input ~ /^mul\([0-9]{1,3},[0-9]{1,3}\)/) {
				match(input, /mul\([0-9]{1,3},[0-9]{1,3}\)/)
				mul = substr(input, RSTART+length("mul("), RLENGTH-length("mul()"))
				split(mul, arg, ",")
                		total += arg[1]*arg[2]
			}
		} else {
			if (input ~ /^do\(\).*/)
				b = 1
		}

		input = substr(input, 2)
	}
	print total
}
