#!/usr/bin/awk -f
/,/ {
	split($0, xy, ",")
	grid[xy[1], xy[2]] = 1
}

/fold/ {

	split($3, fold, "=")

	for (i in grid) {
		if (grid[i]) {
			split(i, xy, SUBSEP)
			x = xy[1]
			y = xy[2]


			if (fold[1] == "x") {
				if (x > fold[2]) {
					delete grid[x, y]
					grid[(x - (fold[2] * 2)) * -1, y] = 1
				}
			} else if (fold[1] == "y") {
				if (y > fold[2]) {
					delete grid[x, y]
					grid[x, (y - (fold[2] * 2)) * -1] = 1
				}
			}
		}
	}
}

END {
	for (i in grid) {
		split(i, xy, SUBSEP)

		if (xy[1] > _x)
			_x = xy[1]

		if (xy[2] > _y)
			_y = xy[2]
	}

	for (y = 0; y <= _y; ++y) {
		for (x = 0; x <= _x; ++x) {
			if (grid[x, y])
				printf("#")
			else
				printf(" ")
		}

		print ""
	}
}
