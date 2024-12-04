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
		if (grid[i] == "A") {
			split(i, xy, SUBSEP)
			x = xy[1]
			y = xy[2]
			if ((grid[x-1, y-1] == "M" && grid[x+1, y+1] == "S") || (grid[x-1, y-1] == "S" && grid[x+1, y+1] == "M"))
				if ((grid[x+1, y-1] == "M" && grid[x-1, y+1] == "S") || (grid[x+1, y-1] == "S" && grid[x-1, y+1] == "M"))
					total += 1
		}
	}
	print total
}
