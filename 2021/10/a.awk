#!/usr/bin/awk -f
BEGIN { FS = "" }

{
	split("", chunk)

	for (i = 1; i <= NF; ++i) {
		c = $i

		if (c ~ /[\(\[\{\<]/)
			stack[++ptr] = c

		val = 0

		if (c == ")")
			val = (stack[ptr--] == "(") ? 0 : 3
		else if (c == "]")
			val = (stack[ptr--] == "[") ? 0 : 57
		else if (c == "}")
			val = (stack[ptr--] == "{") ? 0 : 1197
		else if (c == ">")
			val = (stack[ptr--] == "<") ? 0 : 25137

		if (val) {
			total += val
			next
		}
	}
}

END { print total }
