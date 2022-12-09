#!/usr/bin/awk -f
function sight(x, y, _x, _y, X, Y,	i, sum) {
	i = grid[x, y]
	sum = 0

	do {
		x += _x
		do {
			y += _y
			if (grid[x, y] != "") {
				sum += 1
				if (grid[x, y] >= i)
					return sum
			}
		} while (y != Y)
	} while (x != X)

	return sum
}

BEGIN { FS = "" }

{
	for (x = 1; x <= NF; ++x)
		grid[x, NR] = $x
}

END {
	X = length($0)
	Y = NR

	for (x = 1; x <= X; ++x)
		for (y = 1; y <= Y; ++y) {
			score = sight(x, y, 0, -1, x, 1-1) * \
				 sight(x, y, 0, +1, x, Y+1) * \
				 sight(x, y, -1, 0, 1-1, y) * \
				 sight(x, y, +1, 0, X+1, y)

			if (score > max)
				max = score
		}

	print(max)
}
