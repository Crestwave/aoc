#!/usr/bin/awk -f
function flood(x, y, z) {
	if (grid[x, y] >= z && grid[x, y] != 9 && grid[x, y] != "") {
		size += 1
		z = grid[x, y]
		grid[x, y] = 9

		flood(x - 1, y, z)
		flood(x + 1, y, z)
		flood(x, y - 1, z)
		flood(x, y + 1, z)
	}
}

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
			pt[x, y] = grid[x, y]
	}

	for (i in pt) {
		split(i, xy, SUBSEP)
		size = 0

		flood(xy[1], xy[2], pt[i])
		sizes[size] += 1

		if (size > max || max == "")
			max = size
	}

	k = 3

	for (i = max; i >= 0 && k > 0; --i) {
		for (j = sizes[i]; j > 0 && k > 0; --j) {
			k -= 1

			if (total == "")
				total = i
			else
				total *= i
		}
	}

	print total
}
