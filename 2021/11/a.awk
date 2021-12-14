#!/usr/bin/awk -f
function flash(grid, x, y,	ox, oy) {
	grid[x, y] = 0
	total += 1

	for (ox = -1; ox <= 1; ox += 1)
		for (oy = -1; oy <= 1; oy += 1)
			if (grid[x + ox, y + oy])
				if (++grid[x + ox, y + oy] >= 10)
					flash(grid, x + ox, y + oy)
}

BEGIN { FS = "" }

{
	for (i = 1; i <= NF; ++i)
		grid[i, NR] = $i
}

END {
	for (i = 1; i <= 100; ++i) {
		for (y = 1; y <= NR; ++y)
			for (x = 1; x <= NF; ++x)
				grid[x, y] += 1

		for (y = 1; y <= NR; ++y)
			for (x = 1; x <= NF; ++x)
				if (grid[x, y] >= 10)
					flash(grid, x, y)
	}

	print total
}
