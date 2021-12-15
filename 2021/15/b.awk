#!/usr/bin/awk -f
function walk(ox, oy) {
	v = x + ox SUBSEP y + oy

	if (! Q[v])
		return

	alt = dist[u] + grid[v]

	if (alt < dist[v]) {
		dist[v] = alt
		prev[v] = u
	}
}

BEGIN { FS = "" }

{
	for (x = 1; x <= NF; ++x)
		grid[x, NR] = $x
}

END {
	for (v in grid) {
		split(v, xy, SUBSEP)
		x = xy[1]
		y = xy[2]

		for (i = 1; i <= 4; ++i) {
			for (j = 1; j <= 4; ++j) {
				_x = x + (NF * i)
				_y = y + (NR * j)

				if ((grid[x, y] + i + j) > 9)
					grid[_x, _y] = (grid[x, y] + i + j) % 9
				else
					grid[_x, _y] = (grid[x, y] + i + j)

				if ((grid[x, y] + i) > 9)
					grid[_x, y] = (grid[x, y] + i) % 9 
				else
					grid[_x, y] = grid[x, y] + i

				if ((grid[x, y] + j) > 9)
					grid[x, _y] = (grid[x, y] + j) % 9 
				else
					grid[x, _y] = grid[x, y] + j
			}
		}
	}

	NR *= 5
	NF *= 5

	source = 1 SUBSEP 1
	target = NF SUBSEP NR

	for (v in grid) {
		dist[v] = 999999
		prev[v] = 0
		Q[v] = ++p
	}

	dist[source] = 0

	while (p > 0) {
		min = 999999

		for (v in Q) {
			if (dist[v] < min && Q[v]) {
				u = v
				min = dist[v]
			}
		}

		delete Q[u]
		p -= 1

		if (u == target)
			break

		split(u, xy, SUBSEP)
		x = xy[1]
		y = xy[2]

		walk(-1, 0)
		walk(1, 0)
		walk(0, -1)
		walk(0, 1)
	}

	u = target

	if (prev[u] != "" || u == source) {
		while (u != "") {
			total += grid[u]
			u = prev[u]
		}
	}

	print total - grid[source]
}
