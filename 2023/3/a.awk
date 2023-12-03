#!/usr/bin/awk -f
{
	str = $0
	len = 0
	while (length(str) > 0) {
		i = match(str, /[0-9]+/)
		if (i == 0)
			break
		grid[i + len, NR] = substr(str, i, RLENGTH)
		len += i + RLENGTH - 1
		str = substr(str, i + RLENGTH)
	}

	str = $0
	len = 0
	while (length(str) > 0) {
		i = match(str, /[^0-9.]/)
		if (i == 0)
			break
		sym[i + len, NR] = substr(str, i, 1)
		len += i + RLENGTH - 1
		str = substr(str, i + RLENGTH)
	}
}

END {
	for (k in grid) {
		split(k, xy, SUBSEP)
		for (x = xy[1] - 1; x <= xy[1] + length(grid[k]); ++x)
			for (y = xy[2] - 1; y <= xy[2] + 1; ++y)
				if (sym[x, y])
					total += grid[k]
	}

	print(total)
}
