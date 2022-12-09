#!/usr/bin/awk -f
BEGIN { FS = "" }

{
	for (x = 1; x <= NF; ++x)
		grid[x, NR] = $x
}

END {
	X = length($0)
	Y = NR

	for (x = 1; x <= X; ++x) {
		i = -1
		for (y = 1; y <= Y; ++y) {
			if (grid[x, y] < i)
				continue
			if (grid[x, y] > i)
				visible[x, y] = 1
			i = grid[x, y]
		}
	}

	for (x = 1; x <= X; ++x) {
		i = -1
		for (y = Y; y >= 1; --y) {
			if (grid[x, y] < i)
				continue
			if (grid[x, y] > i)
				visible[x, y] = 1
			i = grid[x, y]
		}
	}

	for (y = 1; y <= Y; ++y) {
		i = -1
		for (x = 1; x <= X; ++x) {
			if (grid[x, y] < i)
				continue
			if (grid[x, y] > i)
				visible[x, y] = 1
			i = grid[x, y]
		}
	}

	for (y = 1; y <= Y; ++y) {
		i = -1
		for (x = X; x >= 1; --x) {
			if (grid[x, y] < i)
				continue
			if (grid[x, y] > i)
				visible[x, y] = 1
			i = grid[x, y]
		}
	}

	for (i in visible)
		sum += 1

	print(sum)
}
