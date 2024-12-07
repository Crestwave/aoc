#!/usr/bin/awk -f
BEGIN { FS = "[|,]" }
/\|/ { rule[$1] = rule[$1] $2 "," }
/^[^\|]*$/ {
	for (i in pages) delete pages[i]

	for (i = 1; i <= NF; ++i) {
		pages[$i] = 1
		r = rule[$i]
		n = split(r, a, ",")
		for (j = 1; j < n; ++j)
			if (pages[a[j]])
				next
	}

	total += $(int(NF/2)+1)
}
END { print total }
