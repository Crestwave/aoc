#!/usr/bin/awk -f
BEGIN {
	for (i = 0; i <= 9; ++i) {
		X[i] = 0
		Y[i] = 0
	}
}

{
	for (i = 1; i <= $2; ++i) {
		if (/U/)
			Y[0] -= 1
		else if (/D/)
			Y[0] += 1
		else if (/L/)
			X[0] -= 1
		else if (/R/)
			X[0] += 1
		
		for (j = 1; j <= 9; ++j) {
			x = X[j-1] - X[j]
			y = Y[j-1] - Y[j]

			if (x == 2)
				X[j] = X[j-1] - 1
			else if (x == -2)
				X[j] = X[j-1] + 1
			else if (y == 2 || y == -2)
				X[j] = X[j-1]

			if (y == 2)
				Y[j] = Y[j-1] - 1
			else if (y == -2)
				Y[j] = Y[j-1] + 1
			else if (x == 2 || x == -2)
				Y[j] = Y[j-1]

			if (j == 9)
				grid[X[j], Y[j]] = 1
		}
	}

}

END {
	for (i in grid)
		if (grid[i]) 
			sum += 1

	print(sum)
}
