#!/usr/bin/awk -f
function cycle(n,	i) {
	for (i = 1; i <= n; ++i) {
		t += 1
		if ((t - 20) % 40 == 0)
			sum += X * t
	}
}

BEGIN { X = 1 }

/noop/ { cycle(1) }
/addx/ {
	cycle(2)
	X += $2
}

END { print(sum) }
