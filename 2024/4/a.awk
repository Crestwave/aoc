#!/usr/bin/awk -f
BEGIN {
	FS = ""
	total = ""
}
{
	for (i = 1; i <= NF; ++i)
		grid[i, NR] = $i
}
END {
	for (i in grid) {
		if (grid[i] == "X") {
			split(i, xy, SUBSEP)
			print(xy[1], xy[2])
			x = xy[1]
			y = xy[2]
			# upper-left
			if (grid[x-1, y-1] == "M" && grid[x-2, y-2] == "A" && grid[x-3, y-3] == "S")
				total += 1
			# upper-right
			if (grid[x+1, y-1] == "M" && grid[x+2, y-2] == "A" && grid[x+3, y-3] == "S")
				total += 1
			# lower-left
			if (grid[x-1, y+1] == "M" && grid[x-2, y+2] == "A" && grid[x-3, y+3] == "S")
				total += 1
			# lower-right
			if (grid[x+1, y+1] == "M" && grid[x+2, y+2] == "A" && grid[x+3, y+3] == "S")
				total += 1
			# left
			if (grid[x-1, y] == "M" && grid[x-2, y] == "A" && grid[x-3, y] == "S")
				total += 1
			# right
			if (grid[x+1, y] == "M" && grid[x+2, y] == "A" && grid[x+3, y] == "S")
				total += 1
			# up
			if (grid[x, y-1] == "M" && grid[x, y-2] == "A" && grid[x, y-3] == "S")
				total += 1
			# down
			if (grid[x, y+1] == "M" && grid[x, y+2] == "A" && grid[x, y+3] == "S")
				total += 1
		}
	}
	print total
}
