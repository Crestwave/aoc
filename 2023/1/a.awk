#!/usr/bin/awk -f
{
	gsub(/[^0-9]/, "")
	total += substr($0, 1, 1) substr($0, length($0 - 1))
}

END { print total }
