#!/usr/bin/awk -f
BEGIN { FS = "" }
{
	for (i = 1; i <= NF; ++i) {
		a[$i] += 1

		if (i >= 4) {
			if (a[$i]*a[$(i-1)]*a[$(i-2)]*a[$(i-3)] == 1) {
				print(i)
				exit
			}

			a[$(i-3)] -= 1
		}
	}
}
