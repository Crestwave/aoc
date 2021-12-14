#!/usr/bin/awk -f
NR == 1 { split($0, input, ",") }

NF == 0 {
	y = 0
	boards += 1
}

NF == 5 {
	y += 1

	for (x = 1; x <= NF; ++x)
		board[x, y, boards] = $x
}

END {
	for (i in board)
		marked[i] = board[i]

	for (num in input) {
		for (i in board) {
			if (board[i] == input[num]) {
				marked[i] = 0

				split(i, xy, SUBSEP)

				for (j = 1; j <= 2; ++j) {
					bingo[j, xy[j], xy[3]] += 1
					if (bingo[j, xy[j], xy[3]] >= 5) {
						for (x = 1; x <= 5; ++x)
							for (y = 1; y <= 5; ++y)
								total += marked[x, y, xy[3]]

						print total * input[num]
						exit
					}
				}
			}
		}
	}
}
