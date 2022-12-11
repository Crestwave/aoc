#!/usr/bin/awk -f
{
	for (i = 1; i <= $2; ++i) {
		_x = x
		_y = y

		if (/U/)
			y -= 1
		else if (/D/)
			y += 1
		else if (/L/)
			x -= 1
		else if (/R/)
			x += 1

		__x = X > x ? X-x : x-X
		__y = Y > y ? Y-y : y-Y

		if (__x > 1 || __y > 1) {
			X = _x
			Y = _y
		}

		grid[X, Y] = 1
	}
}

END {
	for (i in grid)
		if (grid[i]) 
			sum += 1

	print(sum)
}
