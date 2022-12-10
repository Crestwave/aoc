#!/usr/bin/awk -f
function cycle(n,	i, j) {
	for (i = 1; i <= n; ++i) {
		j = t % 40

		if (X == j - 1 || X == j || X == j + 1)
			str = str "#"
		else
			str = str "."

		if (j == 39)
			str = str "\n"

		t += 1
	}
}

BEGIN { X = 1 }

/noop/ { cycle(1) }
/addx/ {
	cycle(2)
	X += $2
}

END { printf("%s", str) }
