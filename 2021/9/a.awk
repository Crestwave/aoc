#!/usr/bin/awk -f
BEGIN { FS = "" }

{
	for (x = 1; x <= NF; ++x)
		grid[x, NR] = $x
}

END {
	for (i in grid) {
		split(i, xy, SUBSEP)
		x = xy[1]
		y = xy[2]

		flag = 1

		for (ox = -1; ox <= 1; ox += 2) {
			adj = grid[x + ox, y]
			if (grid[x, y] >= adj && adj != "")
				flag = 0

			adj = grid[x, y + ox]
			if (grid[x, y] >= adj && adj != "")
				flag = 0
		}

		if (flag)
			total += grid[x, y] + 1
	}

	print total
}
