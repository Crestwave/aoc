#!/usr/bin/awk -f
BEGIN { input = "" }
{ input = input $0 }
END {
	while (match(input, /mul\([0-9]{1,3},[0-9]{1,3}\)/)) {
		mul = substr(input, RSTART+length("mul("), RLENGTH-length("mul()"))
		split(mul, arg, ",")
		total += arg[1]*arg[2]
		input = substr(input, RSTART+RLENGTH)
	}
	print total
}
