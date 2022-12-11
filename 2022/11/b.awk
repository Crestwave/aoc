#!/usr/bin/awk -f
function eval(expr, old) {
	gsub(/old/, old, expr)
	split(expr, e, " ")

	if (e[2] == "+")
		return e[1] + e[3]
	else if (e[2] == "-")
		return e[1] - e[3]
	else if (e[2] == "*")
		return e[1] * e[3]
	else if (e[2] == "/")
		return e[1] / e[3]
}

/Monkey/ {
	sub(/:/, "")
	n = $2
}
/Starting/ {
	sub(/.*: /, "")
	items[n] = $0
}
/Operation/ {
	sub(/.*new = /, "")
	expr[n] = $0
}
/Test/ { test[n] = $(NF) }
/If true/ { true[n] = $(NF) }
/If false/ { false[n] = $(NF) }

END {
	prime = 1

	for (i in test)
		prime *= test[i]

	for (i = 1; i <= 10000; ++i)
		for (j = 0; j <= n; ++j) {
			split(items[j], item, ", ")
			for (k in item) {
				sum[j] += 1
				w = item[k]
				w = eval(expr[j], w)
				w = w % prime

				if (w % test[j] == 0)
					l = true[j]
				else
					l = false[j]

				if (items[l])
					items[l] = items[l] ", " w
				else
					items[l] = w
			}

			items[j] = ""
		}
	
	for (i in sum)
		if (sum[i] > max[0]) {
			max[1] = max[0]
			max[0] = sum[i]
		} else if (sum[i] > max[1]) {
			max[1] = sum[i]
		}

	print(max[0] * max[1])
}
