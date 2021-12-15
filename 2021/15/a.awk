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
