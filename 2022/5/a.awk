#!/usr/bin/awk -f
/[][]/ { input[NR] = $0 }

/^ 1/ {
	for (i = 2; i < length($0); i += 4) {
		j = substr($0, i, 1)
		for (k = NR; k > 0; --k) {
			c = substr(input[k], i, 1)
			if (c != " ") {
				stack[j, ++stack[j]] = c
			}
		}
	}
}

/move/ {
	for (i = 1; i <= $2; ++i) {
		stack[$6, ++stack[$6]] = stack[$4, stack[$4]--]
	}
}

END {
	for (i = 1; i <= j; ++i) {
		printf("%s", stack[i, stack[i]])
	}

	print ""
}
