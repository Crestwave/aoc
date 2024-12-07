#!/usr/bin/awk -f
BEGIN { FS = "[|,]" }
/\|/ { rule[$1] = rule[$1] $2 "," }
/^[^\|]*$/ {
	# clean up all arrays and variables from previous iterations
	# in hindsight, there would probably be less of this boilerplate if I used a function instead
	for (i in pages) delete pages[i]
	for (i in order) delete order[i]
	temp = 0

	# set this separately now since it will be modified during the loop
	for (i = 1; i <= NF; ++i) order[i] = $i

	for (i = 1; i <= NF; ++i) {
		pages[order[i]] = i
		r = rule[order[i]]
		n = split(r, a, ",")
		for (j = 1; j < n; ++j)
			if (pages[a[j]]) {
				# swap the places of the updates in the rule violated
				temp = order[i]
				order[i] = a[j]
				order[pages[a[j]]] = temp

				# restart the processing again to correct any cascading errors
				for (i in pages) delete pages[i]
				i = 0
				break
			}
	}

	if (temp)
		total += order[int(NF/2)+1]
}
END { print total }
