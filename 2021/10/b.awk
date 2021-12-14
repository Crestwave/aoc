#!/usr/bin/awk -f
function qsort(arr, left, right,	i, j, tmp, pivot) {
	if (left >= 0 && right >= 0 && left < right) {
		pivot = arr[int((left + right) / 2)]

		i = left - 1
		j = right + 1

		while (1) {
			do {
				i = i + 1
			} while (arr[i] < pivot)

			do {
				j = j - 1
			} while (arr[j] > pivot)

			if (i >= j)
				break

			tmp = arr[i]
			arr[i] = arr[j]
			arr[j] = tmp
		}

		qsort(arr, left, j)
		qsort(arr, j + 1, right)
	}
}

BEGIN { FS = "" }

{
	split("", chunk)

	ptr = 0

	for (i = 1; i <= NF; ++i) {
		c = $i

		if (c ~ /[\(\[\{\<]/)
			stack[++ptr] = c

		flag = 1

		if (c == ")")
			flag = (stack[ptr--] == "(")
		else if (c == "]")
			flag = (stack[ptr--] == "[")
		else if (c == "}")
			flag = (stack[ptr--] == "{")
		else if (c == ">")
			flag = (stack[ptr--] == "<")

		if (! flag)
			next
	}

	val = 0

	while (ptr) {
		c = stack[ptr--]
		val *= 5
		
		if (c == "(")
			val += 1
		else if (c == "[")
			val += 2
		else if (c == "{")
			val += 3
		else if (c == "<")
			val += 4
	}

	score[++pt] = val
}

END {
	qsort(score, 1, pt)
	print score[pt/2+.5]
}
