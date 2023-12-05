#!/usr/bin/awk -f
/seeds:/ {
	for (i = 2; i <= NF; ++i) {
		map[$i] = "seed"
	}
}

/[a-z]+-[a-z]+-[a-z]+/ {
	split($0, a, "-")
	source = a[1]
	dest = a[3]
}

/[0-9]/ {
	# 50 98 2
	# destination, source, range
	for (i = 1; i <= $3; ++i) {
		for (j in map) {
			print($2+i)
			if (source == map[j] && j == $2 + i) {
				print("HEY")
				delete map[$2 + i]
				map[$1 + 1] = dest
			}
		}
	}
	#print
}

END {
	for (i in map) print(i, map[i])
}
