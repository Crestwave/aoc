#!/usr/bin/awk -f
BEGIN { FS = "" }
{
	for (i = 1; i <= NF; ++i) {
		a[$i] += 1

		if (i >= 14) {
			for (j in a)
				if (a[j] > 1)
					break

			if (a[j] < 2) {
				print(i)
				exit
			}

			a[$(i-13)] -= 1
		}
	}
}
