#!/usr/bin/awk -f
{
	split($0, line, " -> ")
	split(line[1], start, ",")
	split(line[2], end, ",")

	x = start[1]
	y = start[2]

	if (start[1] != end[1] && start[2] != end[2])
		next

	if (start[1] != end[1])
		diff = start[1] - end[1]
	else
		diff = start[2] - end[2]

	if (diff < 0)
		diff = diff * -1

	for (i = 0; i <= diff; ++i) {
		grid[x, y] += 1

		if (start[1] < end[1])
			x += 1
		else if (start[1] > end[1])
			x -= 1
		else if (start[2] < end[2])
			y += 1
		else if (start[2] > end[2])
			y -= 1
	}
}

END {
	for (i in grid)
		if (grid[i] >= 2)
			total += 1

	print total
}
